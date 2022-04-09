# Function call chain of hierarchical netlist
```
HierCellsNetListsVisitor hierCellsNetListsVisitor(v3Global.rootp())[AstNetlist* v3Global.rootp()]
=>HierCellsNetListsVisitor(AstNetlist *nodep) { nodep->accept(*this); }[*this = HierCellsNetListsVisitor]
=>virtual void accept(AstNVisitor &v) override { v.visit(this); }[this = &AstNetlist]
=>virtual void visit(AstNode *nodep) override { iterateChildren(nodep); }[*this = HierCellsNetListsVisitor as AstNVisitor&]
=>inline void AstNVisitor::iterateChildren(AstNode *nodep) { nodep->iterateChildren(*this); }[*this = HierCellsNetListsVisitor as AstNVisitor&]
=>void AstNode::iterateChildren(AstNVisitor &v){if (m_opxp)[1<=x<=4] m_opxp->iterateAndNext(v);}[this = &AstNetlist as &AstNode]
=>void AstNode::iterateAndNext(AstNVisitor &v)[this = &AstModule as &AstNode]
=>virtual void AstNode::accept(AstNVisitor &v) = 0;[this = &AstModule as &AstNode]
=>void HierCellsNetListsVisitor::visit(AstModule *nodep)[*this = HierCellsNetListsVisitor as AstNVisitor&]
```
Key points: If we want to access into AstNode, we should transform AstNVisitor to it. \
            If we want to access into AstNvisitor, we should transform AstNode to it.
