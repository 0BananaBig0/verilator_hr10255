/*************************************************************************
  > File Name: MultipleBitsNetlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Fri 22 Apr 2022 07:25:50 PM CST
 ************************************************************************/
#pragma once

#include "V3Number.h"
#include <cstdint>
#include <string>
#include <vector>

struct RefVarRange
{
    // For example, C[end:start];
    uint32_t end, start;
};
struct ConstValueAndX
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
// MultipleBitsRefVar =Multiple Bits Referenced Variable
struct MultipleBitsRefVar
{
    std::string refVarName = ""; // Referenced Variable Name
    bool hasX = false;           // Are there x or z?
    uint32_t width;
    union
    {
        RefVarRange refVarRange;
        ConstValueAndX constValueAndX;
    };
    // Only when width > 32 and refVarName = "", it will be used.
    std::vector<V3NumberData::ValueAndX> biggerValue;
};
// It can sotre .A(4'd1), .B({1'd0,3'd3,B[2:0],ci}) and so on.
struct MultipleBitsPortAssignment
{
    std::string portDefName; // Port Defined Name
    std::vector<MultipleBitsRefVar> multipleBitsRefVars;
};

// lValue = C[3:0], rValue = Ci[3:0] or {1'b0,ci,1'b1,Ci[1]} or ...
struct MultipleBitsAssignStatement
{
    MultipleBitsRefVar lValue;              // left value (locator value)
    std::vector<MultipleBitsRefVar> rValue; // right value (read value)
};
