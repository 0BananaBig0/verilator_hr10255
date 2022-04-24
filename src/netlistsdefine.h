#pragma once

#include <string>
#include <unordered_map>
#include <vector>

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
struct PortDefinition
{
    std::string portDefName;               // 端口定义名称
    PortType portType = PortType::UNKNOWN; // 端口类型
    bool isVector = false;                 // 是否是数组
    uint32_t bitWidth = 1;                 // 数组大小
};

namespace OneBitNetlist
{

/**
 * @brief 端口实例信息
 * @note  若 varRefName == "anonymous" ，则代表其实直接赋值，
 *        initialVal 即为默认值
 */
// It only stores one bit information, for example, C[1], 1'b0, ci, not store
// C[1:0]
struct VarRef
{
    std::string varRefName = "anonymous"; // 端口实例名称 (实参)
    bool isVector = false;                // 是否是数组类型
    union
    {
        uint32_t index;      // 索引
        uint32_t initialVal; // 初始值，在 varRefName == "anonymous" 下使用
    };
};

/** @brief 端口实例信息
 *  @note  只需要知道端口的形参以及实参即可
 * */
struct PortAssignment
{
    std::string portDefName; // 端口定义名称 (形参)
    // Everytime, it only pushes one bit information, for example, C[1], 1'b0,
    // ci, not store C[1:0]
    std::vector<VarRef> varRefs; // 端口实例组 (实参,参考 c++ 初始化列表)
};

// It is used to store one bit assign statement, for example, C[1]=1'b0,
// C[2] = ci, not sotre C[1:0] = {1'b0, co} or C[1:0] = B[1:0];
struct AssignStatement
{
    VarRef lValue; // 左值
    VarRef rValue; // 右值
};

/**
 * @brief 模块信息
 * @note  需要知道的信息包括以下 ：
 *        1 - 模块自己的名称
 *        2 - 使用的子模块的名称以及其实例名称 (需要知道其顺序)
 *        3 - 需要知道使用到的子模块的引脚及其实例
 * (由于传入本身就不保证顺序，所以这里不保证)\ 4 - 模块的引脚信息
 */
struct Module
{
  public:
    // std::string -> subModuleInstanceName, for example, U1,
    // std::string -> subModuleDefName, for example, full_adder
    // for example,{{U1,full_adder_co},{U2,full_adder_sum},...}
    using SubModInsNameMapSubModDefName =
      std::unordered_map<std::string, std::string>;
    // std::string -> subModuleInstanceName, for example, U1
    // std::vector<PortAssignment> -> 实例引脚表, for example,
    // {{U1,{.co(co),.A(a),.B(b),.ci(ci)}},{U2,{.sum(sum),.A(a),.B(b),.ci(ci)}},...}
    using SubModInsNameMapPortAssignments =
      std::unordered_map<std::string, std::vector<PortAssignment>>;

  public:
    std::string moduleDefName; // 模块定义名称   (形参)
    uint32_t level = 0;        // 模块的层级

    /*********************************** 网表定义信息(START)
     * *********************************************/
    std::vector<PortDefinition> inputs;   // 输入引脚
    std::vector<PortDefinition> outputs;  // 输出引脚
    std::vector<PortDefinition> inouts;   // 输入输出引脚
    std::vector<PortDefinition> wires;    // 连线引脚
    std::vector<AssignStatement> assigns; // assign 语句
    /*********************************** 网表定义信息(END)
     * *********************************************/

    /*********************************** 网表实例信息(START)
     * *********************************************/
    std::vector<std::string> subModuleInstanceNames; // 子模块实例名称  (实参)
    SubModInsNameMapSubModDefName
      subModInsNameMapSubModDefName; // 子模块实例映射表
    SubModInsNameMapPortAssignments
      subModInsNameMapPortAssignments; // 子模块实例的引脚表
    /*********************************** 网表实例信息(END)
     * *********************************************/

  public:
    uint32_t inNum(bool onlyIn = false) const;
    uint32_t outNum(bool onlyOut = false) const;
    uint32_t inoutNum() const;
    uint32_t wireNum() const;
};
}
