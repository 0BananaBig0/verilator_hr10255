/*************************************************************************
  > File Name: OneBitHierNetlist.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Mon 11 Apr 2022 08:18:10 PM CST
 ************************************************************************/
#include "OneBitHierNetlist.h"

void HierNetlistVisitor::visit(AstNode *nodep) { iterateChildren(nodep); };

void HierNetlistVisitor::visit(AstNetlist *nodep)
{
  // First time visit: Find all black boxes excluding std cells
  _theTimesOfVisit = 1;
  _totalUsedBlackBoxes = 0;
  iterateChildren(nodep);
  // Second time visit: Only get information of standard cells we will use from
  // AstCell, AstModule and AstVar
  _theTimesOfVisit = 2;
  _totalUsedStdCells = 0;
  _curModuleIndex = 0;
  iterateChildren(nodep);
  // Third time visit: Get information of all black boxes excluding std cells
  _theTimesOfVisit = 3;
  iterateChildren(nodep);
  // Fourth time visit: Get information of other modules excluding standard
  // cells from AstCell, AstModule and AstVar
  _theTimesOfVisit = 4;
  iterateChildren(nodep);
  // Before the fifth time visit, adjust the stdcells order.
  swapEmptyAndNotEmptyStdCellPosition();
  // Fifth time visit: Get information of all modules including standard cells
  // from AstConst, AstVarRef, AstCell and so on.
  _theTimesOfVisit = 5;
  iterateChildren(nodep);
  _totalUsedBlackBoxes = _totalUsedBlackBoxes + _totalUsedStdCells;
  // Clear data that is no longer in use.
  freeContainerBySwap(_moduleNameMapIndex);
  freeContainerBySwap(_blackBoxesNameExcludingStdCells);
  freeContainerBySwap(_portNameMapPortDefIndexs);
  freeContainerBySwap(_portNameMapPortDefIndex.ports);
  freeContainerBySwap(_curSubmoduleName);
  freeContainerBySwap(_curSubmoduleInstanceName);
  freeContainerBySwap(_multipleBitsAssignStatementTmp.lValue.biggerValues);
  freeContainerBySwap(_multipleBitsAssignStatementTmp.rValue);
  freeContainerBySwap(_multipleBitsPortAssignmentTmp.multipleBitsRefVars);
  freeContainerBySwap(_curSubModInsPortAssignmentsTmp);
  freeContainerBySwap(_multipleBitsRefVarTmp.biggerValues);
};

// Get module name and hierLevel.
// Create LUT.
void HierNetlistVisitor::visit(AstModule *nodep)
{
  const auto &curModuleName = nodep->prettyName();
  const bool &inLibrary = nodep->inLibrary();
  // The first time visit
  if(_theTimesOfVisit == 1 && !inLibrary)
  {
    _isABlackBoxButNotAStdCell = true;
    iterateChildren(nodep);
    if(_isABlackBoxButNotAStdCell)
    {
      _blackBoxesNameExcludingStdCells.insert(curModuleName);
      _totalUsedBlackBoxes++;
    }
  }
  else if(_theTimesOfVisit > 1 && _theTimesOfVisit < 5)
  {
    // The second to fourth time visit AST, we only visit AstModule and AstVar
    // and count the number of AstCell of Every AstModule.
    auto visitAstModuleAndAstVar = [this, &curModuleName, &nodep]()
    {
      Module curModule;
      // Create a LUT.
      _moduleNameMapIndex[curModuleName] = _curModuleIndex;
      // Store name and level for current module.
      curModule.moduleDefName = curModuleName;
      curModule.level = nodep->level();
      // Push current module to hierarchical netlist.
      _hierNetlist.push_back(std::move(curModule));
      // Initial value for all ports of current module.
      _portNameMapPortDefIndex.ports.clear();
      _curPortDefIndex = 0;
      // visit input
      _theTimesOfVisitAstVar = 1;
      iterateChildren(nodep);
      _hierNetlist[_curModuleIndex].totalInputs = _curPortDefIndex;
      // visit inout
      _theTimesOfVisitAstVar = 2;
      iterateChildren(nodep);
      _hierNetlist[_curModuleIndex].totalInputsAndInouts = _curPortDefIndex;
      // visit output
      _theTimesOfVisitAstVar = 3;
      iterateChildren(nodep);
      _hierNetlist[_curModuleIndex].totalPortsExcludingWires =
        _curPortDefIndex;
      // visit wire
      _theTimesOfVisitAstVar = 4;
      iterateChildren(nodep);
      // Store LUT
      _portNameMapPortDefIndexs.push_back(_portNameMapPortDefIndex);
      // Prepare for the next visit to AstModule.
      _curModuleIndex++;
      _theTimesOfVisitAstVar = 0;
    };
    // The second time visit
    if(_theTimesOfVisit == 2 && inLibrary)
    {
      visitAstModuleAndAstVar();
      _totalUsedStdCells++;
    }
    // The third time visit
    else if(_theTimesOfVisit == 3 &&
            _blackBoxesNameExcludingStdCells.find(curModuleName) !=
              _blackBoxesNameExcludingStdCells.end())
    {
      visitAstModuleAndAstVar();
    }
    // The fourth time visit
    else if(_theTimesOfVisit == 4 && !inLibrary &&
            _blackBoxesNameExcludingStdCells.find(curModuleName) ==
              _blackBoxesNameExcludingStdCells.end())
      visitAstModuleAndAstVar();
    return;
  }
  // The fifth time visit AST, we visit all AstNode, except AstVar.
  else
  {
    _curModuleIndex = _moduleNameMapIndex[curModuleName];
    _curSubmoduleInstanceIndex = 0;
    iterateChildren(nodep);
    return;
  }
}

void HierNetlistVisitor::visit(AstVar *nodep)
{
  if(_theTimesOfVisit > 1 && _theTimesOfVisit < 5)
  {
    PortDefinition portDefinition;
    if(nodep->isGParam())
    {
      return;
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
    if((portDefinition.portType == PortType::INPUT &&
        _theTimesOfVisitAstVar == 1) ||
       (portDefinition.portType == PortType::INOUT &&
        _theTimesOfVisitAstVar == 2) ||
       (portDefinition.portType == PortType::OUTPUT &&
        _theTimesOfVisitAstVar == 3) ||
       (portDefinition.portType == PortType::WIRE &&
        _theTimesOfVisitAstVar == 4))
    {
      portDefinition.portDefName = nodep->prettyName();
      if(nodep->basicp() && nodep->basicp()->width() != 1)
      {
        portDefinition.isVector = true;
        portDefinition.bitWidth = nodep->basicp()->width();
      }
      // Create LUT
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
  if(_theTimesOfVisit == 5)
  {
    // Set assign status and initial value.
    _isAssignStatement = true;
    _multipleBitsAssignStatementTmp.rValue.clear();
    iterateChildren(nodep);
    // Convert multi bits wide assign statement into one bit assign
    // statement.
    BitSlicedAssignStatement bitSlicedAssignStatementTmp;
    // Use int type, not uint32_t, because of start = end = 0 may occur.
    int lEnd = _multipleBitsAssignStatementTmp.lValue.refVarRange.end;
    bitSlicedAssignStatementTmp.lValue.refVarDefIndex =
      _portNameMapPortDefIndexs[_curModuleIndex]
        .ports[_multipleBitsAssignStatementTmp.lValue.refVarName];
    auto &assigns = _hierNetlist[_curModuleIndex].assigns;
    uint32_t assignsIndex = assigns.size();
    assigns.resize(assignsIndex + lEnd -
                   _multipleBitsAssignStatementTmp.lValue.refVarRange.start +
                   1);
    // Maybe, in this, the boundary between port and var will become blurred.
    // But, we should remember that, port can be input, output and inout.(In
    // fact, we regard wire as port,too. Look at PortType enum.) Var can be
    // input, output, inout, wire, const value, X or Z.
    _curPortDefIndex = bitSlicedAssignStatementTmp.lValue.refVarDefIndex;
    for(auto &rValue: _multipleBitsAssignStatementTmp.rValue)
    {
      if(rValue.refVarName == "")
      { // rValue is a const value, X or Z.
        auto &rWidth = rValue.width;
        uint32_t position;
        uint32_t biggerValuesSize = rValue.biggerValues.size();
        // Store rValue
        bitSlicedAssignStatementTmp.rValue.refVarDefIndex = UINT_MAX;
        while(biggerValuesSize > 0)
        { // If the width of const value, X or Z is bigger than 32, we should
          // pop up its remaining data, from left to right.
          auto &biggerValue = rValue.biggerValues[biggerValuesSize - 1];
          if(biggerValuesSize == rValue.biggerValues.size())
            position = rWidth - 32 * biggerValuesSize - 1;
          else
            position = 31;
          while(position != UINT_MAX)
          {
            // Store rValue
            bitSlicedAssignStatementTmp.rValue.valueAndValueX =
              getOneBitValueFromDecimalNumber(biggerValue.m_value,
                                              biggerValue.m_valueX, position,
                                              rValue.hasX);
            bitSlicedAssignStatementTmp.lValue.bitIndex = lEnd;
            assigns[assignsIndex] = bitSlicedAssignStatementTmp;
            assignsIndex++;
            position--;
            lEnd--;
          }
          biggerValuesSize--;
        }
        if(rWidth > 32)
          position = 31;
        else
          position = rWidth - 1;
        while(position != UINT_MAX)
        {
          // Store rValue
          bitSlicedAssignStatementTmp.rValue.valueAndValueX =
            getOneBitValueFromDecimalNumber(rValue.constValueAndX.value,
                                            rValue.constValueAndX.valueX,
                                            position, rValue.hasX);
          bitSlicedAssignStatementTmp.lValue.bitIndex = lEnd;
          assigns[assignsIndex] = bitSlicedAssignStatementTmp;
          assignsIndex++;
          position--;
          lEnd--;
        }
      }
      else
      { // rValue is a input, output, wire or inout.
        {
          int rEnd = rValue.refVarRange.end;
          bitSlicedAssignStatementTmp.rValue.refVarDefIndex =
            _portNameMapPortDefIndexs[_curModuleIndex]
              .ports[rValue.refVarName];
          while(rEnd >= int(rValue.refVarRange.start))
          {
            bitSlicedAssignStatementTmp.rValue.bitIndex = rEnd;
            bitSlicedAssignStatementTmp.lValue.bitIndex = lEnd;
            assigns[assignsIndex] = bitSlicedAssignStatementTmp;
            assignsIndex++;
            rEnd--;
            lEnd--;
          }
        }
      }
      _isAssignStatement = false;
    }
  }
  else if(_theTimesOfVisit == 1 && _isABlackBoxButNotAStdCell)
  {
    // Current module is not a black box, it at least has a assign statement.
    _isABlackBoxButNotAStdCell = false;
  }
}

void HierNetlistVisitor::visit(AstCell *nodep)
{
  if(_theTimesOfVisit == 5)
  {
    _curSubmoduleName = nodep->modp()->prettyName();
    _curSubmoduleInstanceName = nodep->prettyName();
    _curSubModInsPortAssignmentsTmp.clear();
    _curSubModInsPortAssignmentsTmp.resize(
      _hierNetlist[_moduleNameMapIndex[_curSubmoduleName]]
        .totalPortsExcludingWires);
    iterateChildren(nodep);
    _hierNetlist[_curModuleIndex].subModuleInstanceNames.push_back(
      _curSubmoduleInstanceName);
    _hierNetlist[_curModuleIndex].subModuleDefIndexs.push_back(
      _moduleNameMapIndex[_curSubmoduleName]);
    _hierNetlist[_curModuleIndex].portAssignmentsOfSubModInss.push_back(
      _curSubModInsPortAssignmentsTmp);
    _curSubmoduleInstanceIndex++;
  }
  else if(_theTimesOfVisit == 1 && _isABlackBoxButNotAStdCell)
  {
    // Current module is not a black box, it at least has a sub module.
    _isABlackBoxButNotAStdCell = false;
  }
}

void HierNetlistVisitor::visit(AstPin *nodep)
{
  _multipleBitsPortAssignmentTmp.multipleBitsRefVars.clear();
  _multipleBitsPortAssignmentTmp.portDefName = nodep->modVarp()->prettyName();
  iterateChildren(nodep);
  // Convert multi bits wide port assignment into unit wide port assignment.
  auto &curSubModuleIndex = _moduleNameMapIndex[_curSubmoduleName];
  auto &portDefIndex = _portNameMapPortDefIndexs[curSubModuleIndex]
                         .ports[_multipleBitsPortAssignmentTmp.portDefName];
  PortAssignment portAssignment;
  if(_multipleBitsPortAssignmentTmp.multipleBitsRefVars.empty())
  {
    _curSubModInsPortAssignmentsTmp[portDefIndex] = portAssignment;
    return;
  }
  portAssignment.refVars.resize(
    _hierNetlist[curSubModuleIndex].ports[portDefIndex].bitWidth);
  uint32_t portBitIndex = 0;
  RefVar refVar;
  for(int i = _multipleBitsPortAssignmentTmp.multipleBitsRefVars.size() - 1;
      i >= 0; i--)
  {
    auto &mRefVar = _multipleBitsPortAssignmentTmp.multipleBitsRefVars[i];
    if(mRefVar.refVarName == "")
    {
      auto &rWidth = mRefVar.width;
      uint32_t positionLimit, position = 0;
      refVar.refVarDefIndex = UINT_MAX;
      if(rWidth > 32)
        positionLimit = 32;
      else
        positionLimit = rWidth;
      while(position < positionLimit)
      {
        refVar.valueAndValueX = getOneBitValueFromDecimalNumber(
          mRefVar.constValueAndX.value, mRefVar.constValueAndX.valueX,
          position, mRefVar.hasX);
        portAssignment.refVars[portBitIndex] = refVar;
        portBitIndex++;
        position++;
      }
      for(auto &biggerValue: mRefVar.biggerValues)
      {
        if(&biggerValue == &mRefVar.biggerValues.back())
          positionLimit = rWidth - 32 * mRefVar.biggerValues.size();
        else
          positionLimit = 32;
        position = 0;
        while(position < positionLimit)
        {
          refVar.valueAndValueX = getOneBitValueFromDecimalNumber(
            biggerValue.m_value, biggerValue.m_valueX, position, mRefVar.hasX);
          portAssignment.refVars[portBitIndex] = refVar;
          portBitIndex++;
          position++;
        }
      }
    }
    else
    {
      uint32_t rStart = mRefVar.refVarRange.start;
      refVar.refVarDefIndex =
        _portNameMapPortDefIndexs[_curModuleIndex].ports[mRefVar.refVarName];
      while(rStart <= mRefVar.refVarRange.end)
      {
        refVar.bitIndex = rStart;
        portAssignment.refVars[portBitIndex] = refVar;
        portBitIndex++;
        rStart++;
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
  { // Now, AstSel is a child or a descendant of AstNodeAssign
    if(_isAssignStatementLvalue)
    { // Now, AstSel is a child of AstNodeAssign
      _multipleBitsAssignStatementTmp.lValue = _multipleBitsRefVarTmp;
      _isAssignStatementLvalue = false;
    }
    else
    { // Now, AstSel is a child of AstNodeAssign or AstExtend or AstConcat
      _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsRefVarTmp);
    }
  }
  else
  {
    // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat
    _multipleBitsPortAssignmentTmp.multipleBitsRefVars.push_back(
      _multipleBitsRefVarTmp);
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
  _multipleBitsRefVarTmp.refVarName = nodep->prettyName();
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
    _multipleBitsRefVarTmp.hasX = false;
    // Make sure all var like A[1:3] or A[3:1] become A[2:0]
    if(nodep->dtypep()->basicp()->nrange().left() >
       nodep->dtypep()->basicp()->nrange().right())
    {
      _multipleBitsRefVarTmp.refVarRange.end =
        nodep->dtypep()->basicp()->nrange().left();
      _multipleBitsRefVarTmp.refVarRange.start =
        nodep->dtypep()->basicp()->nrange().right();
    }
    else
    {
      _multipleBitsRefVarTmp.refVarRange.end =
        nodep->dtypep()->basicp()->nrange().right();
      _multipleBitsRefVarTmp.refVarRange.start =
        nodep->dtypep()->basicp()->nrange().left();
    }
    if(_multipleBitsRefVarTmp.refVarRange.start > 0)
    {
      _multipleBitsRefVarTmp.refVarRange.end =
        _multipleBitsRefVarTmp.refVarRange.end -
        _multipleBitsRefVarTmp.refVarRange.start;
      _multipleBitsRefVarTmp.refVarRange.start = 0;
    }
    _multipleBitsRefVarTmp.width = _multipleBitsRefVarTmp.refVarRange.end -
                                   _multipleBitsRefVarTmp.refVarRange.start +
                                   1;
    if(_isAssignStatement)
    { // Now, AstVarRef is a child of AstNodeAssign or a
      // descendant of AstNodeAssign
      if(nodep->access() == VAccess::WRITE)
      { // Now, AstVarRef is a child of AstNodeAssign
        _multipleBitsAssignStatementTmp.lValue = _multipleBitsRefVarTmp;
      }
      else
      { // Now, AstVarRef is a child of AstNodeAssign or AstExtend or
        // AstConcat or AstReplicate
        _multipleBitsAssignStatementTmp.rValue.push_back(
          _multipleBitsRefVarTmp);
      }
    }
    else
    {
      // Now, AstVarRef is a child of AstPin or AstExtend or AstConcat or
      // AstReplicate
      _multipleBitsPortAssignmentTmp.multipleBitsRefVars.push_back(
        _multipleBitsRefVarTmp);
    }
  }
}

void HierNetlistVisitor::visit(AstExtend *nodep)
{
  uint32_t extendWidth = nodep->width() - nodep->lhsp()->width();
  _multipleBitsRefVarTmp.refVarName = "";
  _multipleBitsRefVarTmp.constValueAndX.value = 0;
  _multipleBitsRefVarTmp.constValueAndX.valueX = 0;
  _multipleBitsRefVarTmp.hasX = false;
  _multipleBitsRefVarTmp.width = std::move(extendWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstNodeAssign or AstConcat
    _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsRefVarTmp);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _multipleBitsPortAssignmentTmp.multipleBitsRefVars.push_back(
      _multipleBitsRefVarTmp);
  }
  iterateChildren(nodep);
}

void HierNetlistVisitor::visit(AstExtendS *nodep)
{
  uint32_t extendSWidth = nodep->width() - nodep->lhsp()->width();
  _multipleBitsRefVarTmp.refVarName = "";
  _multipleBitsRefVarTmp.constValueAndX.value = (1 << extendSWidth) - 1;
  _multipleBitsRefVarTmp.constValueAndX.valueX = 0;
  _multipleBitsRefVarTmp.hasX = false;
  _multipleBitsRefVarTmp.width = std::move(extendSWidth);
  if(_isAssignStatement)
  { // Now, AstExtend is a child of AstNodeAssign or AstConcat
    _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsRefVarTmp);
  }
  else
  { // Now, AstExtend is a child of AstPin or AstConcat
    _multipleBitsPortAssignmentTmp.multipleBitsRefVars.push_back(
      _multipleBitsRefVarTmp);
  }
  iterateChildren(nodep);
}

void HierNetlistVisitor::visit(AstReplicate *nodep)
{
  iterateChildren(nodep);
  if(_isAssignStatement)
  { // Now, AstReplicate is a child of AstNodeAssign or AstExtend or AstConcat
    uint32_t replicateTimes =
      _multipleBitsAssignStatementTmp.rValue.back().constValueAndX.value;
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
      _multipleBitsPortAssignmentTmp.multipleBitsRefVars.back()
        .constValueAndX.value;
    _multipleBitsPortAssignmentTmp.multipleBitsRefVars.pop_back();
    while(replicateTimes != 1)
    {
      _multipleBitsPortAssignmentTmp.multipleBitsRefVars.push_back(
        _multipleBitsPortAssignmentTmp.multipleBitsRefVars.back());
      replicateTimes--;
    }
  }
}

void HierNetlistVisitor::visit(AstConst *nodep)
{
  if(_whichAstSelChildren == 2)
  { // Now, AstConst is a child of AstSel
    _whichAstSelChildren++;
    _multipleBitsRefVarTmp.refVarRange.start =
      nodep->num().value().getValue32();
  }
  else if(_whichAstSelChildren == 3)
  { // Now, AstConst is a child of AstSel
    _multipleBitsRefVarTmp.width = nodep->num().value().getValue32();
    _multipleBitsRefVarTmp.refVarRange.end =
      _multipleBitsRefVarTmp.refVarRange.start + _multipleBitsRefVarTmp.width -
      1;
    _multipleBitsRefVarTmp.hasX = false;
  }
  else
  { // Now, AstConst is a rValue of assign statement or refValue of a
    // port or the number of AstReplicate.
    _multipleBitsRefVarTmp.refVarName = "";
    _multipleBitsRefVarTmp.constValueAndX.value =
      nodep->num().value().getValue32();
    _multipleBitsRefVarTmp.width = nodep->width();
    if(nodep->num().isAnyXZ())
    { // Now, the const value has value x or z.
      _multipleBitsRefVarTmp.constValueAndX.valueX =
        nodep->num().value().getValueX32();
      _multipleBitsRefVarTmp.hasX = true;
    }
    else
    {
      _multipleBitsRefVarTmp.constValueAndX.valueX = 0;
      _multipleBitsRefVarTmp.hasX = false;
    }
    if(_multipleBitsRefVarTmp.width > 32)
      _multipleBitsRefVarTmp.biggerValues.push_back(
        nodep->num().value().getValueAndX64());
    if(_multipleBitsRefVarTmp.width > 64)
    {
      const std::vector<V3NumberData::ValueAndX> valueAndX128Tmp =
        nodep->num().value().getValueAndX128();
      _multipleBitsRefVarTmp.biggerValues.insert(
        _multipleBitsRefVarTmp.biggerValues.end(), valueAndX128Tmp.begin(),
        valueAndX128Tmp.end());
    }
    if(_isAssignStatement)
    { // Now, AstConst is a child of AstNodeAssign or AstConcat or AstReplicate
      _multipleBitsAssignStatementTmp.rValue.push_back(_multipleBitsRefVarTmp);
    }
    else
    { // Now, AstConst is a child of AstPin or AstConcat or AstReplicate
      _multipleBitsPortAssignmentTmp.multipleBitsRefVars.push_back(
        _multipleBitsRefVarTmp);
    }
    if(_multipleBitsRefVarTmp.width > 32)
      _multipleBitsRefVarTmp.biggerValues.clear();
  }
}

char HierNetlistVisitor::getOneBitValueFromDecimalNumber(uint32_t &value,
                                                         uint32_t &valueX,
                                                         uint32_t &position,
                                                         bool &hasX) const
{
  uint32_t hotCode = 1;
  bool bValue = ((value & (hotCode << position)) > 0) ? true : false;
  if(hasX)
  {
    bool bValueX = ((valueX & (hotCode << position)) > 0) ? true : false;
    if(bValue & bValueX)
      return CHAR_X;
    else if((!bValue) & (!bValueX))
      return CHAR_ZERO;
    else if(bValue)
      return CHAR_ONE;
    else
      return CHAR_Z;
  }
  else
  {
    return bValue ? CHAR_ONE : CHAR_ZERO;
  }
}

template<typename T>
void HierNetlistVisitor::freeContainerBySwap(T &rContainer)
{
  T empty;
  std::swap(rContainer, empty);
}

bool HierNetlistVisitor::isAnEmptyStdCellInJson(const std::string &stdCellName)
{
  std::unordered_set<std::string> emptyStdCells = { "MemGen_16_10", "PLL" };
  return emptyStdCells.find(stdCellName) != emptyStdCells.end() ? true : false;
};

// In LibBlackbox.v, all stdcells is empty, we regard them as black boxes.
// But in stdcells.json file, only a few of them is empty(For example, "PLL"),
// we need to find them to regard them as black boxes, too.
void HierNetlistVisitor::swapEmptyAndNotEmptyStdCellPosition()
{
  _totalUsedNotEmptyStdCells = _totalUsedStdCells;
  std::string notEmptyStdCellName, emptyStdCellName;
  uint32_t notEmptyStdCellIndex, emptyStdCellIndex;
  for(auto i = 0; i < _totalUsedNotEmptyStdCells; i++)
  {
    if(isAnEmptyStdCellInJson(_hierNetlist[i].moduleDefName))
    {
      _totalUsedNotEmptyStdCells--;
      emptyStdCellName = _hierNetlist[i].moduleDefName;
      emptyStdCellIndex = i;
      while(isAnEmptyStdCellInJson(
        _hierNetlist[_totalUsedNotEmptyStdCells].moduleDefName))
      {
        if(_totalUsedNotEmptyStdCells > i)
          _totalUsedNotEmptyStdCells--;
        else
          return;
      }
      notEmptyStdCellIndex = _totalUsedNotEmptyStdCells;
      notEmptyStdCellName =
        _hierNetlist[_totalUsedNotEmptyStdCells].moduleDefName;
      _moduleNameMapIndex.erase(emptyStdCellName);
      _moduleNameMapIndex.erase(notEmptyStdCellName);
      _moduleNameMapIndex[emptyStdCellName] = notEmptyStdCellIndex;
      _moduleNameMapIndex[notEmptyStdCellName] = emptyStdCellIndex;
      std::swap(_hierNetlist[emptyStdCellIndex],
                _hierNetlist[notEmptyStdCellIndex]);
      std::swap(_portNameMapPortDefIndexs[emptyStdCellIndex],
                _portNameMapPortDefIndexs[notEmptyStdCellIndex]);
    }
  }
};
