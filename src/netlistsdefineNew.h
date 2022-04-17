/*************************************************************************
  > File Name: netlistsdefineNew.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Wed 13 Apr 2022 08:18:03 AM CST
 ************************************************************************/
#pragma once

#include <string>
#include <unordered_map>
#include <vector>

namespace MultipleBitsNetlist
{
/** @brief 错误类型 */
enum class ErrorType
{
  UNKNOWN = -1,
  FALSE,
  TRUE
};

/** @brief 端口类型
 *  @sa    HDL RTL 级别的 module 设计
 */
enum class PortType
{
  UNKNOWN = -1,
  INPUT,  // 输入
  OUTPUT, // 输出
  INOUT,  // 输入输出
  WIRE,   // 连线
  TYPENUM // 类型种数
};

/**
 * @brief 端口的信息
 * @sa    PortType
 */
// It is used to store input, output, inout and wire definition.
// PortMsg = Port Definded Message
struct PortMsg
{
    std::string portDefName;               // 端口定义名称
    PortType portType = PortType::UNKNOWN; // 端口类型
    bool isArray = false;                  // 是否是数组
    uint32_t arraySize = 1;                // 数组大小
};

// VarRefRange = Variable Referenced Range
struct VarRefRange
{
    // For example, C[end:start], width = end - start + 1;
    uint32_t end, start, width;
};
struct ConstValueAndWidth
{
    // For example, 10'd33, value = 33, valueX = 0, width = 10;
    // 9'bx01xz1x0z, value = 364, valueX = 309, width = 9 <=>
    //          9'bx01xz1x0z,
    // value  = 9'b101101100,
    // valueX = 9'b100110101, width = 9;
    // 1       | 0      | 0      | 1
    //   <=> x |  <=> z |  <=> 0 |  <=> 1
    // 1       | 1      | 0      | 0
    uint32_t value, valueX, width;
};
// It can store C[1], 1'd1, 3'd4, ci and C[3:0].
// VarRefMsg = Variable Referenced Message
// if(varRefName !="" && !hasValueX)
//   isArray means varRef is defined as a vector in verilog source code.
// else
//   isArray means the value is not one bit.
struct VarRefMsg
{
    std::string varRefName = ""; // 端口实例名称 (实参)
    bool isArray = false;        // 是否是数组类型
    bool hasValueX = false;      // Are there value x or z?
    union
    {
        VarRefRange varRefRange;
        ConstValueAndWidth constValueAndWidth; // 初始值，在 portInstanceName
                                               // == "anonymous" 下使用
    };
};
// It can sotre .A(4'd1), .B({1'd0,3'd3,B[2:0],ci}) and so on.
// PortInstanceMsg = Port Instanced Message
struct PortInstanceMsg
{
    std::string portDefName; // 端口定义名称 (形参)
    // Everytime, it only pushes one bit information, for example, C[1], 1'b0,
    // not store C[1:0]
    std::vector<VarRefMsg> varRefMsgs; // 端口实例组 (实参,参考 c++ 初始化列表)
};

// lValue = C[3:0], rValue = Ci[3:0] or {1'b0,ci,1'b1,Ci[1]} or ...
struct AssignStatementMsg
{
    VarRefMsg lValue;              // 左值
    std::vector<VarRefMsg> rValue; // 右值
};

struct ModuleMsg
{
  public:
    // std::string -> subModuleInstanceName, for example, U1,
    // std::string -> subModuleDefName, for example, full_adder
    // for example,{{U1,full_adder_co},{U2,full_adder_sum},...}
    using SubModInsNameMapSubModDefName =
      std::unordered_map<std::string, std::string>;
    // std::string -> subModuleInstanceName, for example, U1
    // std::vector<PortInstanceMsg> -> 实例引脚表, for example,
    // {{U1,{.co(co),.A(a),.B(b),.ci(ci)}},{U2,{.sum(sum),.A(a),.B(b),.ci(ci)}},...}
    using SubModInsNameMapPortInsMsgs =
      std::unordered_map<std::string, std::vector<PortInstanceMsg>>;

  public:
    std::string moduleDefName; // 模块定义名称   (形参)
    uint32_t level = 0;        // 模块的层级

    /*********************************** 网表定义信息(START)
     * *********************************************/
    std::vector<PortMsg> inputs;             // 输入引脚
    std::vector<PortMsg> outputs;            // 输出引脚
    std::vector<PortMsg> inouts;             // 输入输出引脚
    std::vector<PortMsg> wires;              // 连线引脚
    std::vector<AssignStatementMsg> assigns; // assign 语句
    /*********************************** 网表定义信息(END)
     * *********************************************/

    /*********************************** 网表实例信息(START)
     * *********************************************/
    std::vector<std::string> subModuleInstanceNames; // 子模块实例名称  (实参)
    SubModInsNameMapSubModDefName
      subModInsNameMapSubModDefName; // 子模块实例映射表
    SubModInsNameMapPortInsMsgs
      subModInsNameMapPortInsMsgVec; // 子模块实例的引脚表
    /*********************************** 网表实例信息(END)
     * *********************************************/

  public:
    uint32_t inNum(bool onlyIn = false) const;
    uint32_t outNum(bool onlyOut = false) const;
    uint32_t inoutNum() const;
    uint32_t wireNum() const;
};
}
