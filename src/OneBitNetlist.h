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
#include <limits.h>
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
    // If refVarDefIndex == UINT_MAX, it means it is a const value, X or Z.
    uint32_t refVarDefIndex = UINT_MAX;
    union
    {
        uint32_t bitIndex; // Like C[1], bitIndex = 1;
        char valueAndValueX;
    };
};

//.A({1'b0,ci,C[1],C[2]})
// Used in module instantiation
struct PortAssignment
{
    // Everytime, it only pushes one bit information, for example, C[1], 1'b0,
    // not store C[1:0],which will be broken into C[1], C[0]
    std::vector<RefVar> refVars;
};

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
struct Module
{
  public:
    std::string moduleDefName; // Module Defined Name
    uint32_t level = 0;        // the maximal depth in the hierarchical tree

    /* Netlist Definition Information(START) */
    std::vector<PortDefinition> ports;
    uint32_t totalInputs;
    uint32_t totalInputsAndInouts;
    uint32_t totalPortsExcludingWires;
    std::vector<BitSlicedAssignStatement> assigns;
    /* Netlist Definition Information(END) */

    /* Netlist Instance Information(START) */
    // Instance name of all sub modules of current module
    std::vector<std::string> subModuleInstanceNames;
    // All sub modules definition index in hierNetlist of current module
    std::vector<uint32_t> subModuleDefIndexs;
    std::vector<std::vector<PortAssignment>> portAssignmentsOfSubModInss;
    /* Netlist Instance Information(END) */
};
