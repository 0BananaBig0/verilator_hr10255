#include "V3EmitNelists.h"

#include <iostream>
#include <unordered_map>

#include "V3Error.h"
#include "V3Ast.h"

/** @brief 简易版备忘录 */
template <typename T>
class MemoMaker {
    T& _ref;
    const T _saved;
public:
    explicit MemoMaker(T& data)
        : _ref{data}
        , _saved{data} {}
    ~MemoMaker() { _ref = _saved; }
    MemoMaker(const MemoMaker& other) = delete;
    MemoMaker& operator=(const MemoMaker&) = delete;
};

/** @brief 层次化网表访问者 */
class HierCellsNetListsVisitor final : public AstNVisitor {
private:
    std::string  _cunParentName; 
    std::unordered_map<std::string, MoudleInstanceMsg> _moudleMap;
private:
    virtual void visit(AstNode* nodep) override { iterateChildren(nodep); }
    
    virtual void visit(AstNodeModule* nodep) override;
    virtual void visit(AstCell* nodep) override;

public:
    HierCellsNetListsVisitor(AstNetlist* nodep){
        nodep->accept(*this);
    }
    virtual ~HierCellsNetListsVisitor() override {
        std::cout << "HierCellsXmlVisitor 析构" << std::endl;
    };
};

void HierCellsNetListsVisitor::visit(AstNodeModule* nodep) {
    /** @brief 是否是顶级模块 */
    auto isTopMoudle =
    [nodep]() -> bool
    {
        bool res = false;
        if(nodep->level() >= 0 && nodep->level() <= 2){
            res = true;
        }
        return res;
    };

    if(isTopMoudle()){
        MoudleInstanceMsg moudleInstanceMsg;
        std::string moduleDefName = nodep->prettyName();        
        moudleInstanceMsg.moduleDefName = moduleDefName;
        moudleInstanceMsg.level = nodep->level();
        _moudleMap[moduleDefName] = std::move(moudleInstanceMsg);

        _cunParentName = moduleDefName;
        iterateChildren(nodep);
    }      
}

void HierCellsNetListsVisitor::visit(AstCell* nodep) {
    /** @brief 向 MoudleInstanceMsg 塞入一个子模块
     *  @sa    MoudleInstanceMsg
     */
    auto insertSubmouldeInstance = 
    [this, nodep](const std::string& parentMoudleName,
           const std::string& moduleDefName,
           const std::string& moudleInstanceName) -> void
    {
        MoudleInstanceMsg& parentMoudleInstanceMsg = _moudleMap[_cunParentName];
        parentMoudleInstanceMsg.subMoudleInstanceNames.push_back(moudleInstanceName);
        parentMoudleInstanceMsg.mouldeDefInstanceMap[moudleInstanceName] = moduleDefName;
    };

    if (nodep->modp()->dead()) return; 
    /**
     * @brief 由于编译抽象语法树是递归逻辑，所以可以利用递归的特性，
     * 利用备忘者模式，使得每个子模块都能知道其对应的父亲
     */
    MemoMaker<std::string> memoMaker(_cunParentName);
    std::string moduleDefName = nodep->modName();
    std::string moudleInstanceName = nodep->prettyName();

    insertSubmouldeInstance(_cunParentName, moduleDefName, moudleInstanceName);

    MoudleInstanceMsg moudleInstanceMsg;      
    moudleInstanceMsg.moduleDefName = moduleDefName;
    moudleInstanceMsg.level = nodep->modp()->level();
    _moudleMap[moduleDefName] = std::move(moudleInstanceMsg);

    _cunParentName = moduleDefName;
    iterateChildren(nodep);
} 

void V3EmitNetLists::emitNetLists(){
    HierCellsNetListsVisitor hierCellsNetListsVisitor(v3Global.rootp());
}