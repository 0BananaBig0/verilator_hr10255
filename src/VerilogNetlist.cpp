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
#include "V3Case.h"
#include "V3Cast.h"
#include "V3Changed.h"
#include "V3Clean.h"
#include "V3Clock.h"
#include "V3Combine.h"
#include "V3Const.h"
#include "V3Coverage.h"
#include "V3CoverageJoin.h"
#include "V3CCtors.h"
#include "V3Dead.h"
#include "V3Delayed.h"
#include "V3Depth.h"
#include "V3DepthBlock.h"
#include "V3Descope.h"
#include "V3EmitC.h"
#include "V3EmitCMake.h"
#include "V3EmitMk.h"
#include "V3EmitV.h"
#include "V3EmitXml.h"
#include "PrintNetFile.h"
#include "V3Expand.h"
#include "V3File.h"
#include "V3Cdc.h"
#include "V3Gate.h"
#include "V3GenClk.h"
#include "V3Graph.h"
#include "V3Inline.h"
#include "V3Inst.h"
#include "V3Life.h"
#include "V3LifePost.h"
#include "V3LinkCells.h"
#include "V3LinkDot.h"
#include "V3LinkJump.h"
#include "V3LinkLValue.h"
#include "V3LinkLevel.h"
#include "V3LinkParse.h"
#include "V3LinkResolve.h"
#include "V3Localize.h"
#include "V3Name.h"
#include "V3Order.h"
#include "V3Os.h"
#include "V3Param.h"
#include "V3Parse.h"
#include "V3ParseSym.h"
#include "V3Partition.h"
#include "V3PreShell.h"
#include "V3Premit.h"
#include "V3ProtectLib.h"
#include "V3Reloop.h"
#include "V3Scope.h"
#include "V3Scoreboard.h"
#include "V3Slice.h"
#include "V3Split.h"
#include "V3SplitAs.h"
#include "V3Stats.h"
#include "V3String.h"
#include "V3Subst.h"
#include "V3Table.h"
#include "V3Task.h"
#include "V3Trace.h"
#include "V3TraceDecl.h"
#include "V3Tristate.h"
#include "V3TSP.h"
#include "V3Undriven.h"
#include "V3Unknown.h"
#include "V3Unroll.h"
#include "V3Width.h"

#include <ctime>
#include <sys/stat.h>

V3Global v3Global;

//######################################################################
// V3 Class -- top level

AstNetlist *V3Global::makeNetlist()
{
  AstNetlist *newp = new AstNetlist();
  newp->addTypeTablep(new AstTypeTable(newp->fileline()));
  return newp;
}

void V3Global::checkTree() { rootp()->checkTree(); }

void V3Global::clear()
{
  if(m_rootp)
  {
    m_rootp->deleteTree();
    m_rootp = NULL;
    opt.clear();
  }
}

void V3Global::readFiles()
{
  // NODE STATE
  //   AstNode::user4p()      // VSymEnt*    Package and typedef symbol names
  AstUser4InUse inuser4;

  VInFilter filter(v3Global.opt.pipeFilter());
  V3ParseSym parseSyms(
    v3Global.rootp()); // Symbol table must be common across all parsing

  V3Parse parser(v3Global.rootp(), &filter, &parseSyms);
  // Read top module
  const V3StringList &vFiles = v3Global.opt.vFiles();
  for(V3StringList::const_iterator it = vFiles.begin(); it != vFiles.end();
      ++it)
  {
    string filename = *it;
    parser.parseFile(new FileLine(FileLine::commandLineFilename()), filename,
                     false, "Cannot find file containing module: ");
  }

  // Read libraries
  // To be compatible with other simulators,
  // this needs to be done after the top file is read
  const V3StringSet &libraryFiles = v3Global.opt.libraryFiles();
  for(V3StringSet::const_iterator it = libraryFiles.begin();
      it != libraryFiles.end(); ++it)
  {
    string filename = *it;
    parser.parseFile(new FileLine(FileLine::commandLineFilename()), filename,
                     true, "Cannot find file containing library module: ");
  }
#ifdef HT_DEBUG
  v3Global.rootp()->dumpTreeFile(v3Global.debugFilename("parse.tree"));
#endif
  V3Error::abortIfErrors();

  if(!v3Global.opt.preprocOnly())
  {
    // Resolve all modules cells refer to
    V3LinkCells::link(v3Global.rootp(), &filter, &parseSyms);
  }
}

void V3Global::dumpCheckGlobalTree(const string &stagename, int newNumber,
                                   bool doDump)
{
  v3Global.rootp()->dumpTreeFile(
    v3Global.debugFilename(stagename + ".tree", newNumber), false, doDump);
  // if (v3Global.opt.stats()) V3Stats::statsStage(stagename);
}

//######################################################################

void process()
{
  // Sort modules by level so later algorithms don't need to care
  V3LinkLevel::modSortByLevel();
  V3Error::abortIfErrors();

  // Convert parseref's to varrefs, and other directly post parsing fixups
  V3LinkParse::linkParse(v3Global.rootp());
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
  V3Error::abortIfErrors();

  // Calculate and check widths, edit tree to TRUNC/EXTRACT any width
  // mismatches
  V3Width::width(v3Global.rootp());

  // Check XML when debugging to make sure no missing node types
  // V3EmitXml::emitxml();

#ifdef HT_DEBUG
  // write a file (.net) about the netlist infomation
  PrintNetFile::printNetFile();
#endif
}

//######################################################################

void VerilogNetlist::parseHierNet(int comnum, char **command)
{
  // General initialization
  // std::ios::sync_with_stdio();

  auto t_start = std::chrono::system_clock::now();

  // Post-constructor initialization of netlists
  v3Global.boot();

  // Preprocessor
  // Before command parsing so we can handle -Ds on command line.
  V3PreShell::boot(NULL);

  // Command option parsing
  // v3Global.opt.bin(argv[0]);
  // string argString = V3Options::argString(argc-1, argv+1);
  v3Global.opt.parseOpts(new FileLine(FileLine::commandLineFilename()), comnum,
                         command);

  V3Error::abortIfErrors();

  /*     // Can we skip doing everything if times are ok?
   V3File::addSrcDepend(v3Global.opt.bin());
   if (v3Global.opt.skipIdentical().isTrue()
       && V3File::checkTimes(v3Global.opt.makeDir()+"/"+v3Global.opt.prefix()
                             +"__verFiles.dat", argString)) {
       UINFO(1,"--skip-identical: No change to any source files, exiting\n");
       exit(0);
   } */

  //--FRONTEND------------------

  // Cleanup
  V3Os::unlinkRegexp(v3Global.opt.makeDir(),
                     v3Global.opt.prefix() + "_*.tree");
  V3Os::unlinkRegexp(v3Global.opt.makeDir(), v3Global.opt.prefix() + "_*.dot");
  V3Os::unlinkRegexp(v3Global.opt.makeDir(), v3Global.opt.prefix() + "_*.txt");

  // Internal tests (after option parsing as need debug() setting,
  // and after removing files as may make debug output)
  AstBasicDTypeKwd::selfTest();
  /*     if (v3Global.opt.debugSelfTest()) {
       VHashSha256::selfTest();
       VSpellCheck::selfTest();
       V3Graph::selfTest();
       V3TSP::selfTest();
       V3ScoreboardBase::selfTest();
       V3Partition::selfTest();
   } */

  // Read first filename
  v3Global.readFiles();

  // Link, etc, if needed
  if(!v3Global.opt.preprocOnly())
  {
    process();
  }

  // 1,Obtain a hierarchical netlist from AST.
  genHierNet(_hierNetlist, _totalUsedStdCells, _totalUsedNotEmptyStdCells,
             _totalUsedBlackBoxes);

  // Final steps
  // V3Global::dumpCheckGlobalTree("final", 990,
  // v3Global.opt.dumpTreeLevel(__FILE__) >= 3);
  V3Error::abortIfWarnings();
  v3Global.clear();

  FileLine::deleteAllRemaining();

  // UINFO(1, "Done, Exiting...\n");

  auto t_end = std::chrono::system_clock::now();
  HLog << InfoCont << "Verilog parser run time (s): "
       << elapsedSysTimeInSeconds(t_start, t_end) << endl;
}
