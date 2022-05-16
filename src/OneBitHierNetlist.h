/*************************************************************************
  > File Name: OneBitHierNetlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Sun 01 May 2022 04:38:29 PM CST
 ************************************************************************/
#pragma once
#include "MultipleBitsNetlist.h"
#include "OneBitNetlist.h"
#include "V3Ast.h"
#include "V3Error.h"
#include <cstdint>
#include <unordered_map>

// When writing visit functions, there are some keys we should know:
// (1)Everytime we only write either AstNodeAssign or AstPin information
// until all its information have been obtained.
// (2)Only AstVarRef or AstSel can be lValue of assign statement.
// (3)AstConst, AstExtend and AstConcat can't be lValue of assign statement.
// (4)Know about the difference between m_nextp and m_opxp, some information
// about them I have written before the declaration of visit function.
// (5)We are only allowed to writ one AstVarRef information at the same time.
// (6)Only such AstNode that has children pointed by m_opxp and we need the
// information of its children can call iterateChildren(nodep) function.
struct PortNameMapPortDefIndex
{
    std::unordered_map<std::string, uint32_t> ports;
};
class HierNetlistVisitor final : public VNVisitor
{
  private:
    // AstNetlist
    std::vector<Module> _hierNetlist;
    uint32_t _theTimesOfVisit;
    uint32_t _totalUsedNotEmptyStdCells;

    // A module = ItsName + Port  + Wire + Assign staement + Submodule Instance
    // AstModule
    uint32_t _totalUsedStdCells;
    std::unordered_map<std::string, uint32_t> _moduleNameMapIndex;
    uint32_t _curModuleIndex;
    uint32_t _totalUsedBlackBoxes;
    std::unordered_set<std::string> _blackBoxesNameExcludingStdCells;
    bool _isABlackBoxButNotAStdCell;

    // AstVar
    std::vector<PortNameMapPortDefIndex> _portNameMapPortDefIndexs;
    PortNameMapPortDefIndex _portNameMapPortDefIndex;
    uint32_t _curPortDefIndex;
    // 1: visit input, 2: visit inout, 3: visit output, 4: visit inout
    uint32_t _theTimesOfVisitAstVar;

    // AstCell
    std::string _curSubmoduleName;
    std::string _curSubmoduleInstanceName;
    uint32_t _curSubmoduleInstanceIndex;

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
    MultipleBitsRefVar _multipleBitsRefVarTmp;

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
    virtual void visit(AstNode *nodep) override;

    virtual void visit(AstNetlist *nodep) override;
    virtual void visit(AstModule *nodep) override;
    virtual void visit(AstVar *nodep) override;
    virtual void visit(AstNodeAssign *nodep) override;
    virtual void visit(AstCell *nodep) override;
    virtual void visit(AstPin *nodep) override;
    virtual void visit(AstConcat *nodep) override;
    virtual void visit(AstSel *nodep) override;
    virtual void visit(AstVarRef *nodep) override;
    virtual void visit(AstExtend *nodep) override;
    virtual void visit(AstExtendS *nodep) override;
    virtual void visit(AstReplicate *nodep) override;
    virtual void visit(AstConst *nodep) override;
    // Prevent idling iteration
    virtual void visit(AstTypeTable *nodep) override { return; }
    virtual void visit(AstConstPool *nodep) override { return; }

    // reuse some codes.
    char getOneBitValueFromDecimalNumber(uint32_t &value, uint32_t &valueX,
                                         uint32_t &position, bool &hasX) const;

    // Clear data and free ram
    template<typename T>
    void freeContainerBySwap(T &rContainer);

    // Make empty std cells at the end of all std cells in _hierNetlist
    bool isAnEmptyStdCellInJson(const std::string &stdCellName);
    void swapEmptyAndNotEmptyStdCellPosition();

  public:
    const std::vector<Module> &getHierNetlist() const { return _hierNetlist; };
    const uint32_t &getTotalUsedNotEmptyStdCells() const
    {
      return _totalUsedNotEmptyStdCells;
    };
    const uint32_t &getTotalUsedStdCells() const
    {
      return _totalUsedStdCells;
    };
    const uint32_t &getTotalUsedBlackBoxes() const
    {
      return _totalUsedBlackBoxes;
    };

  public:
    // AstNetlist is the root of HierNetlist
    HierNetlistVisitor(AstNetlist *nodep) { nodep->accept(*this); }
    virtual ~HierNetlistVisitor() override{};
};
