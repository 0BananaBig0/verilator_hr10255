/*************************************************************************
  > File Name: OneBitNetlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Wed 13 Apr 2022 08:18:03 AM CST
 ************************************************************************/
#pragma once

#include <cstdint>
#include <cstdlib>
#include <exception>
#include <string>
#include <unistd.h>
#include <unordered_set>
#include <vector>

#ifndef CHAR_ZERO
#define CHAR_ZERO char(0x00)
#endif

#ifndef CHAR_ONE
#define CHAR_ONE char(0xFF)
#endif

#ifndef CHAR_X
#define CHAR_X char(0x0F)
#endif

#ifndef CHAR_Z
#define CHAR_Z char(0xF0)
#endif

enum class PortType
{
  INPUT,
  OUTPUT,
  INOUT,
  WIRE,          // not belong to PortType, but we put it with PortType.
  LAST_PORT_TYPE // The number of port type
};

// It is used to store input, output, inout and wire definition.
struct PortDefinition
{
    std::string portDefName; // Port Defined Name
    PortType portType = PortType::LAST_PORT_TYPE;
    bool isVector = false;
    uint32_t bitWidth = 1;
};

// RefVar = Referenced Variable
// Everytime it stores only one bit information, for example, C[1], ci, 1'b0,
// not store C[3:0], which will be broken into C[3], C[2], C[1], C[0].
struct RefVar
{
    // Referenced Variable Definition Index in std::vector<PortDefinition>
    // If refVarDefIndex == UINT32_MAX, it means it is a const value, X or Z.
    uint32_t refVarDefIndex = UINT32_MAX;
    union
    {
        uint32_t bitIndex; // Like C[1], bitIndex = 1;
        char valueAndValueX;
    };
};

//.A({1'b0,ci,C[1],C[2]})
// Used in module instantiation
// struct PortAssignment
// {
//     // Everytime, it only pushes one bit information, for example, C[1], 1'b0,
//     // not store C[1:0],which will be broken into C[1], C[0]
//     std::vector<RefVar> refVars;
// };
typedef std::vector<RefVar> PortAssignment;

// It is used to store one bit assign statement, for example, C[1]=1'b0,
// C[2] = ci, not sotre C[1:0] = {1'b0, co} or C[1:0] = B[1:0],
// which will be broken into C[1] = 1'b0, C[0] = co or C[1] = B[1], C[0] = B[0]
struct BitSlicedAssignStatement
{
    RefVar lValue; // left value (locator value)
    RefVar rValue; // right value (read value)
};

// The oreder in ports, subModuleInstanceNames, subModuleDefIndexs,
// portAssignmentsOfSubModInss, std::vector<PortAssignment>,
// std::vector<RefVar> and std::vector<Module> are important.
class Module
{
  public:
    Module() :
      _level(0), _totalInputs(0), _totalInputsAndInouts(0),
      _totalPortsExcludingWires(0)
    {
      ;
    }
    ~Module() { ; }

    void moduleDefName(const std::string &name) { _moduleDefName = name; }
    const std::string &moduleDefName() const { return _moduleDefName; }

    void level(const uint32_t &level) { _level = level; }
    const uint32_t &level() const { return _level; }

    const std::vector<PortDefinition> &ports() const { return _ports; }
    std::vector<PortDefinition> &ports() { return _ports; }

    void totalInputs(const uint32_t &number) { _totalInputs = number; }
    const uint32_t &totalInputs() const { return _totalInputs; }

    void totalInputsAndInouts(const uint32_t &number)
    {
      _totalInputsAndInouts = number;
    }
    const uint32_t &totalInputsAndInouts() const
    {
      return _totalInputsAndInouts;
    }

    void totalPortsExcludingWires(const uint32_t &number)
    {
      _totalPortsExcludingWires = number;
    }
    const uint32_t &totalPortsExcludingWires() const
    {
      return _totalPortsExcludingWires;
    }

    std::vector<BitSlicedAssignStatement> &assigns() { return _assigns; }
    const std::vector<BitSlicedAssignStatement> &assigns() const
    {
      return _assigns;
    }

    std::vector<std::string> &subModuleInstanceNames()
    {
      return _subModuleInstanceNames;
    }
    const std::vector<std::string> &subModuleInstanceNames() const
    {
      return _subModuleInstanceNames;
    }

    std::vector<uint32_t> &subModuleDefIndexs() { return _subModuleDefIndexs; }
    const std::vector<uint32_t> &subModuleDefIndexs() const
    {
      return _subModuleDefIndexs;
    }

    std::vector<std::vector<PortAssignment>> &portAssignmentsOfSubModInss()
    {
      return _portAssignmentsOfSubModInss;
    }
    const std::vector<std::vector<PortAssignment>> &
    portAssignmentsOfSubModInss() const
    {
      return _portAssignmentsOfSubModInss;
    }

  private:
    std::string _moduleDefName; // Module Defined Name
    uint32_t _level = 0;        // the maximal depth in the hierarchical tree

    /* Netlist Definition Information(START) */
    std::vector<PortDefinition> _ports;
    uint32_t _totalInputs;
    uint32_t _totalInputsAndInouts;
    uint32_t _totalPortsExcludingWires;
    std::vector<BitSlicedAssignStatement> _assigns;
    /* Netlist Definition Information(END) */

    /* Netlist Instance Information(START) */
    // Instance name of all sub modules of current module
    std::vector<std::string> _subModuleInstanceNames;
    // All sub modules definition index in hierNetlist of current module
    std::vector<uint32_t> _subModuleDefIndexs;
    // The following structure is a three dimensions vector.
    // The first dimension: submodule
    // The second dimension: portAssignments of one submodule
    // The third dimension: one port assignment
    std::vector<std::vector<PortAssignment>> _portAssignmentsOfSubModInss;
    /* Netlist Instance Information(END) */
};
