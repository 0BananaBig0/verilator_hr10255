#include "netlistsdefine.h"

#include <exception>
namespace OneBitNetlist
{
uint32_t Module::inNum(bool onlyIn) const
{
  return onlyIn ? inputs.size() : inputs.size() + inouts.size();
}

uint32_t Module::outNum(bool onlyOut) const
{
  return onlyOut ? outputs.size() : outputs.size() + inouts.size();
}

uint32_t Module::inoutNum() const { return inouts.size(); }

uint32_t Module::wireNum() const { return wires.size(); }
}
