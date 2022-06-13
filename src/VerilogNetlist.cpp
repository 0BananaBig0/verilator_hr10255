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

void VerilogNetlist::genHierNet(
  std::unordered_set<std::string> emptyStdCellsInJson)
{
  HierNetlistVisitor hierNetlistVisitor(v3Global.rootp());
  hierNetlistVisitor.setEmptyStdCells(emptyStdCellsInJson);
  _hierNetlist = hierNetlistVisitor.hierNetlist();
  _totalUsedStdCells = hierNetlistVisitor.totalUsedStdCells();
  _totalUsedNotEmptyStdCells = hierNetlistVisitor.totalUsedNotEmptyStdCells();
  _totalUsedBlackBoxes = hierNetlistVisitor.totalUsedBlackBoxes();
  _moduleNameMapIndex = hierNetlistVisitor.moduleNameMapIndex();
}

void VerilogNetlist::printNetlist(const std::vector<Module> &hierNetlist,
                                  const uint32_t &totalUsedStdCells,
                                  const uint32_t &totalUsedBlackBoxes,
                                  std::string fileName,
                                  const uint32_t maxHierLevel)
{
  std::ofstream ofs(fileName);
  bool shouldHaveEscapeChar;
  uint32_t totalCharsEveryLine;
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
  auto hasVerilogKeyWordOrOperator = [](const string &name)
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
  const uint32_t maxCharsEveryLine = 80;
  uint32_t modIndex = totalUsedStdCells;
  // Every time print one module defintion
  for(uint32_t modIndex = totalUsedStdCells; modIndex < hierNetlist.size();
      modIndex++)
  {
    const auto &oneMod = hierNetlist[modIndex];
    totalCharsEveryLine = 0;
    if(oneMod.level() <= maxHierLevel || modIndex < totalUsedBlackBoxes)
    { // Print one module declaration
      ofs << "module " << oneMod.moduleDefName() << "(";
      totalCharsEveryLine =
        totalCharsEveryLine + 7 + oneMod.moduleDefName().size() + 1;
      for(const auto &port: oneMod.ports())
      {
        if(port.portType != PortType::WIRE &&
           port.portType != PortType::LAST_PORT_TYPE)
        {
          if(totalCharsEveryLine + port.portDefName.size() > maxCharsEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharsEveryLine = 6;
          }
          totalCharsEveryLine = port.portDefName.size() + totalCharsEveryLine;
          if(hasVerilogKeyWordOrOperator(port.portDefName))
          {
            shouldHaveEscapeChar = true;
            ofs << "\\";
            totalCharsEveryLine++;
          }
          ofs << port.portDefName;
          if(shouldHaveEscapeChar)
          {
            ofs << " ";
            totalCharsEveryLine++;
            shouldHaveEscapeChar = false;
          }
          ofs << ",";
          totalCharsEveryLine++;
        }
      }
      ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
      ofs << ");" << std::endl;
      // Every time print one port definition
      for(const auto &port: oneMod.ports())
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
        default:
          ofs << "There are new port type which we not support in "
              << oneMod.moduleDefName() << " whose port name is"
              << port.portDefName;
          break;
        }
        if(port.isVector)
        {
          ofs << "[" << port.bitWidth - 1 << ":0]";
        }
        if(hasVerilogKeyWordOrOperator(port.portDefName))
        {
          shouldHaveEscapeChar = true;
          ofs << "\\";
        }
        ofs << port.portDefName;
        if(shouldHaveEscapeChar)
        {
          ofs << " ";
          shouldHaveEscapeChar = false;
        }
        ofs << ";" << std::endl;
      }

      // Every time print one assign statement, every assign statement only has
      // one bit data;
      for(auto oneAssign: oneMod.assigns())
      {
        ofs << "  assign ";
        if(hasVerilogKeyWordOrOperator(
             oneMod.ports()[oneAssign.lValue.refVarDefIndex].portDefName))
        {
          shouldHaveEscapeChar = true;
          ofs << "\\";
        }
        ofs << oneMod.ports()[oneAssign.lValue.refVarDefIndex].portDefName;
        if(shouldHaveEscapeChar)
        {
          ofs << " ";
          shouldHaveEscapeChar = false;
        }
        if(oneAssign.lValue.refVarDefIndex != UINT32_MAX)
        {
          if(oneMod.ports()[oneAssign.lValue.refVarDefIndex].isVector)
            ofs << "[" << oneAssign.lValue.bitIndex << "]";
        }
        else
        {
          throw std::runtime_error(
            "Assign left value can not be const value or x or z.");
        }
        ofs << " = ";
        // rValue is a consta value or x or z
        if(oneAssign.rValue.refVarDefIndex == UINT32_MAX)
        {
          switch(oneAssign.rValue.valueAndValueX)
          {
          case CHAR_ONE:
            ofs << "1'b1";
            break;
          case CHAR_ZERO:
            ofs << "1'b0";
            break;
          case CHAR_X:
            ofs << "1'bx";
            break;
          case CHAR_Z:
            ofs << "1'bz";
            break;
          default:
            ofs << "1'be"; // e = error valuex
            break;
          }
        }
        else
        {
          if(hasVerilogKeyWordOrOperator(
               oneMod.ports()[oneAssign.rValue.refVarDefIndex].portDefName))
          {
            shouldHaveEscapeChar = true;
            ofs << "\\";
          }
          ofs << oneMod.ports()[oneAssign.rValue.refVarDefIndex].portDefName;
          if(shouldHaveEscapeChar)
          {
            ofs << " ";
            shouldHaveEscapeChar = false;
          }
          if(oneMod.ports()[oneAssign.rValue.refVarDefIndex].isVector)
            ofs << "[" << oneAssign.rValue.bitIndex << "]";
        }
        ofs << ";" << std::endl;
      }

      // Every time print one submodule instance
      uint32_t subModInsIndex = 0;
      for(const auto &onesubModInsName: oneMod.subModuleInstanceNames())
      {
        totalCharsEveryLine = 0;
        ofs << "  "
            << hierNetlist[oneMod.subModuleDefIndexs()[subModInsIndex]]
                 .moduleDefName()
            << " ";
        if(hasVerilogKeyWordOrOperator(onesubModInsName))
        {
          ofs << "\\";
          totalCharsEveryLine++;
        }
        ofs << onesubModInsName << " "
            << "(";
        totalCharsEveryLine =
          totalCharsEveryLine + 5 +
          hierNetlist[oneMod.subModuleDefIndexs()[subModInsIndex]]
            .moduleDefName()
            .size() +
          onesubModInsName.size();
        // Every time print one port assignment
        uint32_t portDefIndex = 0;
        for(const auto &onePortAssignment:
            oneMod.portAssignmentsOfSubModInss()[subModInsIndex])
        {
          if(totalCharsEveryLine + 1 +
               hierNetlist[oneMod.subModuleDefIndexs()[subModInsIndex]]
                 .ports()[portDefIndex]
                 .portDefName.size() >
             maxCharsEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharsEveryLine = 6;
          }
          ofs << ".";
          if(hasVerilogKeyWordOrOperator(
               hierNetlist[oneMod.subModuleDefIndexs()[subModInsIndex]]
                 .ports()[portDefIndex]
                 .portDefName))
          {
            shouldHaveEscapeChar = true;
            ofs << "\\";
            totalCharsEveryLine++;
          }
          ofs << hierNetlist[oneMod.subModuleDefIndexs()[subModInsIndex]]
                   .ports()[portDefIndex]
                   .portDefName;
          if(shouldHaveEscapeChar)
          {
            ofs << " ";
            totalCharsEveryLine++;
            shouldHaveEscapeChar = false;
          }
          ofs << "(";
          totalCharsEveryLine =
            totalCharsEveryLine + 2 +
            hierNetlist[oneMod.subModuleDefIndexs()[subModInsIndex]]
              .ports()[portDefIndex]
              .portDefName.size();
          if(onePortAssignment.size() > 1)
          {
            ofs << "{";
            totalCharsEveryLine++;
          }
          for(uint32_t indexOfRefVars = onePortAssignment.size();
              indexOfRefVars > 0; indexOfRefVars--)
          {
            auto &refVar = onePortAssignment[indexOfRefVars - 1];
            if(refVar.refVarDefIndex == UINT32_MAX)
            {
              if(totalCharsEveryLine + 4 > maxCharsEveryLine)
              {
                ofs << std::endl << "      ";
                totalCharsEveryLine = 6;
              }
              switch(refVar.valueAndValueX)
              {
              case CHAR_ONE:
                ofs << "1'b1";
                break;
              case CHAR_ZERO:
                ofs << "1'b0";
                break;
              case CHAR_X:
                ofs << "1'bx";
                break;
              case CHAR_Z:
                ofs << "1'bz";
                break;
              default:
                ofs << "1'be"; // e = error valuex
                break;
              }
              totalCharsEveryLine = totalCharsEveryLine + 4;
            }
            else
            {
              if(oneMod.ports()[refVar.refVarDefIndex].isVector)
              {
                if(totalCharsEveryLine +
                     oneMod.ports()[refVar.refVarDefIndex].portDefName.size() +
                     2 + getDecimalNumberLength(refVar.bitIndex) >
                   maxCharsEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharsEveryLine = 6;
                }
              }
              else
              {
                if(totalCharsEveryLine +
                     oneMod.ports()[refVar.refVarDefIndex].portDefName.size() >
                   maxCharsEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharsEveryLine = 6;
                }
              }
              if(hasVerilogKeyWordOrOperator(
                   oneMod.ports()[refVar.refVarDefIndex].portDefName))
              {
                shouldHaveEscapeChar = true;
                ofs << "\\";
                totalCharsEveryLine++;
              }
              ofs << oneMod.ports()[refVar.refVarDefIndex].portDefName;
              totalCharsEveryLine =
                totalCharsEveryLine +
                oneMod.ports()[refVar.refVarDefIndex].portDefName.size();
              if(shouldHaveEscapeChar)
              {
                ofs << " ";
                totalCharsEveryLine++;
                shouldHaveEscapeChar = false;
              }
              if(oneMod.ports()[refVar.refVarDefIndex].isVector)
              {
                ofs << "[" << refVar.bitIndex << "]";
                totalCharsEveryLine = totalCharsEveryLine + 2 +
                                      getDecimalNumberLength(refVar.bitIndex);
              }
            }
            ofs << ",";
            totalCharsEveryLine++;
          }
          if(onePortAssignment.size() >= 1)
          {
            ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
            totalCharsEveryLine--;
          }
          if(onePortAssignment.size() > 1)
          {
            ofs << "}";
            totalCharsEveryLine++;
          }
          ofs << ")";
          ofs << ", ";
          totalCharsEveryLine = totalCharsEveryLine + 3;
          portDefIndex++;
        }
        ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
        ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one " "
        ofs << ");";
        ofs << std::endl;
        subModInsIndex++;
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
  // Use to not flatten such module which only have black boxes or assign
  // statement; Sometimes, totalUsedBlackBoxes = 0.
  auto &theMostDepthLevelExcludingBlackBoxes = hierNetlist.back().level();
  for(uint32_t modDefIndex = hierNetlist.size() - 1;
      modDefIndex >= totalUsedBlackBoxes && modDefIndex != UINT32_MAX;
      modDefIndex--)
  {
    // full_adder definition
    const auto &oneModH = hierNetlist[modDefIndex];
    auto &oneModF = flatNetlist[modDefIndex];
    if(oneModH.level() < theMostDepthLevelExcludingBlackBoxes)
    {
      oneModF.subModuleInstanceNames().clear();
      oneModF.subModuleDefIndexs().clear();
      oneModF.portAssignmentsOfSubModInss().clear();
      uint32_t subModInsIndex = 0;
      // full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
      for(auto &subModDefIndex: oneModH.subModuleDefIndexs())
      {
        // subModule is a stdCell or an other black box
        if(subModDefIndex < totalUsedBlackBoxes)
        {
          oneModF.subModuleInstanceNames().push_back(
            oneModH.subModuleInstanceNames()[subModInsIndex]);
          oneModF.subModuleDefIndexs().push_back(subModDefIndex);
          oneModF.portAssignmentsOfSubModInss().push_back(
            oneModH.portAssignmentsOfSubModInss()[subModInsIndex]);
        }
        else
        { // U1, subModule is not a stdCell nor an other black box
          const std::string &subModInsName =
            oneModH.subModuleInstanceNames()[subModInsIndex];
          // (.co(co), .a(a), .b(b), .ci(ci));
          const auto &portAssignmentsOfSubModIns =
            oneModH.portAssignmentsOfSubModInss()[subModInsIndex];
          // full_adder_co definition
          auto &oneSubMod = flatNetlist[subModDefIndex];
          uint32_t oneModFPortsNum = oneModF.ports().size();
          uint32_t oneSubModWirePos = oneSubMod.totalPortsExcludingWires();
          uint32_t newSize =
            oneModFPortsNum + oneSubMod.ports().size() - oneSubModWirePos;
          oneModF.ports().resize(newSize);
          oneModF.portNameMapPortDefIndex().reserve(newSize);
          // full_adder_co wires,n_0_0 become U1_n_0_0
          for(uint32_t i = oneModFPortsNum; i < oneModF.ports().size(); i++)
          {
            oneModF.ports()[i] = oneSubMod.ports()[oneSubModWirePos];
            oneModF.ports()[i].portDefName.insert(0, "/");
            oneModF.ports()[i].portDefName.insert(0, subModInsName);
            oneModF.portNameMapPortDefIndex()[oneModF.ports()[i].portDefName] =
              i;
            oneSubModWirePos++;
          }
          oneModF.subModuleDefIndexs().insert(
            oneModF.subModuleDefIndexs().end(),
            oneSubMod.subModuleDefIndexs().begin(),
            oneSubMod.subModuleDefIndexs().end());
          uint32_t blackBoxInsNameIndex = 0;
          uint32_t portAssignmentsIndex =
            oneModF.portAssignmentsOfSubModInss().size();
          oneModF.portAssignmentsOfSubModInss().resize(
            portAssignmentsIndex +
            oneSubMod.portAssignmentsOfSubModInss().size());
          // INV_X1_LVT i_0_0 (.A(a), .ZN(n_0_0));
          for(auto oneBlackBoxIns: oneSubMod.portAssignmentsOfSubModInss())
          {
            // blackBoxInsName i_0_0 becomes U1_i_0_0
            oneModF.subModuleInstanceNames().push_back(
              oneSubMod.subModuleInstanceNames()[blackBoxInsNameIndex]);
            blackBoxInsNameIndex++;
            oneModF.subModuleInstanceNames().back().insert(0, "/");
            oneModF.subModuleInstanceNames().back().insert(0, subModInsName);
            // .A(a)
            for(auto &portAssignmentOfBlackBox: oneBlackBoxIns)
            {
              for(auto &oneRefVar: portAssignmentOfBlackBox)
              {
                // Now, oneRefVar is a wire
                if(oneRefVar.refVarDefIndex >=
                     oneSubMod.totalPortsExcludingWires() &&
                   oneRefVar.refVarDefIndex < UINT32_MAX)
                {
                  oneRefVar.refVarDefIndex =
                    oneRefVar.refVarDefIndex -
                    oneSubMod.totalPortsExcludingWires() + oneModFPortsNum;
                }
                // Now,oneRefVar is a input, output or inout
                else if(oneRefVar.refVarDefIndex <
                        oneSubMod.totalPortsExcludingWires())
                { // If the port of full_adder_co instance is empty.
                  if(portAssignmentsOfSubModIns[oneRefVar.refVarDefIndex]
                       .empty())
                  {
                    portAssignmentOfBlackBox.clear();
                    break;
                  }
                  else
                    oneRefVar =
                      portAssignmentsOfSubModIns[oneRefVar.refVarDefIndex]
                                                [oneRefVar.bitIndex];
                }
                // Now,oneRefVar is a const value or x or z
                // else{}
              }
            }
            oneModF.portAssignmentsOfSubModInss()[portAssignmentsIndex] =
              oneBlackBoxIns;
            portAssignmentsIndex++;
          }
          uint32_t assignsIndex = oneModF.assigns().size();
          uint32_t totalAssigns = assignsIndex + oneSubMod.assigns().size();
          oneModF.assigns().resize(totalAssigns);
          for(auto oneAssign: oneSubMod.assigns())
          {
            bool _curAssignConnectToEmptySignal = false;
            // lValue is a wire
            if(oneAssign.lValue.refVarDefIndex >=
                 oneSubMod.totalPortsExcludingWires() &&
               oneAssign.lValue.refVarDefIndex < UINT32_MAX)
            {
              oneAssign.lValue.refVarDefIndex =
                oneAssign.lValue.refVarDefIndex -
                oneSubMod.totalPortsExcludingWires() + oneModFPortsNum;
            }
            // lValue is a inout or output
            else if(oneAssign.lValue.refVarDefIndex <
                    oneSubMod.totalPortsExcludingWires())
            {
              if(portAssignmentsOfSubModIns[oneAssign.lValue.refVarDefIndex]
                   .empty())
                _curAssignConnectToEmptySignal = true;
              else
                oneAssign.lValue =
                  portAssignmentsOfSubModIns[oneAssign.lValue.refVarDefIndex]
                                            [oneAssign.lValue.bitIndex];
            }
            // rValue is a wire
            if(oneAssign.rValue.refVarDefIndex >=
                 oneSubMod.totalPortsExcludingWires() &&
               oneAssign.rValue.refVarDefIndex < UINT32_MAX)
            {
              oneAssign.rValue.refVarDefIndex =
                oneAssign.rValue.refVarDefIndex -
                oneSubMod.totalPortsExcludingWires() + oneModFPortsNum;
            }
            // rValue is a input, inout or output
            else if(oneAssign.rValue.refVarDefIndex <
                    oneSubMod.totalPortsExcludingWires())
            {
              if(portAssignmentsOfSubModIns[oneAssign.rValue.refVarDefIndex]
                   .empty())
                _curAssignConnectToEmptySignal = true;
              else
                oneAssign.rValue =
                  portAssignmentsOfSubModIns[oneAssign.rValue.refVarDefIndex]
                                            [oneAssign.rValue.bitIndex];
            }
            if(_curAssignConnectToEmptySignal)
            {
              _curAssignConnectToEmptySignal = false;
              totalAssigns--;
            }
            else
            {
              oneModF.assigns()[assignsIndex] = oneAssign;
              assignsIndex++;
            }
          }
          oneModF.assigns().resize(totalAssigns);
        }
        subModInsIndex++;
      }
    }
  }
}

// make all empty black boxes store at the end of vector.
void VerilogNetlist::sortInsOrderInOneModule(const uint32_t &moduleIndex)
{
  auto &oneModule = _flatNetlist[moduleIndex];
  auto &subModDefIndexs = oneModule.subModuleDefIndexs();
  auto &subModInsNames = oneModule.subModuleInstanceNames();
  auto &subModPortAssignments = oneModule.portAssignmentsOfSubModInss();
  _totalUsedNotEmptyInsInOneMod = subModDefIndexs.size();
  for(uint32_t i = 0; i < _totalUsedNotEmptyInsInOneMod; i++)
  {
    if(subModDefIndexs[i] >= _totalUsedNotEmptyStdCells)
    {
      _totalUsedNotEmptyInsInOneMod--;
      while(subModDefIndexs[_totalUsedNotEmptyInsInOneMod] >=
            _totalUsedNotEmptyStdCells)
      {
        if(_totalUsedNotEmptyInsInOneMod > i)
          _totalUsedNotEmptyInsInOneMod--;
        else
          return;
      }
      std::swap(subModDefIndexs[i],
                subModDefIndexs[_totalUsedNotEmptyInsInOneMod]);
      std::swap(subModInsNames[i],
                subModInsNames[_totalUsedNotEmptyInsInOneMod]);
      std::swap(subModPortAssignments[i],
                subModPortAssignments[_totalUsedNotEmptyInsInOneMod]);
    }
    else if(subModDefIndexs[i] >= _totalUsedBlackBoxes)
      std::cout << "After flattening, no instanced module index will bigger "
                   "than _totalUsedBlackBoxes. You should check the module "
                << _flatNetlist[subModDefIndexs[i]].moduleDefName()
                << "whose instance name is " << subModInsNames[i] << "in "
                << oneModule.moduleDefName() << "of FlatNetlist.v.";
  }
}
