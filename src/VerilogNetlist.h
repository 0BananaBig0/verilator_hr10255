/*************************************************************************
  > File Name: VerilogNetlist.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Sat 23 Apr 2022 05:20:27 PM CST
 ************************************************************************/

#pragma once
#include "OneBitHierNetlist.h"
#include <cstdint>

class VerilogNetlist final
{
  private:
    // emptyStdCellsInjson : like PLL, which is empty in stdcells.json
    uint32_t _totalUsedNotEmptyStdCells;
    // stdCells : all written into LibBlackbox.v or stdcells.json
    uint32_t _totalUsedStdCells;
    // blackBoxes : including all stdCells and some empty module which
    // are written by hardware designer.
    uint32_t _totalUsedBlackBoxes;
    // notEmptyInstance : all stdCells Instances whose definition are
    // not empty in stdcells.json
    uint32_t _totalUsedNotEmptyInsInOneMod;
    std::vector<Module> _hierNetlist;
    std::vector<Module> _flatNetlist;
    std::unordered_map<std::string, uint32_t> _moduleNameMapIndex;

  public:
    const std::vector<Module> &hierNet() const { return _hierNetlist; };
    const std::vector<Module> &flatNet() const { return _flatNetlist; };
    const uint32_t &totalUsedStdCells() const { return _totalUsedStdCells; };
    const uint32_t &totalUsedNotEmptyStdCells()
    {
      return _totalUsedNotEmptyStdCells;
    };
    const uint32_t &totalUsedBlackBoxes() const
    {
      return _totalUsedBlackBoxes;
    };
    const std::unordered_map<std::string, uint32_t> &moduleNameMapIndex() const
    {
      return _moduleNameMapIndex;
    }
    void callFlattenHierNet()
    {
      flattenHierNet(_hierNetlist, _flatNetlist, _totalUsedBlackBoxes);
    };
    void printHierNet()
    {
      printNetlist(_hierNetlist, _totalUsedStdCells, _totalUsedBlackBoxes);
    };
    void printFlatNet()
    {
      printNetlist(_flatNetlist, _totalUsedStdCells, _totalUsedBlackBoxes,
                   "FlatNetlist.v",
                   _hierNetlist[_totalUsedBlackBoxes].level());
    };
    // Get a hierarchical netlist from ast
    void genHierNet(std::unordered_set<std::string> emptyStdCellsInJson = {
                      "MemGen_16_10", "PLL" });
    // Print a Netlist
    void printNetlist(const std::vector<Module> &hierNetlist,
                      const uint32_t &totalUsedStdCells,
                      const uint32_t &totalUsedBlackBoxes,
                      std::string fileName = "HierNetlist.v",
                      const uint32_t maxHierLevel = UINT32_MAX);
    // Flatten Hierarchical netlist
    void flattenHierNet(const std::vector<Module> &hierNetlist,
                        std::vector<Module> &flatNetlist,
                        const uint32_t &totalUsedBlackBoxes);
    void sortInsOrderInOneModule(const uint32_t &moduleIndex);
    void parseHierNet(int argc, char **argv, char **env);
};
