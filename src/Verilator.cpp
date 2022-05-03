// -*- mode: C++; c-file-style: "cc-mode" -*-
//*************************************************************************
// DESCRIPTION: Verilator: main()
//
// Code available from: https://verilator.org
//
//*************************************************************************
//
// Copyright 2003-2021 by Wilson Snyder. This program is free software; you
// can redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
// SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0
//
//*************************************************************************

#include "V3Ast.h"
#include "V3Global.h"

#include "V3Active.h"
#include "V3ActiveTop.h"
#include "V3Assert.h"
#include "V3AssertPre.h"
#include "V3Begin.h"
#include "V3Branch.h"
#include "V3Broken.h"
#include "V3CCtors.h"
#include "V3CUse.h"
#include "V3Case.h"
#include "V3Cast.h"
#include "V3Cdc.h"
#include "V3Changed.h"
#include "V3Class.h"
#include "V3Clean.h"
#include "V3Clock.h"
#include "V3Combine.h"
#include "V3Common.h"
#include "V3Const.h"
#include "V3Coverage.h"
#include "V3CoverageJoin.h"
#include "V3Dead.h"
#include "V3Delayed.h"
#include "V3Depth.h"
#include "V3DepthBlock.h"
#include "V3Descope.h"
#include "V3EmitC.h"
#include "V3EmitCMain.h"
#include "V3EmitCMake.h"
#include "V3EmitMk.h"
#include "V3EmitV.h"
#include "V3EmitXml.h"
#include "V3Expand.h"
#include "V3File.h"
#include "V3Force.h"
#include "V3Gate.h"
#include "V3GenClk.h"
#include "V3Graph.h"
#include "V3HierBlock.h"
#include "V3Inline.h"
#include "V3Inst.h"
#include "V3Life.h"
#include "V3LifePost.h"
#include "V3LinkDot.h"
#include "V3LinkInc.h"
#include "V3LinkJump.h"
#include "V3LinkLValue.h"
#include "V3LinkLevel.h"
#include "V3LinkParse.h"
#include "V3LinkResolve.h"
#include "V3Localize.h"
#include "V3MergeCond.h"
#include "V3Name.h"
#include "V3Order.h"
#include "V3Os.h"
#include "V3Param.h"
#include "V3ParseSym.h"
#include "V3Partition.h"
#include "V3PreShell.h"
#include "V3Premit.h"
#include "V3ProtectLib.h"
#include "V3Randomize.h"
#include "V3Reloop.h"
#include "V3Scope.h"
#include "V3Scoreboard.h"
#include "V3Slice.h"
#include "V3Split.h"
#include "V3SplitAs.h"
#include "V3SplitVar.h"
#include "V3Stats.h"
#include "V3String.h"
#include "V3Subst.h"
#include "V3TSP.h"
#include "V3Table.h"
#include "V3Task.h"
#include "V3Trace.h"
#include "V3TraceDecl.h"
#include "V3Tristate.h"
#include "V3Undriven.h"
#include "V3Unknown.h"
#include "V3Unroll.h"
#include "V3VariableOrder.h"
#include "V3Waiver.h"
#include "V3Width.h"

#include <cstdint>
#include <ctime>

#include "Netlist.h"
V3Global v3Global;
static void process()
{
  // Sort modules by level so later algorithms don't need to care
  V3LinkLevel::modSortByLevel();
  V3Error::abortIfErrors();

  // Convert parseref's to varrefs, and other directly post parsing fixups
  V3LinkParse::linkParse(v3Global.rootp());
  if(v3Global.opt.debugExitUvm())
  {
    V3Error::abortIfErrors();
    cout << "--debug-exit-uvm: Exiting after UVM-supported pass\n";
    std::exit(0);
  }

  // Cross-link signal names
  // Cross-link dotted hierarchical references
  V3LinkDot::linkDotPrimary(v3Global.rootp());
  v3Global
    .checkTree(); // Force a check, as link is most likely place for problems
  // Check if all parameters have been found
  v3Global.opt.checkParameters();
  // Correct state we couldn't know at parse time, repair SEL's
  V3LinkResolve::linkResolve(v3Global.rootp());
  // Set Lvalue's in variable refs
  V3LinkLValue::linkLValue(v3Global.rootp());
  // Convert return/continue/disable to jumps
  V3LinkJump::linkJump(v3Global.rootp());
  // Convert --/++ to normal operations. Must be after LinkJump.
  V3LinkInc::linkIncrements(v3Global.rootp());
  V3Error::abortIfErrors();

  if(v3Global.opt.stats())
    V3Stats::statsStageAll(v3Global.rootp(), "Link");

  // Remove parameters by cloning modules to de-parameterized versions
  //   This requires some width calculations and constant propagation
  V3Param::param(v3Global.rootp());
  V3LinkDot::linkDotParamed(v3Global.rootp()); // Cleanup as made new modules
  V3Error::abortIfErrors();

  // Remove any modules that were parameterized and are no longer referenced.
  V3Dead::deadifyModules(v3Global.rootp());
  v3Global.checkTree();

  // Calculate and check widths, edit tree to TRUNC/EXTRACT any width
  // mismatches
  V3Width::width(v3Global.rootp());

  V3Error::abortIfErrors();

  // Commit to the widths we've chosen; Make widthMin==width
  V3Width::widthCommit(v3Global.rootp());
  v3Global.assertDTypesResolved(true);
  v3Global.widthMinUsage(VWidthMinUsage::MATCHES_WIDTH);

  // Coverage insertion
  //    Before we do dead code elimination and inlining, or we'll lose it.
  if(v3Global.opt.coverage())
    V3Coverage::coverage(v3Global.rootp());

  // Add randomize() class methods if they are used by the design
  if(v3Global.useRandomizeMethods())
    V3Randomize::randomizeNetlist(v3Global.rootp());

  // Push constants, but only true constants preserving liveness
  // so V3Undriven sees variables to be eliminated, ie "if (0 && foo) ..."
  V3Const::constifyAllLive(v3Global.rootp());

  // Signal based lint checks, no change to structures
  // Must be before first constification pass drops dead code
  V3Undriven::undrivenAll(v3Global.rootp());

  // Assertion insertion
  //    After we've added block coverage, but before other nasty transforms
  V3AssertPre::assertPreAll(v3Global.rootp());
  //
  V3Assert::assertAll(v3Global.rootp());

  // Propagate constants into expressions
  V3Const::constifyAllLint(v3Global.rootp());

  //--PRE-FLAT OPTIMIZATIONS------------------

  // Initial const/dead to reduce work for ordering code
  V3Const::constifyAll(v3Global.rootp());
  v3Global.checkTree();

  V3Dead::deadifyDTypes(v3Global.rootp());
  v3Global.checkTree();

  V3Error::abortIfErrors();

  // Output the text
  if(v3Global.opt.xmlOnly()
     // Check XML when debugging to make sure no missing node types
     || (v3Global.opt.debugCheck() && !v3Global.opt.lintOnly() &&
         !v3Global.opt.dpiHdrOnly()))
  {
    // V3EmitXml::emitxml();
    // 1,Create vector to store hierarchical netlist.
    uint32_t theNumberOfStdCellsShouldUse;
    std::vector<Module> hierNetlist, flatNetlist;
    // 2,Obtain hierarchical netlist from AST.
    EmitHierNetlist::emitHierNetlists(hierNetlist,
                                      theNumberOfStdCellsShouldUse);
    // 3,Print hierarchical netlist to a verilog file.
    EmitHierNetlist::printHierNetlist(hierNetlist,
                                      theNumberOfStdCellsShouldUse);
    // 4,Flatten hierarchical netlist
    EmitHierNetlist::emitFlattenedNetlists(hierNetlist, flatNetlist,
                                           theNumberOfStdCellsShouldUse);
    // 5,Print flattened netlist to a verilog file.
    EmitHierNetlist::printHierNetlist(
      flatNetlist, theNumberOfStdCellsShouldUse, "FlatNetlist.v",
      hierNetlist[theNumberOfStdCellsShouldUse].level);
  }
}

static void verilate(const string &argString)
{

  // Read first filename
  v3Global.readFiles();

  // Link, etc, if needed
  // had been modified by haorui, and we need to know about it.
  if(!v3Global.opt.preprocOnly())
  { //
    process();
  }

  // Final steps
  V3Global::dumpCheckGlobalTree("final", 990,
                                v3Global.opt.dumpTreeLevel(__FILE__) >= 3);

  V3Error::abortIfErrors();

  // Cleanup memory for valgrind leak analysis
  v3Global.clear();
  FileLine::deleteAllRemaining();
}

//######################################################################

#include <algorithm>
#include <list>
#include <vector>

//######################################################################

int main(int argc, char **argv, char **env)
{
  // General initialization
  std::ios::sync_with_stdio();

  // Post-constructor initialization of netlists
  v3Global.boot();

  // Preprocessor
  // Before command parsing so we can handle -Ds on command line.
  V3PreShell::boot(env);

  // Command option parsing
  v3Global.opt.bin(argv[0]);
  const string argString = V3Options::argString(argc - 1, argv + 1);
  v3Global.opt.parseOpts(new FileLine(FileLine::commandLineFilename()),
                         argc - 1, argv + 1);

  verilate(argString);

  // Explicitly release resources
  v3Global.shutdown();
}
