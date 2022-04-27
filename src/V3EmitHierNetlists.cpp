#include "V3EmitNetlists.h"

#include <cstdlib>
#include <exception>
#include <fstream>
#include <iostream>
#include <unordered_map>

#include "V3Ast.h"
#include "V3Error.h"

namespace OneBitNetlist
{
/******************************** 内部使用(START)
 * ****************************************/
// 用于屏蔽实现的细节，比较耦合，可以不接触
/**
 * @brief 端口实例形参信息 (复杂)
 * @note  1 - indexRange : uint32_t -> start， uint32_t -> len
 *        2 - 仅供内部使用
 */
struct VarRefComplex
{
    /**
     * @brief varRefName == "anonymous"
     * 时即为常量赋值，也就是匿名赋值
     */
    std::string varRefName = "anonymous";     // 端口实例名称 (实参)
    bool isArray = false;                     // 是否是数组类型
    std::pair<uint32_t, uint32_t> indexRange; // 引脚范围
    /**
     * @brief 获取索引
     * @note  仅当 isArray == true 时可以调用
     */
    std::vector<int> getIndexs();
};

/**
 * @brief assign 语句信息 (复杂)
 * @note  仅供内部使用
 */
struct AssignStatementComplex
{
    VarRefComplex lValue; // 左值
    VarRefComplex rValue; // 右值
};

static uint32_t IndexStrToIndexNum(const std::string &indexStr)
{
  // problem1 : It is slower than stoi().
  // problem2 : If the input is bigger than 15, it will has some
  // problems.
  static std::unordered_map<std::string, uint32_t> _map = {
    { "h0", 0 },  { "h1", 1 },  { "h2", 2 },  { "h3", 3 },
    { "h4", 4 },  { "h5", 5 },  { "h6", 6 },  { "h7", 7 },
    { "h8", 8 },  { "h9", 9 },  { "ha", 10 }, { "hb", 11 },
    { "hc", 12 }, { "hd", 13 }, { "he", 14 }, { "hf", 15 }
  };
  // 例子 ： "8'h0" -> "h0"
  // 为什么 : 因为前面的8不是固定的，例如 "32'h0"
  std::string tmp = indexStr.substr(indexStr.size() - 2, 2);
  return _map[tmp];
}

/** @brief 简易版备忘录 */
template<typename T>
class MemoMaker
{
    T &_ref;
    const T _saved;

  public:
    explicit MemoMaker(T &data) : _ref{ data }, _saved{ data } {}
    ~MemoMaker() { _ref = _saved; }
    MemoMaker(const MemoMaker &other) = delete;
    MemoMaker &operator=(const MemoMaker &) = delete;
};

std::vector<int> VarRefComplex::getIndexs()
{
  if(!isArray)
  {
    throw std::runtime_error("VarRefComplex::getIndexs() should "
                             "be involed by array type");
  }
  std::vector<int> res;

  for(int i = 0; i < indexRange.second; i++)
  {
    res.push_back(i + indexRange.first);
  }

  return res;
}

struct AssignStatus
{
  public:
    bool isAssignStatement = false; // 是否是 assign 语句
    bool isAssignLvalue = false;    // 是否是 assign 的左值,仅当
                                    // isAssignStatement == true 时有效
    AssignStatementComplex assignStatementComplex; // assign 语句信息临时存放处
    bool isFrist = true;

  public:
    /**
     * @brief     处理左值以及右值的端口实例信息
     * @param[in] varRefName : 一般指的是 nodep->prettyName()
     * @return    true 代表当前处理的是 assign 语句
     */
    bool ProcessVarRefName(const std::string &varRefName)
    {
      if(!isAssignStatement)
      {
        return false;
      }
      // First, process assignlValue(corresponding to if statement),
      // Second,process assignrValue(corresponding to else statement)
      if(isAssignLvalue)
      {
        assignStatementComplex.lValue.varRefName = varRefName;
        if(assignStatementComplex.lValue.isArray == false)
        {
          // Make the next call of ProcessVarRefName to process
          // assignrValue.
          isAssignLvalue = !isAssignLvalue;
        }
      }
      else
      {
        assignStatementComplex.rValue.varRefName = varRefName;
        if(assignStatementComplex.rValue.isArray == false)
        {
          isAssignLvalue = !isAssignLvalue;
        }
      }
      return true;
    }
    /**
     * @brief     处理左值以及右值是否是数组
     * @return    true 代表当前处理的是 assign 语句
     * @note      此函数应该在 visit(AstSel* nodep) 中调用
     */
    bool ProcessIsArray()
    {
      if(!isAssignStatement)
      {
        return false;
      }
      if(isAssignLvalue)
      {
        assignStatementComplex.lValue.isArray = true;
      }
      else
      {
        assignStatementComplex.rValue.isArray = true;
      }

      return true;
    }
    /**
     * @brief      处理引脚的范围
     * @param[in]  constStr : 一般指的是 nodep->prettyName()
     * @return     true 代表当前处理的是 assign 语句
     * @note       此函数应该在 visit(AstConst* nodep) 中调用
     */
    bool ProcessIndexRange(const std::string &constStr)
    {
      /**
       * @brief     获取数组 len
       * @param[in] constStr : 一般指的是 nodep->prettyName()
       * @return    常量值的位宽
       * @note      此函数应该在 visit(AstConst* nodep) 中调用
       */
      // constStr = "n'hxxx";
      auto getArrayLen = [](const std::string &constStr) -> uint32_t
      {
        uint32_t res = 0;
        size_t pos = constStr.find("'");
        std::string tmp = constStr.substr(0, pos);
        res = std::atoi(tmp.c_str());
        return res;
      };

      if(!isAssignStatement)
      {
        return false;
      }
      // isAssignLvalue = true, process lValue of assign statement;
      if(isAssignLvalue)
      {
        VarRefComplex &value = assignStatementComplex.lValue;
        if(value.varRefName == "anonymous")
        {
          value.indexRange.first = IndexStrToIndexNum(constStr);
          value.indexRange.second = getArrayLen(constStr);
          isAssignLvalue = !isAssignLvalue;
        }
        else
        {
          // isFirst = true, obtain the starting point of lValue of assign
          // statement which is a array
          if(isFrist)
          {
            isFrist = !isFrist;
            value.indexRange.first = IndexStrToIndexNum(constStr);
          }
          // isFirst = false, obtain the end point of lValue of assign
          // statement which is a array
          else
          {
            isFrist = !isFrist;
            value.indexRange.second = IndexStrToIndexNum(constStr);
            isAssignLvalue = !isAssignLvalue;
          }
        }
      }
      // isAssignLvalue = false, process rValue of assign statement;
      else
      {
        VarRefComplex &value = assignStatementComplex.rValue;
        if(value.varRefName == "anonymous")
        {
          value.indexRange.first = IndexStrToIndexNum(constStr);
          value.indexRange.second = getArrayLen(constStr);
          isAssignLvalue = !isAssignLvalue;
        }
        else
        {
          if(isFrist)
          {
            isFrist = !isFrist;
            value.indexRange.first = IndexStrToIndexNum(constStr);
          }
          else
          {
            isFrist = !isFrist;
            value.indexRange.second = IndexStrToIndexNum(constStr);
            isAssignLvalue = !isAssignLvalue;
          }
        }
      }
      return true;
    }
};
/******************************** 内部使用(END)
 * ****************************************/

/** @brief 层次化网表访问者 */
class HierCellsNetListsVisitor final : public AstNVisitor
{
  public:
    // _moduleMap[_curModuleInstanceParentName] -> 指向当前正在处理的模块
    // _moduleMap[_curModuleInstanceParentName][_curModuleInstanceParentName]
    // -> 指向当前正在处理的模块下的一个模块实例
    std::unordered_map<std::string, Module> _moduleMap;

  private:
    std::string _curModuleInstanceParentName; // 当前模块实例父亲的名称
    std::string _curModuleInstanceName;       // 当前模块实例的名称

    AssignStatus _assignStatus; // assign 相关状态

    PortAssignment _portAssignmentTmp; // 端口实例信息临时变量
    VarRefComplex _varRefComplexTmp;   // 端口实例形参信息 (复杂)

    std::vector<PortAssignment>
      _curModulePortAssignments; // 当前模块的引脚实例信息

  private:
    // All information we can get from this Ast tree by using the
    // polymorphic preperties to call different visit function. And
    // AstNetlist is the first node of the Ast tree. Becaus we have no
    // information needed to get from it, we only iterate over it to
    // access its children nodes.

    // A visit function will be popped up from or not pushed to the function
    // stack after finishing obtainning data only in the following three cases:
    // (1)node has no children. For example, AstConst node.(Not pushed to)
    // (2)node is pointed by m_nextp and its children pointed by m_opxp have
    // been visited, such as AstAssignW node.(Popped up from)
    // (3)node is pointed by m_opxp and its children pointed by m_opxp have
    // been visited. But its iterateAndNext() function will be popped up from
    // function stack only when its all descendants have been visited such as
    // AstModule node.(Popped up from)
    // Note: m_opxp = m_op1p or m_op2p or m_op3p or m_op4p
    // Note: This is also a reason why separating m_opxp and m_nextp by
    // AstNode::iterateChildren and AstNode::iterateAndNext
    // If A->B by m_nextp, it means that they are parallel, and the information
    // extraction between them will not affect each other.
    // If A->B by m_opxp, it means that They are service relationships, where
    // all information of B is to serve A or A's ancestors that is pointed by
    // m_nextp.
    virtual void visit(AstNode *nodep) override { iterateChildren(nodep); }

    virtual void visit(AstModule *nodep) override;
    virtual void visit(AstVar *nodep) override;
    virtual void visit(AstVarRef *nodep) override;
    virtual void visit(AstCell *nodep) override;
    virtual void visit(AstConcat *nodep) override;
    virtual void visit(AstPin *nodep) override;
    virtual void visit(AstNodeAssign *nodep) override;
    virtual void visit(AstConst *nodep) override;
    virtual void visit(AstSel *nodep) override;
    virtual void visit(AstExtend *nodep) override
    {
      // nodep->width();//All children length including it 0 extension.
      // nodep->m_op1p->width();//Except its 0 extension, all children length
      iterateChildren(nodep);
    }
    virtual void visit(AstExtendS *nodep) override
    {
      // nodep->width();//All children length including it 1 extension.
      // nodep->m_op1p->width();//Except its 1 extension, all children length
      iterateChildren(nodep);
    }
    virtual void visit(AstReplicate *nodep) override
    {
      iterateChildren(nodep);
    }
    // virtual void visit(AstAssignW *nodep) override { iterateChildren(nodep);
    // }; virtual void visit(AstAssign *nodep) override {
    // iterateChildren(nodep); };

  public:
    /**
     * @brief 获取层次化网表
     */
    std::unordered_map<std::string, Module> GetHierCellsNetLists();

  public:
    // AstNetlist is ConElement
    HierCellsNetListsVisitor(AstNetlist *nodep) { nodep->accept(*this); }
    virtual ~HierCellsNetListsVisitor() override{
      // selfTest(_moduleMap,
      // "/home/haorui/Desktop/verilator/note/misc/case4/test.v");
    };

    /**
     * @brief         自测
     * @param[in]     hierCellsNetLists :
     * HierCellsNetListsVisitor::_moduleMap
     * @param[out]    filename : 文件名
     * @note          观察输出文件的内容
     */
    static void
    selfTest(std::unordered_map<std::string, Module> hierCellsNetLists,
             const std::string &filename);
};

/**
 * @brief module 语句的入口
 */
void HierCellsNetListsVisitor::visit(AstModule *nodep)
{
  /** @brief 是否是顶级模块
   *  @note  保留，未使用
   */
  auto isTopModule = [nodep]() -> bool
  {
    bool res = false;
    if(nodep->level() >= 0 && nodep->level() <= 2)
    {
      res = true;
    }
    return res;
  };

  /**
   * @brief      创建一个模块实例
   * @param[in]  moduleDefName : 模块定义名称
   * @param[in]  level : 模块的 level
   */
  auto createModuleInstance = [this](const std::string &moduleDefName,
                                     uint32_t level = -1) -> void
  {
    Module moduleInstance;
    moduleInstance.moduleDefName = moduleDefName;
    moduleInstance.level = level;
    _moduleMap[moduleDefName] = std::move(moduleInstance);
  };

  if(nodep->prettyName() == "@CONST-POOL@")
  {
    return;
  }
  // else
  // {
  //   createModuleInstance(nodep->prettyName(), nodep->level());
  // }
  createModuleInstance(nodep->prettyName(), nodep->level());
  _curModuleInstanceParentName = nodep->origName();
  _curModuleInstanceName = nodep->origName();

  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstVar *nodep)
{
  PortDefinition port;
  port.portDefName = nodep->origName();

  if(nodep->isIO())
  {
    switch(nodep->direction())
    {
    case VDirection::INPUT:
      port.portType = PortType::INPUT;
      break;
    case VDirection::OUTPUT:
      port.portType = PortType::OUTPUT;
      break;
    case VDirection::INOUT:
      port.portType = PortType::INOUT;
      break;
    default:
      throw std::runtime_error(
        "only support input，output and inout, other like ref or "
        "constref aren't not support!!!");
      break;
    }
  }
  else
  {
    port.portType = PortType::WIRE;
  }

  if(nodep->basicp() && nodep->basicp()->width() != 1)
  {
    port.isVector = true;
    port.bitWidth = nodep->basicp()->width();
  }

  switch(port.portType)
  {
  case PortType::INPUT:
    _moduleMap[_curModuleInstanceParentName].inputs.push_back(std::move(port));
    break;
  case PortType::OUTPUT:
    _moduleMap[_curModuleInstanceParentName].outputs.push_back(
      std::move(port));
    break;
  case PortType::INOUT:
    _moduleMap[_curModuleInstanceParentName].inouts.push_back(std::move(port));
    break;
  case PortType::WIRE:
    _moduleMap[_curModuleInstanceParentName].wires.push_back(std::move(port));

    break;
  default:
    break;
  }

  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstCell *nodep)
{
  /** @brief 向 Module 塞入一个子模块
   *  @sa    Module
   */
  auto insertSubmoduleInstance =
    [this, nodep](const std::string &parentModuleName,
                  const std::string &moduleDefName,
                  const std::string &moduleInstanceName) -> void
  {
    Module &parentModuleInstance = _moduleMap[_curModuleInstanceParentName];
    parentModuleInstance.subModuleInstanceNames.push_back(moduleInstanceName);
    parentModuleInstance.subModInsNameMapSubModDefName[moduleInstanceName] =
      moduleDefName;
  };

  if(nodep->modp()->dead())
    return;
  /**
   * @brief 446 to 449 and 457 is code redundancy which can make program more
   * stable. Commenting it not affects the result.
   */
  MemoMaker<std::string> memoMaker1(_curModuleInstanceParentName);
  MemoMaker<std::string> memoMaker2(_curModuleInstanceName);
  MemoMaker<VarRefComplex> memoMaker3(_varRefComplexTmp);

  std::string moduleDefName = nodep->modName();
  std::string moduleInstanceName = nodep->origName();

  insertSubmoduleInstance(_curModuleInstanceParentName, nodep->modName(),
                          nodep->origName());

  _curModuleInstanceParentName = _curModuleInstanceName;
  _curModuleInstanceName = moduleInstanceName;

  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstPin *nodep)
{
  // 引脚实例 tmp 自动恢复默认值
  _portAssignmentTmp.varRefs.clear();
  MemoMaker<PortAssignment> memoMaker1(_portAssignmentTmp);
  MemoMaker<VarRefComplex> memoMaker2(_varRefComplexTmp);
  _portAssignmentTmp.portDefName = nodep->prettyName();
  iterateChildren(nodep);
  // 插入当前模块实例的一个端口信息
  _moduleMap[_curModuleInstanceParentName]
    .subModInsNameMapPortAssignments[_curModuleInstanceName]
    .push_back(_portAssignmentTmp);
}

/**
 * @note 进入此引脚的实例参数不止一个，目前这里不需要做任何处理
 * @sa   PortInstance
 */
void HierCellsNetListsVisitor::visit(AstConcat *nodep)
{
  // 手动还原 _varRefComplexTmp.varRefName 默认值
  _varRefComplexTmp.varRefName = "anonymous";
  iterateChildren(nodep);
}

/**
 * @note 当 _varRefComplexTmp.varRefName ==
 * "anonymous", 说明是匿名赋值
 */
void HierCellsNetListsVisitor::visit(AstConst *nodep)
{
  // isFirst == true 代表操作 first，反之操作 second
  static bool isFirst = true;

  /**
   * @brief     获取 len
   * @param[in] indexStr : nodep->prettyName() , nodep is AstConst
   * @return    常量值的位宽
   * @note      参见其具体用法
   */
  auto getLen = [](const std::string &indexStr) -> uint32_t
  {
    uint32_t res = 0;
    size_t pos = indexStr.find("'");
    std::string tmp = indexStr.substr(0, pos);
    res = std::atoi(tmp.c_str());
    return res;
  };
  // nodep->prettyName() <=> The "name" in xml file <=> nodep->name().
  // std::cout << nodep->prettyName() << std::endl;
  // std::cout << nodep->name() << std::endl;
  // std::cout << nodep->width() << std::endl;
  // std::cout << nodep->num().m_value.m_inlined[0].m_value << std::endl;
  // std::cout << nodep->num().m_value.m_inlined[0].m_valueX << std::endl;
  if(_assignStatus.isAssignStatement)
  {
    _assignStatus.ProcessIndexRange(nodep->prettyName());
  }
  else
  {
    // 匿名赋值到这里就已经结束了，手动压入端口实例形参信息临时变量
    if(_varRefComplexTmp.varRefName == "anonymous")
    {
      // 引脚实例 tmp 自动恢复默认值
      MemoMaker<VarRefComplex> memoMaker(_varRefComplexTmp);
      uint32_t len = getLen(nodep->prettyName());
      _varRefComplexTmp.indexRange.first =
        IndexStrToIndexNum(nodep->prettyName());
      VarRef varRef;
      varRef.initialVal = _varRefComplexTmp.indexRange.first;
      for(uint32_t i = 0; i < len; i++)
      {
        _portAssignmentTmp.varRefs.push_back(varRef);
      }
    }
    else
    {
      if(isFirst)
      {
        isFirst = !isFirst;
        _varRefComplexTmp.indexRange.first =
          IndexStrToIndexNum(nodep->prettyName());
      }
      else
      {
        isFirst = !isFirst;
        _varRefComplexTmp.indexRange.second =
          IndexStrToIndexNum(nodep->prettyName());
      }
    }
  }
}

/**
 * @note 进入此函数说明当前引脚实例的类型为 array
 */
void HierCellsNetListsVisitor::visit(AstSel *nodep)
{
  MemoMaker<VarRefComplex> memoMaker(_varRefComplexTmp);

  if(_assignStatus.isAssignStatement)
  {
    _assignStatus.ProcessIsArray();
  }
  else
  {
    _varRefComplexTmp.isArray = true;
  }
  iterateChildren(nodep);
  if(_assignStatus.isAssignStatement) {}
  else
  {
    VarRef varRef;
    varRef.varRefName = _varRefComplexTmp.varRefName;
    varRef.isVector = _varRefComplexTmp.isArray;
    auto indexs = _varRefComplexTmp.getIndexs();
    for(auto index: indexs)
    {
      varRef.index = index;
      _portAssignmentTmp.varRefs.push_back(varRef);
    }
  }
}

/**
 * @note 进入此函数说明当前处理的是 assign 语句
 */
void HierCellsNetListsVisitor::visit(AstNodeAssign *nodep)
{
  MemoMaker<AssignStatus> memoMaker(_assignStatus);
  _assignStatus.isAssignLvalue = false;
  _assignStatus.isAssignStatement = true;
  iterateChildren(nodep);
  AssignStatement assignStatement;
  assignStatement.lValue.varRefName =
    _assignStatus.assignStatementComplex.lValue.varRefName;
  assignStatement.lValue.isVector =
    _assignStatus.assignStatementComplex.lValue.isArray;
  assignStatement.rValue.varRefName =
    _assignStatus.assignStatementComplex.rValue.varRefName;
  assignStatement.rValue.isVector =
    _assignStatus.assignStatementComplex.rValue.isArray;
  for(uint32_t i = 0;
      i < _assignStatus.assignStatementComplex.lValue.indexRange.second; i++)
  {
    if(assignStatement.lValue.varRefName != "anonymous")
    {
      assignStatement.lValue.index =
        _assignStatus.assignStatementComplex.lValue.indexRange.first + i;
    }
    else
    {
      assignStatement.lValue.index =
        _assignStatus.assignStatementComplex.lValue.indexRange.second;
    }
    if(assignStatement.rValue.varRefName != "anonymous")
    {
      assignStatement.rValue.index =
        _assignStatus.assignStatementComplex.rValue.indexRange.first + i;
    }
    else
    {
      assignStatement.rValue.index =
        _assignStatus.assignStatementComplex.rValue.indexRange.first;
    }
    _moduleMap[_curModuleInstanceParentName].assigns.push_back(
      assignStatement);
  }
}

void HierCellsNetListsVisitor::visit(AstVarRef *nodep)
{
  // isFirst == true 代表操作 first，反之操作 second
  static bool isFirst = true;

  if(_assignStatus.isAssignStatement)
  {
    _assignStatus.ProcessVarRefName(nodep->prettyName());
  }
  else
  {
    _varRefComplexTmp.varRefName = nodep->prettyName();
  }
  iterateChildren(nodep);
  if(_assignStatus.isAssignStatement)
  {
    // nothing
    ;
  }
  else
  {
    if(_varRefComplexTmp.isArray == false)
    {
      VarRef varRef;
      varRef.varRefName = _varRefComplexTmp.varRefName;
      varRef.isVector = _varRefComplexTmp.isArray;
      _portAssignmentTmp.varRefs.push_back(varRef);
    }
  }
}

std::unordered_map<std::string, Module>
HierCellsNetListsVisitor::GetHierCellsNetLists()
{
  return _moduleMap;
  // return std::move(_moduleMap);
}

void V3EmitHierNetLists::emitHireNetLists(
  std::unordered_map<std::string, Module> &hierCellsNetLists)
{
  // v3Global will return a AstNetlist*
  HierCellsNetListsVisitor hierCellsNetListsVisitor(v3Global.rootp());
  hierCellsNetLists = hierCellsNetListsVisitor.GetHierCellsNetLists();
}

void V3EmitHierNetLists::printHireNetLists(
  std::unordered_map<std::string, Module> &hierCellsNetLists,
  std::string filename)
{
  HierCellsNetListsVisitor::selfTest(hierCellsNetLists, filename);
}

/**************************************************************
 * 自测函数(START)
 * *****************************************************************/
static bool IsStdCell(const std::string &moduleName)
{
  const std::unordered_set<std::string> stdCells = { "PLL",
                                                     "PADBID",
                                                     "PADCLK",
                                                     "AON_BUF_X1",
                                                     "AON_BUF_X2",
                                                     "AON_BUF_X4",
                                                     "AON_INV_X1",
                                                     "AON_INV_X2",
                                                     "AON_INV_X4",
                                                     "HEADER_OE_X1",
                                                     "HEADER_OE_X2",
                                                     "HEADER_OE_X4",
                                                     "HEADER_X1",
                                                     "HEADER_X2",
                                                     "HEADER_X4",
                                                     "ISO_FENCE0N_X1",
                                                     "ISO_FENCE0N_X2",
                                                     "ISO_FENCE0N_X4",
                                                     "ISO_FENCE0_X1",
                                                     "ISO_FENCE0_X2",
                                                     "ISO_FENCE0_X4",
                                                     "ISO_FENCE1N_X1",
                                                     "ISO_FENCE1N_X2",
                                                     "ISO_FENCE1N_X4",
                                                     "ISO_FENCE1_X1",
                                                     "ISO_FENCE1_X2",
                                                     "ISO_FENCE1_X4",
                                                     "LS_HLEN_X1",
                                                     "LS_HLEN_X2",
                                                     "LS_HLEN_X4",
                                                     "LS_HL_X1",
                                                     "LS_HL_X2",
                                                     "LS_HL_X4",
                                                     "LS_LHEN_X1",
                                                     "LS_LHEN_X2",
                                                     "LS_LHEN_X4",
                                                     "LS_LH_X1",
                                                     "LS_LH_X2",
                                                     "LS_LH_X4",
                                                     "AND2_X1_HVT",
                                                     "AND2_X2_HVT",
                                                     "AND2_X4_HVT",
                                                     "AND3_X1_HVT",
                                                     "AND3_X2_HVT",
                                                     "AND3_X4_HVT",
                                                     "AND4_X1_HVT",
                                                     "AND4_X2_HVT",
                                                     "AND4_X4_HVT",
                                                     "ANTENNA_X1_HVT",
                                                     "AOI211_X1_HVT",
                                                     "AOI211_X2_HVT",
                                                     "AOI211_X4_HVT",
                                                     "AOI21_X1_HVT",
                                                     "AOI21_X2_HVT",
                                                     "AOI21_X4_HVT",
                                                     "AOI221_X1_HVT",
                                                     "AOI221_X2_HVT",
                                                     "AOI221_X4_HVT",
                                                     "AOI222_X1_HVT",
                                                     "AOI222_X2_HVT",
                                                     "AOI222_X4_HVT",
                                                     "AOI22_X1_HVT",
                                                     "AOI22_X2_HVT",
                                                     "AOI22_X4_HVT",
                                                     "BUF_X16_HVT",
                                                     "BUF_X1_HVT",
                                                     "BUF_X2_HVT",
                                                     "BUF_X32_HVT",
                                                     "BUF_X4_HVT",
                                                     "BUF_X8_HVT",
                                                     "CLKBUF_X1_HVT",
                                                     "CLKBUF_X2_HVT",
                                                     "CLKBUF_X3_HVT",
                                                     "CLKGATETST_X1_HVT",
                                                     "CLKGATETST_X2_HVT",
                                                     "CLKGATETST_X4_HVT",
                                                     "CLKGATETST_X8_HVT",
                                                     "CLKGATE_X1_HVT",
                                                     "CLKGATE_X2_HVT",
                                                     "CLKGATE_X4_HVT",
                                                     "CLKGATE_X8_HVT",
                                                     "DFFRS_X1_HVT",
                                                     "DFFRS_X2_HVT",
                                                     "DFFR_X1_HVT",
                                                     "DFFR_X2_HVT",
                                                     "DFFS_X1_HVT",
                                                     "DFFS_X2_HVT",
                                                     "DFF_X1_HVT",
                                                     "DFF_X2_HVT",
                                                     "DLH_X1_HVT",
                                                     "DLH_X2_HVT",
                                                     "DLL_X1_HVT",
                                                     "DLL_X2_HVT",
                                                     "FA_X1_HVT",
                                                     "FILLCELL_X16_HVT",
                                                     "FILLCELL_X1_HVT",
                                                     "FILLCELL_X2_HVT",
                                                     "FILLCELL_X32_HVT",
                                                     "FILLCELL_X4_HVT",
                                                     "FILLCELL_X8_HVT",
                                                     "HA_X1_HVT",
                                                     "INV_X16_HVT",
                                                     "INV_X1_HVT",
                                                     "INV_X2_HVT",
                                                     "INV_X32_HVT",
                                                     "INV_X4_HVT",
                                                     "INV_X8_HVT",
                                                     "LOGIC0_X1_HVT",
                                                     "LOGIC1_X1_HVT",
                                                     "MUX2_X1_HVT",
                                                     "MUX2_X2_HVT",
                                                     "NAND2_X1_HVT",
                                                     "NAND2_X2_HVT",
                                                     "NAND2_X4_HVT",
                                                     "NAND3_X1_HVT",
                                                     "NAND3_X2_HVT",
                                                     "NAND3_X4_HVT",
                                                     "NAND4_X1_HVT",
                                                     "NAND4_X2_HVT",
                                                     "NAND4_X4_HVT",
                                                     "NOR2_X1_HVT",
                                                     "NOR2_X2_HVT",
                                                     "NOR2_X4_HVT",
                                                     "NOR3_X1_HVT",
                                                     "NOR3_X2_HVT",
                                                     "NOR3_X4_HVT",
                                                     "NOR4_X1_HVT",
                                                     "NOR4_X2_HVT",
                                                     "NOR4_X4_HVT",
                                                     "OAI211_X1_HVT",
                                                     "OAI211_X2_HVT",
                                                     "OAI211_X4_HVT",
                                                     "OAI21_X1_HVT",
                                                     "OAI21_X2_HVT",
                                                     "OAI21_X4_HVT",
                                                     "OAI221_X1_HVT",
                                                     "OAI221_X2_HVT",
                                                     "OAI221_X4_HVT",
                                                     "OAI222_X1_HVT",
                                                     "OAI222_X2_HVT",
                                                     "OAI222_X4_HVT",
                                                     "OAI22_X1_HVT",
                                                     "OAI22_X2_HVT",
                                                     "OAI22_X4_HVT",
                                                     "OAI33_X1_HVT",
                                                     "OR2_X1_HVT",
                                                     "OR2_X2_HVT",
                                                     "OR2_X4_HVT",
                                                     "OR3_X1_HVT",
                                                     "OR3_X2_HVT",
                                                     "OR3_X4_HVT",
                                                     "OR4_X1_HVT",
                                                     "OR4_X2_HVT",
                                                     "OR4_X4_HVT",
                                                     "SDFFRS_X1_HVT",
                                                     "SDFFRS_X2_HVT",
                                                     "SDFFR_X1_HVT",
                                                     "SDFFR_X2_HVT",
                                                     "SDFFS_X1_HVT",
                                                     "SDFFS_X2_HVT",
                                                     "SDFF_X1_HVT",
                                                     "SDFF_X2_HVT",
                                                     "TBUF_X16_HVT",
                                                     "TBUF_X1_HVT",
                                                     "TBUF_X2_HVT",
                                                     "TBUF_X4_HVT",
                                                     "TBUF_X8_HVT",
                                                     "TINV_X1_HVT",
                                                     "TLAT_X1_HVT",
                                                     "XNOR2_X1_HVT",
                                                     "XNOR2_X2_HVT",
                                                     "XOR2_X1_HVT",
                                                     "XOR2_X2_HVT",
                                                     "AND2_X1_LVT",
                                                     "AND2_X2_LVT",
                                                     "AND2_X4_LVT",
                                                     "AND3_X1_LVT",
                                                     "AND3_X2_LVT",
                                                     "AND3_X4_LVT",
                                                     "AND4_X1_LVT",
                                                     "AND4_X2_LVT",
                                                     "AND4_X4_LVT",
                                                     "ANTENNA_X1_LVT",
                                                     "AOI211_X1_LVT",
                                                     "AOI211_X2_LVT",
                                                     "AOI211_X4_LVT",
                                                     "AOI21_X1_LVT",
                                                     "AOI21_X2_LVT",
                                                     "AOI21_X4_LVT",
                                                     "AOI221_X1_LVT",
                                                     "AOI221_X2_LVT",
                                                     "AOI221_X4_LVT",
                                                     "AOI222_X1_LVT",
                                                     "AOI222_X2_LVT",
                                                     "AOI222_X4_LVT",
                                                     "AOI22_X1_LVT",
                                                     "AOI22_X2_LVT",
                                                     "AOI22_X4_LVT",
                                                     "BUF_X16_LVT",
                                                     "BUF_X1_LVT",
                                                     "BUF_X2_LVT",
                                                     "BUF_X32_LVT",
                                                     "BUF_X4_LVT",
                                                     "BUF_X8_LVT",
                                                     "CLKBUF_X1_LVT",
                                                     "CLKBUF_X2_LVT",
                                                     "CLKBUF_X3_LVT",
                                                     "CLKGATETST_X1_LVT",
                                                     "CLKGATETST_X2_LVT",
                                                     "CLKGATETST_X4_LVT",
                                                     "CLKGATETST_X8_LVT",
                                                     "CLKGATE_X1_LVT",
                                                     "CLKGATE_X2_LVT",
                                                     "CLKGATE_X4_LVT",
                                                     "CLKGATE_X8_LVT",
                                                     "DFFRS_X1_LVT",
                                                     "DFFRS_X2_LVT",
                                                     "DFFR_X1_LVT",
                                                     "DFFR_X2_LVT",
                                                     "DFFS_X1_LVT",
                                                     "DFFS_X2_LVT",
                                                     "DFF_X1_LVT",
                                                     "DFF_X2_LVT",
                                                     "DLH_X1_LVT",
                                                     "DLH_X2_LVT",
                                                     "DLL_X1_LVT",
                                                     "DLL_X2_LVT",
                                                     "FA_X1_LVT",
                                                     "FILLCELL_X16_LVT",
                                                     "FILLCELL_X1_LVT",
                                                     "FILLCELL_X2_LVT",
                                                     "FILLCELL_X32_LVT",
                                                     "FILLCELL_X4_LVT",
                                                     "FILLCELL_X8_LVT",
                                                     "HA_X1_LVT",
                                                     "INV_X16_LVT",
                                                     "INV_X1_LVT",
                                                     "INV_X2_LVT",
                                                     "INV_X32_LVT",
                                                     "INV_X4_LVT",
                                                     "INV_X8_LVT",
                                                     "LOGIC0_X1_LVT",
                                                     "LOGIC1_X1_LVT",
                                                     "MUX2_X1_LVT",
                                                     "MUX2_X2_LVT",
                                                     "NAND2_X1_LVT",
                                                     "NAND2_X2_LVT",
                                                     "NAND2_X4_LVT",
                                                     "NAND3_X1_LVT",
                                                     "NAND3_X2_LVT",
                                                     "NAND3_X4_LVT",
                                                     "NAND4_X1_LVT",
                                                     "NAND4_X2_LVT",
                                                     "NAND4_X4_LVT",
                                                     "NOR2_X1_LVT",
                                                     "NOR2_X2_LVT",
                                                     "NOR2_X4_LVT",
                                                     "NOR3_X1_LVT",
                                                     "NOR3_X2_LVT",
                                                     "NOR3_X4_LVT",
                                                     "NOR4_X1_LVT",
                                                     "NOR4_X2_LVT",
                                                     "NOR4_X4_LVT",
                                                     "OAI211_X1_LVT",
                                                     "OAI211_X2_LVT",
                                                     "OAI211_X4_LVT",
                                                     "OAI21_X1_LVT",
                                                     "OAI21_X2_LVT",
                                                     "OAI21_X4_LVT",
                                                     "OAI221_X1_LVT",
                                                     "OAI221_X2_LVT",
                                                     "OAI221_X4_LVT",
                                                     "OAI222_X1_LVT",
                                                     "OAI222_X2_LVT",
                                                     "OAI222_X4_LVT",
                                                     "OAI22_X1_LVT",
                                                     "OAI22_X2_LVT",
                                                     "OAI22_X4_LVT",
                                                     "OAI33_X1_LVT",
                                                     "OR2_X1_LVT",
                                                     "OR2_X2_LVT",
                                                     "OR2_X4_LVT",
                                                     "OR3_X1_LVT",
                                                     "OR3_X2_LVT",
                                                     "OR3_X4_LVT",
                                                     "OR4_X1_LVT",
                                                     "OR4_X2_LVT",
                                                     "OR4_X4_LVT",
                                                     "SDFFRS_X1_LVT",
                                                     "SDFFRS_X2_LVT",
                                                     "SDFFR_X1_LVT",
                                                     "SDFFR_X2_LVT",
                                                     "SDFFS_X1_LVT",
                                                     "SDFFS_X2_LVT",
                                                     "SDFF_X1_LVT",
                                                     "SDFF_X2_LVT",
                                                     "TBUF_X16_LVT",
                                                     "TBUF_X1_LVT",
                                                     "TBUF_X2_LVT",
                                                     "TBUF_X4_LVT",
                                                     "TBUF_X8_LVT",
                                                     "TINV_X1_LVT",
                                                     "TLAT_X1_LVT",
                                                     "XNOR2_X1_LVT",
                                                     "XNOR2_X2_LVT",
                                                     "XOR2_X1_LVT",
                                                     "XOR2_X2_LVT",
                                                     "AND2_X1_SVT",
                                                     "AND2_X2_SVT",
                                                     "AND2_X4_SVT",
                                                     "AND3_X1_SVT",
                                                     "AND3_X2_SVT",
                                                     "AND3_X4_SVT",
                                                     "AND4_X1_SVT",
                                                     "AND4_X2_SVT",
                                                     "AND4_X4_SVT",
                                                     "ANTENNA_X1_SVT",
                                                     "AOI211_X1_SVT",
                                                     "AOI211_X2_SVT",
                                                     "AOI211_X4_SVT",
                                                     "AOI21_X1_SVT",
                                                     "AOI21_X2_SVT",
                                                     "AOI21_X4_SVT",
                                                     "AOI221_X1_SVT",
                                                     "AOI221_X2_SVT",
                                                     "AOI221_X4_SVT",
                                                     "AOI222_X1_SVT",
                                                     "AOI222_X2_SVT",
                                                     "AOI222_X4_SVT",
                                                     "AOI22_X1_SVT",
                                                     "AOI22_X2_SVT",
                                                     "AOI22_X4_SVT",
                                                     "BUF_X16_SVT",
                                                     "BUF_X1_SVT",
                                                     "BUF_X2_SVT",
                                                     "BUF_X32_SVT",
                                                     "BUF_X4_SVT",
                                                     "BUF_X8_SVT",
                                                     "CLKBUF_X1_SVT",
                                                     "CLKBUF_X2_SVT",
                                                     "CLKBUF_X3_SVT",
                                                     "CLKGATETST_X1_SVT",
                                                     "CLKGATETST_X2_SVT",
                                                     "CLKGATETST_X4_SVT",
                                                     "CLKGATETST_X8_SVT",
                                                     "CLKGATE_X1_SVT",
                                                     "CLKGATE_X2_SVT",
                                                     "CLKGATE_X4_SVT",
                                                     "CLKGATE_X8_SVT",
                                                     "DFFRS_X1_SVT",
                                                     "DFFRS_X2_SVT",
                                                     "DFFR_X1_SVT",
                                                     "DFFR_X2_SVT",
                                                     "DFFS_X1_SVT",
                                                     "DFFS_X2_SVT",
                                                     "DFF_X1_SVT",
                                                     "DFF_X2_SVT",
                                                     "DLH_X1_SVT",
                                                     "DLH_X2_SVT",
                                                     "DLL_X1_SVT",
                                                     "DLL_X2_SVT",
                                                     "FA_X1_SVT",
                                                     "FILLCELL_X16_SVT",
                                                     "FILLCELL_X1_SVT",
                                                     "FILLCELL_X2_SVT",
                                                     "FILLCELL_X32_SVT",
                                                     "FILLCELL_X4_SVT",
                                                     "FILLCELL_X8_SVT",
                                                     "HA_X1_SVT",
                                                     "INV_X16_SVT",
                                                     "INV_X1_SVT",
                                                     "INV_X2_SVT",
                                                     "INV_X32_SVT",
                                                     "INV_X4_SVT",
                                                     "INV_X8_SVT",
                                                     "LOGIC0_X1_SVT",
                                                     "LOGIC1_X1_SVT",
                                                     "MUX2_X1_SVT",
                                                     "MUX2_X2_SVT",
                                                     "NAND2_X1_SVT",
                                                     "NAND2_X2_SVT",
                                                     "NAND2_X4_SVT",
                                                     "NAND3_X1_SVT",
                                                     "NAND3_X2_SVT",
                                                     "NAND3_X4_SVT",
                                                     "NAND4_X1_SVT",
                                                     "NAND4_X2_SVT",
                                                     "NAND4_X4_SVT",
                                                     "NOR2_X1_SVT",
                                                     "NOR2_X2_SVT",
                                                     "NOR2_X4_SVT",
                                                     "NOR3_X1_SVT",
                                                     "NOR3_X2_SVT",
                                                     "NOR3_X4_SVT",
                                                     "NOR4_X1_SVT",
                                                     "NOR4_X2_SVT",
                                                     "NOR4_X4_SVT",
                                                     "OAI211_X1_SVT",
                                                     "OAI211_X2_SVT",
                                                     "OAI211_X4_SVT",
                                                     "OAI21_X1_SVT",
                                                     "OAI21_X2_SVT",
                                                     "OAI21_X4_SVT",
                                                     "OAI221_X1_SVT",
                                                     "OAI221_X2_SVT",
                                                     "OAI221_X4_SVT",
                                                     "OAI222_X1_SVT",
                                                     "OAI222_X2_SVT",
                                                     "OAI222_X4_SVT",
                                                     "OAI22_X1_SVT",
                                                     "OAI22_X2_SVT",
                                                     "OAI22_X4_SVT",
                                                     "OAI33_X1_SVT",
                                                     "OR2_X1_SVT",
                                                     "OR2_X2_SVT",
                                                     "OR2_X4_SVT",
                                                     "OR3_X1_SVT",
                                                     "OR3_X2_SVT",
                                                     "OR3_X4_SVT",
                                                     "OR4_X1_SVT",
                                                     "OR4_X2_SVT",
                                                     "OR4_X4_SVT",
                                                     "SDFFRS_X1_SVT",
                                                     "SDFFRS_X2_SVT",
                                                     "SDFFR_X1_SVT",
                                                     "SDFFR_X2_SVT",
                                                     "SDFFS_X1_SVT",
                                                     "SDFFS_X2_SVT",
                                                     "SDFF_X1_SVT",
                                                     "SDFF_X2_SVT",
                                                     "TBUF_X16_SVT",
                                                     "TBUF_X1_SVT",
                                                     "TBUF_X2_SVT",
                                                     "TBUF_X4_SVT",
                                                     "TBUF_X8_SVT",
                                                     "TINV_X1_SVT",
                                                     "TLAT_X1_SVT",
                                                     "XNOR2_X1_SVT",
                                                     "XNOR2_X2_SVT",
                                                     "XOR2_X1_SVT",
                                                     "XOR2_X2_SVT",
                                                     "AND2_X1",
                                                     "AND2_X2",
                                                     "AND2_X4",
                                                     "AND3_X1",
                                                     "AND3_X2",
                                                     "AND3_X4",
                                                     "AND4_X1",
                                                     "AND4_X2",
                                                     "AND4_X4",
                                                     "ANTENNA_X1",
                                                     "AOI211_X1",
                                                     "AOI211_X2",
                                                     "AOI211_X4",
                                                     "AOI21_X1",
                                                     "AOI21_X2",
                                                     "AOI21_X4",
                                                     "AOI221_X1",
                                                     "AOI221_X2",
                                                     "AOI221_X4",
                                                     "AOI222_X1",
                                                     "AOI222_X2",
                                                     "AOI222_X4",
                                                     "AOI22_X1",
                                                     "AOI22_X2",
                                                     "AOI22_X4",
                                                     "BUF_X16",
                                                     "BUF_X1",
                                                     "BUF_X2",
                                                     "BUF_X32",
                                                     "BUF_X4",
                                                     "BUF_X8",
                                                     "CLKBUF_X1",
                                                     "CLKBUF_X2",
                                                     "CLKBUF_X3",
                                                     "CLKGATETST_X1",
                                                     "CLKGATETST_X2",
                                                     "CLKGATETST_X4",
                                                     "CLKGATETST_X8",
                                                     "CLKGATE_X1",
                                                     "CLKGATE_X2",
                                                     "CLKGATE_X4",
                                                     "CLKGATE_X8",
                                                     "DFFRS_X1",
                                                     "DFFRS_X2",
                                                     "DFFR_X1",
                                                     "DFFR_X2",
                                                     "DFFS_X1",
                                                     "DFFS_X2",
                                                     "DFF_X1",
                                                     "DFF_X2",
                                                     "DLH_X1",
                                                     "DLH_X2",
                                                     "DLL_X1",
                                                     "DLL_X2",
                                                     "FA_X1",
                                                     "FILLCELL_X16",
                                                     "FILLCELL_X1",
                                                     "FILLCELL_X2",
                                                     "FILLCELL_X32",
                                                     "FILLCELL_X4",
                                                     "FILLCELL_X8",
                                                     "HA_X1",
                                                     "INV_X16",
                                                     "INV_X1",
                                                     "INV_X2",
                                                     "INV_X32",
                                                     "INV_X4",
                                                     "INV_X8",
                                                     "LOGIC0_X1",
                                                     "LOGIC1_X1",
                                                     "MUX2_X1",
                                                     "MUX2_X2",
                                                     "NAND2_X1",
                                                     "NAND2_X2",
                                                     "NAND2_X4",
                                                     "NAND3_X1",
                                                     "NAND3_X2",
                                                     "NAND3_X4",
                                                     "NAND4_X1",
                                                     "NAND4_X2",
                                                     "NAND4_X4",
                                                     "NOR2_X1",
                                                     "NOR2_X2",
                                                     "NOR2_X4",
                                                     "NOR3_X1",
                                                     "NOR3_X2",
                                                     "NOR3_X4",
                                                     "NOR4_X1",
                                                     "NOR4_X2",
                                                     "NOR4_X4",
                                                     "OAI211_X1",
                                                     "OAI211_X2",
                                                     "OAI211_X4",
                                                     "OAI21_X1",
                                                     "OAI21_X2",
                                                     "OAI21_X4",
                                                     "OAI221_X1",
                                                     "OAI221_X2",
                                                     "OAI221_X4",
                                                     "OAI222_X1",
                                                     "OAI222_X2",
                                                     "OAI222_X4",
                                                     "OAI22_X1",
                                                     "OAI22_X2",
                                                     "OAI22_X4",
                                                     "OAI33_X1",
                                                     "OR2_X1",
                                                     "OR2_X2",
                                                     "OR2_X4",
                                                     "OR3_X1",
                                                     "OR3_X2",
                                                     "OR3_X4",
                                                     "OR4_X1",
                                                     "OR4_X2",
                                                     "OR4_X4",
                                                     "SDFFRS_X1",
                                                     "SDFFRS_X2",
                                                     "SDFFR_X1",
                                                     "SDFFR_X2",
                                                     "SDFFS_X1",
                                                     "SDFFS_X2",
                                                     "SDFF_X1",
                                                     "SDFF_X2",
                                                     "TBUF_X16",
                                                     "TBUF_X1",
                                                     "TBUF_X2",
                                                     "TBUF_X4",
                                                     "TBUF_X8",
                                                     "TINV_X1",
                                                     "TLAT_X1",
                                                     "XNOR2_X1",
                                                     "XNOR2_X2",
                                                     "XOR2_X1",
                                                     "XOR2_X2",
                                                     "MemGen_16_10" };
  return stdCells.find(moduleName) != stdCells.end();
}
void HierCellsNetListsVisitor::selfTest(
  std::unordered_map<std::string, Module> hierCellsNetLists,
  const std::string &filename)
{
  std::ofstream ofs(filename);
  for(const auto &oneModule: hierCellsNetLists)
  {
    if(!IsStdCell(oneModule.first))
    { /**
       * @example module omsp_and_gate__0_1424(y, a, b);
       */
      auto module = oneModule.second;
      ofs << "module " << module.moduleDefName << "(";
      for(auto input: module.inputs)
      {
        ofs << input.portDefName << ", ";
      }
      for(auto output: module.outputs)
      {
        ofs << output.portDefName << ", ";
      }
      for(auto inout: module.inouts)
      {
        ofs << inout.portDefName << ", ";
      }
      ofs.seekp(ofs.tellp() - std::streampos(1)); // 顶掉一个 ","
      ofs.seekp(ofs.tellp() - std::streampos(1)); // 顶掉一个 ","
      ofs << ");" << std::endl;

      /**
       * @example
       *    output y;
       *     input a;
       *     input b;
       */
      for(auto output: module.outputs)
      {
        ofs << "\t output ";
        if(output.isVector)
        {
          ofs << "[" << output.bitWidth - 1 << ":0]";
        }
        ofs << output.portDefName;
        ofs << ";" << std::endl;
      }
      for(auto input: module.inputs)
      {
        ofs << "\t input ";
        if(input.isVector)
        {
          ofs << "[" << input.bitWidth - 1 << ":0]";
        }
        ofs << input.portDefName;
        ofs << ";" << std::endl;
      }
      for(auto inout: module.inouts)
      {
        ofs << "\t inout ";
        if(inout.isVector)
        {
          ofs << "[" << inout.bitWidth - 1 << ":0]";
        }
        ofs << inout.portDefName;
        ofs << ";" << std::endl;
      }
      ofs << std::endl;

      /**
       * @example wire wdtnmies;
       */
      for(auto wire: module.wires)
      {
        ofs << "\t wire ";
        if(wire.isVector)
        {
          ofs << "[" << wire.bitWidth - 1 << ":0]";
        }
        ofs << wire.portDefName;
        ofs << ";" << std::endl;
      }
      ofs << std::endl;

      /**
       * @example
       *          1 - assign per_dout[15] = 1'b0;
       *          2 - assign per_dout[14] = per_dout[5];
       */

      for(auto assign: module.assigns)
      {
        ofs << "\tassign ";
        if(assign.lValue.varRefName != "anonymous")
        {
          ofs << assign.lValue.varRefName;
          if(assign.lValue.isVector)
          {
            ofs << "[" << assign.lValue.index << "]";
          }
        }
        else
        {
          throw std::runtime_error("assign left value can not be anonymous");
        }
        ofs << " = ";
        if(assign.rValue.varRefName == "anonymous")
        {
          ofs << "1'b" << assign.rValue.initialVal;
        }
        else
        {
          ofs << assign.rValue.varRefName;
          if(assign.rValue.isVector)
          {
            ofs << "[" << assign.rValue.index << "]";
          }
        }
        ofs << ";" << std::endl;
      }
      ofs << std::endl;

      /**
       * @example  NAND2_X1_LVT i_0_0 (.A1(exec_cycle), .A2(inst_bw),
       * .ZN(op_bit8_msk));
       */
      for(const auto &subModuleInstanceName: module.subModuleInstanceNames)
      {
        ofs << "\t"
            << module.subModInsNameMapSubModDefName[subModuleInstanceName]
            << " " << subModuleInstanceName << " ";
        ofs << "(";
        for(const auto &portAssignment:
            module.subModInsNameMapPortAssignments[subModuleInstanceName])
        {
          ofs << "." << portAssignment.portDefName << "(";
          if(portAssignment.varRefs.size() > 1)
          {
            ofs << "{";
          }
          for(const auto &varRef: portAssignment.varRefs)
          {
            if(varRef.varRefName == "anonymous")
            {
              ofs << "1'b" << varRef.initialVal;
            }
            else
            {
              ofs << varRef.varRefName;
              if(varRef.isVector)
              {
                ofs << "[" << varRef.index << "]";
              }
            }
            ofs << ",";
          }
          if(!portAssignment.varRefs.empty())
          {
            ofs.seekp(ofs.tellp() - std::streampos(1)); // 顶掉一个 ","
          }
          if(portAssignment.varRefs.size() > 1)
          {
            ofs << "}";
          }
          ofs << "),";
        }
        ofs.seekp(ofs.tellp() - std::streampos(1)); // 顶掉一个 ","
        ofs << ");" << std::endl;
      }

      ofs << "endmodule" << std::endl << std::endl;
    }
  }
}
/**************************************************************
 * 自测函数(END)
 * *****************************************************************/
}
