// -*- mode: C++; c-file-style: "cc-mode" -*-
//*************************************************************************
// DESCRIPTION: Verilator: main()
//
// Code available from: https://verilator.org
//
//*************************************************************************
//
// Copyright 2003-2021 by Wilson Snyder. This program is free software; you
// can redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
// SPDX-License-Identifier: LGPL-3.0-only OR Artistic-2.0
//
//*************************************************************************
#include "VerilogNetlist.h"
int main(int argc, char **argv, char **env)
{
  VerilogNetlist verilogNetlist;
  // 1,Obtain a hierarchical netlist from AST.
  verilogNetlist.parseHierNet(argc, argv, env);
  // 2,Print a hierarchical netlist to a verilog file.
  verilogNetlist.printHierNet("HierNetlist.v");
  // 3,Flatten a hierarchical netlist
  verilogNetlist.callFlattenHierNet();
  // verilogNetlist.sortInsOrderInTop();
  // 4,Print a flattened netlist to a verilog file.
  verilogNetlist.printFlatNet("FlatNetlist.v");
  return 0;
}
