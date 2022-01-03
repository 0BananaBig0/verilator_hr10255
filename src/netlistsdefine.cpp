#include "netlistsdefine.h"

#include <exception>

std::vector<int> PortInstanceFormalMsg::getIndexs() {
    if (!isArray) {
        throw std::runtime_error(
            "PortInstanceFormalMsg::getIndexs() should be involed by array type");
    }
    std::vector<int> res;
    if (indexRange.first >= indexRange.second) {
        res.push_back(indexRange.first);
    } else {
        for (int i = indexRange.first; i < indexRange.second; i++) { res.push_back(i); }
    }

    return res;
}

uint32_t MoudleMsg::inNum(bool onlyIn) const
{
    return onlyIn ? inputs.size() : inputs.size() + inouts.size();
}

uint32_t MoudleMsg::outNum(bool onlyOut) const
{
    return onlyOut ? outputs.size() : outputs.size() + inouts.size();
}

uint32_t MoudleMsg::inoutNum() const
{
    return inouts.size();
}

uint32_t MoudleMsg::wireNum() const
{
    return wires.size();
}