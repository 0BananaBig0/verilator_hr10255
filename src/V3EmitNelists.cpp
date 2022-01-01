#include "V3EmitNelists.h"

#include <cstdlib>
#include <iostream>
#include <unordered_map>


#include "V3Error.h"
#include "V3Ast.h"

/** @brief 简易版备忘录 */
template <typename T> class MemoMaker {
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

static uint32_t IndexStrToIndexNum(const std::string& indexStr) {
    static std::unordered_map<std::string, uint32_t> _map = {
        {"h0", 0},  {"h1", 1},  {"h2", 2},  {"h3", 3},  {"h4", 4},  {"h5", 5},
        {"h6", 6},  {"h7", 7},  {"h8", 8},  {"h9", 9},  {"ha", 10}, {"hb", 11},
        {"hc", 12}, {"hd", 13}, {"he", 14}, {"hf", 15}
    };
    // 例子 ： "8'h0" -> "h0"
    // 为什么 : 因为前面的8不是固定的，例如 "32'h0"
    std::string tmp = indexStr.substr(indexStr.size()-2, 2);
    return _map[tmp];
}

/** @brief 层次化网表访问者 */
class HierCellsNetListsVisitor final : public AstNVisitor {
private:
    std::string _curMouldeInstanceParentName;  // 当前模块实例父亲的名称
    std::string _curMouldeInstanceName;  // 当前模块实例的名称
    PortInstanceMsg _portInstanceMsgTmp;  // 端口实例信息临时变量
    PortInstanceFormalMsg _portInstanceFormalTmp;  // 端口实例形参信息
                                                   // (此成员是为了能够方便插入引脚信息
                                                   // MoudleMsg::subMoudlePorts)
    std::vector<PortInstanceMsg> _curMoudlePortInstanceMsg;  // 当前模块的引脚实例信息
    std::unordered_map<std::string, MoudleMsg> _moudleMap;

private:
    virtual void visit(AstNode* nodep) override { iterateChildren(nodep); }

    virtual void visit(AstNodeModule* nodep) override;
    virtual void visit(AstCell* nodep) override;
    virtual void visit(AstConcat* nodep) override;
    virtual void visit(AstPin* nodep) override;
    virtual void visit(AstVarRef* nodep) override;
    virtual void visit(AstConst* nodep) override;
    virtual void visit(AstSel* nodep) override;

public:
    HierCellsNetListsVisitor(AstNetlist* nodep) { nodep->accept(*this); }
    virtual ~HierCellsNetListsVisitor() override {
        std::cout << "HierCellsXmlVisitor 析构" << std::endl;
    };
};

void HierCellsNetListsVisitor::visit(AstNodeModule* nodep) {
    /** @brief 是否是顶级模块
     *  @note  保留，未使用
     */
    auto isTopMoudle = [nodep]() -> bool {
        bool res = false;
        if (nodep->level() >= 0 && nodep->level() <= 2) { res = true; }
        return res;
    };

    // 此处的含义并不是同 AstCell 中的一样的，只是为了保持一致而已
    MoudleMsg moudleInstanceMsg;
    std::string moduleDefName = nodep->prettyName();
    moudleInstanceMsg.moduleDefName = moduleDefName;
    moudleInstanceMsg.level = nodep->level();
    _curMouldeInstanceParentName = moduleDefName;
    _curMouldeInstanceName = moduleDefName;
    _moudleMap[moduleDefName] = std::move(moudleInstanceMsg);

    iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstCell* nodep) {
    /** @brief 向 MoudleMsg 塞入一个子模块
     *  @sa    MoudleMsg
     */
    auto insertSubmouldeInstance
        = [this, nodep](const std::string& parentMoudleName, const std::string& moduleDefName,
                        const std::string& moudleInstanceName) -> void {
        MoudleMsg& parentMoudleInstanceMsg = _moudleMap[_curMouldeInstanceParentName];
        parentMoudleInstanceMsg.subMoudleInstanceNames.push_back(moudleInstanceName);
        parentMoudleInstanceMsg.mouldeDefInstanceMap[moudleInstanceName] = moduleDefName;
    };

    if (nodep->modp()->dead()) return;
    /**
     * @brief 由于编译抽象语法树是递归逻辑，所以可以利用递归的特性，
     * 利用备忘者模式，使得每个子模块都能知道其对应的父亲
    MemoMaker<std::string> memoMaker1(_curMouldeInstanceParentName);
    std::string moduleDefName = nodep->modName();
    std::string moudleInstanceName = nodep->origName();

    insertSubmouldeInstance(_curMouldeInstanceParentName, moduleDefName, moudleInstanceName);

    MoudleMsg moudleInstanceMsg;
    moudleInstanceMsg.moduleDefName = moduleDefName;
    moudleInstanceMsg.level = nodep->modp()->level();
    _moudleMap[moduleDefName] = std::move(moudleInstanceMsg);
 * @note 1 - 当 _portInstanceFormalTmp.portInstanceName == "anonymous", 说明是匿名赋值
    static bool isFirst = true;

    /**
     * @brief     获取循环次数
     * @param[in] indexStr : nodep->prettyName() , nodep is AstConst
     * @return    循环次数
     * @note      参见其具体用法
     */
    auto getLoopTime = [](const std::string& indexStr) -> uint32_t {
        uint32_t res = 0;
        size_t pos = indexStr.find("'");
        std::string tmp = indexStr.substr(0, pos);
        res = std::atoi(tmp.c_str());
        return res;
    };

    // 匿名赋值到这里就已经结束了，手动压入端口实例形参信息临时变量
    if (_portInstanceFormalTmp.portInstanceName == "anonymous") {
        // 引脚实例 tmp 自动恢复默认值
        MemoMaker<PortInstanceFormalMsg> memoMaker(_portInstanceFormalTmp);
        uint32_t loopTime = getLoopTime(nodep->prettyName());
        _portInstanceFormalTmp.indexRange.first = IndexStrToIndexNum(nodep->prettyName());
        for (uint32_t i = 0; i < loopTime; i++) {
            _portInstanceMsgTmp.portInstanceFormalMsgs.push_back(_portInstanceFormalTmp);
        }
    } else {
        if (isFirst) {
            isFirst = !isFirst;
            _portInstanceFormalTmp.indexRange.first = IndexStrToIndexNum(nodep->prettyName());
        } else {
            isFirst = !isFirst;
            _portInstanceFormalTmp.indexRange.second = IndexStrToIndexNum(nodep->prettyName());
        }
    }
}

/**
 * @note 进入此函数说明当前引脚实例的类型为 array
 */
void HierCellsNetListsVisitor::visit(AstSel* nodep) {
    MemoMaker<PortInstanceFormalMsg> memoMaker(_portInstanceFormalTmp);
    _portInstanceFormalTmp.isArray = true;
    iterateChildren(nodep);
    _portInstanceMsgTmp.portInstanceFormalMsgs.push_back(_portInstanceFormalTmp);
}

void HierCellsNetListsVisitor::visit(AstVarRef* nodep) {
    _portInstanceFormalTmp.portInstanceName = nodep->prettyName();
    iterateChildren(nodep);
    if(_portInstanceFormalTmp.isArray == false){
        _portInstanceMsgTmp.portInstanceFormalMsgs.push_back(_portInstanceFormalTmp);
    }
=======
    // _curParentMoudleInstanceMsg = _moudleMap[_curParentName];
    _curParentName = moduleDefName;

    iterateChildren(nodep);
>>>>>>> master
}

void V3EmitNetLists::emitNetLists() {
    HierCellsNetListsVisitor hierCellsNetListsVisitor(v3Global.rootp());
}
