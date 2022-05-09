/*************************************************************************
  > File Name: Netlist.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Sun 01 May 2022 04:09:26 PM CST
 ************************************************************************/

#include "Netlist.h"
#include <climits>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <unordered_set>

void ProcessNetlist::getHierNet(std::vector<Module> &hierNetlist,
                                uint32_t &totalUsedStdCells,
                                uint32_t &totalUsedBlackBoxes)
{
  HierNetlistVisitor hierNetlistVisitor(v3Global.rootp());
  hierNetlist = hierNetlistVisitor.getHierNetlist();
  totalUsedStdCells = hierNetlistVisitor.getTotalUsedStdCells();
  totalUsedBlackBoxes = hierNetlistVisitor.getTotalUsedBlackBoxes();
}

void ProcessNetlist::printNetlist(const std::vector<Module> &hierNetlist,
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
void ProcessNetlist::FlattenHierNet(std::vector<Module> &hierNetlist,
                                    std::vector<Module> &flatNetlist,
                                    uint32_t &totalUsedBlackBoxes)
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
