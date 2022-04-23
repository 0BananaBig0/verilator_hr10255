/*************************************************************************
  > File Name: src/V3EmitHierNetlistsNew.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Mon 11 Apr 2022 08:18:10 PM CST
 ************************************************************************/
#include "V3EmitNetlistsNew.h"
#include "V3Number.h"

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
    MultipleBitsAssignStatement _multipleBitsAssignStatementTmp;

    // Themporary instance message of current visited port
    MultipleBitsPortAssignment _multipleBitsPortAssignmentsTmp;
    // Port Instance message of current visited submodule instance
    std::vector<MultipleBitsPortAssignment>
      _curSubModInsMultipleBitsPortAssignmentsTmp;

    // AstSel Status:1 = m_op1p, 2 = m_op2p, 3 = m_op3p, 4 = m_op4p
    uint32_t _whichAstSelChildren = 0;
    MultipleBitsVarRef _multipleBitsVarRef;

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
    // Prevent idling iteration
    virtual void visit(AstTypeTable *nodep) override { return; }

  public:
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
  _multipleBitsAssignStatementTmp.rValue.clear();
  iterateChildren(nodep);
  _modsNameMapTheirMsg[_curModuleName].assigns.push_back(
    _multipleBitsAssignStatementTmp);
  _isAssignStatement = false;
}

void HierCellsNetListsVisitor::visit(AstAssign *nodep)
{
  _isAssignStatement = true;
  _multipleBitsAssignStatementTmp.rValue.clear();
  iterateChildren(nodep);
  _modsNameMapTheirMsg[_curModuleName].assigns.push_back(
    _multipleBitsAssignStatementTmp);
  _isAssignStatement = false;
}

void HierCellsNetListsVisitor::visit(AstCell *nodep)
{
  _curSubmoduleName = nodep->modp()->prettyName();
  _curSubmoduleInstanceName = nodep->prettyName();
  _curSubModInsMultipleBitsPortAssignmentsTmp.clear();
  iterateChildren(nodep);
  _modsNameMapTheirMsg[_curModuleName]
    .subModInsNameMapPortInsMsgs[_curSubmoduleInstanceName] =
    _curSubModInsMultipleBitsPortAssignmentsTmp;
  _modsNameMapTheirMsg[_curModuleName]
    .subModInsNameMapSubModDefName[_curSubmoduleInstanceName] =
    _curSubmoduleName;
  _modsNameMapTheirMsg[_curModuleName].subModuleInstanceNames.push_back(
    _curSubmoduleInstanceName);
}

void HierCellsNetListsVisitor::visit(AstPin *nodep)
{
  _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.clear();
  _multipleBitsPortAssignmentsTmp.portDefName = nodep->modVarp()->name();
  iterateChildren(nodep);
  _curSubModInsMultipleBitsPortAssignmentsTmp.push_back(
    _multipleBitsPortAssignmentsTmp);
}

void HierCellsNetListsVisitor::visit(AstSel *nodep)
{
  _whichAstSelChildren = 1;
  iterateChildren(nodep);
  if(_isAssignStatement)
  { // Now, AstSel is a child or a descendant of AstAssignW
    if(_isAssignStatementLvalue)
    { // Now, AstSel is a child of AstAssignW
      _multipleBitsAssignStatementTmp.lValue = _multipleBitsVarRef;
      _isAssignStatementLvalue = false;
    }
    else
    { // Now, AstSel is a child of AstAssign or AstExtend or AstConcat
      _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRef);
    }
  }
  else
  {
    // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat
    _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.push_back(
      _multipleBitsVarRef);
  }
  _whichAstSelChildren = 0;
}

// If AstVarRef is a child of AstSel, it references some part of a var.
// Sometimes, whole part.
// For example, C[2:1];
// Otherwise, it references the whole part of a var.
// For example, C[n-1:0] or ci;
void HierCellsNetListsVisitor::visit(AstVarRef *nodep)
{
  _multipleBitsVarRef.varRefName = nodep->prettyName();
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
    _multipleBitsVarRef.hasValueX = false;
    // Make sure all var like A[1:3] or A[3:1] become A[2:0]
    if(nodep->dtypep()->basicp()->nrange().left() >
       nodep->dtypep()->basicp()->nrange().right())
    {
      _multipleBitsVarRef.varRefRange.end =
        nodep->dtypep()->basicp()->nrange().left();
      _multipleBitsVarRef.varRefRange.start =
        nodep->dtypep()->basicp()->nrange().right();
    }
    else
    {
      _multipleBitsVarRef.varRefRange.end =
        nodep->dtypep()->basicp()->nrange().right();
      _multipleBitsVarRef.varRefRange.start =
        nodep->dtypep()->basicp()->nrange().left();
    }
    if(_multipleBitsVarRef.varRefRange.start > 0)
    {
      _multipleBitsVarRef.varRefRange.end =
        _multipleBitsVarRef.varRefRange.end -
        _multipleBitsVarRef.varRefRange.start;
      _multipleBitsVarRef.varRefRange.start = 0;
    }
    _multipleBitsVarRef.width = _multipleBitsVarRef.varRefRange.end -
                                _multipleBitsVarRef.varRefRange.start + 1;
    if(_multipleBitsVarRef.width > 1)
      _multipleBitsVarRef.isVector = true;
    else
      _multipleBitsVarRef.isVector = false;
    if(_isAssignStatement)
    { // Now, AstVarRef is a child of AstAssign or a descendant of AstAssignW
      if(nodep->access() == VAccess::WRITE)
      { // Now, AstVarRef is a child of AstAssign
        _multipleBitsAssignStatementTmp.lValue = _multipleBitsVarRef;
      }
      else
      { // Now, AstVarRef is a child of AstAssign or AstExtend or AstConcat or
        // AstReplicate
        _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRef);
      }
    }
    else
    {
      // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat or
      // AstReplicate
      _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.push_back(
        _multipleBitsVarRef);
    }
  }
}

void HierCellsNetListsVisitor::visit(AstExtend *nodep)
{
  uint32_t extendWidth = nodep->width() - nodep->lhsp()->width();
  _multipleBitsVarRef.varRefName = "";
  _multipleBitsVarRef.constValueAndValueX.value = 0;
  _multipleBitsVarRef.constValueAndValueX.valueX = 0;
  if(extendWidth > 1)
    _multipleBitsVarRef.isVector = true;
  else
    _multipleBitsVarRef.isVector = false;
  _multipleBitsVarRef.hasValueX = false;
  _multipleBitsVarRef.width = std::move(extendWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstAssign or AstAssignW or AstConcat
    _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRef);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.push_back(
      _multipleBitsVarRef);
  }
  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstExtendS *nodep)
{
  uint32_t extendSWidth = nodep->width() - nodep->lhsp()->width();
  _multipleBitsVarRef.varRefName = "";
  _multipleBitsVarRef.constValueAndValueX.value = (1 << extendSWidth) - 1;
  _multipleBitsVarRef.constValueAndValueX.valueX = 0;
  if(extendSWidth > 1)
    _multipleBitsVarRef.isVector = true;
  else
    _multipleBitsVarRef.isVector = false;
  _multipleBitsVarRef.hasValueX = false;
  _multipleBitsVarRef.width = std::move(extendSWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstAssign or AstAssignW or AstConcat
    _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRef);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.push_back(
      _multipleBitsVarRef);
  }
  iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstReplicate *nodep)
{
  iterateChildren(nodep);
  if(_isAssignStatement)
  { // Now, AstReplicate is a child of AstAssignW or AstExtend or AstConcat
    uint32_t replicateTimes =
      _multipleBitsAssignStatementTmp.rValue.back().constValueAndValueX.value;
    _multipleBitsAssignStatementTmp.rValue.pop_back();
    while(replicateTimes != 1)
    {
      _multipleBitsAssignStatementTmp.rValue.push_back(
        _multipleBitsAssignStatementTmp.rValue.back());
      replicateTimes--;
    }
  }
  else
  { // Now, AstReplicate is a child of AstPin or AstExtend or AstConcat
    uint32_t replicateTimes =
      _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.back()
        .constValueAndValueX.value;
    _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.pop_back();
    while(replicateTimes != 1)
    {
      _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.push_back(
        _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.back());
      replicateTimes--;
    }
  }
}

void HierCellsNetListsVisitor::visit(AstConst *nodep)
{
  if(_whichAstSelChildren == 2)
  { // Now, AstConst is a child of AstSel
    _whichAstSelChildren++;
    _multipleBitsVarRef.varRefRange.start = nodep->num().value().getValue32();
  }
  else if(_whichAstSelChildren == 3)
  { // Now, AstConst is a child of AstSel
    _multipleBitsVarRef.width = nodep->num().value().getValue32();
    _multipleBitsVarRef.varRefRange.end =
      _multipleBitsVarRef.varRefRange.start + _multipleBitsVarRef.width - 1;
    _multipleBitsVarRef.isVector = true;
    _multipleBitsVarRef.hasValueX = false;
  }
  else
  { // Now, AstConst is a rValue of assign statement or refValue of a port or
    // the number of AstReplicate.
    _multipleBitsVarRef.varRefName = "";
    _multipleBitsVarRef.constValueAndValueX.value =
      nodep->num().value().getValue32();
    _multipleBitsVarRef.width = nodep->width();
    if(_multipleBitsVarRef.width > 1)
      _multipleBitsVarRef.isVector = true;
    else
      _multipleBitsVarRef.isVector = false;
    if(nodep->num().isAnyXZ())
    { // Now, the const value has value x or z.
      _multipleBitsVarRef.constValueAndValueX.valueX =
        nodep->num().value().getValueX32();
      _multipleBitsVarRef.hasValueX = true;
    }
    else
    {
      _multipleBitsVarRef.constValueAndValueX.valueX = 0;
      _multipleBitsVarRef.hasValueX = false;
    }
    if(_multipleBitsVarRef.width > 32)
      _multipleBitsVarRef.BiggerValue.push_back(
        nodep->num().value().getValueAndX64());
    if(_multipleBitsVarRef.width > 64)
    {
      const std::vector<V3NumberData::ValueAndX> valueAndX128Tmp =
        nodep->num().value().getValueAndX128();
      _multipleBitsVarRef.BiggerValue.insert(
        _multipleBitsVarRef.BiggerValue.end(), valueAndX128Tmp.begin(),
        valueAndX128Tmp.end());
    }
    if(_isAssignStatement)
    { // Now, AstConst is a child of AstAssign or AstAssignW or AstConcat or
      // AstReplicate
      _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRef);
      if(_multipleBitsVarRef.width > 32)
        _multipleBitsVarRef.BiggerValue.clear();
    }
    else
    { // Now, AstConst is a child of AstPin or AstConcat or AstReplicate
      _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.push_back(
        _multipleBitsVarRef);
      if(_multipleBitsVarRef.width > 32)
        _multipleBitsVarRef.BiggerValue.clear();
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

void V3EmitHierNetLists::multipleBitsToOneBit(
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
        oneBitAssignStatementMsg.lValue.isArray = lValue.isVector;
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
          oneBitAssignStatementMsg.rValue.isArray = rValue.isVector;
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
        for(auto &mVarRefMsg: mPortInstanceMsg.multipleBitsVarRefs)
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
            oVarRefMsg.isArray = mVarRefMsg.isVector;
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
