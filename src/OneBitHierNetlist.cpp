/*************************************************************************
  > File Name: src/V3EmitHierNetlistsNew.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Mon 11 Apr 2022 08:18:10 PM CST
 ************************************************************************/
#include "MultipleBitsNetlist.h"
#include "Netlist.h"
#include "OneBitNetlist.h"

#include <cstdint>
#include <cstdlib>
#include <exception>
#include <fstream>
#include <iostream>
#include <string>
#include <unordered_map>

#include "V3Ast.h"
#include "V3Error.h"

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
struct PortNameMapIndex
{
    std::unordered_map<std::string, uint32_t> ports;
};
class HierNetlistVisitor final : public AstNVisitor
{
  public:
    // AstNetlist
    std::vector<Module> _hierNetlist;

  private:
    // A module = ItsName + Port  + Wire + Assign staement + Submodule Instance
    // AstModule
    bool _isOnlyGetModuleNameAndVarName;
    uint32_t _theNumberOfSubModuleInstance;
    std::vector<uint32_t> _theNumberOfSubModuleInstances;
    std::unordered_map<std::string, uint32_t> _moduleNameMapIndex;
    std::string _curModuleName;
    uint32_t _curModuleIndex = 0;

    // AstVar
    std::vector<PortNameMapIndex> _portNameMapIndexs;
    PortNameMapIndex _portNameMapIndex;
    uint32_t _curPortIndex;

    // AstCell
    std::string _curSubmoduleName;
    std::string _curSubmoduleInstanceName;
    uint32_t _curSubmoduleInstanceIndex;

    // AstAssignW/AstAssign Status
    bool _isAssignStatement = false;
    bool _isAssignStatementLvalue = false;
    uint32_t _curAssignIndex;
    // Themporary message of current visited assign statement
    MultipleBitsAssignStatement _multipleBitsAssignStatementTmp;

    // AstPin
    MultipleBitsPortAssignment _multipleBitsPortAssignmentTmp;
    std::vector<PortAssignment> _curSubModInsPortAssignmentsTmp;

    // AstSel Status:1 = m_op1p, 2 = m_op2p, 3 = m_op3p,
    uint32_t _whichAstSelChildren = 0;

    // AstVarRef
    MultipleBitsVarRef _multipleBitsVarRefTmp;

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

    // m_opxp means parent node owns its children.
    // m_nextp means parent node and its children is parallel in verilog source
    // code.
    // For example, if A -> B by m_opxp, A owns B and B's descendants,like
    // AstAssign can own AstVarRef.
    // If A -> B by m_nextp, A and B are parallel, like AstAssign and AstAssign
    // or AstCell.
    virtual void visit(AstNode *nodep) override { iterateChildren(nodep); };

    virtual void visit(AstNetlist *nodep) override;
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
    const std::vector<Module> &GetHierNetList() const { return _hierNetlist; };

  public:
    // AstNetlist is the root of HierNetList
    HierNetlistVisitor(AstNetlist *nodep) { nodep->accept(*this); }
    virtual ~HierNetlistVisitor() override{};
};

void HierNetlistVisitor::visit(AstNetlist *nodep)
{
  _isOnlyGetModuleNameAndVarName = true;
  iterateChildren(nodep);
  _curModuleIndex = 0;
  _isOnlyGetModuleNameAndVarName = false;
  iterateChildren(nodep);
  EmitHierNetList::printHierNetlist(_hierNetlist);
  _portNameMapIndexs.clear();
  // _theNumberOfAssignStateOfModules.clear();
  // _moduleNameMapIndex.clear();
  // _curModuleName = "";
  // _curSubmoduleName = "";
  // _curSubmoduleInstanceName = "";
  // _multipleBitsPortAssignmentsTmp.portDefName = "";
  // _multipleBitsPortAssignmentsTmp.multipleBitsVarRefs.clear();
  // _curSubModInsPortAssignmentsTmp.clear();
  // _multipleBitsVarRefTmp.biggerValue.clear();
};

// Get module name and hierLevel.
// Create LUT.
void HierNetlistVisitor::visit(AstModule *nodep)
{
  if(nodep->prettyName() == "@CONST-POOL@")
    return;
  else if(_isOnlyGetModuleNameAndVarName)
  {
    // The first time visit AST, we only visit AstModule and AstVar and cout
    // the number of AstCell of Every AstModule.
    Module curModule;
    _curModuleName = nodep->prettyName();
    // Create a LUT.
    _moduleNameMapIndex[_curModuleName] = _curModuleIndex;
    // Store name and level for current module.
    curModule.moduleDefName = _curModuleName;
    curModule.level = nodep->level();
    // Push current module to hierarchical netlist.
    _hierNetlist.push_back(std::move(curModule));
    // Initial value for all ports of every module.
    _curPortIndex = 0;
    _portNameMapIndex.ports.clear();
    // Initial value
    _theNumberOfSubModuleInstance = 0;
    // Ready to start visiting AstVar and counting the number
    // of SubModuleInstance.
    AstNode *varpTmp = nodep->op2p();
    while(varpTmp)
    {
      if(varpTmp->type() == AstType::atVar)
        varpTmp->accept(*this);
      else if(varpTmp->type() == AstType::atCell)
        _theNumberOfSubModuleInstance++;
      varpTmp = varpTmp->nextp();
    }
    // Store LUT, the number of SubModuleInstance.
    _portNameMapIndexs.push_back(_portNameMapIndex);
    _theNumberOfSubModuleInstances.push_back(_theNumberOfSubModuleInstance);
    // Prepare for the next visit to AstModule.
    _curModuleIndex++;
    delete varpTmp;
    return;
  }
  // The second time visit AST, we visit all AstNode, except AstVar.
  else
  {
    _curSubmoduleInstanceIndex = 0;
    _curAssignIndex = _theNumberOfSubModuleInstances[_curModuleIndex];
    AstNode *nodepTmp = nodep->op2p();
    while(nodepTmp)
    {
      if(nodepTmp->type() != AstType::atVar)
        nodepTmp->accept(*this);
      nodepTmp = nodepTmp->nextp();
    }
    // Prepare for the next visit to AstModule.
    _curModuleIndex++;
  }
}

void HierNetlistVisitor::visit(AstVar *nodep)
{
  PortDefinition portDefinition;
  if(nodep->isGParam())
  {
    return;
  }
  portDefinition.portDefName = nodep->prettyName();
  if(nodep->basicp() && nodep->basicp()->width() != 1)
  {
    portDefinition.isVector = true;
    portDefinition.bitWidth = nodep->basicp()->width();
  }
  if(nodep->isIO())
  {
    switch(nodep->direction())
    {
    case VDirection::INPUT:
      {
        portDefinition.portType = PortType::INPUT;
        break;
      }
    case VDirection::OUTPUT:
      {
        portDefinition.portType = PortType::OUTPUT;
        portDefinition.whichInstanceOutput.resize(portDefinition.bitWidth,
                                                  MAX32);
        break;
      }
    case VDirection::INOUT:
      {
        portDefinition.portType = PortType::INOUT;
        portDefinition.whichInstanceOutput.resize(portDefinition.bitWidth,
                                                  MAX32);
        break;
      }
    default:
      break;
    }
  }
  else
  {
    portDefinition.portType = PortType::WIRE;
    portDefinition.whichInstanceOutput.resize(portDefinition.bitWidth, MAX32);
  }
  // Create LUT
  _portNameMapIndex.ports[portDefinition.portDefName] = _curPortIndex;
  _curPortIndex++;
  // Store input definition
  _hierNetlist[_curModuleIndex].ports.push_back(std::move(portDefinition));
}

void HierNetlistVisitor::visit(AstAssignW *nodep)
{
  _isAssignStatement = true;
  _multipleBitsAssignStatementTmp.rValue.clear();
  iterateChildren(nodep);
  BitSlicedAssignStatement bitSlicedAssignStatementTmp;
  int lEnd = _multipleBitsAssignStatementTmp.lValue.varRefRange.end;
  bitSlicedAssignStatementTmp.lValue.varRefIndex =
    _portNameMapIndexs[_curModuleIndex]
      .ports[_multipleBitsAssignStatementTmp.lValue.varRefName];
  bitSlicedAssignStatementTmp.lValue.isVector =
    _multipleBitsAssignStatementTmp.lValue.isVector;
  _curPortIndex = bitSlicedAssignStatementTmp.lValue.varRefIndex;
  for(auto &rValue: _multipleBitsAssignStatementTmp.rValue)
  {
    if(rValue.varRefName == "")
    {
      uint32_t hotCode = 1 << 31;
      auto rWidth = rValue.width;
      uint32_t rWidthTmp = rWidth;
      bitSlicedAssignStatementTmp.rValue.varRefIndex = MAX32;
      bitSlicedAssignStatementTmp.rValue.isVector = false;
      if(rWidth > 32)
      {
        rWidthTmp = 32;
        rWidth = rWidth - 32;
      }
      else
      {
        rWidthTmp = rWidth;
        rWidth = rWidth - 32;
      }
      while(rWidthTmp >= 1)
      {
        bool bValue = ((rValue.constValueAndValueX.value &
                        (hotCode >> (32 - rWidthTmp))) > 0);
        if(rValue.hasValueX)
        {
          bool bValueX = ((rValue.constValueAndValueX.valueX &
                           (hotCode >> (32 - rWidthTmp))) > 0);
          if(bValue & bValueX)
            bitSlicedAssignStatementTmp.rValue.valueAndValueX = X;
          else if((!bValue) & (!bValue))
            bitSlicedAssignStatementTmp.rValue.valueAndValueX = ZERO;
          else if(bValue)
            bitSlicedAssignStatementTmp.rValue.valueAndValueX = ONE;
          else
            bitSlicedAssignStatementTmp.rValue.valueAndValueX = Z;
        }
        else
        {
          bitSlicedAssignStatementTmp.rValue.valueAndValueX =
            bValue ? ONE : ZERO;
        }
        bitSlicedAssignStatementTmp.lValue.index = lEnd;
        _hierNetlist[_curModuleIndex].assigns.push_back(
          bitSlicedAssignStatementTmp);
        rWidthTmp--;
        _hierNetlist[_curModuleIndex]
          .ports[_curPortIndex]
          .whichInstanceOutput[lEnd] = _curAssignIndex;
        _curAssignIndex++;
        lEnd--;
      }
      for(auto &biggerValue: rValue.biggerValue)
      {
        if(rWidth > 32)
        {
          rWidthTmp = 32;
          rWidth = rWidth - 32;
        }
        else
        {
          rWidthTmp = rWidth;
          rWidth = rWidth - 32;
        }
        while(rWidthTmp >= 1)
        {
          bool bValue =
            ((biggerValue.m_value & (hotCode >> (32 - rWidthTmp))) > 0);
          if(rValue.hasValueX)
          {
            bool bValueX =
              ((biggerValue.m_valueX & (hotCode >> (32 - rWidthTmp))) > 0);
            if(bValue & bValueX)
              bitSlicedAssignStatementTmp.rValue.valueAndValueX = X;
            else if((!bValue) & (!bValue))
              bitSlicedAssignStatementTmp.rValue.valueAndValueX = ZERO;
            else if(bValue)
              bitSlicedAssignStatementTmp.rValue.valueAndValueX = ONE;
            else
              bitSlicedAssignStatementTmp.rValue.valueAndValueX = Z;
          }
          else
          {
            bitSlicedAssignStatementTmp.rValue.valueAndValueX =
              bValue ? ONE : ZERO;
          }
          bitSlicedAssignStatementTmp.lValue.index = lEnd;
          _hierNetlist[_curModuleIndex].assigns.push_back(
            bitSlicedAssignStatementTmp);
          rWidthTmp--;
          _hierNetlist[_curModuleIndex]
            .ports[_curPortIndex]
            .whichInstanceOutput[lEnd] = _curAssignIndex;
          _curAssignIndex++;
          lEnd--;
        }
      }
    }
    else
    {
      {
        int rEnd = rValue.varRefRange.end;
        bitSlicedAssignStatementTmp.rValue.varRefIndex =
          _portNameMapIndexs[_curModuleIndex].ports[rValue.varRefName];
        bitSlicedAssignStatementTmp.rValue.isVector = rValue.isVector;
        while(rEnd >= int(rValue.varRefRange.start))
        {
          bitSlicedAssignStatementTmp.rValue.index = rEnd;
          bitSlicedAssignStatementTmp.lValue.index = lEnd;
          _hierNetlist[_curModuleIndex].assigns.push_back(
            bitSlicedAssignStatementTmp);
          rEnd--;
          _hierNetlist[_curModuleIndex]
            .ports[_curPortIndex]
            .whichInstanceOutput[lEnd] = _curAssignIndex;
          _curAssignIndex++;
          lEnd--;
        }
      }
    }
    _isAssignStatement = false;
  }
}

void HierNetlistVisitor::visit(AstAssign *nodep)
{
  _isAssignStatement = true;
  _multipleBitsAssignStatementTmp.rValue.clear();
  iterateChildren(nodep);
  BitSlicedAssignStatement bitSlicedAssignStatementTmp;
  int lEnd = _multipleBitsAssignStatementTmp.lValue.varRefRange.end;
  bitSlicedAssignStatementTmp.lValue.varRefIndex =
    _portNameMapIndexs[_curModuleIndex]
      .ports[_multipleBitsAssignStatementTmp.lValue.varRefName];
  bitSlicedAssignStatementTmp.lValue.isVector =
    _multipleBitsAssignStatementTmp.lValue.isVector;
  _curPortIndex = bitSlicedAssignStatementTmp.lValue.varRefIndex;
  for(auto &rValue: _multipleBitsAssignStatementTmp.rValue)
  {
    if(rValue.varRefName == "")
    {
      uint32_t hotCode = 1 << 31;
      auto rWidth = rValue.width;
      uint32_t rWidthTmp = rWidth;
      bitSlicedAssignStatementTmp.rValue.varRefIndex = MAX32;
      bitSlicedAssignStatementTmp.rValue.isVector = false;
      if(rWidth > 32)
      {
        rWidthTmp = 32;
        rWidth = rWidth - 32;
      }
      else
      {
        rWidthTmp = rWidth;
        rWidth = rWidth - 32;
      }
      while(rWidthTmp >= 1)
      {
        bool bValue = ((rValue.constValueAndValueX.value &
                        (hotCode >> (32 - rWidthTmp))) > 0);
        if(rValue.hasValueX)
        {
          bool bValueX = ((rValue.constValueAndValueX.valueX &
                           (hotCode >> (32 - rWidthTmp))) > 0);
          if(bValue & bValueX)
            bitSlicedAssignStatementTmp.rValue.valueAndValueX = X;
          else if((!bValue) & (!bValue))
            bitSlicedAssignStatementTmp.rValue.valueAndValueX = ZERO;
          else if(bValue)
            bitSlicedAssignStatementTmp.rValue.valueAndValueX = ONE;
          else
            bitSlicedAssignStatementTmp.rValue.valueAndValueX = Z;
        }
        else
        {
          bitSlicedAssignStatementTmp.rValue.valueAndValueX =
            bValue ? ONE : ZERO;
        }
        bitSlicedAssignStatementTmp.lValue.index = lEnd;
        _hierNetlist[_curModuleIndex].assigns.push_back(
          bitSlicedAssignStatementTmp);
        rWidthTmp--;
        _hierNetlist[_curModuleIndex]
          .ports[_curPortIndex]
          .whichInstanceOutput[lEnd] = _curAssignIndex;
        _curAssignIndex++;
        lEnd--;
      }
      for(auto &biggerValue: rValue.biggerValue)
      {
        if(rWidth > 32)
        {
          rWidthTmp = 32;
          rWidth = rWidth - 32;
        }
        else
        {
          rWidthTmp = rWidth;
          rWidth = rWidth - 32;
        }
        while(rWidthTmp >= 1)
        {
          bool bValue =
            ((biggerValue.m_value & (hotCode >> (32 - rWidthTmp))) > 0);
          if(rValue.hasValueX)
          {
            bool bValueX =
              ((biggerValue.m_valueX & (hotCode >> (32 - rWidthTmp))) > 0);
            if(bValue & bValueX)
              bitSlicedAssignStatementTmp.rValue.valueAndValueX = X;
            else if((!bValue) & (!bValue))
              bitSlicedAssignStatementTmp.rValue.valueAndValueX = ZERO;
            else if(bValue)
              bitSlicedAssignStatementTmp.rValue.valueAndValueX = ONE;
            else
              bitSlicedAssignStatementTmp.rValue.valueAndValueX = Z;
          }
          else
          {
            bitSlicedAssignStatementTmp.rValue.valueAndValueX =
              bValue ? ONE : ZERO;
          }
          bitSlicedAssignStatementTmp.lValue.index = lEnd;
          _hierNetlist[_curModuleIndex].assigns.push_back(
            bitSlicedAssignStatementTmp);
          rWidthTmp--;
          _hierNetlist[_curModuleIndex]
            .ports[_curPortIndex]
            .whichInstanceOutput[lEnd] = _curAssignIndex;
          _curAssignIndex++;
          lEnd--;
        }
      }
    }
    else
    {
      {
        int rEnd = rValue.varRefRange.end;
        bitSlicedAssignStatementTmp.rValue.varRefIndex =
          _portNameMapIndexs[_curModuleIndex].ports[rValue.varRefName];
        bitSlicedAssignStatementTmp.rValue.isVector = rValue.isVector;
        while(rEnd >= int(rValue.varRefRange.start))
        {
          bitSlicedAssignStatementTmp.rValue.index = rEnd;
          bitSlicedAssignStatementTmp.lValue.index = lEnd;
          _hierNetlist[_curModuleIndex].assigns.push_back(
            bitSlicedAssignStatementTmp);
          rEnd--;
          _hierNetlist[_curModuleIndex]
            .ports[_curPortIndex]
            .whichInstanceOutput[lEnd] = _curAssignIndex;
          _curAssignIndex++;
          lEnd--;
        }
      }
    }
    _isAssignStatement = false;
  }
}

void HierNetlistVisitor::visit(AstCell *nodep)
{
  _curSubmoduleName = nodep->modp()->prettyName();
  _curSubmoduleInstanceName = nodep->prettyName();
  _curSubModInsPortAssignmentsTmp.clear();
  iterateChildren(nodep);
  _hierNetlist[_curModuleIndex].subModuleInstanceNames.push_back(
    _curSubmoduleInstanceName);
  _hierNetlist[_curModuleIndex].subModuleDefIndex.push_back(
    _moduleNameMapIndex[_curSubmoduleName]);
  _hierNetlist[_curModuleIndex].portAssignmentsOfSubModuleInstances.push_back(
    _curSubModInsPortAssignmentsTmp);
  _curSubmoduleInstanceIndex++;
}

void HierNetlistVisitor::visit(AstPin *nodep)
{
  _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.clear();
  _multipleBitsPortAssignmentTmp.portDefName = nodep->modVarp()->name();
  iterateChildren(nodep);
  PortAssignment portAssignment;
  VarRef varRef;
  auto &curSubModuleIndex = _moduleNameMapIndex[_curSubmoduleName];
  portAssignment.portDefIndex =
    _portNameMapIndexs[curSubModuleIndex]
      .ports[_multipleBitsPortAssignmentTmp.portDefName];
  for(auto &mVarRef: _multipleBitsPortAssignmentTmp.multipleBitsVarRefs)
  {
    if(mVarRef.varRefName == "")
    {
      uint32_t hotCode = 1 << 31;
      auto rWidth = mVarRef.width;
      uint32_t rWidthTmp = rWidth;
      varRef.varRefIndex = MAX32;
      varRef.isVector = false;
      if(rWidth > 32)
      {
        rWidthTmp = 32;
        rWidth = rWidth - 32;
      }
      else
      {
        rWidth = rWidth - 32;
      }
      while(rWidthTmp >= 1)
      {
        bool bValue = ((mVarRef.constValueAndValueX.value &
                        (hotCode >> (32 - rWidth))) > 0);
        if(mVarRef.hasValueX)
        {
          bool bValueX = ((mVarRef.constValueAndValueX.valueX &
                           (hotCode >> (32 - rWidth))) > 0);
          if(bValue & bValueX)
            varRef.valueAndValueX = X;
          else if((!bValue) & (!bValueX))
            varRef.valueAndValueX = ZERO;
          else if(bValue)
            varRef.valueAndValueX = ONE;
          else
            varRef.valueAndValueX = Z;
        }
        else
        {
          varRef.valueAndValueX = bValue ? ONE : ZERO;
        }
        portAssignment.varRefs.push_back(varRef);
        rWidthTmp--;
      }
      for(auto &biggerValue: mVarRef.biggerValue)
      {
        if(rWidth > 32)
        {
          rWidthTmp = 32;
          rWidth = rWidth - 32;
        }
        else
        {
          rWidth = rWidth - 32;
        }
        while(rWidthTmp >= 1)
        {
          bool bValue =
            ((biggerValue.m_value & (hotCode >> (32 - rWidthTmp))) > 0);
          if(mVarRef.hasValueX)
          {
            bool bValueX =
              ((biggerValue.m_valueX & (hotCode >> (32 - rWidthTmp))) > 0);
            if(bValue & bValueX)
              varRef.valueAndValueX = X;
            else if((!bValue) & (!bValueX))
              varRef.valueAndValueX = ZERO;
            else if(bValue)
              varRef.valueAndValueX = ONE;
            else
              varRef.valueAndValueX = Z;
          }
          else
          {
            varRef.valueAndValueX = bValue ? ONE : ZERO;
          }
          portAssignment.varRefs.push_back(varRef);
        }
      }
    }
    else
    {
      int rEnd = mVarRef.varRefRange.end;
      varRef.varRefIndex =
        _portNameMapIndexs[_curModuleIndex].ports[mVarRef.varRefName];
      varRef.isVector = mVarRef.isVector;
      while(rEnd >= int(mVarRef.varRefRange.start))
      {
        varRef.index = rEnd;
        portAssignment.varRefs.push_back(varRef);
        rEnd--;
        if(_hierNetlist[curSubModuleIndex]
               .ports[portAssignment.portDefIndex]
               .portType != PortType::INPUT &&
           _hierNetlist[_curModuleIndex].ports[varRef.varRefIndex].portType !=
             PortType::INPUT)
          _hierNetlist[_curModuleIndex]
            .ports[varRef.varRefIndex]
            .whichInstanceOutput[varRef.index] = _curSubmoduleInstanceIndex;
      }
    }
  }
  _curSubModInsPortAssignmentsTmp.push_back(portAssignment);
}

void HierNetlistVisitor::visit(AstSel *nodep)
{
  _whichAstSelChildren = 1;
  iterateChildren(nodep);
  if(_isAssignStatement)
  { // Now, AstSel is a child or a descendant of
    // AstAssignW
    if(_isAssignStatementLvalue)
    { // Now, AstSel is a child of AstAssignW
      _multipleBitsAssignStatementTmp.lValue = _multipleBitsVarRefTmp;
      _isAssignStatementLvalue = false;
    }
    else
    { // Now, AstSel is a child of AstAssign or AstExtend or AstConcat
      _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRefTmp);
    }
  }
  else
  {
    // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat
    _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.push_back(
      _multipleBitsVarRefTmp);
  }
  _whichAstSelChildren = 0;
}

// If AstVarRef is a child of AstSel, it references some part of a var.
// Sometimes, whole part.
// For example, C[2:1];
// Otherwise, it references the whole part of a var.
// For example, C[n-1:0] or ci;
void HierNetlistVisitor::visit(AstVarRef *nodep)
{
  _multipleBitsVarRefTmp.varRefName = nodep->prettyName();
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
    _multipleBitsVarRefTmp.hasValueX = false;
    // Make sure all var like A[1:3] or A[3:1] become A[2:0]
    if(nodep->dtypep()->basicp()->nrange().left() >
       nodep->dtypep()->basicp()->nrange().right())
    {
      _multipleBitsVarRefTmp.varRefRange.end =
        nodep->dtypep()->basicp()->nrange().left();
      _multipleBitsVarRefTmp.varRefRange.start =
        nodep->dtypep()->basicp()->nrange().right();
    }
    else
    {
      _multipleBitsVarRefTmp.varRefRange.end =
        nodep->dtypep()->basicp()->nrange().right();
      _multipleBitsVarRefTmp.varRefRange.start =
        nodep->dtypep()->basicp()->nrange().left();
    }
    if(_multipleBitsVarRefTmp.varRefRange.start > 0)
    {
      _multipleBitsVarRefTmp.varRefRange.end =
        _multipleBitsVarRefTmp.varRefRange.end -
        _multipleBitsVarRefTmp.varRefRange.start;
      _multipleBitsVarRefTmp.varRefRange.start = 0;
    }
    _multipleBitsVarRefTmp.width = _multipleBitsVarRefTmp.varRefRange.end -
                                   _multipleBitsVarRefTmp.varRefRange.start +
                                   1;
    if(_multipleBitsVarRefTmp.width > 1)
      _multipleBitsVarRefTmp.isVector = true;
    else
      _multipleBitsVarRefTmp.isVector = false;
    if(_isAssignStatement)
    { // Now, AstVarRef is a child of AstAssign or a
      // descendant of AstAssignW
      if(nodep->access() == VAccess::WRITE)
      { // Now, AstVarRef is a child of AstAssign
        _multipleBitsAssignStatementTmp.lValue = _multipleBitsVarRefTmp;
      }
      else
      { // Now, AstVarRef is a child of AstAssign or AstExtend or
        // AstConcat or
        // AstReplicate
        _multipleBitsAssignStatementTmp.rValue.push_back(
          _multipleBitsVarRefTmp);
      }
    }
    else
    {
      // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat or
      // AstReplicate
      _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.push_back(
        _multipleBitsVarRefTmp);
    }
  }
}

void HierNetlistVisitor::visit(AstExtend *nodep)
{
  uint32_t extendWidth = nodep->width() - nodep->lhsp()->width();
  _multipleBitsVarRefTmp.varRefName = "";
  _multipleBitsVarRefTmp.constValueAndValueX.value = 0;
  _multipleBitsVarRefTmp.constValueAndValueX.valueX = 0;
  if(extendWidth > 1)
    _multipleBitsVarRefTmp.isVector = true;
  else
    _multipleBitsVarRefTmp.isVector = false;
  _multipleBitsVarRefTmp.hasValueX = false;
  _multipleBitsVarRefTmp.width = std::move(extendWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstAssign or
    // AstAssignW or AstConcat
    _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRefTmp);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.push_back(
      _multipleBitsVarRefTmp);
  }
  iterateChildren(nodep);
}

void HierNetlistVisitor::visit(AstExtendS *nodep)
{
  uint32_t extendSWidth = nodep->width() - nodep->lhsp()->width();
  _multipleBitsVarRefTmp.varRefName = "";
  _multipleBitsVarRefTmp.constValueAndValueX.value = (1 << extendSWidth) - 1;
  _multipleBitsVarRefTmp.constValueAndValueX.valueX = 0;
  if(extendSWidth > 1)
    _multipleBitsVarRefTmp.isVector = true;
  else
    _multipleBitsVarRefTmp.isVector = false;
  _multipleBitsVarRefTmp.hasValueX = false;
  _multipleBitsVarRefTmp.width = std::move(extendSWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstAssign or
    // AstAssignW or AstConcat
    _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRefTmp);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.push_back(
      _multipleBitsVarRefTmp);
  }
  iterateChildren(nodep);
}

void HierNetlistVisitor::visit(AstReplicate *nodep)
{
  iterateChildren(nodep);
  if(_isAssignStatement)
  { // Now, AstReplicate is a child of AstAssignW or
    // AstExtend or AstConcat
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
      _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.back()
        .constValueAndValueX.value;
    _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.pop_back();
    while(replicateTimes != 1)
    {
      _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.push_back(
        _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.back());
      replicateTimes--;
    }
  }
}

void HierNetlistVisitor::visit(AstConst *nodep)
{
  if(_whichAstSelChildren == 2)
  { // Now, AstConst is a child of AstSel
    _whichAstSelChildren++;
    _multipleBitsVarRefTmp.varRefRange.start =
      nodep->num().value().getValue32();
  }
  else if(_whichAstSelChildren == 3)
  { // Now, AstConst is a child of AstSel
    _multipleBitsVarRefTmp.width = nodep->num().value().getValue32();
    _multipleBitsVarRefTmp.varRefRange.end =
      _multipleBitsVarRefTmp.varRefRange.start + _multipleBitsVarRefTmp.width -
      1;
    _multipleBitsVarRefTmp.isVector = true;
    _multipleBitsVarRefTmp.hasValueX = false;
  }
  else
  { // Now, AstConst is a rValue of assign statement or refValue of a
    // port or
    // the number of AstReplicate.
    _multipleBitsVarRefTmp.varRefName = "";
    _multipleBitsVarRefTmp.constValueAndValueX.value =
      nodep->num().value().getValue32();
    _multipleBitsVarRefTmp.width = nodep->width();
    if(_multipleBitsVarRefTmp.width > 1)
      _multipleBitsVarRefTmp.isVector = true;
    else
      _multipleBitsVarRefTmp.isVector = false;
    if(nodep->num().isAnyXZ())
    { // Now, the const value has value x or z.
      _multipleBitsVarRefTmp.constValueAndValueX.valueX =
        nodep->num().value().getValueX32();
      _multipleBitsVarRefTmp.hasValueX = true;
    }
    else
    {
      _multipleBitsVarRefTmp.constValueAndValueX.valueX = 0;
      _multipleBitsVarRefTmp.hasValueX = false;
    }
    if(_multipleBitsVarRefTmp.width > 32)
      _multipleBitsVarRefTmp.biggerValue.push_back(
        nodep->num().value().getValueAndX64());
    if(_multipleBitsVarRefTmp.width > 64)
    {
      const std::vector<V3NumberData::ValueAndX> valueAndX128Tmp =
        nodep->num().value().getValueAndX128();
      _multipleBitsVarRefTmp.biggerValue.insert(
        _multipleBitsVarRefTmp.biggerValue.end(), valueAndX128Tmp.begin(),
        valueAndX128Tmp.end());
    }
    if(_isAssignStatement)
    { // Now, AstConst is a child of AstAssign or
      // AstAssignW or AstConcat or
      // AstReplicate
      _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsVarRefTmp);
      if(_multipleBitsVarRefTmp.width > 32)
        _multipleBitsVarRefTmp.biggerValue.clear();
    }
    else
    { // Now, AstConst is a child of AstPin or AstConcat or AstReplicate
      _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.push_back(
        _multipleBitsVarRefTmp);
      if(_multipleBitsVarRefTmp.width > 32)
        _multipleBitsVarRefTmp.biggerValue.clear();
    }
  }
}
void EmitHierNetList::emitHierNetLists(std::vector<Module> &hierNetList)
{
  HierNetlistVisitor hierNetListVisitor(v3Global.rootp());
  hierNetList = hierNetListVisitor.GetHierNetList();
}

void EmitHierNetList::printHierNetlist(const std::vector<Module> &hierNetList)
{
  std::ofstream ofs("HierNetlist.v");
}
