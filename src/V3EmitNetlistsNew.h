/*************************************************************************
  > File Name: V3EmitNetlistsNew.h
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Wed 13 Apr 2022 08:16:46 AM CST
 ************************************************************************/
#pragma once

#include "netlistsdefineNew.h"

namespace MultipleBitsNetlist
{
class V3EmitHierNetLists final
{
  public:
    static void emitHierNetLists(
      std::unordered_map<std::string, ModuleMsg> &hierCellsNetLists);
    static void multipleBitsToOneBit(
      std::unordered_map<std::string, MultipleBitsNetlist::ModuleMsg>
        &multipleBitsHierCellsNetLists,
      std::unordered_map<std::string, OneBitNetlist::ModuleMsg>
        &oneBitHierCellsNetLists);
    // static void printHireNetLists(
    //   std::unordered_map<std::string, ModuleMsg> &hierCellsNetLists,
    //   std::string filename);
};

// class V3EmitPlainNetLists final
// {
//   public:
//     static void emitPlainNetLists(
//       std::unordered_map<std::string, ModuleMsg> &hierCellsNetLists,
//       std::unordered_map<std::string, ModuleMsg> &plainCellsNetLists);
//     static void printPlainNetLists(
//       std::unordered_map<std::string, ModuleMsg> &hierCellsNetLists,
//       std::string filename)
//     {
//       V3EmitHierNetLists::printHireNetLists(hierCellsNetLists, filename);
//     }
// };
}
