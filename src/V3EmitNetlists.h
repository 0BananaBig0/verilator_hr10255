#pragma once

#include "netlistsdefine.h"

namespace OneBitNetlist
{
class V3EmitHierNetLists final
{
  public:
    static void emitHireNetLists(
      std::unordered_map<std::string, Module> &hierCellsNetLists);
    static void printHireNetLists(
      std::unordered_map<std::string, Module> &hierCellsNetLists,
      std::string filename);
};

class V3EmitPlainNetLists final
{
  public:
    static void emitPlainNetLists(
      std::unordered_map<std::string, Module> &hierCellsNetLists,
      std::unordered_map<std::string, Module> &plainCellsNetLists);
    static void printPlainNetLists(
      std::unordered_map<std::string, Module> &hierCellsNetLists,
      std::string filename)
    {
      V3EmitHierNetLists::printHireNetLists(hierCellsNetLists, filename);
    }
};
}
