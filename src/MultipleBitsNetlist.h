/*************************************************************************
  > File Name: MultipleBitsNetlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Fri 22 Apr 2022 07:25:50 PM CST
 ************************************************************************/
#pragma once

#include <cstdint>
#include <string>
#include <vector>

struct RefVarRange {
      // For example, C[end:start];
      uint32_t start;
      uint32_t end;
};
struct ConstValueAndXOrZ {
      // For example, 10'd33, value = 33, valueX = 0, width = 10;
      // 9'bx01xz1x0z, value = 364, valueX = 309, width = 9 <=>
      //          9'bx01xz1x0z,
      // value  = 9'b101101100,
      // valueX = 9'b100110101, width = 9;
      // 1       | 0      | 0      | 1
      //   <=> x |  <=> z |  <=> 0 |  <=> 1
      // 1       | 1      | 0      | 0
      uint32_t value;
      uint32_t valueXOrZ;
};
// MultipleBitsRefVar =Multiple Bits Referenced Variable
// It can store C[1], 1'd1, 3'd4, ci and C[3:0].
class MultipleBitsRefVar {
   public:
      MultipleBitsRefVar() : _refVarName(""), _hasXOrZ(false), _width(0) { ; }
      ~MultipleBitsRefVar() { ; }

      void refVarName(const std::string &name) { _refVarName = name; }
      const std::string &refVarName() const { return _refVarName; }

      void hasXOrZ(const bool &hasXOrZ) { _hasXOrZ = hasXOrZ; }
      const bool &hasXOrZ() const { return _hasXOrZ; }

      void width(const uint32_t &width) { _width = width; }
      const uint32_t &width() const { return _width; }

      RefVarRange &refVarRange() { return _refVarRange; }

      std::vector<ConstValueAndXOrZ> &values() { return _values; }

   private:
      std::string _refVarName; // Referenced Variable Name
      bool _hasXOrZ;           // Are there x or z?
      uint32_t _width;
      // Only when _refVarName != "", it will be used.
      RefVarRange _refVarRange;
      // Only when _refVarName = "", it will be used.
      std::vector<ConstValueAndXOrZ> _values;
};
// It can sotre .A(4'd1), .B({1'd0,3'd3,B[2:0],ci}) and so on.
class MultipleBitsPortAssignment {
   public:
      MultipleBitsPortAssignment() : _portDefName("") { ; }
      ~MultipleBitsPortAssignment() { ; }

      void portDefName(const std::string &name) { _portDefName = name; }
      const std::string &portDefName() const { return _portDefName; }

      std::vector<MultipleBitsRefVar> &multipleBitsRefVars() {
         return _multipleBitsRefVars;
      }

   private:
      std::string _portDefName; // Port Defined Name
      std::vector<MultipleBitsRefVar> _multipleBitsRefVars;
};

// lValue = C[3:0], rValue = Ci[3:0] or {1'b0,ci,1'b1,Ci[1]} or ...
class MultipleBitsAssignStatement {
   public:
      MultipleBitsRefVar &lValue() { return _lValue; }
      std::vector<MultipleBitsRefVar> &rValue() { return _rValue; }

   private:
      MultipleBitsRefVar _lValue;              // left value (locator value)
      std::vector<MultipleBitsRefVar> _rValue; // right value (read value)
};
