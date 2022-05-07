/*************************************************************************
  > File Name: OneBitHierNetlist.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Mon 11 Apr 2022 08:18:10 PM CST
 ************************************************************************/
#include "OneBitHierNetlist.h"

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
void HierNetlistVisitor::visit(AstNode *nodep) { iterateChildren(nodep); };

void HierNetlistVisitor::visit(AstNetlist *nodep)
{
  // First time visit: Only get information of standard cells we will use from
  // AstCell, AstModule and AstVar
  _theTimesOfVisit = 1;
  _theNumberOfStdCellsShouldUse = 0;
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
      // Prepare for the next visit to AstModule.
      _curModuleIndex++;
    };
    // The first time visit
    if(_theTimesOfVisit == 1 && nodep->inLibrary())
    {
      visitAstModuleAndAstVar(nodep);
      _theNumberOfStdCellsShouldUse++;
    }
    // The second time visit
    else if(_theTimesOfVisit == 2 && !nodep->inLibrary())
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
        auto &rWidth = rValue.width;
        uint32_t position;
        uint32_t biggerValueSize = rValue.biggerValue.size();
        // Store rValue
        bitSlicedAssignStatementTmp.rValue.varRefIndex = UINT_MAX;
        while(biggerValueSize > 0)
        { // If the width of const value, X or Z is bigger than 32, we should
          // pop up its remaining data, from left to right.
          auto &biggerValue = rValue.biggerValue[biggerValueSize - 1];
          if(biggerValueSize == rValue.biggerValue.size())
            position = rWidth - 32 * biggerValueSize;
          else
            position = 32;
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
          biggerValueSize--;
        }
        if(rWidth > 32)
          position = 32;
        else
          position = rWidth;
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
  if(_theTimesOfVisit == 3)
  {
    _curSubmoduleName = nodep->modp()->prettyName();
    _curSubmoduleInstanceName = nodep->prettyName();
    _curSubModInsPortAssignmentsTmp.clear();
    _curSubModInsPortAssignmentsTmp.resize(
      _hierNetlist[_moduleNameMapIndex[_curSubmoduleName]]
        .theNumberOfPortExcludingWire);
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
  auto &portDefIndex = _portNameMapPortDefIndexs[curSubModuleIndex]
                         .ports[_multipleBitsPortAssignmentTmp.portDefName];
  for(auto &mVarRef: _multipleBitsPortAssignmentTmp.multipleBitsVarRefs)
  {
    if(mVarRef.varRefName == "")
    {
      auto &rWidth = mVarRef.width;
      uint32_t position;
      uint32_t biggerValueSize = mVarRef.biggerValue.size();
      varRef.varRefIndex = UINT_MAX;
      while(biggerValueSize > 0)
      {
        auto &biggerValue = mVarRef.biggerValue[biggerValueSize - 1];
        if(biggerValueSize == mVarRef.biggerValue.size())
          position = rWidth - 32 * biggerValueSize;
        else
          position = 32;
        while(position >= 1)
        {
          varRef.valueAndValueX = getOneBitValueFromDecimalNumber(
            biggerValue.m_value, biggerValue.m_valueX, position,
            mVarRef.hasValueX);
          portAssignment.varRefs.insert(portAssignment.varRefs.begin(),
                                        varRef);
          position--;
        }
        biggerValueSize--;
      }
      if(rWidth > 32)
        position = 32;
      else
        position = rWidth;
      while(position >= 1)
      {
        varRef.valueAndValueX = getOneBitValueFromDecimalNumber(
          mVarRef.constValueAndValueX.value,
          mVarRef.constValueAndValueX.valueX, position, mVarRef.hasValueX);
        portAssignment.varRefs.insert(portAssignment.varRefs.begin(), varRef);
        position--;
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
        portAssignment.varRefs.insert(portAssignment.varRefs.begin(), varRef);
        rEnd--;
      }
    }
  }
  _curSubModInsPortAssignmentsTmp[portDefIndex] = portAssignment;
}

void HierNetlistVisitor::visit(AstConcat *nodep) { iterateChildren(nodep); };

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

template<typename T>
void HierNetlistVisitor::freeContainerBySwap(T &rContainer)
{
  T empty;
  std::swap(rContainer, empty);
}
