/*************************************************************************
  > File Name: Netlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Sat 23 Apr 2022 05:20:27 PM CST
 ************************************************************************/

#pragma once
#include "MultipleBitsNetlist.h"
#include "OneBitNetlist.h"
class EmitHierNetList final
{
  public:
    static void emitHierNetLists(std::vector<Module> &hierNetList);
    static void
    printHierNetlist(const std::vector<Module> &hierNetList);
};
