/*************************************************************************
  > File Name: src/V3EmitHierNetlistsNew.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Mon 11 Apr 2022 08:18:10 PM CST
 ************************************************************************/
#include "V3EmitNetlistsNew.h"

#include <cstdint>
#include <cstdlib>
#include <exception>
#include <fstream>
#include <iostream>
#include <unordered_map>
#include <vector>

#include "V3Ast.h"
#include "V3Error.h"
#include "netlistsdefine.h"

namespace MultipleBitsNetlist
{
/** @brief 层次化网表访问者 */
struct ModAndItsHierLevel
{
    std::string moduleDefName;
    uint32_t level;
    bool isFlatted = false;
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
    VarRefMsg _varRefMsgTmp;

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
  else
  {
    createModule(nodep->prettyName(), nodep->level());
  }
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
    std::cout << "We know " << nodep->prettyName() << " is a parameter in "
              << _curModuleName << ". But we don't care about it."
              << std::endl;
    return;
  }
  else
  {
    portMsg.portType = PortType::WIRE;
  }
  portMsg.portDefName = nodep->prettyName();

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
  _curSubmoduleName = nodep->modp()->prettyName();
  _curSubmoduleInstanceName = nodep->prettyName();
  _curSubModInsPortInsMsgs.clear();
  iterateChildren(nodep);
  _modsNameMapTheirMsg[_curModuleName]
    .subModInsNameMapPortInsMsgs[_curSubmoduleInstanceName] =
    _curSubModInsPortInsMsgs;
  _modsNameMapTheirMsg[_curModuleName]
    .subModInsNameMapSubModDefName[_curSubmoduleInstanceName] =
    _curSubmoduleName;
  _modsNameMapTheirMsg[_curModuleName].subModuleInstanceNames.push_back(
    _curSubmoduleInstanceName);
}

void HierCellsNetListsVisitor::visit(AstPin *nodep)
{
  _portInstanceMsgTmp.varRefMsgs.clear();
  _portInstanceMsgTmp.portDefName = nodep->modVarp()->name();
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
      _assignStatementMsgTmp.lValue = _varRefMsgTmp;
      _isAssignStatementLvalue = false;
    }
    else
    { // Now, AstSel is a child of AstAssign or AstExtend or AstConcat
      _assignStatementMsgTmp.rValue.push_back(_varRefMsgTmp);
    }
  }
  else
  {
    // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat
    _portInstanceMsgTmp.varRefMsgs.push_back(_varRefMsgTmp);
  }
  _whichAstSelChildren = 0;
}

// If AstVarRef is a child of AstSel, it references some part of a var.
// For example, C[2:1];
// Otherwise, it references the whole part of a var.
// For example, C[n-1:0] or ci;
void HierCellsNetListsVisitor::visit(AstVarRef *nodep)
{
  _varRefMsgTmp.varRefName = nodep->name();
  if(_whichAstSelChildren)
  { // Now, AstVarRef is a child of AstSel
    _whichAstSelChildren++;
    if(_isAssignStatement && (nodep->access() == VAccess::WRITE))
    {
      _isAssignStatementLvalue = true;
    }
  }
  else
  {
    _varRefMsgTmp.hasValueX = false;
    _varRefMsgTmp.varRefRange.end = nodep->dtypep()->basicp()->nrange().left();
    _varRefMsgTmp.varRefRange.start =
      nodep->dtypep()->basicp()->nrange().right();
    _varRefMsgTmp.width =
      _varRefMsgTmp.varRefRange.end - _varRefMsgTmp.varRefRange.start + 1;
    if(_varRefMsgTmp.width > 1)
      _varRefMsgTmp.isArray = true;
    else
      _varRefMsgTmp.isArray = false;
    if(_isAssignStatement)
    { // Now, AstVarRef is a child of AstAssign or a descendant of AstAssignW
      if(nodep->access() == VAccess::WRITE)
      { // Now, AstVarRef is a child of AstAssign
        _assignStatementMsgTmp.lValue = _varRefMsgTmp;
      }
      else
      { // Now, AstVarRef is a child of AstAssign or AstExtend or AstConcat or
        // AstReplicate
        _assignStatementMsgTmp.rValue.push_back(_varRefMsgTmp);
      }
    }
    else
    {
      // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat or
      // AstReplicate
      _portInstanceMsgTmp.varRefMsgs.push_back(_varRefMsgTmp);
    }
  }
}

void HierCellsNetListsVisitor::visit(AstExtend *nodep)
{
  uint32_t extendWidth = nodep->width() - nodep->lhsp()->width();
  _varRefMsgTmp.varRefName = "";
  _varRefMsgTmp.constValueAndValueX.value = 0;
  _varRefMsgTmp.constValueAndValueX.valueX = 0;
  if(extendWidth > 1)
    _varRefMsgTmp.isArray = true;
  else
    _varRefMsgTmp.isArray = false;
  _varRefMsgTmp.hasValueX = false;
  _varRefMsgTmp.width = std::move(extendWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstAssign or AstAssignW or AstConcat
    _assignStatementMsgTmp.rValue.push_back(_varRefMsgTmp);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _portInstanceMsgTmp.varRefMsgs.push_back(_varRefMsgTmp);
  }
  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstExtendS *nodep)
{
  uint32_t extendSWidth = nodep->width() - nodep->lhsp()->width();
  _varRefMsgTmp.varRefName = "";
  _varRefMsgTmp.constValueAndValueX.value = (1 << extendSWidth) - 1;
  _varRefMsgTmp.constValueAndValueX.valueX = 0;
  if(extendSWidth > 1)
    _varRefMsgTmp.isArray = true;
  else
    _varRefMsgTmp.isArray = false;
  _varRefMsgTmp.hasValueX = false;
  _varRefMsgTmp.width = std::move(extendSWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstAssign or AstAssignW or AstConcat
    _assignStatementMsgTmp.rValue.push_back(_varRefMsgTmp);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _portInstanceMsgTmp.varRefMsgs.push_back(_varRefMsgTmp);
  }
  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstReplicate *nodep)
{
  iterateChildren(nodep);
  if(_isAssignStatement)
  { // Now, AstReplicate is a child of AstAssignW or AstExtend or AstConcat
    uint32_t replicateTimes =
      _assignStatementMsgTmp.rValue.back().constValueAndValueX.value;
    _assignStatementMsgTmp.rValue.pop_back();
    while(replicateTimes != 1)
    {
      _assignStatementMsgTmp.rValue.push_back(
        _assignStatementMsgTmp.rValue.back());
      replicateTimes--;
    }
  }
  else
  { // Now, AstReplicate is a child of AstPin or AstExtend or AstConcat
    uint32_t replicateTimes =
      _portInstanceMsgTmp.varRefMsgs.back().constValueAndValueX.value;
    _portInstanceMsgTmp.varRefMsgs.pop_back();
    while(replicateTimes != 1)
    {
      _portInstanceMsgTmp.varRefMsgs.push_back(
        _portInstanceMsgTmp.varRefMsgs.back());
      replicateTimes--;
    }
  }
}

void HierCellsNetListsVisitor::visit(AstConst *nodep)
{
  if(_whichAstSelChildren == 2)
  { // Now, AstConst is a child of AstSel
    _whichAstSelChildren++;
    _varRefMsgTmp.varRefRange.start = nodep->num().getValue();
  }
  else if(_whichAstSelChildren == 3)
  { // Now, AstConst is a child of AstSel
    _varRefMsgTmp.width = nodep->num().getValue();
    _varRefMsgTmp.varRefRange.end =
      _varRefMsgTmp.varRefRange.start + _varRefMsgTmp.width - 1;
    _varRefMsgTmp.isArray = true;
    _varRefMsgTmp.hasValueX = false;
  }
  else
  { // Now, AstConst is a rValue of assign statement or refValue of a port or
    // the number of AstReplicate.
    _varRefMsgTmp.varRefName = "";
    _varRefMsgTmp.constValueAndValueX.value = nodep->num().getValue();
    _varRefMsgTmp.width = nodep->width();
    if(_varRefMsgTmp.width > 1)
      _varRefMsgTmp.isArray = true;
    else
      _varRefMsgTmp.isArray = false;
    if(nodep->num().isAnyXZ())
    { // Now, the const value has value x or z.
      _varRefMsgTmp.constValueAndValueX.valueX = nodep->num().getValueX();
      _varRefMsgTmp.hasValueX = true;
    }
    else
    {
      _varRefMsgTmp.constValueAndValueX.valueX = 0;
      _varRefMsgTmp.hasValueX = false;
    }
    if(_isAssignStatement)
    { // Now, AstConst is a child of AstAssign or AstAssignW or AstConcat or
      // AstReplicate
      _assignStatementMsgTmp.rValue.push_back(_varRefMsgTmp);
    }
    else
    { // Now, AstConst is a child of AstPin or AstConcat or AstReplicate
      _portInstanceMsgTmp.varRefMsgs.push_back(_varRefMsgTmp);
    }
  }
}

std::unordered_map<std::string, ModuleMsg>
HierCellsNetListsVisitor::GetHierCellsNetLists()
{
  return _modsNameMapTheirMsg;
}

void V3EmitHierNetLists::emitHierNetLists(
  std::unordered_map<std::string, ModuleMsg> &hierCellsNetLists)
{
  // v3Global will return a AstNetlist*
  HierCellsNetListsVisitor hierCellsNetListsVisitor(v3Global.rootp());
  hierCellsNetLists = hierCellsNetListsVisitor.GetHierCellsNetLists();
}

void V3EmitHierNetLists::MultipleBitsToOneBit(
  std::unordered_map<std::string, MultipleBitsNetlist::ModuleMsg>
    &multipleBitsHierCellsNetLists,
  std::unordered_map<std::string, OneBitNetlist::ModuleMsg>
    &oneBitHierCellsNetLists)
{
  std::string curModuleName;

  OneBitNetlist::AssignStatementMsg oneBitAssignStatementMsg;
  int lEnd, rEnd;
  uint32_t rWidth;
  uint32_t hotCode = 1 << 31;

  std::string curSubmoduleInstanceName;
  OneBitNetlist::PortInstanceMsg oPortInstanceMsg;
  OneBitNetlist::VarRefMsg oVarRefMsg;
  std::vector<OneBitNetlist::PortInstanceMsg> oPortInstanceMsgs;

  for(auto &mBHCN: multipleBitsHierCellsNetLists)
  {
    curModuleName = mBHCN.first;
    oneBitHierCellsNetLists[curModuleName].moduleDefName =
      mBHCN.second.moduleDefName;
    oneBitHierCellsNetLists[curModuleName].level = mBHCN.second.level;
    oneBitHierCellsNetLists[curModuleName].inputs = mBHCN.second.inputs;
    oneBitHierCellsNetLists[curModuleName].outputs = mBHCN.second.outputs;
    oneBitHierCellsNetLists[curModuleName].inouts = mBHCN.second.inouts;
    oneBitHierCellsNetLists[curModuleName].wires = mBHCN.second.wires;
    oneBitHierCellsNetLists[curModuleName].subModuleInstanceNames =
      mBHCN.second.subModuleInstanceNames;
    oneBitHierCellsNetLists[curModuleName].subModInsNameMapSubModDefName =
      mBHCN.second.subModInsNameMapSubModDefName;

    for(auto &assigns: mBHCN.second.assigns)
    { // One AstAssignW/AstAssign Node
      auto &lValue = assigns.lValue;
      lEnd = lValue.varRefRange.end;
      for(auto &rValue: assigns.rValue)
      {
        oneBitAssignStatementMsg.lValue.varRefName = lValue.varRefName;
        oneBitAssignStatementMsg.lValue.isArray = lValue.isArray;
        oneBitAssignStatementMsg.rValue.varRefName = rValue.varRefName;
        if(rValue.varRefName == "")
        {
          rWidth = rValue.width;
          oneBitAssignStatementMsg.rValue.varRefName = "anonymous";
          oneBitAssignStatementMsg.rValue.isArray = false;
          while(rWidth >= 1)
          {
            oneBitAssignStatementMsg.rValue.initialVal =
              ((rValue.constValueAndValueX.value &
                (hotCode >> (32 - rWidth))) > 0)
                ? 1
                : 0;
            oneBitAssignStatementMsg.lValue.index = lEnd;
            oneBitHierCellsNetLists[curModuleName].assigns.push_back(
              oneBitAssignStatementMsg);
            rWidth--;
            lEnd--;
          }
        }
        else
        {
          rEnd = rValue.varRefRange.end;
          oneBitAssignStatementMsg.rValue.varRefName = rValue.varRefName;
          oneBitAssignStatementMsg.rValue.isArray = rValue.isArray;
          while(rEnd >= int(rValue.varRefRange.start))
          {
            oneBitAssignStatementMsg.rValue.index = rEnd;
            oneBitAssignStatementMsg.lValue.index = lEnd;
            oneBitHierCellsNetLists[curModuleName].assigns.push_back(
              oneBitAssignStatementMsg);
            rEnd--;
            lEnd--;
          }
        }
      }
    }
    for(auto &sMINMPIM: mBHCN.second.subModInsNameMapPortInsMsgs)
    { // One AstCell
      curSubmoduleInstanceName = sMINMPIM.first;
      oPortInstanceMsgs.clear();
      for(auto &mPortInstanceMsg: sMINMPIM.second)
      { // One AstPin
        oPortInstanceMsg.portDefName = mPortInstanceMsg.portDefName;
        oPortInstanceMsg.varRefMsgs.clear();
        for(auto &mVarRefMsg: mPortInstanceMsg.varRefMsgs)
        {
          if(mVarRefMsg.varRefName == "")
          {
            rWidth = mVarRefMsg.width;
            oVarRefMsg.varRefName = "anonymous";
            oVarRefMsg.isArray = false;
            while(rWidth >= 1)
            {
              oVarRefMsg.initialVal = ((mVarRefMsg.constValueAndValueX.value &
                                        (hotCode >> (32 - rWidth))) > 0)
                                        ? 1
                                        : 0;
              oPortInstanceMsg.varRefMsgs.push_back(oVarRefMsg);
              rWidth--;
            }
          }
          else
          {
            rEnd = mVarRefMsg.varRefRange.end;
            oVarRefMsg.varRefName = mVarRefMsg.varRefName;
            oVarRefMsg.isArray = mVarRefMsg.isArray;
            while(rEnd >= int(mVarRefMsg.varRefRange.start))
            {
              oVarRefMsg.index = rEnd;
              oPortInstanceMsg.varRefMsgs.push_back(oVarRefMsg);
              rEnd--;
            }
          }
        }
        oPortInstanceMsgs.push_back(oPortInstanceMsg);
      }
      oneBitHierCellsNetLists[curModuleName]
        .subModInsNameMapPortInsMsgs[curSubmoduleInstanceName] =
        oPortInstanceMsgs;
    }
  }
}
}
