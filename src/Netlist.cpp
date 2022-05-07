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

void EmitHierNetlist::emitHierNetlists(std::vector<Module> &hierNetlist,
                                       uint32_t &theNumberOfStdCellsShouldUse)
{
  HierNetlistVisitor hierNetlistVisitor(v3Global.rootp());
  hierNetlist = hierNetlistVisitor.getHierNetlist();
  theNumberOfStdCellsShouldUse =
    hierNetlistVisitor.getTheNumberOfStdCellsShouldUse();
}

void EmitHierNetlist::printHierNetlist(
  const std::vector<Module> &hierNetlist,
  const uint32_t &theNumberOfStdCellsShouldUse, std::string fileName,
  const uint32_t hierMaxLevel)
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
  uint32_t moduleIndex = theNumberOfStdCellsShouldUse;
  // Every time print one module defintion
  for(uint32_t moduleIndex = theNumberOfStdCellsShouldUse;
      moduleIndex < hierNetlist.size(); moduleIndex++)
  {
    const auto &oneModule = hierNetlist[moduleIndex];
    totalCharactersEveryLine = 0;
    if(oneModule.level <= hierMaxLevel)
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
             oneModule.ports[oneAssign.lValue.varRefIndex].portDefName))
        {
          shouldHaveEscapeCharacter = true;
          ofs << "\\";
        }
        ofs << oneModule.ports[oneAssign.lValue.varRefIndex].portDefName;
        if(shouldHaveEscapeCharacter)
        {
          ofs << " ";
          shouldHaveEscapeCharacter = false;
        }
        if(oneAssign.lValue.varRefIndex != UINT_MAX)
        {
          if(oneModule.ports[oneAssign.lValue.varRefIndex].isVector)
            ofs << "[" << oneAssign.lValue.index << "]";
        }
        else
        {
          throw std::runtime_error(
            "Assign left value can not be const value or x or z.");
        }
        ofs << " = ";
        // rValue is a consta value or x or z
        if(oneAssign.rValue.varRefIndex == UINT_MAX)
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
               oneModule.ports[oneAssign.rValue.varRefIndex].portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
          }
          ofs << oneModule.ports[oneAssign.rValue.varRefIndex].portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            shouldHaveEscapeCharacter = false;
          }
          if(oneModule.ports[oneAssign.rValue.varRefIndex].isVector)
            ofs << "[" << oneAssign.rValue.index << "]";
        }
        ofs << ";" << std::endl;
      }

      // Every time print one submodule instance
      uint32_t subModuleIndex = 0;
      for(const auto &onesubModuleInstanceName:
          oneModule.subModuleInstanceNames)
      {
        totalCharactersEveryLine = 0;
        ofs << "  "
            << hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
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
          hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
            .moduleDefName.size() +
          onesubModuleInstanceName.size();
        // Every time print one port assignment
        uint32_t portDefIndex = 0;
        for(const auto &onePortAssignment:
            oneModule.portAssignmentsOfSubModuleInstances[subModuleIndex])
        {
          if(totalCharactersEveryLine + 1 +
               hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
                 .ports[portDefIndex]
                 .portDefName.size() >
             maxCharactersEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharactersEveryLine = 6;
          }
          ofs << ".";
          if(haveVerilogKeyWordOrOperator(
               hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
                 .ports[portDefIndex]
                 .portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
            totalCharactersEveryLine++;
          }
          ofs << hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
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
            hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
              .ports[portDefIndex]
              .portDefName.size();
          if(onePortAssignment.varRefs.size() > 1)
          {
            ofs << "{";
            totalCharactersEveryLine++;
          }
          for(uint32_t indexOfVarRefs = onePortAssignment.varRefs.size();
              indexOfVarRefs > 0; indexOfVarRefs--)
          {
            auto &varRef = onePortAssignment.varRefs[indexOfVarRefs - 1];
            if(varRef.varRefIndex == UINT_MAX)
            {
              if(totalCharactersEveryLine + 4 > maxCharactersEveryLine)
              {
                ofs << std::endl << "      ";
                totalCharactersEveryLine = 6;
              }
              switch(varRef.valueAndValueX)
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
              if(oneModule.ports[varRef.varRefIndex].isVector)
              {
                if(totalCharactersEveryLine +
                     oneModule.ports[varRef.varRefIndex].portDefName.size() +
                     2 + getDecimalNumberLength(varRef.index) >
                   maxCharactersEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharactersEveryLine = 6;
                }
              }
              else
              {
                if(totalCharactersEveryLine +
                     oneModule.ports[varRef.varRefIndex].portDefName.size() >
                   maxCharactersEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharactersEveryLine = 6;
                }
              }
              if(haveVerilogKeyWordOrOperator(
                   oneModule.ports[varRef.varRefIndex].portDefName))
              {
                shouldHaveEscapeCharacter = true;
                ofs << "\\";
                totalCharactersEveryLine++;
              }
              ofs << oneModule.ports[varRef.varRefIndex].portDefName;
              totalCharactersEveryLine =
                totalCharactersEveryLine +
                oneModule.ports[varRef.varRefIndex].portDefName.size();
              if(shouldHaveEscapeCharacter)
              {
                ofs << " ";
                totalCharactersEveryLine++;
                shouldHaveEscapeCharacter = false;
              }
              if(oneModule.ports[varRef.varRefIndex].isVector)
              {
                ofs << "[" << varRef.index << "]";
                totalCharactersEveryLine =
                  totalCharactersEveryLine + 2 +
                  getDecimalNumberLength(varRef.index);
              }
            }
            ofs << ",";
            totalCharactersEveryLine++;
          }
          if(onePortAssignment.varRefs.size() >= 1)
          {
            ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
            totalCharactersEveryLine--;
          }
          if(onePortAssignment.varRefs.size() > 1)
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
        subModuleIndex++;
      }
      ofs << "endmodule" << std::endl << std::endl;
    }
  }
  ofs.close();
}

// Use case2 as a example to demonstrate.
void EmitHierNetlist::emitFlattenedNetlists(
  std::vector<Module> &hierNetlist, std::vector<Module> &flatNetlist,
  uint32_t &theNumberOfStdCellsShouldUse)
{
  flatNetlist = hierNetlist;
  // Use to not flatten such module which only have standard cells or assign
  // statement; Sometimes, theNumberOfStdCellsShouldUse = 0.
  auto &theMostDepthLevelExcludingStdCells = hierNetlist.back().level;
  for(uint32_t moduleDefIndex = hierNetlist.size() - 1;
      moduleDefIndex >= theNumberOfStdCellsShouldUse &&
      moduleDefIndex != UINT_MAX;
      moduleDefIndex--)
  {
    // full_adder definition
    const auto &oneModuleH = hierNetlist[moduleDefIndex];
    auto &oneModuleF = flatNetlist[moduleDefIndex];
    if((oneModuleH.level < theMostDepthLevelExcludingStdCells) &&
       !(oneModuleH.subModuleDefIndex.empty() && oneModuleH.assigns.empty()))
    {
      oneModuleF.subModuleInstanceNames.clear();
      oneModuleF.subModuleDefIndex.clear();
      oneModuleF.portAssignmentsOfSubModuleInstances.clear();
      uint32_t subModuleInstanceIndex = 0;
      // full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
      for(auto &subModuleDefIndex: oneModuleH.subModuleDefIndex)
      {
        // subModule is a stdCell or a black box
        if((subModuleDefIndex < theNumberOfStdCellsShouldUse) ||
           (hierNetlist[subModuleDefIndex].subModuleDefIndex.empty() &&
            hierNetlist[subModuleDefIndex].assigns.empty()))
        {
          oneModuleF.subModuleInstanceNames.push_back(
            oneModuleH.subModuleInstanceNames[subModuleInstanceIndex]);
          oneModuleF.subModuleDefIndex.push_back(subModuleDefIndex);
          oneModuleF.portAssignmentsOfSubModuleInstances.push_back(
            oneModuleH
              .portAssignmentsOfSubModuleInstances[subModuleInstanceIndex]);
        }
        else
        { // U1, subModule is not a stdCell
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
            oneSubModule.theNumberOfPortExcludingWire;
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
          uint32_t stdCellInstanceNameIndex = 0;
          // INV_X1_LVT i_0_0 (.A(a), .ZN(n_0_0));
          for(auto oneStdCellIns:
              oneSubModule.portAssignmentsOfSubModuleInstances)
          {
            // stdInstanceName i_0_0 becomes U1_i_0_0
            oneModuleF.subModuleInstanceNames.push_back(
              oneSubModule.subModuleInstanceNames[stdCellInstanceNameIndex]);
            stdCellInstanceNameIndex++;
            oneModuleF.subModuleInstanceNames.back().insert(0, "_");
            oneModuleF.subModuleInstanceNames.back().insert(
              0, subModuleInstanceName);
            // .A(a)
            for(auto &portAssignmentOfStdCell: oneStdCellIns)
            {
              for(auto &oneVarRef: portAssignmentOfStdCell.varRefs)
              {
                // Now, oneVarRef is a wire
                if(oneVarRef.varRefIndex >=
                     oneSubModule.theNumberOfPortExcludingWire &&
                   oneVarRef.varRefIndex < UINT_MAX)
                {
                  oneVarRef.varRefIndex =
                    oneVarRef.varRefIndex -
                    oneSubModule.theNumberOfPortExcludingWire +
                    oneModuleFPortsNumber;
                }
                // Now,oneVarRef is a input, output or inout
                else if(oneVarRef.varRefIndex <
                        oneSubModule.theNumberOfPortExcludingWire)
                { // If the port of full_adder_co instance is empty.
                  if(portAssignmentsOfSubModuleInstance[oneVarRef.varRefIndex]
                       .varRefs.empty())
                  {
                    portAssignmentOfStdCell.varRefs.clear();
                  }
                  else
                    oneVarRef =
                      portAssignmentsOfSubModuleInstance[oneVarRef.varRefIndex]
                        .varRefs[oneVarRef.index];
                }
                // Now,oneVarRef is a const value or x or z
                // else{}
              }
            }
            oneModuleF.portAssignmentsOfSubModuleInstances.push_back(
              std::move(oneStdCellIns));
          }
          for(auto oneAssign: oneSubModule.assigns)
          {
            bool _curAssignConnectToEmptySignal = false;
            if(oneAssign.lValue.varRefIndex >=
                 oneSubModule.theNumberOfPortExcludingWire &&
               oneAssign.lValue.varRefIndex < UINT_MAX)
            {
              oneAssign.lValue.varRefIndex =
                oneAssign.lValue.varRefIndex -
                oneSubModule.theNumberOfPortExcludingWire +
                oneModuleFPortsNumber;
            }
            else if(oneAssign.lValue.varRefIndex <
                    oneSubModule.theNumberOfPortExcludingWire)
            {
              if(portAssignmentsOfSubModuleInstance[oneAssign.lValue
                                                      .varRefIndex]
                   .varRefs.empty())
                _curAssignConnectToEmptySignal = true;
              else
                oneAssign.lValue =
                  portAssignmentsOfSubModuleInstance[oneAssign.lValue
                                                       .varRefIndex]
                    .varRefs[oneAssign.lValue.index];
            }
            if(oneAssign.rValue.varRefIndex >=
                 oneSubModule.theNumberOfPortExcludingWire &&
               oneAssign.rValue.varRefIndex < UINT_MAX)
            {
              oneAssign.rValue.varRefIndex =
                oneAssign.rValue.varRefIndex -
                oneSubModule.theNumberOfPortExcludingWire +
                oneModuleFPortsNumber;
            }
            else if(oneAssign.rValue.varRefIndex <
                    oneSubModule.theNumberOfPortExcludingWire)
            {
              if(portAssignmentsOfSubModuleInstance[oneAssign.rValue
                                                      .varRefIndex]
                   .varRefs.empty())
                _curAssignConnectToEmptySignal = true;
              else
                oneAssign.rValue =
                  portAssignmentsOfSubModuleInstance[oneAssign.rValue
                                                       .varRefIndex]
                    .varRefs[oneAssign.rValue.index];
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
