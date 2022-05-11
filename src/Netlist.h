/*************************************************************************
  > File Name: Netlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Sat 23 Apr 2022 05:20:27 PM CST
 ************************************************************************/

#pragma once
#include "MultipleBitsNetlist.h"
#include "OneBitHierNetlist.h"

class ProcessNetlist final
{
  public:
    // Get a hierarchical netlist from ast
    static void getHierNet(std::vector<Module> &hierNetlist,
                           uint32_t &totalUsedStdCells,
                           uint32_t &totalUsedBlackBoxes);
    // Print a Netlist
    static void printNetlist(const std::vector<Module> &hierNetlist,
                             const uint32_t &totalUsedStdCells,
                             const uint32_t &totalUsedBlackBoxes,
                             const std::string fileName = "HierNetlist.v",
                             const uint32_t maxHierLevel = UINT32_MAX);
    // Flatten Hierarchical netlist
    static void flattenHierNet(std::vector<Module> &hierNetlist,
                               std::vector<Module> &flatNetlist,
                               uint32_t &totalUsedBlackBoxes);
};
