/*************************************************************************
  > File Name: VerilogNetlist.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Sun 01 May 2022 04:09:26 PM CST
 ************************************************************************/

#include "VerilogNetlist.h"
#include <climits>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <unordered_set>

void VerilogNetlist::genHierNet(std::vector<Module> &hierNetlist,
                                uint32_t &totalUsedStdCells,
                                uint32_t &totalUsedNotEmptyStdCells,
                                uint32_t &totalUsedBlackBoxes)
{
  HierNetlistVisitor hierNetlistVisitor(v3Global.rootp());
  hierNetlist = hierNetlistVisitor.getHierNetlist();
  totalUsedStdCells = hierNetlistVisitor.getTotalUsedStdCells();
  totalUsedNotEmptyStdCells =
    hierNetlistVisitor.getTotalUsedNotEmptyStdCells();
  totalUsedBlackBoxes = hierNetlistVisitor.getTotalUsedBlackBoxes();
}

void VerilogNetlist::printNetlist(const std::vector<Module> &hierNetlist,
                                  const uint32_t &totalUsedStdCells,
                                  const uint32_t &totalUsedBlackBoxes,
                                  std::string fileName,
                                  const uint32_t maxHierLevel)
{
  std::ofstream ofs(fileName);
  bool shouldHaveEscapeCharacter;
  uint32_t totalCharactersEveryLine;
  auto getDecimalNumberLength = [](uint32_t number)
  {
    uint32_t length = 0;
    while(number)
    {
      number /= 10;
      length++;
    }
    return length;
  };
  auto haveVerilogKeyWordOrOperator = [](const string &name)
  {
    // If there are too many kinds of keywords(more than 14) will be used in
    // port name, instance name, module name, variable name and so on, use map
    // to replace vector.
    std::vector<std::string> verilogKeyWord = { "run", "signed" };
    std::vector<std::string> verilogOperator = { "[", ".", "]" };
    for(auto vKW: verilogKeyWord)
    {
      if(vKW.size() == name.size() && name.find(vKW) < name.size())
        return true;
    }
    for(auto vO: verilogOperator)
    {
      if(name.find(vO) < name.size())
        return true;
    }
    return false;
  };
  const uint32_t maxCharactersEveryLine = 80;
  uint32_t moduleIndex = totalUsedStdCells;
  // Every time print one module defintion
  for(uint32_t moduleIndex = totalUsedStdCells;
      moduleIndex < hierNetlist.size(); moduleIndex++)
  {
    const auto &oneModule = hierNetlist[moduleIndex];
    totalCharactersEveryLine = 0;
    if(oneModule.level <= maxHierLevel || moduleIndex < totalUsedBlackBoxes)
    { // Print one module declaration
      ofs << "module " << oneModule.moduleDefName << "(";
      totalCharactersEveryLine =
        totalCharactersEveryLine + 7 + oneModule.moduleDefName.size() + 1;
      for(const auto &port: oneModule.ports)
      {
        if(port.portType != PortType::WIRE &&
           port.portType != PortType::LAST_PORT_TYPE)
        {
          if(totalCharactersEveryLine + port.portDefName.size() >
             maxCharactersEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharactersEveryLine = 6;
          }
          totalCharactersEveryLine =
            port.portDefName.size() + totalCharactersEveryLine;
          if(haveVerilogKeyWordOrOperator(port.portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
            totalCharactersEveryLine++;
          }
          ofs << port.portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            totalCharactersEveryLine++;
            shouldHaveEscapeCharacter = false;
          }
          ofs << ",";
          totalCharactersEveryLine++;
        }
      }
      ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
      ofs << ");" << std::endl;
      // Every time print one port definition
      for(const auto &port: oneModule.ports)
      {
        switch(port.portType)
        {
        case PortType::INPUT:
          ofs << "   input ";
          break;
        case PortType::OUTPUT:
          ofs << "   output ";
          break;
        case PortType::INOUT:
          ofs << "   inout ";
          break;
        case PortType::WIRE:
          ofs << "   wire ";
          break;
        }
        if(port.isVector)
        {
          ofs << "[" << port.bitWidth - 1 << ":0]";
        }
        if(haveVerilogKeyWordOrOperator(port.portDefName))
        {
          shouldHaveEscapeCharacter = true;
          ofs << "\\";
        }
        ofs << port.portDefName;
        if(shouldHaveEscapeCharacter)
        {
          ofs << " ";
          shouldHaveEscapeCharacter = false;
        }
        ofs << ";" << std::endl;
      }

      // Every time print one assign statement, every assign statement only has
      // one bit data;
      for(auto oneAssign: oneModule.assigns)
      {
        ofs << "  assign ";
        if(haveVerilogKeyWordOrOperator(
             oneModule.ports[oneAssign.lValue.refVarDefIndex].portDefName))
        {
          shouldHaveEscapeCharacter = true;
          ofs << "\\";
        }
        ofs << oneModule.ports[oneAssign.lValue.refVarDefIndex].portDefName;
        if(shouldHaveEscapeCharacter)
        {
          ofs << " ";
          shouldHaveEscapeCharacter = false;
        }
        if(oneAssign.lValue.refVarDefIndex != UINT_MAX)
        {
          if(oneModule.ports[oneAssign.lValue.refVarDefIndex].isVector)
            ofs << "[" << oneAssign.lValue.bitIndex << "]";
        }
        else
        {
          throw std::runtime_error(
            "Assign left value can not be const value or x or z.");
        }
        ofs << " = ";
        // rValue is a consta value or x or z
        if(oneAssign.rValue.refVarDefIndex == UINT_MAX)
        {
          switch(oneAssign.rValue.valueAndValueX)
          {
          case ONE:
            ofs << "1'b1";
            break;
          case ZERO:
            ofs << "1'b0";
            break;
          case X:
            ofs << "1'bx";
            break;
          case Z:
            ofs << "1'bz";
            break;
          default:
            ofs << "1'be"; // e = error valuex
            break;
          }
        }
        else
        {
          if(haveVerilogKeyWordOrOperator(
               oneModule.ports[oneAssign.rValue.refVarDefIndex].portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
          }
          ofs << oneModule.ports[oneAssign.rValue.refVarDefIndex].portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            shouldHaveEscapeCharacter = false;
          }
          if(oneModule.ports[oneAssign.rValue.refVarDefIndex].isVector)
            ofs << "[" << oneAssign.rValue.bitIndex << "]";
        }
        ofs << ";" << std::endl;
      }

      // Every time print one submodule instance
      uint32_t subModuleInstanceIndex = 0;
      for(const auto &onesubModuleInstanceName:
          oneModule.subModuleInstanceNames)
      {
        totalCharactersEveryLine = 0;
        ofs << "  "
            << hierNetlist[oneModule.subModuleDefIndex[subModuleInstanceIndex]]
                 .moduleDefName
            << " ";
        if(haveVerilogKeyWordOrOperator(onesubModuleInstanceName))
        {
          ofs << "\\";
          totalCharactersEveryLine++;
        }
        ofs << onesubModuleInstanceName << " "
            << "(";
        totalCharactersEveryLine =
          totalCharactersEveryLine + 5 +
          hierNetlist[oneModule.subModuleDefIndex[subModuleInstanceIndex]]
            .moduleDefName.size() +
          onesubModuleInstanceName.size();
        // Every time print one port assignment
        uint32_t portDefIndex = 0;
        for(const auto &onePortAssignment:
            oneModule
              .portAssignmentsOfSubModuleInstances[subModuleInstanceIndex])
        {
          if(totalCharactersEveryLine + 1 +
               hierNetlist[oneModule.subModuleDefIndex[subModuleInstanceIndex]]
                 .ports[portDefIndex]
                 .portDefName.size() >
             maxCharactersEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharactersEveryLine = 6;
          }
          ofs << ".";
          if(haveVerilogKeyWordOrOperator(
               hierNetlist[oneModule.subModuleDefIndex[subModuleInstanceIndex]]
                 .ports[portDefIndex]
                 .portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
            totalCharactersEveryLine++;
          }
          ofs
            << hierNetlist[oneModule.subModuleDefIndex[subModuleInstanceIndex]]
                 .ports[portDefIndex]
                 .portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            totalCharactersEveryLine++;
            shouldHaveEscapeCharacter = false;
          }
          ofs << "(";
          totalCharactersEveryLine =
            totalCharactersEveryLine + 2 +
            hierNetlist[oneModule.subModuleDefIndex[subModuleInstanceIndex]]
              .ports[portDefIndex]
              .portDefName.size();
          if(onePortAssignment.refVars.size() > 1)
          {
            ofs << "{";
            totalCharactersEveryLine++;
          }
          for(uint32_t indexOfRefVars = onePortAssignment.refVars.size();
              indexOfRefVars > 0; indexOfRefVars--)
          {
            auto &refVar = onePortAssignment.refVars[indexOfRefVars - 1];
            if(refVar.refVarDefIndex == UINT_MAX)
            {
              if(totalCharactersEveryLine + 4 > maxCharactersEveryLine)
              {
                ofs << std::endl << "      ";
                totalCharactersEveryLine = 6;
              }
              switch(refVar.valueAndValueX)
              {
              case ONE:
                ofs << "1'b1";
                break;
              case ZERO:
                ofs << "1'b0";
                break;
              case X:
                ofs << "1'bx";
                break;
              case Z:
                ofs << "1'bz";
                break;
              default:
                ofs << "1'be"; // e = error valuex
                break;
              }
              totalCharactersEveryLine = totalCharactersEveryLine + 4;
            }
            else
            {
              if(oneModule.ports[refVar.refVarDefIndex].isVector)
              {
                if(totalCharactersEveryLine +
                     oneModule.ports[refVar.refVarDefIndex]
                       .portDefName.size() +
                     2 + getDecimalNumberLength(refVar.bitIndex) >
                   maxCharactersEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharactersEveryLine = 6;
                }
              }
              else
              {
                if(totalCharactersEveryLine +
                     oneModule.ports[refVar.refVarDefIndex]
                       .portDefName.size() >
                   maxCharactersEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharactersEveryLine = 6;
                }
              }
              if(haveVerilogKeyWordOrOperator(
                   oneModule.ports[refVar.refVarDefIndex].portDefName))
              {
                shouldHaveEscapeCharacter = true;
                ofs << "\\";
                totalCharactersEveryLine++;
              }
              ofs << oneModule.ports[refVar.refVarDefIndex].portDefName;
              totalCharactersEveryLine =
                totalCharactersEveryLine +
                oneModule.ports[refVar.refVarDefIndex].portDefName.size();
              if(shouldHaveEscapeCharacter)
              {
                ofs << " ";
                totalCharactersEveryLine++;
                shouldHaveEscapeCharacter = false;
              }
              if(oneModule.ports[refVar.refVarDefIndex].isVector)
              {
                ofs << "[" << refVar.bitIndex << "]";
                totalCharactersEveryLine =
                  totalCharactersEveryLine + 2 +
                  getDecimalNumberLength(refVar.bitIndex);
              }
            }
            ofs << ",";
            totalCharactersEveryLine++;
          }
          if(onePortAssignment.refVars.size() >= 1)
          {
            ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
            totalCharactersEveryLine--;
          }
          if(onePortAssignment.refVars.size() > 1)
          {
            ofs << "}";
            totalCharactersEveryLine++;
          }
          ofs << ")";
          ofs << ", ";
          totalCharactersEveryLine = totalCharactersEveryLine + 3;
          portDefIndex++;
        }
        ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
        ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one " "
        ofs << ");";
        ofs << std::endl;
        subModuleInstanceIndex++;
      }
      ofs << "endmodule" << std::endl << std::endl;
    }
  }
  ofs.close();
}

// Use case2 as a example to demonstrate.
void VerilogNetlist::flattenHierNet(const std::vector<Module> &hierNetlist,
                                    std::vector<Module> &flatNetlist,
                                    const uint32_t &totalUsedBlackBoxes)
{
  flatNetlist = hierNetlist;
  // Use to not flatten such module which only have standard cells or assign
  // statement; Sometimes, totalUsedBlackBoxes = 0.
  auto &theMostDepthLevelExcludingBlackBoxes = hierNetlist.back().level;
  for(uint32_t moduleDefIndex = hierNetlist.size() - 1;
      moduleDefIndex >= totalUsedBlackBoxes && moduleDefIndex != UINT_MAX;
      moduleDefIndex--)
  {
    // full_adder definition
    const auto &oneModuleH = hierNetlist[moduleDefIndex];
    auto &oneModuleF = flatNetlist[moduleDefIndex];
    if(oneModuleH.level < theMostDepthLevelExcludingBlackBoxes)
    {
      oneModuleF.subModuleInstanceNames.clear();
      oneModuleF.subModuleDefIndex.clear();
      oneModuleF.portAssignmentsOfSubModuleInstances.clear();
      uint32_t subModuleInstanceIndex = 0;
      // full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
      for(auto &subModuleDefIndex: oneModuleH.subModuleDefIndex)
      {
        // subModule is a stdCell or an other black box
        if(subModuleDefIndex < totalUsedBlackBoxes)
        {
          oneModuleF.subModuleInstanceNames.push_back(
            oneModuleH.subModuleInstanceNames[subModuleInstanceIndex]);
          oneModuleF.subModuleDefIndex.push_back(subModuleDefIndex);
          oneModuleF.portAssignmentsOfSubModuleInstances.push_back(
            oneModuleH
              .portAssignmentsOfSubModuleInstances[subModuleInstanceIndex]);
        }
        else
        { // U1, subModule is not a stdCell nor an other black box
          const std::string &subModuleInstanceName =
            oneModuleH.subModuleInstanceNames[subModuleInstanceIndex];
          // (.co(co), .a(a), .b(b), .ci(ci));
          const auto &portAssignmentsOfSubModuleInstance =
            oneModuleH
              .portAssignmentsOfSubModuleInstances[subModuleInstanceIndex];
          // full_adder_co definition
          auto &oneSubModule = flatNetlist[subModuleDefIndex];
          uint32_t oneModuleFPortsNumber = oneModuleF.ports.size();
          uint32_t oneSubModuleWirePosition =
            oneSubModule.totalPortsExcludingWires;
          oneModuleF.ports.resize(oneModuleFPortsNumber +
                                  oneSubModule.ports.size() -
                                  oneSubModuleWirePosition);
          // full_adder_co wires,n_0_0 become U1_n_0_0
          for(uint32_t i = oneModuleFPortsNumber; i < oneModuleF.ports.size();
              i++)
          {
            oneModuleF.ports[i] = oneSubModule.ports[oneSubModuleWirePosition];
            oneModuleF.ports[i].portDefName.insert(0, "_");
            oneModuleF.ports[i].portDefName.insert(0, subModuleInstanceName);
            oneSubModuleWirePosition++;
          }
          oneModuleF.subModuleDefIndex.insert(
            oneModuleF.subModuleDefIndex.end(),
            oneSubModule.subModuleDefIndex.begin(),
            oneSubModule.subModuleDefIndex.end());
          uint32_t blackBoxInstanceNameIndex = 0;
          // INV_X1_LVT i_0_0 (.A(a), .ZN(n_0_0));
          for(auto oneBlackBoxIns:
              oneSubModule.portAssignmentsOfSubModuleInstances)
          {
            // stdInstanceName i_0_0 becomes U1_i_0_0
            oneModuleF.subModuleInstanceNames.push_back(
              oneSubModule.subModuleInstanceNames[blackBoxInstanceNameIndex]);
            blackBoxInstanceNameIndex++;
            oneModuleF.subModuleInstanceNames.back().insert(0, "_");
            oneModuleF.subModuleInstanceNames.back().insert(
              0, subModuleInstanceName);
            // .A(a)
            for(auto &portAssignmentOfBlackBox: oneBlackBoxIns)
            {
              for(auto &oneRefVar: portAssignmentOfBlackBox.refVars)
              {
                // Now, oneRefVar is a wire
                if(oneRefVar.refVarDefIndex >=
                     oneSubModule.totalPortsExcludingWires &&
                   oneRefVar.refVarDefIndex < UINT_MAX)
                {
                  oneRefVar.refVarDefIndex =
                    oneRefVar.refVarDefIndex -
                    oneSubModule.totalPortsExcludingWires +
                    oneModuleFPortsNumber;
                }
                // Now,oneRefVar is a input, output or inout
                else if(oneRefVar.refVarDefIndex <
                        oneSubModule.totalPortsExcludingWires)
                { // If the port of full_adder_co instance is empty.
                  if(portAssignmentsOfSubModuleInstance[oneRefVar
                                                          .refVarDefIndex]
                       .refVars.empty())
                  {
                    portAssignmentOfBlackBox.refVars.clear();
                  }
                  else
                    oneRefVar =
                      portAssignmentsOfSubModuleInstance[oneRefVar
                                                           .refVarDefIndex]
                        .refVars[oneRefVar.bitIndex];
                }
                // Now,oneRefVar is a const value or x or z
                // else{}
              }
            }
            oneModuleF.portAssignmentsOfSubModuleInstances.push_back(
              std::move(oneBlackBoxIns));
          }
          for(auto oneAssign: oneSubModule.assigns)
          {
            bool _curAssignConnectToEmptySignal = false;
            if(oneAssign.lValue.refVarDefIndex >=
                 oneSubModule.totalPortsExcludingWires &&
               oneAssign.lValue.refVarDefIndex < UINT_MAX)
            {
              oneAssign.lValue.refVarDefIndex =
                oneAssign.lValue.refVarDefIndex -
                oneSubModule.totalPortsExcludingWires + oneModuleFPortsNumber;
            }
            else if(oneAssign.lValue.refVarDefIndex <
                    oneSubModule.totalPortsExcludingWires)
            {
              if(portAssignmentsOfSubModuleInstance[oneAssign.lValue
                                                      .refVarDefIndex]
                   .refVars.empty())
                _curAssignConnectToEmptySignal = true;
              else
                oneAssign.lValue =
                  portAssignmentsOfSubModuleInstance[oneAssign.lValue
                                                       .refVarDefIndex]
                    .refVars[oneAssign.lValue.bitIndex];
            }
            if(oneAssign.rValue.refVarDefIndex >=
                 oneSubModule.totalPortsExcludingWires &&
               oneAssign.rValue.refVarDefIndex < UINT_MAX)
            {
              oneAssign.rValue.refVarDefIndex =
                oneAssign.rValue.refVarDefIndex -
                oneSubModule.totalPortsExcludingWires + oneModuleFPortsNumber;
            }
            else if(oneAssign.rValue.refVarDefIndex <
                    oneSubModule.totalPortsExcludingWires)
            {
              if(portAssignmentsOfSubModuleInstance[oneAssign.rValue
                                                      .refVarDefIndex]
                   .refVars.empty())
                _curAssignConnectToEmptySignal = true;
              else
                oneAssign.rValue =
                  portAssignmentsOfSubModuleInstance[oneAssign.rValue
                                                       .refVarDefIndex]
                    .refVars[oneAssign.rValue.bitIndex];
            }
            if(_curAssignConnectToEmptySignal)
              _curAssignConnectToEmptySignal = false;
            else
              oneModuleF.assigns.push_back(std::move(oneAssign));
          }
        }
        subModuleInstanceIndex++;
      }
    }
  }
}

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

void VerilogNetlist::parseHierNet(int argc, char **argv, char **env)
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
  // 1,Obtain a hierarchical netlist from AST.
  genHierNet(_hierNetlist, _totalUsedStdCells, _totalUsedNotEmptyStdCells,
             _totalUsedBlackBoxes);

  // Explicitly release resources
  v3Global.shutdown();
}
