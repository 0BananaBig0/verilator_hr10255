/*************************************************************************
  > File Name: Netlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Sat 23 Apr 2022 05:20:27 PM CST
 ************************************************************************/

#pragma once
#include "MultipleBitsNetlist.h"
#include "OneBitHierNetlist.h"

class EmitHierNetlist final
{
  public:
    static void emitHierNetlists(std::vector<Module> &hierNetlist,
                                 uint32_t &theNumberOfStdCellsShouldUse,
                                 uint32_t &theNumberOfBlackBoxes);
    static void printHierNetlist(const std::vector<Module> &hierNetlist,
                                 const uint32_t &theNumberOfStdCellsShouldUse,
                                 const uint32_t &theNumberOfBlackBoxes,
                                 const std::string fileName = "HierNetlist.v",
                                 const uint32_t hierMaxLevel = UINT32_MAX);
    static void emitFlattenedNetlists(std::vector<Module> &hierNetlist,
                                      std::vector<Module> &flatNetlist,
                                      uint32_t &theNumberOfBlackBoxes);
};
