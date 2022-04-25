/*************************************************************************
  > File Name: MultipleBitsNetlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Fri 22 Apr 2022 07:25:50 PM CST
 ************************************************************************/
#pragma once

#include "V3Number.h"
#include <vector>
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
// MultipleBitsVarRef =Multiple Bits Variable Referenced
// if(varRefName !="" && !hasValueX)
//   isArray means MultipleBitsVarRef is defined as a vector in verilog source
//   code.
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
    // Only when width > 32 and varRefName = "", it will be used.
    std::vector<V3NumberData::ValueAndX> biggerValue;
};
// It can sotre .A(4'd1), .B({1'd0,3'd3,B[2:0],ci}) and so on.
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
