#pragma once

#include "netlistsdefine.h"

class V3EmitNetLists final {
public:
    static void emitNetLists(std::unordered_map<std::string, MoudleMsg>& hierCellsNetLists);
};