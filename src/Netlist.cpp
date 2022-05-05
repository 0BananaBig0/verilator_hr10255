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

bool isStdCell(const std::string &moduleName)
{
  const std::unordered_set<std::string> stdCells = {
    "ADDFHX1",   "ADDFHX2",    "ADDFHX4",    "ADDFHXL",    "ADDFX1",
    "ADDFX2",    "ADDFX4",     "ADDFXL",     "ADDHX1",     "ADDHX2",
    "ADDHX4",    "ADDHXL",     "AND2X1",     "AND2X2",     "AND2X4",
    "AND2XL",    "AND3X1",     "AND3X2",     "AND3X4",     "AND3XL",
    "AND4X1",    "AND4X2",     "AND4X4",     "AND4XL",     "AOI211X1",
    "AOI211X2",  "AOI211X4",   "AOI211XL",   "AOI21X1",    "AOI21X2",
    "AOI21X4",   "AOI21XL",    "AOI221X1",   "AOI221X2",   "AOI221X4",
    "AOI221XL",  "AOI222X1",   "AOI222X2",   "AOI222X4",   "AOI222XL",
    "AOI22X1",   "AOI22X2",    "AOI22X4",    "AOI22XL",    "AOI2BB1X1",
    "AOI2BB1X2", "AOI2BB1X4",  "AOI2BB1XL",  "AOI2BB2X1",  "AOI2BB2X2",
    "AOI2BB2X4", "AOI2BB2XL",  "AOI31X1",    "AOI31X2",    "AOI31X4",
    "AOI31XL",   "AOI32X1",    "AOI32X2",    "AOI32X4",    "AOI32XL",
    "AOI33X1",   "AOI33X2",    "AOI33X4",    "AOI33XL",    "BUFX1",
    "BUFX12",    "BUFX16",     "BUFX2",      "BUFX20",     "BUFX3",
    "BUFX4",     "BUFX8",      "BUFXL",      "CLKBUFX1",   "CLKBUFX12",
    "CLKBUFX16", "CLKBUFX2",   "CLKBUFX20",  "CLKBUFX3",   "CLKBUFX4",
    "CLKBUFX8",  "CLKBUFXL",   "CLKINVX1",   "CLKINVX12",  "CLKINVX16",
    "CLKINVX2",  "CLKINVX20",  "CLKINVX3",   "CLKINVX4",   "CLKINVX8",
    "CLKINVXL",  "DFFHQX1",    "DFFHQX2",    "DFFHQX4",    "DFFHQXL",
    "DFFNSRX1",  "DFFNSRX2",   "DFFNSRX4",   "DFFNSRXL",   "DFFRHQX1",
    "DFFRHQX2",  "DFFRHQX4",   "DFFRHQXL",   "DFFRX1",     "DFFRX2",
    "DFFRX4",    "DFFRXL",     "DFFSHQX1",   "DFFSHQX2",   "DFFSHQX4",
    "DFFSHQXL",  "DFFSRHQX1",  "DFFSRHQX2",  "DFFSRHQX4",  "DFFSRHQXL",
    "DFFSRX1",   "DFFSRX2",    "DFFSRX4",    "DFFSRXL",    "DFFSX1",
    "DFFSX2",    "DFFSX4",     "DFFSXL",     "DFFTRX1",    "DFFTRX2",
    "DFFTRX4",   "DFFTRXL",    "DFFX1",      "DFFX2",      "DFFX4",
    "DFFXL",     "DLY1X1",     "DLY2X1",     "DLY3X1",     "DLY4X1",
    "EDFFTRX1",  "EDFFTRX2",   "EDFFTRX4",   "EDFFTRXL",   "EDFFX1",
    "EDFFX2",    "EDFFX4",     "EDFFXL",     "INVX1",      "INVX12",
    "INVX16",    "INVX2",      "INVX20",     "INVX3",      "INVX4",
    "INVX8",     "INVXL",      "JKFFRX1",    "JKFFRX2",    "JKFFRX4",
    "JKFFRXL",   "JKFFSRX1",   "JKFFSRX2",   "JKFFSRX4",   "JKFFSRXL",
    "JKFFSX1",   "JKFFSX2",    "JKFFSX4",    "JKFFSXL",    "JKFFX1",
    "JKFFX2",    "JKFFX4",     "JKFFXL",     "MX2X1",      "MX2X2",
    "MX2X4",     "MX2XL",      "MX4X1",      "MX4X2",      "MX4X4",
    "MX4XL",     "MXI2X1",     "MXI2X2",     "MXI2X4",     "MXI2XL",
    "MXI4X1",    "MXI4X2",     "MXI4X4",     "MXI4XL",     "NAND2BX1",
    "NAND2BX2",  "NAND2BX4",   "NAND2BXL",   "NAND2X1",    "NAND2X2",
    "NAND2X4",   "NAND2XL",    "NAND3BX1",   "NAND3BX2",   "NAND3BX4",
    "NAND3BXL",  "NAND3X1",    "NAND3X2",    "NAND3X4",    "NAND3XL",
    "NAND4BBX1", "NAND4BBX2",  "NAND4BBX4",  "NAND4BBXL",  "NAND4BX1",
    "NAND4BX2",  "NAND4BX4",   "NAND4BXL",   "NAND4X1",    "NAND4X2",
    "NAND4X4",   "NAND4XL",    "NOR2BX1",    "NOR2BX2",    "NOR2BX4",
    "NOR2BXL",   "NOR2X1",     "NOR2X2",     "NOR2X4",     "NOR2XL",
    "NOR3BX1",   "NOR3BX2",    "NOR3BX4",    "NOR3BXL",    "NOR3X1",
    "NOR3X2",    "NOR3X4",     "NOR3XL",     "NOR4BBX1",   "NOR4BBX2",
    "NOR4BBX4",  "NOR4BBXL",   "NOR4BX1",    "NOR4BX2",    "NOR4BX4",
    "NOR4BXL",   "NOR4X1",     "NOR4X2",     "NOR4X4",     "NOR4XL",
    "OAI211X1",  "OAI211X2",   "OAI211X4",   "OAI211XL",   "OAI21X1",
    "OAI21X2",   "OAI21X4",    "OAI21XL",    "OAI221X1",   "OAI221X2",
    "OAI221X4",  "OAI221XL",   "OAI222X1",   "OAI222X2",   "OAI222X4",
    "OAI222XL",  "OAI22X1",    "OAI22X2",    "OAI22X4",    "OAI22XL",
    "OAI2BB1X1", "OAI2BB1X2",  "OAI2BB1X4",  "OAI2BB1XL",  "OAI2BB2X1",
    "OAI2BB2X2", "OAI2BB2X4",  "OAI2BB2XL",  "OAI31X1",    "OAI31X2",
    "OAI31X4",   "OAI31XL",    "OAI32X1",    "OAI32X2",    "OAI32X4",
    "OAI32XL",   "OAI33X1",    "OAI33X2",    "OAI33X4",    "OAI33XL",
    "OR2X1",     "OR2X2",      "OR2X4",      "OR2XL",      "OR3X1",
    "OR3X2",     "OR3X4",      "OR3XL",      "OR4X1",      "OR4X2",
    "OR4X4",     "OR4XL",      "RSLATNX1",   "RSLATNX2",   "RSLATNX4",
    "RSLATNXL",  "SDFFHQX1",   "SDFFHQX2",   "SDFFHQX4",   "SDFFHQXL",
    "SDFFNSRX1", "SDFFNSRX2",  "SDFFNSRX4",  "SDFFNSRXL",  "SDFFRHQX1",
    "SDFFRHQX2", "SDFFRHQX4",  "SDFFRHQXL",  "SDFFRX1",    "SDFFRX2",
    "SDFFRX4",   "SDFFRXL",    "SDFFSHQX1",  "SDFFSHQX2",  "SDFFSHQX4",
    "SDFFSHQXL", "SDFFSRHQX1", "SDFFSRHQX2", "SDFFSRHQX4", "SDFFSRHQXL",
    "SDFFSRX1",  "SDFFSRX2",   "SDFFSRX4",   "SDFFSRXL",   "SDFFSX1",
    "SDFFSX2",   "SDFFSX4",    "SDFFSXL",    "SDFFTRX1",   "SDFFTRX2",
    "SDFFTRX4",  "SDFFTRXL",   "SDFFX1",     "SDFFX2",     "SDFFX4",
    "SDFFXL",    "SEDFFHQX1",  "SEDFFHQX2",  "SEDFFHQX4",  "SEDFFHQXL",
    "SEDFFTRX1", "SEDFFTRX2",  "SEDFFTRX4",  "SEDFFTRXL",  "SEDFFX1",
    "SEDFFX2",   "SEDFFX4",    "SEDFFXL",    "TBUFX1",     "TBUFX12",
    "TBUFX16",   "TBUFX2",     "TBUFX20",    "TBUFX3",     "TBUFX4",
    "TBUFX8",    "TBUFXL",     "TIEHI",      "TIELO",      "TINVX1",
    "TLATNSRX1", "TLATNSRX2",  "TLATNSRX4",  "TLATNSRXL",  "TLATNX1",
    "TLATNX2",   "TLATNX4",    "TLATNXL",    "TLATSRX1",   "TLATSRX2",
    "TLATSRX4",  "TLATSRXL",   "TLATX1",     "TLATX2",     "TLATX4",
    "TLATXL",    "XNOR2X1",    "XNOR2X2",    "XNOR2X4",    "XNOR2XL",
    "XNOR3X2",   "XNOR3X4",    "XOR2X1",     "XOR2X2",     "XOR2X4",
    "XOR2XL",    "XOR3X2",     "XOR3X4"
  };
  return stdCells.find(moduleName) != stdCells.end();
}

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
    if(oneModuleH.level < theMostDepthLevelExcludingStdCells)
    {
      oneModuleF.subModuleInstanceNames.clear();
      oneModuleF.subModuleDefIndex.clear();
      oneModuleF.portAssignmentsOfSubModuleInstances.clear();
      uint32_t subModuleInstanceIndex = 0;
      // full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
      for(auto &subModuleDefIndex: oneModuleH.subModuleDefIndex)
      {
        // subModule is a stdCell
        if(subModuleDefIndex < theNumberOfStdCellsShouldUse)
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
