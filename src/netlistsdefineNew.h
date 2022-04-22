/*************************************************************************
  > File Name: netlistsdefineNew.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Wed 13 Apr 2022 08:18:03 AM CST
 ************************************************************************/
#pragma once

#include "V3Number.h"
#include "netlistsdefine.h"
#include <string>
#include <unordered_map>
#include <vector>

namespace MultipleBitsNetlist
{
// enum class ErrorType
// {
//   UNKNOWN = -1,
//   FALSE,
//   TRUE
// };
//
// enum class PortType
// {
//   UNKNOWN = -1,
//   INPUT,
//   OUTPUT,
//   INOUT,
//   WIRE,
//   TYPENUM // The number of port type
// };
//
// // It is used to store input, output, inout and wire definition.
// // PortMsg = Port Definded Message
// struct PortMsg
// {
//     std::string portDefName;               // Port Defined Name
//     PortType portType = PortType::UNKNOWN;
//     bool isArray = false;
//     uint32_t arraySize = 1;
// };

// VarRefRange = Variable Referenced Range
struct VarRefRange
{
    // For example, C[end:start], width = end - start + 1;
    uint32_t end, start;
};
struct ConstValueAndValueX
{
    // For example, 10'd33, value = 33, valueX = 0, width = 10;
    // 9'bx01xz1x0z, value = 364, valueX = 309, width = 9 <=>
    //          9'bx01xz1x0z,
    // value  = 9'b101101100,
    // valueX = 9'b100110101, width = 9;
    // 1       | 0      | 0      | 1
    //   <=> x |  <=> z |  <=> 0 |  <=> 1
    // 1       | 1      | 0      | 0
    uint32_t value, valueX;
};
// It can store C[1], 1'd1, 3'd4, ci and C[3:0].
// VarRefMsg = Variable Referenced Message
// if(varRefName !="" && !hasValueX)
//   isArray means varRef is defined as a vector in verilog source code.
// else
//   isArray means the value is not one bit.
struct MultipleBitsVarRef
{
    std::string varRefName = ""; // Variable Referenced Name
    bool isVector = false;
    bool hasValueX = false; // Are there value x or z?
    uint32_t width;
    union
    {
        VarRefRange varRefRange;
        ConstValueAndValueX constValueAndValueX;
    };
    std::vector<V3NumberData::ValueAndX> BiggerValue;
};
// It can sotre .A(4'd1), .B({1'd0,3'd3,B[2:0],ci}) and so on.
// PortInstanceMsg = Port Instanced Message
struct MultipleBitsPortAssignment
{
    std::string portDefName; // Port Defined Name
    // Everytime, it only pushes one bit information, for example, C[1], 1'b0,
    // not store C[1:0]
    std::vector<MultipleBitsVarRef> multipleBitsVarRefs;
};

// lValue = C[3:0], rValue = Ci[3:0] or {1'b0,ci,1'b1,Ci[1]} or ...
struct MultipleBitsAssignStatement
{
    MultipleBitsVarRef lValue;              // left value (locator value)
    std::vector<MultipleBitsVarRef> rValue; // right value (read value)
};

struct ModuleMsg
{
  public:
    // std::string -> subModuleInstanceName, for example, U1.
    // std::string -> subModuleDefName, for example, full_adder.
    // For example,{{U1,full_adder_co},{U2,full_adder_sum},...}
    using SubModInsNameMapSubModDefName =
      std::unordered_map<std::string, std::string>;
    // std::string -> subModuleInstanceName, for example, U1.
    // std::vector<PortInstanceMsg> -> allInstancedPortsMsgoFOneSubMod,
    // For example,{.co(co),.A(a),.B(b),.ci(ci)}.
    // For example,{{U1,{.co(co),.A(a),.B(b),.ci(ci)}},
    // {U2,{.sum(sum),.A(a[1],a[2],1'b0),.B(b,1'b1,1'b0),.ci(ci)}},...}
    using SubModInsNameMapPortInsMsgs =
      std::unordered_map<std::string, std::vector<MultipleBitsPortAssignment>>;

  public:
    std::string moduleDefName; // Module Defined Name
    uint32_t level = 0;        // The Hierarchy Level Of Module

    /*********************************** Netlist Definition Information(START)
     * *********************************************/
    std::vector<PortMsg> inputs;
    std::vector<PortMsg> outputs;
    std::vector<PortMsg> inouts;
    std::vector<PortMsg> wires;
    std::vector<MultipleBitsAssignStatement> assigns;
    /*********************************** Netlist Definition Information(END)
     * *********************************************/

    /*********************************** Netlist Instance Information(START)
     * *********************************************/
    // Instance Name Of All Sub Modules Of Current Module
    std::vector<std::string> subModuleInstanceNames;
    // SubModule Instanced Name Map SubModule Defined Name
    SubModInsNameMapSubModDefName subModInsNameMapSubModDefName;
    // SubModule Instanced Name Map Port Instanced Messages
    SubModInsNameMapPortInsMsgs subModInsNameMapPortInsMsgs;
    /*********************************** Netlist Instance Information(END)
     * *********************************************/

  public:
    uint32_t inNum(bool onlyIn = false) const;
    uint32_t outNum(bool onlyOut = false) const;
    uint32_t inoutNum() const;
    uint32_t wireNum() const;
};
}
