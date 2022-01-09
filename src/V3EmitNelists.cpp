#include "V3EmitNelists.h"

#include <cstdlib>
#include <iostream>
#include <exception>

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
    static std::unordered_map<std::string, uint32_t> _map
        = {{"h0", 0},  {"h1", 1},  {"h2", 2},  {"h3", 3}, {"h4", 4},  {"h5", 5},
           {"h6", 6},  {"h7", 7},  {"h8", 8},  {"h9", 9}, {"ha", 10}, {"hb", 11},
           {"hc", 12}, {"hd", 13}, {"he", 14}, {"hf", 15}};
    // 例子 ： "8'h0" -> "h0"
    // 为什么 : 因为前面的8不是固定的，例如 "32'h0"
    std::string tmp = indexStr.substr(indexStr.size() - 2, 2);
    return _map[tmp];
}

/** @brief 层次化网表访问者 */
class HierCellsNetListsVisitor final : public AstNVisitor {
private:
    std::string _curMouldeInstanceParentName;                 // 当前模块实例父亲的名称
    std::string _curMouldeInstanceName;                       // 当前模块实例的名称

    bool _isAssignLvalue = true;                              // 当前处理的是否是 assign 语句的左值
    bool _isAssignStatement = false;                          // 当前是否是 assign 语句 
    AssignStatementMsg _assignStatementMsgTmp;                // assign语句信息临时变量

    PortInstanceMsg _portInstanceMsgTmp;                      // 端口实例信息临时变量
    PortInstanceFormalMsg _portInstanceFormalTmp;             // 端口实例形参信息
                                                              // (此成员是为了能够方便插入引脚信息)

    std::vector<PortInstanceMsg> _curMoudlePortInstanceMsg;   // 当前模块的引脚实例信息
    std::unordered_map<std::string, MoudleMsg> _moudleMap;

private:
    virtual void visit(AstNode* nodep) override { iterateChildren(nodep); }

    virtual void visit(AstModule* nodep) override;
    virtual void visit(AstVar* nodep) override;
    virtual void visit(AstVarRef* nodep) override;
    virtual void visit(AstCell* nodep) override;
    virtual void visit(AstConcat* nodep) override;
    virtual void visit(AstPin* nodep) override;
    virtual void visit(AstNodeAssign* nodep) override;
    virtual void visit(AstConst* nodep) override;
    virtual void visit(AstSel* nodep) override;

public:
    HierCellsNetListsVisitor(AstNetlist* nodep) { nodep->accept(*this); }
    virtual ~HierCellsNetListsVisitor() override {
        std::cout << "HierCellsXmlVisitor 析构" << std::endl;
    };
};

/**
 * @brief moudle 语句的入口
 */
void HierCellsNetListsVisitor::visit(AstModule* nodep)
{
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

void HierCellsNetListsVisitor::visit(AstVar* nodep) {
    PortMsg portMsg;
    portMsg.portDefName = nodep->origName();

    if (nodep->isIO()) {
        switch (nodep->direction()) {
        case VDirection::INPUT: portMsg.portType = PortType::INPUT; break;
        case VDirection::OUTPUT: portMsg.portType = PortType::OUTPUT; break;
        case VDirection::INOUT: portMsg.portType = PortType::INOUT; break;
        default:
            throw std::runtime_error("only support input，output and inout, other like ref or "
                                     "constref aren't not support!!!");
            break;
        }
    } else {
        portMsg.portType = PortType::WIRE;
    }

    if (nodep->basicp() && nodep->basicp()->width() != 1) {
        portMsg.isArray = true;
        portMsg.arraySize = nodep->basicp()->width();
    }

    switch (portMsg.portType) {
    case PortType::INPUT:
        _moudleMap[_curMouldeInstanceParentName].inputs.push_back(std::move(portMsg));
        break;
    case PortType::OUTPUT:
        _moudleMap[_curMouldeInstanceParentName].outputs.push_back(std::move(portMsg));
        break;
    case PortType::INOUT:
        _moudleMap[_curMouldeInstanceParentName].inouts.push_back(std::move(portMsg));
        break;
    case PortType::WIRE:
        _moudleMap[_curMouldeInstanceParentName].wires.push_back(std::move(portMsg));

        break;
    default: break;
    }

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
     */
    MemoMaker<std::string> memoMaker1(_curMouldeInstanceParentName);
    MemoMaker<std::string> memoMaker2(_curMouldeInstanceName);
    MemoMaker<PortInstanceFormalMsg> memoMaker3(_portInstanceFormalTmp);

    std::string moduleDefName = nodep->modName();
    std::string moudleInstanceName = nodep->origName();

    insertSubmouldeInstance(_curMouldeInstanceParentName, moduleDefName, moudleInstanceName);

    MoudleMsg moudleInstanceMsg;
    moudleInstanceMsg.moduleDefName = moduleDefName;
    moudleInstanceMsg.level = nodep->modp()->level();
    _moudleMap[moduleDefName] = std::move(moudleInstanceMsg);

    _curMouldeInstanceParentName = _curMouldeInstanceName;
    _curMouldeInstanceName = moudleInstanceName;

    iterateChildren(nodep);
}

void HierCellsNetListsVisitor::visit(AstPin* nodep) {
    // 引脚实例 tmp 自动恢复默认值
    MemoMaker<PortInstanceMsg> memoMaker1(_portInstanceMsgTmp);
    MemoMaker<PortInstanceFormalMsg> memoMaker2(_portInstanceFormalTmp);
    _portInstanceMsgTmp.portDefName = nodep->prettyName();
    iterateChildren(nodep);
    // 插入当前模块实例的一个端口信息
    _moudleMap[_curMouldeInstanceParentName].subMoudlePorts[_curMouldeInstanceName].push_back(
        _portInstanceMsgTmp);
}

/**
 * @note 进入此引脚的实例参数不止一个，目前这里不需要做任何处理
 * @sa   PortInstanceMsg
 */
void HierCellsNetListsVisitor::visit(AstConcat* nodep) {
    // 手动还原 _portInstanceFormalTmp.portInstanceName 默认值
    _portInstanceFormalTmp.portInstanceName = "anonymous";
    iterateChildren(nodep);
}

/**
 * @note 当 _portInstanceFormalTmp.portInstanceName == "anonymous", 说明是匿名赋值
 */
void HierCellsNetListsVisitor::visit(AstConst* nodep) {
    // isFirst == true 代表操作 first，反之操作 second
    static bool isFirst = true;

    /**
     * @brief     获取 len
     * @param[in] indexStr : nodep->prettyName() , nodep is AstConst
     * @return    常量值的位宽
     * @note      参见其具体用法
     */
    auto getLen = [](const std::string& indexStr) -> uint32_t {
        uint32_t res = 0;
        size_t pos = indexStr.find("'");
        std::string tmp = indexStr.substr(0, pos);
        res = std::atoi(tmp.c_str());
        return res;
    };


    if (_isAssignStatement){
        if(_isAssignLvalue){
            if(_assignStatementMsgTmp.lValue.isArray == false && _assignStatementMsgTmp.lValue.portInstanceName == "anonymous"){
                _assignStatementMsgTmp.lValue.indexRange.first = IndexStrToIndexNum(nodep->prettyName());
                _assignStatementMsgTmp.lValue.indexRange.second = getLen(nodep->prettyName());
                _isAssignLvalue = !_isAssignLvalue;
            }else{
                if(isFirst){
                    isFirst = !isFirst;
                    _assignStatementMsgTmp.lValue.indexRange.first = IndexStrToIndexNum(nodep->prettyName());
                }else{
                    isFirst = !isFirst;
                    _assignStatementMsgTmp.lValue.indexRange.second = IndexStrToIndexNum(nodep->prettyName());
                    _isAssignLvalue = !_isAssignLvalue;
                }
            }
        }else{
             if(_assignStatementMsgTmp.rValue.isArray == false && _assignStatementMsgTmp.rValue.portInstanceName == "anonymous"){
                _assignStatementMsgTmp.rValue.indexRange.first = IndexStrToIndexNum(nodep->prettyName());
                _assignStatementMsgTmp.rValue.indexRange.second = getLen(nodep->prettyName());
                _isAssignLvalue = !_isAssignLvalue;
            }else{
                if(isFirst){
                    isFirst = !isFirst;
                    _assignStatementMsgTmp.lValue.indexRange.first = IndexStrToIndexNum(nodep->prettyName());
                }else{
                    isFirst = !isFirst;
                    _assignStatementMsgTmp.rValue.indexRange.second = IndexStrToIndexNum(nodep->prettyName());
                    _isAssignLvalue = !_isAssignLvalue;
                }
            }           
        }
    }else{
        // 匿名赋值到这里就已经结束了，手动压入端口实例形参信息临时变量
        if (_portInstanceFormalTmp.portInstanceName == "anonymous") {
            // 引脚实例 tmp 自动恢复默认值
            MemoMaker<PortInstanceFormalMsg> memoMaker(_portInstanceFormalTmp);
            uint32_t len = getLen(nodep->prettyName());
            _portInstanceFormalTmp.indexRange.first = IndexStrToIndexNum(nodep->prettyName());
            for (uint32_t i = 0; i < len; i++) {
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
}

/**
 * @note 进入此函数说明当前引脚实例的类型为 array
 */
void HierCellsNetListsVisitor::visit(AstSel* nodep) {
    MemoMaker<PortInstanceFormalMsg> memoMaker(_portInstanceFormalTmp);

    if(_isAssignStatement){
        if(_isAssignLvalue){
            _assignStatementMsgTmp.lValue.isArray = true;
        }else{
            _assignStatementMsgTmp.rValue.isArray = true;
        }
    }else{
        _portInstanceFormalTmp.isArray = true;
        _portInstanceMsgTmp.portInstanceFormalMsgs.push_back(_portInstanceFormalTmp);
    }
    iterateChildren(nodep);
}

/**
 * @note 进入此函数说明当前处理的是 assign 语句
 */
void HierCellsNetListsVisitor::visit(AstNodeAssign* nodep) 
{
    MemoMaker<bool> memoMaker1(_isAssignStatement);
    MemoMaker<AssignStatementMsg> memoMaker2(_assignStatementMsgTmp); 
    MemoMaker<bool> memoMaker3(_isAssignLvalue);
    _isAssignStatement = true;
    iterateChildren(nodep);
    _moudleMap[_curMouldeInstanceParentName].assigns.push_back(_assignStatementMsgTmp);    
}

void HierCellsNetListsVisitor::visit(AstVarRef* nodep) {
    // isFirst == true 代表操作 first，反之操作 second
    static bool isFirst = true;  

    if(_isAssignStatement){
        if(_isAssignLvalue){
            _assignStatementMsgTmp.lValue.portInstanceName = nodep->prettyName();
            if(_assignStatementMsgTmp.lValue.isArray == false){
                _isAssignLvalue = !_isAssignLvalue;
            }
        }else{
            _assignStatementMsgTmp.rValue.portInstanceName = nodep->prettyName();
            if(_assignStatementMsgTmp.rValue.isArray == false){
                _isAssignLvalue = !_isAssignLvalue;
            }
        }
    }else{
        _portInstanceFormalTmp.portInstanceName = nodep->prettyName();
    }
    iterateChildren(nodep);
    if (_isAssignStatement){
        // nothing
        ;
    }else{
        if (_portInstanceFormalTmp.isArray == false) {
            _portInstanceMsgTmp.portInstanceFormalMsgs.push_back(_portInstanceFormalTmp);
        }        
    }
}

void V3EmitNetLists::emitNetLists() {
    HierCellsNetListsVisitor hierCellsNetListsVisitor(v3Global.rootp());
}
