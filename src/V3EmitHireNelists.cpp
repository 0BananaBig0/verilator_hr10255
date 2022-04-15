#include "V3EmitNelists.h"

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
struct PortInstanceFormalComplexMsg
{
    /**
     * @brief portInstanceName == "anonymous"
     * 时即为常量赋值，也就是匿名赋值
     */
    std::string portInstanceName = "anonymous"; // 端口实例名称 (实参)
    bool isArray = false;                       // 是否是数组类型
    std::pair<uint32_t, uint32_t> indexRange;   // 引脚范围
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
struct AssignStatementComplexMsg
{
    PortInstanceFormalComplexMsg lValue; // 左值
    PortInstanceFormalComplexMsg rValue; // 右值
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

std::vector<int> PortInstanceFormalComplexMsg::getIndexs()
{
  if(!isArray)
  {
    throw std::runtime_error(
      "PortInstanceFormalComplexMsg::getIndexs() should "
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
    AssignStatementComplexMsg
      assignStatementComplexMsg; // assign 语句信息临时存放处
    bool isFrist = true;

  public:
    /**
     * @brief     处理左值以及右值的端口实例信息
     * @param[in] portInstanceName : 一般指的是 nodep->prettyName()
     * @return    true 代表当前处理的是 assign 语句
     */
    bool ProcessPortInstanceName(const std::string &portInstanceName)
    {
      if(!isAssignStatement)
      {
        return false;
      }
      // First, process assignlValue(corresponding to if statement),
      // Second,process assignrValue(corresponding to else statement)
      if(isAssignLvalue)
      {
        assignStatementComplexMsg.lValue.portInstanceName = portInstanceName;
        if(assignStatementComplexMsg.lValue.isArray == false)
        {
          // Make the next call of ProcessPortInstanceName to process
          // assignrValue.
          isAssignLvalue = !isAssignLvalue;
        }
      }
      else
      {
        assignStatementComplexMsg.rValue.portInstanceName = portInstanceName;
        if(assignStatementComplexMsg.rValue.isArray == false)
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
        assignStatementComplexMsg.lValue.isArray = true;
      }
      else
      {
        assignStatementComplexMsg.rValue.isArray = true;
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
        PortInstanceFormalComplexMsg &value = assignStatementComplexMsg.lValue;
        if(value.portInstanceName == "anonymous")
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
        PortInstanceFormalComplexMsg &value = assignStatementComplexMsg.rValue;
        if(value.portInstanceName == "anonymous")
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
    std::unordered_map<std::string, ModuleMsg> _moduleMap;

  private:
    std::string _curModuleInstanceParentName; // 当前模块实例父亲的名称
    std::string _curModuleInstanceName;       // 当前模块实例的名称

    AssignStatus _assignStatus; // assign 相关状态

    PortInstanceMsg _portInstanceMsgTmp; // 端口实例信息临时变量
    PortInstanceFormalComplexMsg
      _portInstanceFormalComplexTmp; // 端口实例形参信息 (复杂)

    std::vector<PortInstanceMsg>
      _curModulePortInstanceMsg; // 当前模块的引脚实例信息

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
    virtual void visit(AstAssignW *nodep) override { iterateChildren(nodep); };
    virtual void visit(AstAssign *nodep) override { iterateChildren(nodep); };

  public:
    /**
     * @brief 获取层次化网表
     */
    std::unordered_map<std::string, ModuleMsg> GetHierCellsNetLists();

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
    selfTest(std::unordered_map<std::string, ModuleMsg> hierCellsNetLists,
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
    ModuleMsg moduleInstanceMsg;
    moduleInstanceMsg.moduleDefName = moduleDefName;
    moduleInstanceMsg.level = level;
    _moduleMap[moduleDefName] = std::move(moduleInstanceMsg);
  };

  if(nodep->prettyName() == "@CONST-POOL@")
  {
    return;
  }

  createModuleInstance(nodep->origName(), nodep->level());

  _curModuleInstanceParentName = nodep->origName();
  _curModuleInstanceName = nodep->origName();

  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstVar *nodep)
{
  PortMsg portMsg;
  portMsg.portDefName = nodep->origName();

  if(nodep->isIO())
  {
    switch(nodep->direction())
    {
    case VDirection::INPUT:
      portMsg.portType = PortType::INPUT;
      break;
    case VDirection::OUTPUT:
      portMsg.portType = PortType::OUTPUT;
      break;
    case VDirection::INOUT:
      portMsg.portType = PortType::INOUT;
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
    portMsg.portType = PortType::WIRE;
  }

  if(nodep->basicp() && nodep->basicp()->width() != 1)
  {
    portMsg.isArray = true;
    portMsg.arraySize = nodep->basicp()->width();
  }

  switch(portMsg.portType)
  {
  case PortType::INPUT:
    _moduleMap[_curModuleInstanceParentName].inputs.push_back(
      std::move(portMsg));
    break;
  case PortType::OUTPUT:
    _moduleMap[_curModuleInstanceParentName].outputs.push_back(
      std::move(portMsg));
    break;
  case PortType::INOUT:
    _moduleMap[_curModuleInstanceParentName].inouts.push_back(
      std::move(portMsg));
    break;
  case PortType::WIRE:
    _moduleMap[_curModuleInstanceParentName].wires.push_back(
      std::move(portMsg));

    break;
  default:
    break;
  }

  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstCell *nodep)
{
  /** @brief 向 ModuleMsg 塞入一个子模块
   *  @sa    ModuleMsg
   */
  auto insertSubmoduleInstance =
    [this, nodep](const std::string &parentModuleName,
                  const std::string &moduleDefName,
                  const std::string &moduleInstanceName) -> void
  {
    ModuleMsg &parentModuleInstanceMsg =
      _moduleMap[_curModuleInstanceParentName];
    parentModuleInstanceMsg.subModuleInstanceNames.push_back(
      moduleInstanceName);
    parentModuleInstanceMsg.moduleDefInstanceMap[moduleInstanceName] =
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
  MemoMaker<PortInstanceFormalComplexMsg> memoMaker3(
    _portInstanceFormalComplexTmp);

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
  _portInstanceMsgTmp.portInstanceFormalMsgs.clear();
  MemoMaker<PortInstanceMsg> memoMaker1(_portInstanceMsgTmp);
  MemoMaker<PortInstanceFormalComplexMsg> memoMaker2(
    _portInstanceFormalComplexTmp);
  _portInstanceMsgTmp.portDefName = nodep->prettyName();
  iterateChildren(nodep);
  // 插入当前模块实例的一个端口信息
  _moduleMap[_curModuleInstanceParentName]
    .subModulePorts[_curModuleInstanceName]
    .push_back(_portInstanceMsgTmp);
}

/**
 * @note 进入此引脚的实例参数不止一个，目前这里不需要做任何处理
 * @sa   PortInstanceMsg
 */
void HierCellsNetListsVisitor::visit(AstConcat *nodep)
{
  // 手动还原 _portInstanceFormalComplexTmp.portInstanceName 默认值
  _portInstanceFormalComplexTmp.portInstanceName = "anonymous";
  iterateChildren(nodep);
}

/**
 * @note 当 _portInstanceFormalComplexTmp.portInstanceName ==
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
    if(_portInstanceFormalComplexTmp.portInstanceName == "anonymous")
    {
      // 引脚实例 tmp 自动恢复默认值
      MemoMaker<PortInstanceFormalComplexMsg> memoMaker(
        _portInstanceFormalComplexTmp);
      uint32_t len = getLen(nodep->prettyName());
      _portInstanceFormalComplexTmp.indexRange.first =
        IndexStrToIndexNum(nodep->prettyName());
      PortInstanceFormalMsg portInstanceFormalMsg;
      portInstanceFormalMsg.initialVal =
        _portInstanceFormalComplexTmp.indexRange.first;
      for(uint32_t i = 0; i < len; i++)
      {
        _portInstanceMsgTmp.portInstanceFormalMsgs.push_back(
          portInstanceFormalMsg);
      }
    }
    else
    {
      if(isFirst)
      {
        isFirst = !isFirst;
        _portInstanceFormalComplexTmp.indexRange.first =
          IndexStrToIndexNum(nodep->prettyName());
      }
      else
      {
        isFirst = !isFirst;
        _portInstanceFormalComplexTmp.indexRange.second =
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
  MemoMaker<PortInstanceFormalComplexMsg> memoMaker(
    _portInstanceFormalComplexTmp);

  if(_assignStatus.isAssignStatement)
  {
    _assignStatus.ProcessIsArray();
  }
  else
  {
    _portInstanceFormalComplexTmp.isArray = true;
  }
  iterateChildren(nodep);
  if(_assignStatus.isAssignStatement) {}
  else
  {
    PortInstanceFormalMsg portInstanceFormalMsg;
    portInstanceFormalMsg.portInstanceName =
      _portInstanceFormalComplexTmp.portInstanceName;
    portInstanceFormalMsg.isArray = _portInstanceFormalComplexTmp.isArray;
    auto indexs = _portInstanceFormalComplexTmp.getIndexs();
    for(auto index: indexs)
    {
      portInstanceFormalMsg.index = index;
      _portInstanceMsgTmp.portInstanceFormalMsgs.push_back(
        portInstanceFormalMsg);
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
  AssignStatementMsg assignStatementMsg;
  assignStatementMsg.lValue.portInstanceName =
    _assignStatus.assignStatementComplexMsg.lValue.portInstanceName;
  assignStatementMsg.lValue.isArray =
    _assignStatus.assignStatementComplexMsg.lValue.isArray;
  assignStatementMsg.rValue.portInstanceName =
    _assignStatus.assignStatementComplexMsg.rValue.portInstanceName;
  assignStatementMsg.rValue.isArray =
    _assignStatus.assignStatementComplexMsg.rValue.isArray;
  for(uint32_t i = 0;
      i < _assignStatus.assignStatementComplexMsg.lValue.indexRange.second;
      i++)
  {
    if(assignStatementMsg.lValue.portInstanceName != "anonymous")
    {
      assignStatementMsg.lValue.index =
        _assignStatus.assignStatementComplexMsg.lValue.indexRange.first + i;
    }
    else
    {
      assignStatementMsg.lValue.index =
        _assignStatus.assignStatementComplexMsg.lValue.indexRange.second;
    }
    if(assignStatementMsg.rValue.portInstanceName != "anonymous")
    {
      assignStatementMsg.rValue.index =
        _assignStatus.assignStatementComplexMsg.rValue.indexRange.first + i;
    }
    else
    {
      assignStatementMsg.rValue.index =
        _assignStatus.assignStatementComplexMsg.rValue.indexRange.first;
    }
    _moduleMap[_curModuleInstanceParentName].assigns.push_back(
      assignStatementMsg);
  }
}

void HierCellsNetListsVisitor::visit(AstVarRef *nodep)
{
  // isFirst == true 代表操作 first，反之操作 second
  static bool isFirst = true;

  if(_assignStatus.isAssignStatement)
  {
    _assignStatus.ProcessPortInstanceName(nodep->prettyName());
  }
  else
  {
    _portInstanceFormalComplexTmp.portInstanceName = nodep->prettyName();
  }
  iterateChildren(nodep);
  if(_assignStatus.isAssignStatement)
  {
    // nothing
    ;
  }
  else
  {
    if(_portInstanceFormalComplexTmp.isArray == false)
    {
      PortInstanceFormalMsg portInstanceFormalMsg;
      portInstanceFormalMsg.portInstanceName =
        _portInstanceFormalComplexTmp.portInstanceName;
      portInstanceFormalMsg.isArray = _portInstanceFormalComplexTmp.isArray;
      _portInstanceMsgTmp.portInstanceFormalMsgs.push_back(
        portInstanceFormalMsg);
    }
  }
}

std::unordered_map<std::string, ModuleMsg>
HierCellsNetListsVisitor::GetHierCellsNetLists()
{
  return _moduleMap;
  // return std::move(_moduleMap);
}

void V3EmitHierNetLists::emitHireNetLists(
  std::unordered_map<std::string, ModuleMsg> &hierCellsNetLists)
{
  // v3Global will return a AstNetlist*
  HierCellsNetListsVisitor hierCellsNetListsVisitor(v3Global.rootp());
  hierCellsNetLists = hierCellsNetListsVisitor.GetHierCellsNetLists();
}

void V3EmitHierNetLists::printHireNetLists(
  std::unordered_map<std::string, ModuleMsg> &hierCellsNetLists,
  std::string filename)
{
  HierCellsNetListsVisitor::selfTest(hierCellsNetLists, filename);
}

/**************************************************************
 * 自测函数(START)
 * *****************************************************************/
void HierCellsNetListsVisitor::selfTest(
  std::unordered_map<std::string, ModuleMsg> hierCellsNetLists,
  const std::string &filename)
{
  std::ofstream ofs(filename);
  for(const auto &moduleMsg: hierCellsNetLists)
  {
    /**
     * @example module omsp_and_gate__0_1424(y, a, b);
     */
    auto module = moduleMsg.second;
    ofs << "module " << module.moduleDefName << "(";
    for(auto output: module.outputs) { ofs << output.portDefName << ","; }
    for(auto input: module.inputs) { ofs << input.portDefName << ","; }
    for(auto inout: module.inouts) { ofs << inout.portDefName << ","; }
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
      if(output.isArray)
      {
        ofs << "[" << output.arraySize - 1 << ":0]";
      }
      ofs << output.portDefName;
      ofs << ";" << std::endl;
    }
    for(auto input: module.inputs)
    {
      ofs << "\t input ";
      if(input.isArray)
      {
        ofs << "[" << input.arraySize - 1 << ":0]";
      }
      ofs << input.portDefName;
      ofs << ";" << std::endl;
    }
    for(auto inout: module.inouts)
    {
      ofs << "\t inout ";
      if(inout.isArray)
      {
        ofs << "[" << inout.arraySize - 1 << ":0]";
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
      if(wire.isArray)
      {
        ofs << "[" << wire.arraySize - 1 << ":0]";
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
      if(assign.lValue.portInstanceName != "anonymous")
      {
        ofs << assign.lValue.portInstanceName;
        if(assign.lValue.isArray)
        {
          ofs << "[" << assign.lValue.index << "]";
        }
      }
      else
      {
        throw std::runtime_error("assign left value can not be anonymous");
      }
      ofs << " = ";
      if(assign.rValue.portInstanceName == "anonymous")
      {
        ofs << "1'b" << assign.rValue.initialVal;
      }
      else
      {
        ofs << assign.rValue.portInstanceName;
        if(assign.rValue.isArray)
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
      ofs << "\t" << module.moduleDefInstanceMap[subModuleInstanceName] << " "
          << subModuleInstanceName << " ";
      ofs << "(";
      for(const auto &portInstanceMsg:
          module.subModulePorts[subModuleInstanceName])
      {
        ofs << "." << portInstanceMsg.portDefName << "(";
        if(portInstanceMsg.portInstanceFormalMsgs.size() > 1)
        {
          ofs << "{";
        }
        for(const auto &portInstanceFormalMsg:
            portInstanceMsg.portInstanceFormalMsgs)
        {
          if(portInstanceFormalMsg.portInstanceName == "anonymous")
          {
            ofs << "1'b" << portInstanceFormalMsg.initialVal;
          }
          else
          {
            ofs << portInstanceFormalMsg.portInstanceName;
            if(portInstanceFormalMsg.isArray)
            {
              ofs << "[" << portInstanceFormalMsg.index << "]";
            }
          }
          ofs << ",";
        }
        if(!portInstanceMsg.portInstanceFormalMsgs.empty())
        {
          ofs.seekp(ofs.tellp() - std::streampos(1)); // 顶掉一个 ","
        }
        if(portInstanceMsg.portInstanceFormalMsgs.size() > 1)
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
/**************************************************************
 * 自测函数(END)
 * *****************************************************************/
}
