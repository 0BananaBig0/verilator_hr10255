/*************************************************************************
  > File Name: src/V3EmitHireNelistsNew.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Mon 11 Apr 2022 08:18:10 PM CST
 ************************************************************************/
#include "V3EmitNelistsNew.h"

#include <cstdint>
#include <cstdlib>
#include <exception>
#include <fstream>
#include <iostream>
#include <unordered_map>

#include "V3Ast.h"
#include "V3Error.h"
// #include "netlistsdefineNew.h"

namespace MultipleBitsNetlist
{
/** @brief 层次化网表访问者 */
struct ModAndItsHierLevel
{
    std::string moduleDefName;
    uint32_t level;
};
// When writing visit functions, there are some keys we should know:
// (1)Everytime we only write either AstAssignW/AstAssign or AstPin information
// until all its information have been obtained.
// (2)Only AstVarRef or AstSel can be lValue of assign statement.
// (3)AstConst, AstExtend and AstConcat can't be lValue of assign statement.
// (4)Know the difference between m_nextp and m_opxp, some information about
// them I have written before the declaration of visit function.
// (5)AstAssign only has one bit information.
// (6)We only can writ one AstVarRef information at the same time.
// (7)Only such AstNode that has children pointed by m_opxp and we need the
// information of its children can call iterateChildren(nodep) function.
class HierCellsNetListsVisitor final : public AstNVisitor
{
  public:
    // std::string -> Current Module name.
    // ModuleMsg -> All information about current module include port,
    // submodule instance, assign statement and so on.
    // AstNetlist
    std::unordered_map<std::string, ModuleMsg> _modsNameMapTheirMsg;
    // use to optimize flattern netlist.
    // AstNetlist
    std::vector<ModAndItsHierLevel> _modAndItsHierLevels;

  private:
    // A module = ItsName + Port  + Wire + Assign staement + Submodule Instance
    // AstModule
    std::string _curModuleName;
    // AstCell
    std::string _curSubmoduleName;
    std::string _curSubmoduleInstanceName;

    // AstAssignW/AstAssign Status
    bool _isAssignStatement = false;
    bool _isAssignStatementLvalue = false;
    // Themporary message of current visited assign statement
    AssignStatementMsg _assignStatementMsgTmp;

    // Themporary instance message of current visited port
    PortInstanceMsg _portInstanceMsgTmp;
    // Port Instance message of current visited submodule instance
    std::vector<PortInstanceMsg> _curSubModInsPortInsMsgs;

    // AstSel Status:1 = m_op1p, 2 = m_op2p, 3 = m_op3p, 4 = m_op4p
    uint32_t _whichAstSelChildren = 0;
    PortRefMsg _portRefMsgTmp;

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
    virtual void visit(AstNode *nodep) override { iterateChildren(nodep); };

    virtual void visit(AstModule *nodep) override;
    virtual void visit(AstVar *nodep) override;
    virtual void visit(AstAssignW *nodep) override;
    virtual void visit(AstAssign *nodep) override;
    virtual void visit(AstCell *nodep) override;
    virtual void visit(AstPin *nodep) override;
    virtual void visit(AstConcat *nodep) override { iterateChildren(nodep); };
    virtual void visit(AstSel *nodep) override;
    virtual void visit(AstVarRef *nodep) override;
    virtual void visit(AstExtend *nodep) override;
    virtual void visit(AstExtendS *nodep) override;
    virtual void visit(AstReplicate *nodep) override;
    virtual void visit(AstConst *nodep) override;

  public:
    /**
     * @brief 获取层次化网表
     */
    std::unordered_map<std::string, ModuleMsg> GetHierCellsNetLists();

  public:
    // AstNetlist is ConElement
    HierCellsNetListsVisitor(AstNetlist *nodep) { nodep->accept(*this); }
    virtual ~HierCellsNetListsVisitor() override{};
};

// Get module name and hierLevel,
// create ModuleMsg object to store module information.
void HierCellsNetListsVisitor::visit(AstModule *nodep)
{
  auto createModule = [this](const std::string &moduleDefName,
                             uint32_t level = -1) -> void
  {
    ModuleMsg moduleMsg;
    moduleMsg.moduleDefName = moduleDefName;
    moduleMsg.level = level;
    _modsNameMapTheirMsg[moduleDefName] = std::move(moduleMsg);
    _curModuleName = moduleDefName;

    ModAndItsHierLevel modAndItsHierLevel;
    modAndItsHierLevel.moduleDefName = moduleDefName;
    modAndItsHierLevel.level = level;
    _modAndItsHierLevels.push_back(std::move(modAndItsHierLevel));
  };

  if(nodep->prettyName() == "@CONST-POOL@")
  {
    return;
  }

  createModule(nodep->origName(), nodep->level());
  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstVar *nodep)
{
  PortMsg portMsg;

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
  else if(nodep->isGParam())
  {
    std::cout << "We know " << nodep->origName() << " is a parameter in "
              << _curModuleName << ". But we don't care about it."
              << std::endl;
    return;
  }
  else
  {
    portMsg.portType = PortType::WIRE;
  }
  portMsg.portDefName = nodep->origName();

  if(nodep->basicp() && nodep->basicp()->width() != 1)
  {
    portMsg.isArray = true;
    portMsg.arraySize = nodep->basicp()->width();
  }

  switch(portMsg.portType)
  {
  case PortType::INPUT:
    _modsNameMapTheirMsg[_curModuleName].inputs.push_back(std::move(portMsg));
    break;
  case PortType::OUTPUT:
    _modsNameMapTheirMsg[_curModuleName].outputs.push_back(std::move(portMsg));
    break;
  case PortType::INOUT:
    _modsNameMapTheirMsg[_curModuleName].inouts.push_back(std::move(portMsg));
    break;
  case PortType::WIRE:
    _modsNameMapTheirMsg[_curModuleName].wires.push_back(std::move(portMsg));
    break;
  default:
    break;
  }
}

void HierCellsNetListsVisitor::visit(AstAssignW *nodep)
{
  _isAssignStatement = true;
  _assignStatementMsgTmp.rValue.clear();
  iterateChildren(nodep);
  _modsNameMapTheirMsg[_curModuleName].assigns.push_back(
    _assignStatementMsgTmp);
  _isAssignStatement = false;
}

void HierCellsNetListsVisitor::visit(AstAssign *nodep)
{
  _isAssignStatement = true;
  _assignStatementMsgTmp.rValue.clear();
  iterateChildren(nodep);
  _modsNameMapTheirMsg[_curModuleName].assigns.push_back(
    _assignStatementMsgTmp);
  _isAssignStatement = false;
}

void HierCellsNetListsVisitor::visit(AstCell *nodep)
{
  _curSubmoduleName = nodep->modName();
  _curSubmoduleInstanceName = nodep->origName();
  _curSubModInsPortInsMsgs.clear();
  iterateChildren(nodep);
  _modsNameMapTheirMsg[_curModuleName]
    .subModInsNameMapPortInsMsgVec[_curSubmoduleInstanceName] =
    _curSubModInsPortInsMsgs;
  _modsNameMapTheirMsg[_curModuleName]
    .subModInsNameMapSubModDefName[_curSubmoduleInstanceName] =
    _curSubmoduleName;
  _modsNameMapTheirMsg[_curModuleName].subModuleInstanceNames.push_back(
    _curSubmoduleInstanceName);
}

void HierCellsNetListsVisitor::visit(AstPin *nodep)
{
  _portInstanceMsgTmp.portRefMsgs.clear();
  _portInstanceMsgTmp.portDefName = nodep->name();
  iterateChildren(nodep);
  _curSubModInsPortInsMsgs.push_back(_portInstanceMsgTmp);
}

void HierCellsNetListsVisitor::visit(AstSel *nodep)
{
  _whichAstSelChildren = 1;
  iterateChildren(nodep);
  if(_isAssignStatement)
  { // Now, AstSel is a child or a descendant of AstAssignW
    if(_isAssignStatementLvalue)
    { // Now, AstSel is a child of AstAssignW
      _assignStatementMsgTmp.lValue = _portRefMsgTmp;
      _isAssignStatementLvalue = false;
    }
    else
    { // Now, AstSel is a child of AstAssign or AstExtend or AstConcat
      _assignStatementMsgTmp.rValue.push_back(_portRefMsgTmp);
    }
  }
  else
  {
    // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat
    _portInstanceMsgTmp.portRefMsgs.push_back(_portRefMsgTmp);
  }
  _whichAstSelChildren = 0;
}

// If AstVarRef is a child of AstSel, it references some part of a var.
// For example, C[2:1];
// Otherwise, it references the whole part of a var.
// For example, C[n-1:0] or ci;
void HierCellsNetListsVisitor::visit(AstVarRef *nodep)
{
  _portRefMsgTmp.portRefName = nodep->name();
  if(_whichAstSelChildren)
  { // Now, AstVarRef is a child of AstSel
    _whichAstSelChildren++;
    if(nodep->access() == VAccess::WRITE)
    {
      _isAssignStatementLvalue = true;
    }
  }
  else
  {
    _portRefMsgTmp.hasValueX = false;
    _portRefMsgTmp.portRefRange.end =
      nodep->dtypep()->basicp()->nrange().left();
    _portRefMsgTmp.portRefRange.start =
      nodep->dtypep()->basicp()->nrange().right();
    _portRefMsgTmp.portRefRange.width =
      _portRefMsgTmp.portRefRange.end - _portRefMsgTmp.portRefRange.start + 1;
    if(_portRefMsgTmp.portRefRange.width > 1)
      _portRefMsgTmp.isArray = true;
    else
      _portRefMsgTmp.isArray = false;
    if(_isAssignStatement)
    { // Now, AstVarRef is a child of AstAssign or a descendant of AstAssignW
      if(nodep->access() == VAccess::WRITE)
      { // Now, AstVarRef is a child of AstAssign
        _assignStatementMsgTmp.lValue = _portRefMsgTmp;
      }
      else
      { // Now, AstVarRef is a child of AstAssign or AstExtend or AstConcat or
        // AstReplicate
        _assignStatementMsgTmp.rValue.push_back(_portRefMsgTmp);
      }
    }
    else
    {
      // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat or
      // AstReplicate
      _portInstanceMsgTmp.portRefMsgs.push_back(_portRefMsgTmp);
    }
  }
}

void HierCellsNetListsVisitor::visit(AstExtend *nodep)
{
  uint32_t extendWidth = nodep->width() - nodep->lhsp()->width();
  _portRefMsgTmp.portRefName = "";
  _portRefMsgTmp.constValueAndWidth.value = 0;
  _portRefMsgTmp.constValueAndWidth.valueX = 0;
  if(extendWidth > 1)
    _portRefMsgTmp.isArray = true;
  else
    _portRefMsgTmp.isArray = false;
  _portRefMsgTmp.hasValueX = false;
  _portRefMsgTmp.constValueAndWidth.width = std::move(extendWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstAssign or AstAssignW or AstConcat
    _assignStatementMsgTmp.rValue.push_back(_portRefMsgTmp);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _portInstanceMsgTmp.portRefMsgs.push_back(_portRefMsgTmp);
  }
  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstExtendS *nodep)
{
  uint32_t extendSWidth = nodep->width() - nodep->lhsp()->width();
  _portRefMsgTmp.portRefName = "";
  _portRefMsgTmp.constValueAndWidth.value = (1 << extendSWidth) - 1;
  _portRefMsgTmp.constValueAndWidth.valueX = 0;
  if(extendSWidth > 1)
    _portRefMsgTmp.isArray = true;
  else
    _portRefMsgTmp.isArray = false;
  _portRefMsgTmp.hasValueX = false;
  _portRefMsgTmp.constValueAndWidth.width = std::move(extendSWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstAssign or AstAssignW or AstConcat
    _assignStatementMsgTmp.rValue.push_back(_portRefMsgTmp);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _portInstanceMsgTmp.portRefMsgs.push_back(_portRefMsgTmp);
  }
  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstReplicate *nodep)
{
  iterateChildren(nodep);
  if(_isAssignStatement)
  { // Now, AstReplicate is a child of AstAssignW or AstExtend or AstConcat
    uint32_t replicateTimes =
      _assignStatementMsgTmp.rValue.back().constValueAndWidth.value;
    _assignStatementMsgTmp.rValue.pop_back();
    while(replicateTimes > 0)
    {
      _assignStatementMsgTmp.rValue.push_back(
        _assignStatementMsgTmp.rValue.back());
    }
  }
  else
  { // Now, AstReplicate is a child of AstPin or AstExtend or AstConcat
    uint32_t replicateTimes =
      _portInstanceMsgTmp.portRefMsgs.back().constValueAndWidth.value;
    _portInstanceMsgTmp.portRefMsgs.pop_back();
    while(replicateTimes > 0)
    {
      _portInstanceMsgTmp.portRefMsgs.push_back(
        _portInstanceMsgTmp.portRefMsgs.back());
      replicateTimes--;
    }
  }
}

void HierCellsNetListsVisitor::visit(AstConst *nodep)
{
  if(_whichAstSelChildren == 2)
  { // Now, AstConst is a child of AstSel
    _whichAstSelChildren++;
    _portRefMsgTmp.portRefRange.start = nodep->num().getValue();
  }
  else if(_whichAstSelChildren == 3)
  { // Now, AstConst is a child of AstSel
    _portRefMsgTmp.portRefRange.width = nodep->num().getValue();
    _portRefMsgTmp.portRefRange.end = _portRefMsgTmp.portRefRange.start +
                                      _portRefMsgTmp.portRefRange.width - 1;
    if(_portRefMsgTmp.portRefRange.width > 1)
      _portRefMsgTmp.isArray = true;
    else
      _portRefMsgTmp.isArray = false;
    _portRefMsgTmp.hasValueX = false;
  }
  else
  { // Now, AstConst is a rValue of assign statement or refValue of a port or
    // the number of AstReplicate.
    _portRefMsgTmp.portRefName = "";
    _portRefMsgTmp.constValueAndWidth.value = nodep->num().getValue();
    _portRefMsgTmp.constValueAndWidth.width = nodep->width();
    if(_portRefMsgTmp.constValueAndWidth.width > 1)
      _portRefMsgTmp.isArray = true;
    else
      _portRefMsgTmp.isArray = false;
    if(nodep->num().isAnyXZ())
    { // Now, the const value has value x or z.
      _portRefMsgTmp.constValueAndWidth.valueX = nodep->num().getValueX();
      _portRefMsgTmp.hasValueX = true;
    }
    else
    {
      _portRefMsgTmp.constValueAndWidth.valueX = 0;
      _portRefMsgTmp.hasValueX = false;
    }
    if(_isAssignStatement)
    { // Now, AstConst is a child of AstAssign or AstAssignW or AstConcat or
      // AstReplicate
      _assignStatementMsgTmp.rValue.push_back(_portRefMsgTmp);
    }
    else
    { // Now, AstConst is a child of AstPin or AstConcat or AstReplicate
      _portInstanceMsgTmp.portRefMsgs.push_back(_portRefMsgTmp);
    }
  }
}

std::unordered_map<std::string, ModuleMsg>
HierCellsNetListsVisitor::GetHierCellsNetLists()
{
  return _modsNameMapTheirMsg;
}

void V3EmitHierNetLists::emitHireNetLists(
  std::unordered_map<std::string, ModuleMsg> &hierCellsNetLists)
{
  // v3Global will return a AstNetlist*
  HierCellsNetListsVisitor hierCellsNetListsVisitor(v3Global.rootp());
  hierCellsNetLists = hierCellsNetListsVisitor.GetHierCellsNetLists();
}
}
