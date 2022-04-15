/*************************************************************************
  > File Name: netlistsdefineNew.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Wed 13 Apr 2022 08:21:18 AM CST
 ************************************************************************/
#include "netlistsdefineNew.h"

#include <exception>

namespace MultipleBitsNetlist
{
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
}
