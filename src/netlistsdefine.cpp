#include "netlistsdefine.h"

#include <exception>

uint32_t ModuleMsg::inNum(bool onlyIn) const
{
  return onlyIn ? inputs.size() : inputs.size() + inouts.size();
}

uint32_t ModuleMsg::outNum(bool onlyOut) const
{
  return onlyOut ? outputs.size() : outputs.size() + inouts.size();
}

uint32_t ModuleMsg::inoutNum() const { return inouts.size(); }

uint32_t ModuleMsg::wireNum() const { return wires.size(); }
