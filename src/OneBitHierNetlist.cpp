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
#include <unistd.h>
#include <unordered_map>

#include "V3Ast.h"
#include "V3Error.h"

// When writing visit functions, there are some keys we should know:
// (1)Everytime we only write either AstAssignW/AstAssign or AstPin information
// until all its information have been obtained.
// (2)Only AstVarRef or AstSel can be lValue of assign statement.
// (3)AstConst, AstExtend and AstConcat can't be lValue of assign statement.
// (4)Know about the difference between m_nextp and m_opxp, some information
// about them I have written before the declaration of visit function.
// (5)We are only allowed to writ one AstVarRef information at the same time.
// (6)Only such AstNode that has children pointed by m_opxp and we need the
// information of its children can call iterateChildren(nodep) function.
bool IsStdCell(const std::string &moduleName);
struct PortNameMapPortDefIndex
{
    std::unordered_map<std::string, uint32_t> ports;
};
class HierNetlistVisitor final : public VNVisitor
{
  public:
    // AstNetlist
    std::vector<Module> _hierNetlist;

  private:
    // AstNetlist
    uint32_t _theTimesOfVisit;

    // A module = ItsName + Port  + Wire + Assign staement + Submodule Instance
    // AstModule
    uint32_t _theNumberOfStdModuleShouldUse;
    std::vector<uint32_t> _theNumberOfSubModuleInstances;
    std::unordered_map<std::string, uint32_t> _moduleNameMapIndex;
    std::string _curModuleName;
    uint32_t _curModuleIndex;

    // AstVar
    std::vector<PortNameMapPortDefIndex> _portNameMapPortDefIndexs;
    PortNameMapPortDefIndex _portNameMapPortDefIndex;
    uint32_t _curPortDefIndex;
    std::vector<PortDefinition> wires;

    // AstCell
    std::string _curSubmoduleName;
    std::string _curSubmoduleInstanceName;
    uint32_t _curSubmoduleInstanceIndex;
    uint32_t _theNumberOfSubModuleInstance;

    // AstAssignW/AstAssign:AstNodeAssign Status
    bool _isAssignStatement = false;
    bool _isAssignStatementLvalue = false;
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
    // (1)Node has no children. For example, AstConst node.(Not pushed to)
    // (2)Node is pointed by m_nextp and its children pointed by m_opxp have
    // been visited, such as AstAssignW node.(Popped up from)
    // (3)Node is pointed by m_opxp and its children pointed by m_opxp have
    // been visited.(Popped up from) But its iterateAndNext() function will be
    // popped up from function stack only when its all descendants have been
    // visited such as AstModule node.
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
    virtual void visit(AstNodeAssign *nodep) override;
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

    // reuse some codes.
    char getOneBitValueFromDecimalNumber(uint32_t &value, uint32_t &valueX,
                                         uint32_t &position,
                                         bool &hasValueX) const;
    void
    determineWhetherTheWidthOfConstValueIsBiggerThan32(uint32_t &rWidth,
                                                       uint32_t &position);

    // Clear data and free ram
    template<typename T>
    void freeContainerBySwap(T &rContainer)
    {
      T empty;
      std::swap(rContainer, empty);
    }

  public:
    const std::vector<Module> &GetHierNetList() const { return _hierNetlist; };
    const uint32_t &getTheNumberOfStdCellsShouldUse() const
    {
      return _theNumberOfStdModuleShouldUse;
    };

  public:
    // AstNetlist is the root of HierNetList
    HierNetlistVisitor(AstNetlist *nodep) { nodep->accept(*this); }
    virtual ~HierNetlistVisitor() override{};
};

void HierNetlistVisitor::visit(AstNetlist *nodep)
{
  // First time visit: Only get information of standard cells we will use from
  // AstCell, AstModule and AstVar
  _theTimesOfVisit = 1;
  _theNumberOfStdModuleShouldUse = 0;
  _curModuleIndex = 0;
  iterateChildren(nodep);
  // Second time visit: Get information of other modules excluding standard
  // cells from AstCell, AstModule and AstVar
  _theTimesOfVisit = 2;
  iterateChildren(nodep);
  // Third time visit: Get information of all modules including standard cells
  // from AstConst, AstVarRef, AstCell and so on.
  _theTimesOfVisit = 3;
  iterateChildren(nodep);
  // Clear data that is no longer in use.
  freeContainerBySwap(_theNumberOfSubModuleInstances);
  freeContainerBySwap(_moduleNameMapIndex);
  freeContainerBySwap(_curModuleName);
  freeContainerBySwap(_portNameMapPortDefIndexs);
  freeContainerBySwap(_portNameMapPortDefIndex.ports);
  freeContainerBySwap(wires);
  freeContainerBySwap(_curSubmoduleName);
  freeContainerBySwap(_curSubmoduleInstanceName);
  freeContainerBySwap(_multipleBitsAssignStatementTmp.lValue.biggerValue);
  freeContainerBySwap(_multipleBitsAssignStatementTmp.rValue);
  freeContainerBySwap(_multipleBitsPortAssignmentTmp.multipleBitsVarRefs);
  freeContainerBySwap(_curSubModInsPortAssignmentsTmp);
  freeContainerBySwap(_multipleBitsVarRefTmp.biggerValue);
};

// Get module name and hierLevel.
// Create LUT.
void HierNetlistVisitor::visit(AstModule *nodep)
{
  _curModuleName = nodep->prettyName();
  if(_curModuleName == "@CONST-POOL@")
    return;
  else if(_theTimesOfVisit == 1 || _theTimesOfVisit == 2)
  {
    // The first two times visit AST, we only visit AstModule and AstVar and
    // count the number of AstCell of Every AstModule.
    auto visitAstModuleAndAstVar = [this](AstModule *nodep)
    {
      Module curModule;
      // Create a LUT.
      _moduleNameMapIndex[_curModuleName] = _curModuleIndex;
      // Store name and level for current module.
      curModule.moduleDefName = _curModuleName;
      curModule.level = nodep->level();
      // Push current module to hierarchical netlist.
      _hierNetlist.push_back(std::move(curModule));
      // Initial value for all ports of every module.
      _portNameMapPortDefIndex.ports.clear();
      _curPortDefIndex = 0;
      wires.clear();
      // Initial value
      _theNumberOfSubModuleInstance = 0;
      iterateChildren(nodep);
      _hierNetlist[_curModuleIndex].theNumberOfPortExcludingWire =
        _curPortDefIndex;
      // Make sure store wires at the end of ports.
      _hierNetlist[_curModuleIndex].ports.insert(
        _hierNetlist[_curModuleIndex].ports.end(), wires.begin(), wires.end());
      for(const auto &wire: wires)
      {
        // Create LUT for wires
        _portNameMapPortDefIndex.ports[wire.portDefName] = _curPortDefIndex;
        _curPortDefIndex++;
      }
      // Store LUT, the number of SubModuleInstance.
      _portNameMapPortDefIndexs.push_back(_portNameMapPortDefIndex);
      _theNumberOfSubModuleInstances.push_back(_theNumberOfSubModuleInstance);
      // Prepare for the next visit to AstModule.
      _curModuleIndex++;
    };
    // The first time visit
    if(_theTimesOfVisit == 1 && IsStdCell(_curModuleName))
      visitAstModuleAndAstVar(nodep);
    // The second time visit
    else if(_theTimesOfVisit == 2 && !IsStdCell(_curModuleName))
      visitAstModuleAndAstVar(nodep);
    return;
  }
  // The third time visit AST, we visit all AstNode, except AstVar.
  else
  {
    _curModuleIndex = _moduleNameMapIndex[_curModuleName];
    _curSubmoduleInstanceIndex = 0;
    iterateChildren(nodep);
    return;
  }
}

void HierNetlistVisitor::visit(AstVar *nodep)
{
  if(_theTimesOfVisit == 1 || _theTimesOfVisit == 2)
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
          break;
        }
      case VDirection::INOUT:
        {
          portDefinition.portType = PortType::INOUT;
          break;
        }
      default:
        break;
      }
    }
    else
    {
      portDefinition.portType = PortType::WIRE;
    }
    if(portDefinition.portType == PortType::WIRE)
    {
      // Store wire definition
      wires.push_back(std::move(portDefinition));
    }
    else
    {
      // Create LUT excluding wires
      _portNameMapPortDefIndex.ports[portDefinition.portDefName] =
        _curPortDefIndex;
      _curPortDefIndex++;
      // Store port definition
      _hierNetlist[_curModuleIndex].ports.push_back(std::move(portDefinition));
    }
  }
}

void HierNetlistVisitor::visit(AstNodeAssign *nodep)
{
  if(_theTimesOfVisit == 3)
  {
    // Set assign status and initial value.
    _isAssignStatement = true;
    _multipleBitsAssignStatementTmp.rValue.clear();
    iterateChildren(nodep);
    // Convert multi bits wide assign statement into unit wide assign
    // statement.
    BitSlicedAssignStatement bitSlicedAssignStatementTmp;
    // Use int type, not uint32_t, because of start = end = 0 may occur.
    int lEnd = _multipleBitsAssignStatementTmp.lValue.varRefRange.end;
    bitSlicedAssignStatementTmp.lValue.varRefIndex =
      _portNameMapPortDefIndexs[_curModuleIndex]
        .ports[_multipleBitsAssignStatementTmp.lValue.varRefName];
    // Maybe, in this, the boundary between port and var will become blurred.
    // But, we should remember that, port can be input, output and inout.(In
    // fact, we regard wire as port,too. Look at PortType enum.) Var can be
    // input, output, inout, wire, const value, X or Z.
    _curPortDefIndex = bitSlicedAssignStatementTmp.lValue.varRefIndex;
    for(auto &rValue: _multipleBitsAssignStatementTmp.rValue)
    {
      if(rValue.varRefName == "")
      { // rValue is a const value, X or Z.
        auto rWidth = rValue.width;
        uint32_t position;
        // Store rValue
        bitSlicedAssignStatementTmp.rValue.varRefIndex = UINT_MAX;
        determineWhetherTheWidthOfConstValueIsBiggerThan32(rWidth, position);
        while(position >= 1)
        {
          // Store rValue
          bitSlicedAssignStatementTmp.rValue.valueAndValueX =
            getOneBitValueFromDecimalNumber(rValue.constValueAndValueX.value,
                                            rValue.constValueAndValueX.valueX,
                                            position, rValue.hasValueX);
          bitSlicedAssignStatementTmp.lValue.index = lEnd;
          _hierNetlist[_curModuleIndex].assigns.push_back(
            bitSlicedAssignStatementTmp);
          position--;
          lEnd--;
        }
        for(auto &biggerValue: rValue.biggerValue)
        { // If the width of const value, X or Z is bigger than 32, we should
          // pop up its remaining data, from left to right.
          determineWhetherTheWidthOfConstValueIsBiggerThan32(rWidth, position);
          while(position >= 1)
          {
            // Store rValue
            bitSlicedAssignStatementTmp.rValue.valueAndValueX =
              getOneBitValueFromDecimalNumber(biggerValue.m_value,
                                              biggerValue.m_valueX, position,
                                              rValue.hasValueX);
            bitSlicedAssignStatementTmp.lValue.index = lEnd;
            _hierNetlist[_curModuleIndex].assigns.push_back(
              bitSlicedAssignStatementTmp);
            position--;
            lEnd--;
          }
        }
      }
      else
      { // rValue is a input, output, wire or inout.
        {
          int rEnd = rValue.varRefRange.end;
          bitSlicedAssignStatementTmp.rValue.varRefIndex =
            _portNameMapPortDefIndexs[_curModuleIndex]
              .ports[rValue.varRefName];
          while(rEnd >= int(rValue.varRefRange.start))
          {
            bitSlicedAssignStatementTmp.rValue.index = rEnd;
            bitSlicedAssignStatementTmp.lValue.index = lEnd;
            _hierNetlist[_curModuleIndex].assigns.push_back(
              bitSlicedAssignStatementTmp);
            rEnd--;
            lEnd--;
          }
        }
      }
      _isAssignStatement = false;
    }
  }
}

void HierNetlistVisitor::visit(AstCell *nodep)
{
  if(_theTimesOfVisit == 1 || _theTimesOfVisit == 2)
  {
    _theNumberOfSubModuleInstance++;
  }
  else
  {
    _curSubmoduleName = nodep->modp()->prettyName();
    _curSubmoduleInstanceName = nodep->prettyName();
    _curSubModInsPortAssignmentsTmp.clear();
    iterateChildren(nodep);
    _hierNetlist[_curModuleIndex].subModuleInstanceNames.push_back(
      _curSubmoduleInstanceName);
    _hierNetlist[_curModuleIndex].subModuleDefIndex.push_back(
      _moduleNameMapIndex[_curSubmoduleName]);
    _hierNetlist[_curModuleIndex]
      .portAssignmentsOfSubModuleInstances.push_back(
        _curSubModInsPortAssignmentsTmp);
    _curSubmoduleInstanceIndex++;
  }
}

void HierNetlistVisitor::visit(AstPin *nodep)
{
  _multipleBitsPortAssignmentTmp.multipleBitsVarRefs.clear();
  _multipleBitsPortAssignmentTmp.portDefName = nodep->modVarp()->prettyName();
  iterateChildren(nodep);
  // Convert multi bits wide port assignment into unit wide port assignment.
  PortAssignment portAssignment;
  VarRef varRef;
  auto &curSubModuleIndex = _moduleNameMapIndex[_curSubmoduleName];
  portAssignment.portDefIndex =
    _portNameMapPortDefIndexs[curSubModuleIndex]
      .ports[_multipleBitsPortAssignmentTmp.portDefName];
  for(auto &mVarRef: _multipleBitsPortAssignmentTmp.multipleBitsVarRefs)
  {
    if(mVarRef.varRefName == "")
    {
      auto rWidth = mVarRef.width;
      uint32_t position;
      varRef.varRefIndex = UINT_MAX;
      determineWhetherTheWidthOfConstValueIsBiggerThan32(rWidth, position);
      while(position >= 1)
      {
        varRef.valueAndValueX = getOneBitValueFromDecimalNumber(
          mVarRef.constValueAndValueX.value,
          mVarRef.constValueAndValueX.valueX, position, mVarRef.hasValueX);
        portAssignment.varRefs.push_back(varRef);
        position--;
      }
      for(auto &biggerValue: mVarRef.biggerValue)
      {
        determineWhetherTheWidthOfConstValueIsBiggerThan32(rWidth, position);
        while(position >= 1)
        {
          varRef.valueAndValueX = getOneBitValueFromDecimalNumber(
            biggerValue.m_value, biggerValue.m_valueX, position,
            mVarRef.hasValueX);
          portAssignment.varRefs.push_back(varRef);
          position--;
        }
      }
    }
    else
    {
      int rEnd = mVarRef.varRefRange.end;
      varRef.varRefIndex =
        _portNameMapPortDefIndexs[_curModuleIndex].ports[mVarRef.varRefName];
      while(rEnd >= int(mVarRef.varRefRange.start))
      {
        varRef.index = rEnd;
        portAssignment.varRefs.push_back(varRef);
        rEnd--;
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
    if(_isAssignStatement)
    { // Now, AstVarRef is a child of AstAssign or a
      // descendant of AstAssignW
      if(nodep->access() == VAccess::WRITE)
      { // Now, AstVarRef is a child of AstAssign
        _multipleBitsAssignStatementTmp.lValue = _multipleBitsVarRefTmp;
      }
      else
      { // Now, AstVarRef is a child of AstAssign or AstExtend or
        // AstConcat or AstReplicate
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

char HierNetlistVisitor::getOneBitValueFromDecimalNumber(uint32_t &value,
                                                         uint32_t &valueX,
                                                         uint32_t &position,
                                                         bool &hasValueX) const
{
  uint32_t hotCode = 1 << 31;
  bool bValue = ((value & (hotCode >> (32 - position))) > 0) ? true : false;
  if(hasValueX)
  {
    bool bValueX =
      ((valueX & (hotCode >> (32 - position))) > 0) ? true : false;
    if(bValue & bValueX)
      return X;
    else if((!bValue) & (!bValueX))
      return ZERO;
    else if(bValue)
      return ONE;
    else
      return Z;
  }
  else
  {
    return bValue ? ONE : ZERO;
  }
}
void HierNetlistVisitor::determineWhetherTheWidthOfConstValueIsBiggerThan32(
  uint32_t &rWidth, uint32_t &position)
{
  if(rWidth > 32)
  {
    // Bigger than 32, every bit of the uint32_t number(value or valueX) we
    // should obtain.
    position = 32;
    rWidth = rWidth - 32;
  }
  else
  {
    // Smaller than 32, the rWidth bit of the uint32_t number(value or valueX)
    // we should obtain
    position = rWidth;
    rWidth = 0;
  }
}

void EmitHierNetList::emitHierNetLists(std::vector<Module> &hierNetList,
                                       uint32_t &theNumberOfStdCellsShouldUse)
{
  HierNetlistVisitor hierNetListVisitor(v3Global.rootp());
  hierNetList = hierNetListVisitor.GetHierNetList();
  theNumberOfStdCellsShouldUse =
    hierNetListVisitor.getTheNumberOfStdCellsShouldUse();
}

void EmitHierNetList::printHierNetlist(
  const std::vector<Module> &hierNetList,
  const uint32_t &theNumberOfStdCellsShouldUse, const uint32_t hierMaxLevel)
{
  std::ofstream ofs("HierNetlist.v");
  bool shouldHaveEscapeCharacter;
  uint32_t totalCharactersEveryLine;
  auto getDecimalNumberLength = [](uint32_t number)
  {
    uint32_t length = 0;
    while(number)
    {
      number /= 10;
      length++;
    }
    return length;
  };
  auto haveVerilogKeyWordOrOperator = [](const string &name)
  {
    // If there are too many kinds of keywords(more than 14) will be used in
    // port name, instance name, module name, variable name and so on, use map
    // to replace vector.
    std::vector<std::string> verilogKeyWord = { "run", "signed" };
    std::vector<std::string> verilogOperator = { "[", ".", "]" };
    for(auto vKW: verilogKeyWord)
    {
      if(vKW.size() == name.size() && name.find(vKW) < name.size())
        return true;
    }
    for(auto vO: verilogOperator)
    {
      if(name.find(vO) < name.size())
        return true;
    }
    return false;
  };
  const uint32_t maxCharactersEveryLine = 80;
  uint32_t moduleIndex = theNumberOfStdCellsShouldUse;
  // Every time print one module defintion
  for(uint32_t moduleIndex = theNumberOfStdCellsShouldUse;
      moduleIndex < hierNetList.size(); moduleIndex++)
  {
    const auto &oneModule = hierNetList[moduleIndex];
    totalCharactersEveryLine = 0;
    if(!IsStdCell(oneModule.moduleDefName) && oneModule.level <= hierMaxLevel)
    { // Print one module declaration
      ofs << "module " << oneModule.moduleDefName << "(";
      totalCharactersEveryLine =
        totalCharactersEveryLine + 7 + oneModule.moduleDefName.size() + 1;
      for(const auto &port: oneModule.ports)
      {
        if(port.portType != PortType::WIRE &&
           port.portType != PortType::LAST_PORT_TYPE)
        {
          if(totalCharactersEveryLine + port.portDefName.size() >
             maxCharactersEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharactersEveryLine = 6;
          }
          totalCharactersEveryLine =
            port.portDefName.size() + totalCharactersEveryLine;
          if(haveVerilogKeyWordOrOperator(port.portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
            totalCharactersEveryLine++;
          }
          ofs << port.portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            totalCharactersEveryLine++;
            shouldHaveEscapeCharacter = false;
          }
          ofs << ",";
          totalCharactersEveryLine++;
        }
      }
      ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
      ofs << ");" << std::endl;
      // Every time print one port definition
      for(const auto &port: oneModule.ports)
      {
        switch(port.portType)
        {
        case PortType::INPUT:
          ofs << "   input ";
          break;
        case PortType::OUTPUT:
          ofs << "   output ";
          break;
        case PortType::INOUT:
          ofs << "   inout ";
          break;
        case PortType::WIRE:
          ofs << "   wire ";
          break;
        }
        if(port.isVector)
        {
          ofs << "[" << port.bitWidth - 1 << ":0]";
        }
        if(haveVerilogKeyWordOrOperator(port.portDefName))
        {
          shouldHaveEscapeCharacter = true;
          ofs << "\\";
        }
        ofs << port.portDefName;
        if(shouldHaveEscapeCharacter)
        {
          ofs << " ";
          shouldHaveEscapeCharacter = false;
        }
        ofs << ";" << std::endl;
      }

      // Every time print one assign statement, every assign statement only has
      // one bit data;
      for(auto oneAssign: oneModule.assigns)
      {
        ofs << "  assign ";
        if(haveVerilogKeyWordOrOperator(
             oneModule.ports[oneAssign.lValue.varRefIndex].portDefName))
        {
          shouldHaveEscapeCharacter = true;
          ofs << "\\";
        }
        ofs << oneModule.ports[oneAssign.lValue.varRefIndex].portDefName;
        if(shouldHaveEscapeCharacter)
        {
          ofs << " ";
          shouldHaveEscapeCharacter = false;
        }
        if(oneAssign.lValue.varRefIndex != UINT_MAX)
        {
          if(oneModule.ports[oneAssign.lValue.varRefIndex].isVector)
            ofs << "[" << oneAssign.lValue.index << "]";
        }
        else
        {
          throw std::runtime_error(
            "Assign left value can not be const value or x or z.");
        }
        ofs << " = ";
        // rValue is a consta value or x or z
        if(oneAssign.rValue.varRefIndex == UINT_MAX)
        {
          switch(oneAssign.rValue.valueAndValueX)
          {
          case ONE:
            ofs << "1'b1";
            break;
          case ZERO:
            ofs << "1'b0";
            break;
          case X:
            ofs << "1'bx";
            break;
          case Z:
            ofs << "1'bz";
            break;
          default:
            ofs << "1'be"; // e = error valuex
            break;
          }
        }
        else
        {
          if(haveVerilogKeyWordOrOperator(
               oneModule.ports[oneAssign.rValue.varRefIndex].portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
          }
          ofs << oneModule.ports[oneAssign.rValue.varRefIndex].portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            shouldHaveEscapeCharacter = false;
          }
          if(oneModule.ports[oneAssign.rValue.varRefIndex].isVector)
            ofs << "[" << oneAssign.rValue.index << "]";
        }
        ofs << ";" << std::endl;
      }

      // Every time print one submodule instance
      uint32_t subModuleIndex = 0;
      for(const auto &onesubModuleInstanceName:
          oneModule.subModuleInstanceNames)
      {
        totalCharactersEveryLine = 0;
        ofs << "  "
            << hierNetList[oneModule.subModuleDefIndex[subModuleIndex]]
                 .moduleDefName
            << " ";
        if(haveVerilogKeyWordOrOperator(onesubModuleInstanceName))
        {
          ofs << "\\";
          totalCharactersEveryLine++;
        }
        ofs << onesubModuleInstanceName << " "
            << "(";
        totalCharactersEveryLine =
          totalCharactersEveryLine + 5 +
          hierNetList[oneModule.subModuleDefIndex[subModuleIndex]]
            .moduleDefName.size() +
          onesubModuleInstanceName.size();
        // Every time print one port assignment
        for(const auto &onePortAssignment:
            oneModule.portAssignmentsOfSubModuleInstances[subModuleIndex])
        {
          if(totalCharactersEveryLine + 1 +
               hierNetList[oneModule.subModuleDefIndex[subModuleIndex]]
                 .ports[onePortAssignment.portDefIndex]
                 .portDefName.size() >
             maxCharactersEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharactersEveryLine = 6;
          }
          ofs << ".";
          if(haveVerilogKeyWordOrOperator(
               hierNetList[oneModule.subModuleDefIndex[subModuleIndex]]
                 .ports[onePortAssignment.portDefIndex]
                 .portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
            totalCharactersEveryLine++;
          }
          ofs << hierNetList[oneModule.subModuleDefIndex[subModuleIndex]]
                   .ports[onePortAssignment.portDefIndex]
                   .portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            totalCharactersEveryLine++;
            shouldHaveEscapeCharacter = false;
          }
          ofs << "(";
          totalCharactersEveryLine =
            totalCharactersEveryLine + 2 +
            hierNetList[oneModule.subModuleDefIndex[subModuleIndex]]
              .ports[onePortAssignment.portDefIndex]
              .portDefName.size();
          if(onePortAssignment.varRefs.size() > 1)
          {
            ofs << "{";
            totalCharactersEveryLine++;
          }
          for(const auto &varRef: onePortAssignment.varRefs)
          {
            if(varRef.varRefIndex == UINT_MAX)
            {
              if(totalCharactersEveryLine + 4 > maxCharactersEveryLine)
              {
                ofs << std::endl << "      ";
                totalCharactersEveryLine = 6;
              }
              switch(varRef.valueAndValueX)
              {
              case ONE:
                ofs << "1'b1";
                break;
              case ZERO:
                ofs << "1'b0";
                break;
              case X:
                ofs << "1'bx";
                break;
              case Z:
                ofs << "1'bz";
                break;
              default:
                ofs << "1'be"; // e = error valuex
                break;
              }
              totalCharactersEveryLine = totalCharactersEveryLine + 4;
            }
            else
            {
              if(oneModule.ports[varRef.varRefIndex].isVector)
              {
                if(totalCharactersEveryLine +
                     oneModule.ports[varRef.varRefIndex].portDefName.size() +
                     2 + getDecimalNumberLength(varRef.index) >
                   maxCharactersEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharactersEveryLine = 6;
                }
              }
              else
              {
                if(totalCharactersEveryLine +
                     oneModule.ports[varRef.varRefIndex].portDefName.size() >
                   maxCharactersEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharactersEveryLine = 6;
                }
              }
              if(haveVerilogKeyWordOrOperator(
                   oneModule.ports[varRef.varRefIndex].portDefName))
              {
                shouldHaveEscapeCharacter = true;
                ofs << "\\";
                totalCharactersEveryLine++;
              }
              ofs << oneModule.ports[varRef.varRefIndex].portDefName;
              totalCharactersEveryLine =
                totalCharactersEveryLine +
                oneModule.ports[varRef.varRefIndex].portDefName.size();
              if(shouldHaveEscapeCharacter)
              {
                ofs << " ";
                totalCharactersEveryLine++;
                shouldHaveEscapeCharacter = false;
              }
              if(oneModule.ports[varRef.varRefIndex].isVector)
              {
                ofs << "[" << varRef.index << "]";
                totalCharactersEveryLine =
                  totalCharactersEveryLine + 2 +
                  getDecimalNumberLength(varRef.index);
              }
            }
            ofs << ",";
            totalCharactersEveryLine++;
          }
          if(onePortAssignment.varRefs.size() >= 1)
          {
            ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
            totalCharactersEveryLine--;
          }
          if(onePortAssignment.varRefs.size() > 1)
          {
            ofs << "}";
            totalCharactersEveryLine++;
          }
          ofs << ")";
          ofs << ", ";
          totalCharactersEveryLine = totalCharactersEveryLine + 3;
        }
        ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
        ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one " "
        ofs << ");";
        ofs << std::endl;
        subModuleIndex++;
      }
      ofs << "endmodule" << std::endl << std::endl;
    }
  }
  ofs.close();
}
