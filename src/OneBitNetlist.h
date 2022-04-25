/*************************************************************************
  > File Name: netlistsdefineNew.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Wed 13 Apr 2022 08:18:03 AM CST
 ************************************************************************/
#pragma once

#include <cstdint>
#include <string>
#include <unordered_map>
#include <vector>
#define ZERO  char(0x00)
#define ONE   char(0xFF)
#define X     char(0x0F)
#define Z     char(0xF0)
#define MAX32 uint32_t(0xFFFFFFFF)

enum class PortType
{
  INPUT,
  OUTPUT,
  INOUT,
  WIRE,          // not belong to PortType
  LAST_PORT_TYPE // The number of port type
};

// It is used to store input, output, inout and wire definition.
struct PortDefinition
{
    std::string portDefName; // Port Defined Name
    PortType portType = PortType::LAST_PORT_TYPE;
    bool isVector = false;
    uint32_t bitWidth = 1;
    // Only use for port whoes PortType is OUTPUT or INOUT or WIRE.
    // Because, every port whoes PortType is not INPUT can be used as
    // output of submodule only once. And this port can be input of
    // another module.
    // If A is the parent of B, then B is one child of A.
    std::vector<uint32_t> whichInstanceOutput;
    // For example, wire[3:0] w;w[0] and w[1] is the output of U0,
    // w[2] and w[3] is the output of U1;
    // the result of whichInstanceOutput is:
    // PortIndex       0 1 2 3
    // InstanceIndex   0 0 1 1
};

// VarRef = Variable Referenced
// Everytime it store only one bit information, for example, C[1], ci, 1'b0,
// not store C[3:0], which will be broken into C[3], C[2], C[1], C[0].
// if(varRefIndex !="")
//   hasIndex means the variable is like C[1], C[0], not like ci;
// else
//   hasIndex has no meaning.

struct VarRef
{
    // Variable Referenced Index in std::vector<PortDefinition>
    // If varRefIndex == MAX32, it means it is a const value, X or Z.
    uint32_t varRefIndex = MAX32;
    bool isVector = false;
    union
    {
        uint32_t index; // Like C[1], index = 1;
        char valueAndValueX;
    };
};

//.A({1'b0,ci,C[1],C[2]})
// PortInstanceMsg = Port Instanced Message
struct PortAssignment
{
    uint32_t portDefIndex; // Port Definition Index
    // Everytime, it only pushes one bit information, for example, C[1], 1'b0,
    // not store C[1:0]
    std::vector<VarRef> varRefs;
};

// It is used to store one bit assign statement, for example, C[1]=1'b0,
// C[2] = ci, not sotre C[1:0] = {1'b0, co} or C[1:0] = B[1:0];

struct BitSlicedAssignStatement
{
    VarRef lValue; // left value (locator value)
    VarRef rValue; // right value (read value)
};

struct Module
{
  public:
    std::string moduleDefName; // Module Defined Name
    uint32_t level = 0;        // the maximal depth in the hierarchical tree

    /*********************************** Netlist Definition Information(START)
     * *********************************************/
    std::vector<PortDefinition> ports;
    std::vector<BitSlicedAssignStatement> assigns;
    /*********************************** Netlist Definition Information(END)
     * *********************************************/

    /*********************************** Netlist Instance Information(START)
     * *********************************************/
    // Instance Name Of All Sub Modules Of Current Module
    std::vector<std::string> subModuleInstanceNames;
    // All Sub Modules Definition Index Of Current Module
    std::vector<uint32_t> subModuleDefIndex;
    std::vector<std::vector<PortAssignment>>
      portAssignmentsOfSubModuleInstances;
    /*********************************** Netlist Instance Information(END)
     * *********************************************/

  public:
    // uint32_t inNum(bool onlyIn = false) const;
    // uint32_t outNum(bool onlyOut = false) const;
    // uint32_t inoutNum() const;
    // uint32_t wireNum() const;
};
