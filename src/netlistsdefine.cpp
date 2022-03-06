#include "netlistsdefine.h"

#include <exception>

uint32_t MoudleMsg::inNum(bool onlyIn) const {
  return onlyIn ? inputs.size() : inputs.size() + inouts.size();
}

uint32_t MoudleMsg::outNum(bool onlyOut) const {
  return onlyOut ? outputs.size() : outputs.size() + inouts.size();
}

uint32_t MoudleMsg::inoutNum() const { return inouts.size(); }

uint32_t MoudleMsg::wireNum() const { return wires.size(); }