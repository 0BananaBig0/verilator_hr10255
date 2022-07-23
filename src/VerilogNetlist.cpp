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
  _totalUsedNotEmptyStdCells = hierNetlistVisitor.totalUsedNotEmptyStdCells();
  _totalUsedStdCells = hierNetlistVisitor.totalUsedStdCells();
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
    const auto &curMod = hierNetlist[modIndex];
    totalCharsEveryLine = 0;
    if(curMod.level() <= maxHierLevel || modIndex < totalUsedBlackBoxes)
    { // Print one module declaration
      ofs << "module " << curMod.moduleDefName() << "(";
      totalCharsEveryLine =
        totalCharsEveryLine + 7 + curMod.moduleDefName().size() + 1;
      for(const auto &port: curMod.ports())
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
      for(const auto &curPort: curMod.ports())
      {
        switch(curPort.portType)
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
              << curMod.moduleDefName() << " whose port name is"
              << curPort.portDefName;
          break;
        }
        if(curPort.isVector)
        {
          ofs << "[" << curPort.bitWidth - 1 << ":0]";
        }
        if(hasVerilogKeyWordOrOperator(curPort.portDefName))
        {
          shouldHaveEscapeChar = true;
          ofs << "\\";
        }
        ofs << curPort.portDefName;
        if(shouldHaveEscapeChar)
        {
          ofs << " ";
          shouldHaveEscapeChar = false;
        }
        ofs << ";" << std::endl;
      }

      // Every time print one assign statement, every assign statement only has
      // one bit data;
      for(auto curAssign: curMod.assigns())
      {
        ofs << "  assign ";
        if(hasVerilogKeyWordOrOperator(
             curMod.ports()[curAssign.lValue.refVarDefIndex].portDefName))
        {
          shouldHaveEscapeChar = true;
          ofs << "\\";
        }
        ofs << curMod.ports()[curAssign.lValue.refVarDefIndex].portDefName;
        if(shouldHaveEscapeChar)
        {
          ofs << " ";
          shouldHaveEscapeChar = false;
        }
        if(curAssign.lValue.refVarDefIndex != UINT32_MAX)
        {
          if(curMod.ports()[curAssign.lValue.refVarDefIndex].isVector)
            ofs << "[" << curAssign.lValue.bitIndex << "]";
        }
        else
        {
          throw std::runtime_error(
            "Assign left value can not be const value or x or z.");
        }
        ofs << " = ";
        // rValue is a consta value or x or z
        if(curAssign.rValue.refVarDefIndex == UINT32_MAX)
        {
          switch(curAssign.rValue.valueAndValueX)
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
               curMod.ports()[curAssign.rValue.refVarDefIndex].portDefName))
          {
            shouldHaveEscapeChar = true;
            ofs << "\\";
          }
          ofs << curMod.ports()[curAssign.rValue.refVarDefIndex].portDefName;
          if(shouldHaveEscapeChar)
          {
            ofs << " ";
            shouldHaveEscapeChar = false;
          }
          if(curMod.ports()[curAssign.rValue.refVarDefIndex].isVector)
            ofs << "[" << curAssign.rValue.bitIndex << "]";
        }
        ofs << ";" << std::endl;
      }

      // Every time print one submodule instance
      uint32_t subModInsIndex = 0;
      for(const auto &curSubModInsName: curMod.subModuleInstanceNames())
      {
        totalCharsEveryLine = 0;
        ofs << "  "
            << hierNetlist[curMod.subModuleDefIndexs()[subModInsIndex]]
                 .moduleDefName()
            << " ";
        if(hasVerilogKeyWordOrOperator(curSubModInsName))
        {
          ofs << "\\";
          totalCharsEveryLine++;
        }
        ofs << curSubModInsName << " "
            << "(";
        totalCharsEveryLine =
          totalCharsEveryLine + 5 +
          hierNetlist[curMod.subModuleDefIndexs()[subModInsIndex]]
            .moduleDefName()
            .size() +
          curSubModInsName.size();
        // Every time print one port assignment
        uint32_t portDefIndex = 0;
        for(const auto &curPortAssignment:
            curMod.portAssignmentsOfSubModInss()[subModInsIndex])
        {
          if(totalCharsEveryLine + 1 +
               hierNetlist[curMod.subModuleDefIndexs()[subModInsIndex]]
                 .ports()[portDefIndex]
                 .portDefName.size() >
             maxCharsEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharsEveryLine = 6;
          }
          ofs << ".";
          if(hasVerilogKeyWordOrOperator(
               hierNetlist[curMod.subModuleDefIndexs()[subModInsIndex]]
                 .ports()[portDefIndex]
                 .portDefName))
          {
            shouldHaveEscapeChar = true;
            ofs << "\\";
            totalCharsEveryLine++;
          }
          ofs << hierNetlist[curMod.subModuleDefIndexs()[subModInsIndex]]
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
            hierNetlist[curMod.subModuleDefIndexs()[subModInsIndex]]
              .ports()[portDefIndex]
              .portDefName.size();
          if(curPortAssignment.size() > 1)
          {
            ofs << "{";
            totalCharsEveryLine++;
          }
          for(uint32_t indexOfRefVars = curPortAssignment.size();
              indexOfRefVars > 0; indexOfRefVars--)
          {
            auto &refVar = curPortAssignment[indexOfRefVars - 1];
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
              if(curMod.ports()[refVar.refVarDefIndex].isVector)
              {
                if(totalCharsEveryLine +
                     curMod.ports()[refVar.refVarDefIndex].portDefName.size() +
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
                     curMod.ports()[refVar.refVarDefIndex].portDefName.size() >
                   maxCharsEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharsEveryLine = 6;
                }
              }
              if(hasVerilogKeyWordOrOperator(
                   curMod.ports()[refVar.refVarDefIndex].portDefName))
              {
                shouldHaveEscapeChar = true;
                ofs << "\\";
                totalCharsEveryLine++;
              }
              ofs << curMod.ports()[refVar.refVarDefIndex].portDefName;
              totalCharsEveryLine =
                totalCharsEveryLine +
                curMod.ports()[refVar.refVarDefIndex].portDefName.size();
              if(shouldHaveEscapeChar)
              {
                ofs << " ";
                totalCharsEveryLine++;
                shouldHaveEscapeChar = false;
              }
              if(curMod.ports()[refVar.refVarDefIndex].isVector)
              {
                ofs << "[" << refVar.bitIndex << "]";
                totalCharsEveryLine = totalCharsEveryLine + 2 +
                                      getDecimalNumberLength(refVar.bitIndex);
              }
            }
            ofs << ",";
            totalCharsEveryLine++;
          }
          if(curPortAssignment.size() >= 1)
          {
            ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
            totalCharsEveryLine--;
          }
          if(curPortAssignment.size() > 1)
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
    const auto &curModH = hierNetlist[modDefIndex];
    auto &curModF = flatNetlist[modDefIndex];
    if(curModH.level() < theMostDepthLevelExcludingBlackBoxes)
    {
      curModF.subModuleInstanceNames().clear();
      curModF.subModuleDefIndexs().clear();
      curModF.portAssignmentsOfSubModInss().clear();
      uint32_t subModInsIndex = 0;
      // full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
      for(auto &subModDefIndex: curModH.subModuleDefIndexs())
      {
        // subModule is a stdCell or an other black box
        if(subModDefIndex < totalUsedBlackBoxes)
        {
          curModF.subModuleInstanceNames().push_back(
            curModH.subModuleInstanceNames()[subModInsIndex]);
          curModF.subModuleDefIndexs().push_back(subModDefIndex);
          curModF.portAssignmentsOfSubModInss().push_back(
            curModH.portAssignmentsOfSubModInss()[subModInsIndex]);
        }
        else
        { // U1, subModule is not a stdCell nor an other black box
          const std::string &subModInsName =
            curModH.subModuleInstanceNames()[subModInsIndex];
          // (.co(co), .a(a), .b(b), .ci(ci));
          const auto &portAssignmentsOfSubModIns =
            curModH.portAssignmentsOfSubModInss()[subModInsIndex];
          // full_adder_co definition
          auto &curSubMod = flatNetlist[subModDefIndex];
          uint32_t curModFPortsNum = curModF.ports().size();
          uint32_t curSubModWirePos = curSubMod.totalPortsExcludingWires();
          uint32_t newSize =
            curModFPortsNum + curSubMod.ports().size() - curSubModWirePos;
          curModF.ports().resize(newSize);
          curModF.portNameMapPortDefIndex().reserve(newSize);
          // full_adder_co wires,n_0_0 become U1_n_0_0
          for(uint32_t i = curModFPortsNum; i < curModF.ports().size(); i++)
          {
            curModF.ports()[i] = curSubMod.ports()[curSubModWirePos];
            curModF.ports()[i].portDefName.insert(0, "/");
            curModF.ports()[i].portDefName.insert(0, subModInsName);
            curModF.portNameMapPortDefIndex()[curModF.ports()[i].portDefName] =
              i;
            curSubModWirePos++;
          }
          curModF.subModuleDefIndexs().insert(
            curModF.subModuleDefIndexs().end(),
            curSubMod.subModuleDefIndexs().begin(),
            curSubMod.subModuleDefIndexs().end());
          uint32_t blackBoxInsNameIndex = 0;
          uint32_t portAssignmentsIndex =
            curModF.portAssignmentsOfSubModInss().size();
          curModF.portAssignmentsOfSubModInss().resize(
            portAssignmentsIndex +
            curSubMod.portAssignmentsOfSubModInss().size());
          // INV_X1_LVT i_0_0 (.A(a), .ZN(n_0_0));
          for(auto curBlackBoxIns: curSubMod.portAssignmentsOfSubModInss())
          {
            // blackBoxInsName i_0_0 becomes U1_i_0_0
            curModF.subModuleInstanceNames().push_back(
              curSubMod.subModuleInstanceNames()[blackBoxInsNameIndex]);
            blackBoxInsNameIndex++;
            curModF.subModuleInstanceNames().back().insert(0, "/");
            curModF.subModuleInstanceNames().back().insert(0, subModInsName);
            // .A(a)
            for(auto &portAssignmentOfBlackBox: curBlackBoxIns)
            {
              for(auto &curRefVar: portAssignmentOfBlackBox)
              {
                // Now, curRefVar is a wire
                if(curRefVar.refVarDefIndex >=
                     curSubMod.totalPortsExcludingWires() &&
                   curRefVar.refVarDefIndex < UINT32_MAX)
                {
                  curRefVar.refVarDefIndex =
                    curRefVar.refVarDefIndex -
                    curSubMod.totalPortsExcludingWires() + curModFPortsNum;
                }
                // Now,curRefVar is a input, output or inout
                else if(curRefVar.refVarDefIndex <
                        curSubMod.totalPortsExcludingWires())
                { // If the port of full_adder_co instance is empty.
                  if(portAssignmentsOfSubModIns[curRefVar.refVarDefIndex]
                       .empty())
                  {
                    portAssignmentOfBlackBox.clear();
                    break;
                  }
                  else
                    curRefVar =
                      portAssignmentsOfSubModIns[curRefVar.refVarDefIndex]
                                                [curRefVar.bitIndex];
                }
                // Now,curRefVar is a const value or x or z
                // else{}
              }
            }
            curModF.portAssignmentsOfSubModInss()[portAssignmentsIndex] =
              curBlackBoxIns;
            portAssignmentsIndex++;
          }
          uint32_t assignsIndex = curModF.assigns().size();
          uint32_t totalAssigns = assignsIndex + curSubMod.assigns().size();
          curModF.assigns().resize(totalAssigns);
          for(auto curAssign: curSubMod.assigns())
          {
            bool _curAssignConnectToEmptySignal = false;
            // lValue is a wire
            if(curAssign.lValue.refVarDefIndex >=
                 curSubMod.totalPortsExcludingWires() &&
               curAssign.lValue.refVarDefIndex < UINT32_MAX)
            {
              curAssign.lValue.refVarDefIndex =
                curAssign.lValue.refVarDefIndex -
                curSubMod.totalPortsExcludingWires() + curModFPortsNum;
            }
            // lValue is a inout or output
            else if(curAssign.lValue.refVarDefIndex <
                    curSubMod.totalPortsExcludingWires())
            {
              if(portAssignmentsOfSubModIns[curAssign.lValue.refVarDefIndex]
                   .empty())
                _curAssignConnectToEmptySignal = true;
              else
                curAssign.lValue =
                  portAssignmentsOfSubModIns[curAssign.lValue.refVarDefIndex]
                                            [curAssign.lValue.bitIndex];
            }
            // rValue is a wire
            if(curAssign.rValue.refVarDefIndex >=
                 curSubMod.totalPortsExcludingWires() &&
               curAssign.rValue.refVarDefIndex < UINT32_MAX)
            {
              curAssign.rValue.refVarDefIndex =
                curAssign.rValue.refVarDefIndex -
                curSubMod.totalPortsExcludingWires() + curModFPortsNum;
            }
            // rValue is a input, inout or output
            else if(curAssign.rValue.refVarDefIndex <
                    curSubMod.totalPortsExcludingWires())
            {
              if(portAssignmentsOfSubModIns[curAssign.rValue.refVarDefIndex]
                   .empty())
                _curAssignConnectToEmptySignal = true;
              else
                curAssign.rValue =
                  portAssignmentsOfSubModIns[curAssign.rValue.refVarDefIndex]
                                            [curAssign.rValue.bitIndex];
            }
            if(_curAssignConnectToEmptySignal)
            {
              _curAssignConnectToEmptySignal = false;
              totalAssigns--;
            }
            else
            {
              curModF.assigns()[assignsIndex] = curAssign;
              assignsIndex++;
            }
          }
          curModF.assigns().resize(totalAssigns);
        }
        subModInsIndex++;
      }
    }
  }
}

// make all empty black boxes store at the end of vector.
void VerilogNetlist::sortInsOrderInTop(const uint32_t &topModIndex)
{
  auto &topMod = _flatNetlist[topModIndex];
  auto &subModDefIndexs = topMod.subModuleDefIndexs();
  auto &subModInsNames = topMod.subModuleInstanceNames();
  auto &subModPortAssignments = topMod.portAssignmentsOfSubModInss();
  _totalUsedNotEmptyInsInTop = subModDefIndexs.size();
  for(uint32_t curInsInd = 0; curInsInd < _totalUsedNotEmptyInsInTop;
      curInsInd++)
  {
    if(subModDefIndexs[curInsInd] >= _totalUsedNotEmptyStdCells)
    {
      _totalUsedNotEmptyInsInTop--;
      while(subModDefIndexs[_totalUsedNotEmptyInsInTop] >=
            _totalUsedNotEmptyStdCells)
      {
        if(_totalUsedNotEmptyInsInTop > curInsInd)
          _totalUsedNotEmptyInsInTop--;
        else
          return;
      }
      std::swap(subModDefIndexs[curInsInd],
                subModDefIndexs[_totalUsedNotEmptyInsInTop]);
      std::swap(subModInsNames[curInsInd],
                subModInsNames[_totalUsedNotEmptyInsInTop]);
      std::swap(subModPortAssignments[curInsInd],
                subModPortAssignments[_totalUsedNotEmptyInsInTop]);
    }
    else if(subModDefIndexs[curInsInd] >= _totalUsedBlackBoxes)
      std::cout << "After flattening, no instanced module index will bigger "
                   "than _totalUsedBlackBoxes. You should check the module "
                << _flatNetlist[subModDefIndexs[curInsInd]].moduleDefName()
                << "whose instance name is " << subModInsNames[curInsInd]
                << "in " << topMod.moduleDefName() << "of FlatNetlist.v.";
  }
}

// make all constant assignments( assign a = 1'b1 or 1'b0 or 1'bz or 1'bx)
// store at the end of vector.
void VerilogNetlist::sortAssignOrderInTop(const uint32_t &moduleIndex)
{
  auto &assigns = _flatNetlist[moduleIndex].assigns();
  _totalNotTieConstantAssign = assigns.size();
  for(uint32_t curAssignIndex = 0; curAssignIndex < _totalNotTieConstantAssign;
      curAssignIndex++)
  {
    auto &curAssign = assigns[curAssignIndex];
    if(!(curAssign.rValue.refVarDefIndex ^ UINT32_MAX))
    {
      _totalNotTieConstantAssign--;
      while(!(assigns[_totalNotTieConstantAssign].rValue.refVarDefIndex ^
              UINT32_MAX))
      {
        if(_totalNotTieConstantAssign >= curAssignIndex)
          _totalNotTieConstantAssign--;
        else
          return;
      }
      std::swap(curAssign, assigns[_totalNotTieConstantAssign]);
    }
  }
}

void VerilogNetlist::computePortsPositionInOneMod(const uint32_t &moduleIndex)
{
  auto &curMod = _flatNetlist[moduleIndex];
  curMod.portPositionInStdCellNetlists().resize(
    curMod.totalPortsExcludingWires(), 0);
  auto i = 0;
  while(i < (curMod.totalInoutsAndInputs() - 1) &&
        curMod.totalInoutsAndInputs() > 0)
  {
    curMod.portPositionInStdCellNetlists()[i + 1] =
      curMod.ports()[i].bitWidth + curMod.portPositionInStdCellNetlists()[i];
    i++;
  }
  if(curMod.totalInoutsAndInputs() > 0)
    i++;
  if(curMod.totalInouts() > 0)
    curMod.portPositionInStdCellNetlists()[i] =
      curMod.portPositionInStdCellNetlists()[curMod.totalInouts()];
  while(i < (curMod.totalPortsExcludingWires() - 1) &&
        curMod.totalPortsExcludingWires() > 0)
  {
    curMod.portPositionInStdCellNetlists()[i + 1] =
      curMod.ports()[i].bitWidth + curMod.portPositionInStdCellNetlists()[i];
    i++;
  }
}
