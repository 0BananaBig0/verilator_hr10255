/*************************************************************************
  > File Name: Netlist.cpp
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn
  > Created Time: Sun 01 May 2022 04:09:26 PM CST
 ************************************************************************/

#include "Netlist.h"
#include <climits>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <unordered_set>

bool isStdCell(const std::string &moduleName)
{
  const std::unordered_set<std::string> stdCells = { "PLL",
                                                     "PADBID",
                                                     "PADCLK",
                                                     "AON_BUF_X1",
                                                     "AON_BUF_X2",
                                                     "AON_BUF_X4",
                                                     "AON_INV_X1",
                                                     "AON_INV_X2",
                                                     "AON_INV_X4",
                                                     "HEADER_OE_X1",
                                                     "HEADER_OE_X2",
                                                     "HEADER_OE_X4",
                                                     "HEADER_X1",
                                                     "HEADER_X2",
                                                     "HEADER_X4",
                                                     "ISO_FENCE0N_X1",
                                                     "ISO_FENCE0N_X2",
                                                     "ISO_FENCE0N_X4",
                                                     "ISO_FENCE0_X1",
                                                     "ISO_FENCE0_X2",
                                                     "ISO_FENCE0_X4",
                                                     "ISO_FENCE1N_X1",
                                                     "ISO_FENCE1N_X2",
                                                     "ISO_FENCE1N_X4",
                                                     "ISO_FENCE1_X1",
                                                     "ISO_FENCE1_X2",
                                                     "ISO_FENCE1_X4",
                                                     "LS_HLEN_X1",
                                                     "LS_HLEN_X2",
                                                     "LS_HLEN_X4",
                                                     "LS_HL_X1",
                                                     "LS_HL_X2",
                                                     "LS_HL_X4",
                                                     "LS_LHEN_X1",
                                                     "LS_LHEN_X2",
                                                     "LS_LHEN_X4",
                                                     "LS_LH_X1",
                                                     "LS_LH_X2",
                                                     "LS_LH_X4",
                                                     "AND2_X1_HVT",
                                                     "AND2_X2_HVT",
                                                     "AND2_X4_HVT",
                                                     "AND3_X1_HVT",
                                                     "AND3_X2_HVT",
                                                     "AND3_X4_HVT",
                                                     "AND4_X1_HVT",
                                                     "AND4_X2_HVT",
                                                     "AND4_X4_HVT",
                                                     "ANTENNA_X1_HVT",
                                                     "AOI211_X1_HVT",
                                                     "AOI211_X2_HVT",
                                                     "AOI211_X4_HVT",
                                                     "AOI21_X1_HVT",
                                                     "AOI21_X2_HVT",
                                                     "AOI21_X4_HVT",
                                                     "AOI221_X1_HVT",
                                                     "AOI221_X2_HVT",
                                                     "AOI221_X4_HVT",
                                                     "AOI222_X1_HVT",
                                                     "AOI222_X2_HVT",
                                                     "AOI222_X4_HVT",
                                                     "AOI22_X1_HVT",
                                                     "AOI22_X2_HVT",
                                                     "AOI22_X4_HVT",
                                                     "BUF_X16_HVT",
                                                     "BUF_X1_HVT",
                                                     "BUF_X2_HVT",
                                                     "BUF_X32_HVT",
                                                     "BUF_X4_HVT",
                                                     "BUF_X8_HVT",
                                                     "CLKBUF_X1_HVT",
                                                     "CLKBUF_X2_HVT",
                                                     "CLKBUF_X3_HVT",
                                                     "CLKGATETST_X1_HVT",
                                                     "CLKGATETST_X2_HVT",
                                                     "CLKGATETST_X4_HVT",
                                                     "CLKGATETST_X8_HVT",
                                                     "CLKGATE_X1_HVT",
                                                     "CLKGATE_X2_HVT",
                                                     "CLKGATE_X4_HVT",
                                                     "CLKGATE_X8_HVT",
                                                     "DFFRS_X1_HVT",
                                                     "DFFRS_X2_HVT",
                                                     "DFFR_X1_HVT",
                                                     "DFFR_X2_HVT",
                                                     "DFFS_X1_HVT",
                                                     "DFFS_X2_HVT",
                                                     "DFF_X1_HVT",
                                                     "DFF_X2_HVT",
                                                     "DLH_X1_HVT",
                                                     "DLH_X2_HVT",
                                                     "DLL_X1_HVT",
                                                     "DLL_X2_HVT",
                                                     "FA_X1_HVT",
                                                     "FILLCELL_X16_HVT",
                                                     "FILLCELL_X1_HVT",
                                                     "FILLCELL_X2_HVT",
                                                     "FILLCELL_X32_HVT",
                                                     "FILLCELL_X4_HVT",
                                                     "FILLCELL_X8_HVT",
                                                     "HA_X1_HVT",
                                                     "INV_X16_HVT",
                                                     "INV_X1_HVT",
                                                     "INV_X2_HVT",
                                                     "INV_X32_HVT",
                                                     "INV_X4_HVT",
                                                     "INV_X8_HVT",
                                                     "LOGIC0_X1_HVT",
                                                     "LOGIC1_X1_HVT",
                                                     "MUX2_X1_HVT",
                                                     "MUX2_X2_HVT",
                                                     "NAND2_X1_HVT",
                                                     "NAND2_X2_HVT",
                                                     "NAND2_X4_HVT",
                                                     "NAND3_X1_HVT",
                                                     "NAND3_X2_HVT",
                                                     "NAND3_X4_HVT",
                                                     "NAND4_X1_HVT",
                                                     "NAND4_X2_HVT",
                                                     "NAND4_X4_HVT",
                                                     "NOR2_X1_HVT",
                                                     "NOR2_X2_HVT",
                                                     "NOR2_X4_HVT",
                                                     "NOR3_X1_HVT",
                                                     "NOR3_X2_HVT",
                                                     "NOR3_X4_HVT",
                                                     "NOR4_X1_HVT",
                                                     "NOR4_X2_HVT",
                                                     "NOR4_X4_HVT",
                                                     "OAI211_X1_HVT",
                                                     "OAI211_X2_HVT",
                                                     "OAI211_X4_HVT",
                                                     "OAI21_X1_HVT",
                                                     "OAI21_X2_HVT",
                                                     "OAI21_X4_HVT",
                                                     "OAI221_X1_HVT",
                                                     "OAI221_X2_HVT",
                                                     "OAI221_X4_HVT",
                                                     "OAI222_X1_HVT",
                                                     "OAI222_X2_HVT",
                                                     "OAI222_X4_HVT",
                                                     "OAI22_X1_HVT",
                                                     "OAI22_X2_HVT",
                                                     "OAI22_X4_HVT",
                                                     "OAI33_X1_HVT",
                                                     "OR2_X1_HVT",
                                                     "OR2_X2_HVT",
                                                     "OR2_X4_HVT",
                                                     "OR3_X1_HVT",
                                                     "OR3_X2_HVT",
                                                     "OR3_X4_HVT",
                                                     "OR4_X1_HVT",
                                                     "OR4_X2_HVT",
                                                     "OR4_X4_HVT",
                                                     "SDFFRS_X1_HVT",
                                                     "SDFFRS_X2_HVT",
                                                     "SDFFR_X1_HVT",
                                                     "SDFFR_X2_HVT",
                                                     "SDFFS_X1_HVT",
                                                     "SDFFS_X2_HVT",
                                                     "SDFF_X1_HVT",
                                                     "SDFF_X2_HVT",
                                                     "TBUF_X16_HVT",
                                                     "TBUF_X1_HVT",
                                                     "TBUF_X2_HVT",
                                                     "TBUF_X4_HVT",
                                                     "TBUF_X8_HVT",
                                                     "TINV_X1_HVT",
                                                     "TLAT_X1_HVT",
                                                     "XNOR2_X1_HVT",
                                                     "XNOR2_X2_HVT",
                                                     "XOR2_X1_HVT",
                                                     "XOR2_X2_HVT",
                                                     "AND2_X1_LVT",
                                                     "AND2_X2_LVT",
                                                     "AND2_X4_LVT",
                                                     "AND3_X1_LVT",
                                                     "AND3_X2_LVT",
                                                     "AND3_X4_LVT",
                                                     "AND4_X1_LVT",
                                                     "AND4_X2_LVT",
                                                     "AND4_X4_LVT",
                                                     "ANTENNA_X1_LVT",
                                                     "AOI211_X1_LVT",
                                                     "AOI211_X2_LVT",
                                                     "AOI211_X4_LVT",
                                                     "AOI21_X1_LVT",
                                                     "AOI21_X2_LVT",
                                                     "AOI21_X4_LVT",
                                                     "AOI221_X1_LVT",
                                                     "AOI221_X2_LVT",
                                                     "AOI221_X4_LVT",
                                                     "AOI222_X1_LVT",
                                                     "AOI222_X2_LVT",
                                                     "AOI222_X4_LVT",
                                                     "AOI22_X1_LVT",
                                                     "AOI22_X2_LVT",
                                                     "AOI22_X4_LVT",
                                                     "BUF_X16_LVT",
                                                     "BUF_X1_LVT",
                                                     "BUF_X2_LVT",
                                                     "BUF_X32_LVT",
                                                     "BUF_X4_LVT",
                                                     "BUF_X8_LVT",
                                                     "CLKBUF_X1_LVT",
                                                     "CLKBUF_X2_LVT",
                                                     "CLKBUF_X3_LVT",
                                                     "CLKGATETST_X1_LVT",
                                                     "CLKGATETST_X2_LVT",
                                                     "CLKGATETST_X4_LVT",
                                                     "CLKGATETST_X8_LVT",
                                                     "CLKGATE_X1_LVT",
                                                     "CLKGATE_X2_LVT",
                                                     "CLKGATE_X4_LVT",
                                                     "CLKGATE_X8_LVT",
                                                     "DFFRS_X1_LVT",
                                                     "DFFRS_X2_LVT",
                                                     "DFFR_X1_LVT",
                                                     "DFFR_X2_LVT",
                                                     "DFFS_X1_LVT",
                                                     "DFFS_X2_LVT",
                                                     "DFF_X1_LVT",
                                                     "DFF_X2_LVT",
                                                     "DLH_X1_LVT",
                                                     "DLH_X2_LVT",
                                                     "DLL_X1_LVT",
                                                     "DLL_X2_LVT",
                                                     "FA_X1_LVT",
                                                     "FILLCELL_X16_LVT",
                                                     "FILLCELL_X1_LVT",
                                                     "FILLCELL_X2_LVT",
                                                     "FILLCELL_X32_LVT",
                                                     "FILLCELL_X4_LVT",
                                                     "FILLCELL_X8_LVT",
                                                     "HA_X1_LVT",
                                                     "INV_X16_LVT",
                                                     "INV_X1_LVT",
                                                     "INV_X2_LVT",
                                                     "INV_X32_LVT",
                                                     "INV_X4_LVT",
                                                     "INV_X8_LVT",
                                                     "LOGIC0_X1_LVT",
                                                     "LOGIC1_X1_LVT",
                                                     "MUX2_X1_LVT",
                                                     "MUX2_X2_LVT",
                                                     "NAND2_X1_LVT",
                                                     "NAND2_X2_LVT",
                                                     "NAND2_X4_LVT",
                                                     "NAND3_X1_LVT",
                                                     "NAND3_X2_LVT",
                                                     "NAND3_X4_LVT",
                                                     "NAND4_X1_LVT",
                                                     "NAND4_X2_LVT",
                                                     "NAND4_X4_LVT",
                                                     "NOR2_X1_LVT",
                                                     "NOR2_X2_LVT",
                                                     "NOR2_X4_LVT",
                                                     "NOR3_X1_LVT",
                                                     "NOR3_X2_LVT",
                                                     "NOR3_X4_LVT",
                                                     "NOR4_X1_LVT",
                                                     "NOR4_X2_LVT",
                                                     "NOR4_X4_LVT",
                                                     "OAI211_X1_LVT",
                                                     "OAI211_X2_LVT",
                                                     "OAI211_X4_LVT",
                                                     "OAI21_X1_LVT",
                                                     "OAI21_X2_LVT",
                                                     "OAI21_X4_LVT",
                                                     "OAI221_X1_LVT",
                                                     "OAI221_X2_LVT",
                                                     "OAI221_X4_LVT",
                                                     "OAI222_X1_LVT",
                                                     "OAI222_X2_LVT",
                                                     "OAI222_X4_LVT",
                                                     "OAI22_X1_LVT",
                                                     "OAI22_X2_LVT",
                                                     "OAI22_X4_LVT",
                                                     "OAI33_X1_LVT",
                                                     "OR2_X1_LVT",
                                                     "OR2_X2_LVT",
                                                     "OR2_X4_LVT",
                                                     "OR3_X1_LVT",
                                                     "OR3_X2_LVT",
                                                     "OR3_X4_LVT",
                                                     "OR4_X1_LVT",
                                                     "OR4_X2_LVT",
                                                     "OR4_X4_LVT",
                                                     "SDFFRS_X1_LVT",
                                                     "SDFFRS_X2_LVT",
                                                     "SDFFR_X1_LVT",
                                                     "SDFFR_X2_LVT",
                                                     "SDFFS_X1_LVT",
                                                     "SDFFS_X2_LVT",
                                                     "SDFF_X1_LVT",
                                                     "SDFF_X2_LVT",
                                                     "TBUF_X16_LVT",
                                                     "TBUF_X1_LVT",
                                                     "TBUF_X2_LVT",
                                                     "TBUF_X4_LVT",
                                                     "TBUF_X8_LVT",
                                                     "TINV_X1_LVT",
                                                     "TLAT_X1_LVT",
                                                     "XNOR2_X1_LVT",
                                                     "XNOR2_X2_LVT",
                                                     "XOR2_X1_LVT",
                                                     "XOR2_X2_LVT",
                                                     "AND2_X1_SVT",
                                                     "AND2_X2_SVT",
                                                     "AND2_X4_SVT",
                                                     "AND3_X1_SVT",
                                                     "AND3_X2_SVT",
                                                     "AND3_X4_SVT",
                                                     "AND4_X1_SVT",
                                                     "AND4_X2_SVT",
                                                     "AND4_X4_SVT",
                                                     "ANTENNA_X1_SVT",
                                                     "AOI211_X1_SVT",
                                                     "AOI211_X2_SVT",
                                                     "AOI211_X4_SVT",
                                                     "AOI21_X1_SVT",
                                                     "AOI21_X2_SVT",
                                                     "AOI21_X4_SVT",
                                                     "AOI221_X1_SVT",
                                                     "AOI221_X2_SVT",
                                                     "AOI221_X4_SVT",
                                                     "AOI222_X1_SVT",
                                                     "AOI222_X2_SVT",
                                                     "AOI222_X4_SVT",
                                                     "AOI22_X1_SVT",
                                                     "AOI22_X2_SVT",
                                                     "AOI22_X4_SVT",
                                                     "BUF_X16_SVT",
                                                     "BUF_X1_SVT",
                                                     "BUF_X2_SVT",
                                                     "BUF_X32_SVT",
                                                     "BUF_X4_SVT",
                                                     "BUF_X8_SVT",
                                                     "CLKBUF_X1_SVT",
                                                     "CLKBUF_X2_SVT",
                                                     "CLKBUF_X3_SVT",
                                                     "CLKGATETST_X1_SVT",
                                                     "CLKGATETST_X2_SVT",
                                                     "CLKGATETST_X4_SVT",
                                                     "CLKGATETST_X8_SVT",
                                                     "CLKGATE_X1_SVT",
                                                     "CLKGATE_X2_SVT",
                                                     "CLKGATE_X4_SVT",
                                                     "CLKGATE_X8_SVT",
                                                     "DFFRS_X1_SVT",
                                                     "DFFRS_X2_SVT",
                                                     "DFFR_X1_SVT",
                                                     "DFFR_X2_SVT",
                                                     "DFFS_X1_SVT",
                                                     "DFFS_X2_SVT",
                                                     "DFF_X1_SVT",
                                                     "DFF_X2_SVT",
                                                     "DLH_X1_SVT",
                                                     "DLH_X2_SVT",
                                                     "DLL_X1_SVT",
                                                     "DLL_X2_SVT",
                                                     "FA_X1_SVT",
                                                     "FILLCELL_X16_SVT",
                                                     "FILLCELL_X1_SVT",
                                                     "FILLCELL_X2_SVT",
                                                     "FILLCELL_X32_SVT",
                                                     "FILLCELL_X4_SVT",
                                                     "FILLCELL_X8_SVT",
                                                     "HA_X1_SVT",
                                                     "INV_X16_SVT",
                                                     "INV_X1_SVT",
                                                     "INV_X2_SVT",
                                                     "INV_X32_SVT",
                                                     "INV_X4_SVT",
                                                     "INV_X8_SVT",
                                                     "LOGIC0_X1_SVT",
                                                     "LOGIC1_X1_SVT",
                                                     "MUX2_X1_SVT",
                                                     "MUX2_X2_SVT",
                                                     "NAND2_X1_SVT",
                                                     "NAND2_X2_SVT",
                                                     "NAND2_X4_SVT",
                                                     "NAND3_X1_SVT",
                                                     "NAND3_X2_SVT",
                                                     "NAND3_X4_SVT",
                                                     "NAND4_X1_SVT",
                                                     "NAND4_X2_SVT",
                                                     "NAND4_X4_SVT",
                                                     "NOR2_X1_SVT",
                                                     "NOR2_X2_SVT",
                                                     "NOR2_X4_SVT",
                                                     "NOR3_X1_SVT",
                                                     "NOR3_X2_SVT",
                                                     "NOR3_X4_SVT",
                                                     "NOR4_X1_SVT",
                                                     "NOR4_X2_SVT",
                                                     "NOR4_X4_SVT",
                                                     "OAI211_X1_SVT",
                                                     "OAI211_X2_SVT",
                                                     "OAI211_X4_SVT",
                                                     "OAI21_X1_SVT",
                                                     "OAI21_X2_SVT",
                                                     "OAI21_X4_SVT",
                                                     "OAI221_X1_SVT",
                                                     "OAI221_X2_SVT",
                                                     "OAI221_X4_SVT",
                                                     "OAI222_X1_SVT",
                                                     "OAI222_X2_SVT",
                                                     "OAI222_X4_SVT",
                                                     "OAI22_X1_SVT",
                                                     "OAI22_X2_SVT",
                                                     "OAI22_X4_SVT",
                                                     "OAI33_X1_SVT",
                                                     "OR2_X1_SVT",
                                                     "OR2_X2_SVT",
                                                     "OR2_X4_SVT",
                                                     "OR3_X1_SVT",
                                                     "OR3_X2_SVT",
                                                     "OR3_X4_SVT",
                                                     "OR4_X1_SVT",
                                                     "OR4_X2_SVT",
                                                     "OR4_X4_SVT",
                                                     "SDFFRS_X1_SVT",
                                                     "SDFFRS_X2_SVT",
                                                     "SDFFR_X1_SVT",
                                                     "SDFFR_X2_SVT",
                                                     "SDFFS_X1_SVT",
                                                     "SDFFS_X2_SVT",
                                                     "SDFF_X1_SVT",
                                                     "SDFF_X2_SVT",
                                                     "TBUF_X16_SVT",
                                                     "TBUF_X1_SVT",
                                                     "TBUF_X2_SVT",
                                                     "TBUF_X4_SVT",
                                                     "TBUF_X8_SVT",
                                                     "TINV_X1_SVT",
                                                     "TLAT_X1_SVT",
                                                     "XNOR2_X1_SVT",
                                                     "XNOR2_X2_SVT",
                                                     "XOR2_X1_SVT",
                                                     "XOR2_X2_SVT",
                                                     "AND2_X1",
                                                     "AND2_X2",
                                                     "AND2_X4",
                                                     "AND3_X1",
                                                     "AND3_X2",
                                                     "AND3_X4",
                                                     "AND4_X1",
                                                     "AND4_X2",
                                                     "AND4_X4",
                                                     "ANTENNA_X1",
                                                     "AOI211_X1",
                                                     "AOI211_X2",
                                                     "AOI211_X4",
                                                     "AOI21_X1",
                                                     "AOI21_X2",
                                                     "AOI21_X4",
                                                     "AOI221_X1",
                                                     "AOI221_X2",
                                                     "AOI221_X4",
                                                     "AOI222_X1",
                                                     "AOI222_X2",
                                                     "AOI222_X4",
                                                     "AOI22_X1",
                                                     "AOI22_X2",
                                                     "AOI22_X4",
                                                     "BUF_X16",
                                                     "BUF_X1",
                                                     "BUF_X2",
                                                     "BUF_X32",
                                                     "BUF_X4",
                                                     "BUF_X8",
                                                     "CLKBUF_X1",
                                                     "CLKBUF_X2",
                                                     "CLKBUF_X3",
                                                     "CLKGATETST_X1",
                                                     "CLKGATETST_X2",
                                                     "CLKGATETST_X4",
                                                     "CLKGATETST_X8",
                                                     "CLKGATE_X1",
                                                     "CLKGATE_X2",
                                                     "CLKGATE_X4",
                                                     "CLKGATE_X8",
                                                     "DFFRS_X1",
                                                     "DFFRS_X2",
                                                     "DFFR_X1",
                                                     "DFFR_X2",
                                                     "DFFS_X1",
                                                     "DFFS_X2",
                                                     "DFF_X1",
                                                     "DFF_X2",
                                                     "DLH_X1",
                                                     "DLH_X2",
                                                     "DLL_X1",
                                                     "DLL_X2",
                                                     "FA_X1",
                                                     "FILLCELL_X16",
                                                     "FILLCELL_X1",
                                                     "FILLCELL_X2",
                                                     "FILLCELL_X32",
                                                     "FILLCELL_X4",
                                                     "FILLCELL_X8",
                                                     "HA_X1",
                                                     "INV_X16",
                                                     "INV_X1",
                                                     "INV_X2",
                                                     "INV_X32",
                                                     "INV_X4",
                                                     "INV_X8",
                                                     "LOGIC0_X1",
                                                     "LOGIC1_X1",
                                                     "MUX2_X1",
                                                     "MUX2_X2",
                                                     "NAND2_X1",
                                                     "NAND2_X2",
                                                     "NAND2_X4",
                                                     "NAND3_X1",
                                                     "NAND3_X2",
                                                     "NAND3_X4",
                                                     "NAND4_X1",
                                                     "NAND4_X2",
                                                     "NAND4_X4",
                                                     "NOR2_X1",
                                                     "NOR2_X2",
                                                     "NOR2_X4",
                                                     "NOR3_X1",
                                                     "NOR3_X2",
                                                     "NOR3_X4",
                                                     "NOR4_X1",
                                                     "NOR4_X2",
                                                     "NOR4_X4",
                                                     "OAI211_X1",
                                                     "OAI211_X2",
                                                     "OAI211_X4",
                                                     "OAI21_X1",
                                                     "OAI21_X2",
                                                     "OAI21_X4",
                                                     "OAI221_X1",
                                                     "OAI221_X2",
                                                     "OAI221_X4",
                                                     "OAI222_X1",
                                                     "OAI222_X2",
                                                     "OAI222_X4",
                                                     "OAI22_X1",
                                                     "OAI22_X2",
                                                     "OAI22_X4",
                                                     "OAI33_X1",
                                                     "OR2_X1",
                                                     "OR2_X2",
                                                     "OR2_X4",
                                                     "OR3_X1",
                                                     "OR3_X2",
                                                     "OR3_X4",
                                                     "OR4_X1",
                                                     "OR4_X2",
                                                     "OR4_X4",
                                                     "SDFFRS_X1",
                                                     "SDFFRS_X2",
                                                     "SDFFR_X1",
                                                     "SDFFR_X2",
                                                     "SDFFS_X1",
                                                     "SDFFS_X2",
                                                     "SDFF_X1",
                                                     "SDFF_X2",
                                                     "TBUF_X16",
                                                     "TBUF_X1",
                                                     "TBUF_X2",
                                                     "TBUF_X4",
                                                     "TBUF_X8",
                                                     "TINV_X1",
                                                     "TLAT_X1",
                                                     "XNOR2_X1",
                                                     "XNOR2_X2",
                                                     "XOR2_X1",
                                                     "XOR2_X2",
                                                     "MemGen_16_10" };
  return stdCells.find(moduleName) != stdCells.end();
}

void EmitHierNetlist::emitHierNetlists(std::vector<Module> &hierNetlist,
                                       uint32_t &theNumberOfStdCellsShouldUse)
{
  HierNetlistVisitor hierNetlistVisitor(v3Global.rootp());
  hierNetlist = hierNetlistVisitor.getHierNetlist();
  theNumberOfStdCellsShouldUse =
    hierNetlistVisitor.getTheNumberOfStdCellsShouldUse();
}

void EmitHierNetlist::printHierNetlist(
  const std::vector<Module> &hierNetlist,
  const uint32_t &theNumberOfStdCellsShouldUse, std::string fileName,
  const uint32_t hierMaxLevel)
{
  std::ofstream ofs(fileName);
  bool shouldHaveEscapeCharacter;
  uint32_t totalCharactersEveryLine;
  auto getDecimalNumberLength = [](uint32_t number)
  {
    uint32_t length = 0;
    while(number)
    {
      number /= 10;
      length++;
    }
    return length;
  };
  auto haveVerilogKeyWordOrOperator = [](const string &name)
  {
    // If there are too many kinds of keywords(more than 14) will be used in
    // port name, instance name, module name, variable name and so on, use map
    // to replace vector.
    std::vector<std::string> verilogKeyWord = { "run", "signed" };
    std::vector<std::string> verilogOperator = { "[", ".", "]" };
    for(auto vKW: verilogKeyWord)
    {
      if(vKW.size() == name.size() && name.find(vKW) < name.size())
        return true;
    }
    for(auto vO: verilogOperator)
    {
      if(name.find(vO) < name.size())
        return true;
    }
    return false;
  };
  const uint32_t maxCharactersEveryLine = 80;
  uint32_t moduleIndex = theNumberOfStdCellsShouldUse;
  // Every time print one module defintion
  for(uint32_t moduleIndex = theNumberOfStdCellsShouldUse;
      moduleIndex < hierNetlist.size(); moduleIndex++)
  {
    const auto &oneModule = hierNetlist[moduleIndex];
    totalCharactersEveryLine = 0;
    if(oneModule.level <= hierMaxLevel)
    { // Print one module declaration
      ofs << "module " << oneModule.moduleDefName << "(";
      totalCharactersEveryLine =
        totalCharactersEveryLine + 7 + oneModule.moduleDefName.size() + 1;
      for(const auto &port: oneModule.ports)
      {
        if(port.portType != PortType::WIRE &&
           port.portType != PortType::LAST_PORT_TYPE)
        {
          if(totalCharactersEveryLine + port.portDefName.size() >
             maxCharactersEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharactersEveryLine = 6;
          }
          totalCharactersEveryLine =
            port.portDefName.size() + totalCharactersEveryLine;
          if(haveVerilogKeyWordOrOperator(port.portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
            totalCharactersEveryLine++;
          }
          ofs << port.portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            totalCharactersEveryLine++;
            shouldHaveEscapeCharacter = false;
          }
          ofs << ",";
          totalCharactersEveryLine++;
        }
      }
      ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
      ofs << ");" << std::endl;
      // Every time print one port definition
      for(const auto &port: oneModule.ports)
      {
        switch(port.portType)
        {
        case PortType::INPUT:
          ofs << "   input ";
          break;
        case PortType::OUTPUT:
          ofs << "   output ";
          break;
        case PortType::INOUT:
          ofs << "   inout ";
          break;
        case PortType::WIRE:
          ofs << "   wire ";
          break;
        }
        if(port.isVector)
        {
          ofs << "[" << port.bitWidth - 1 << ":0]";
        }
        if(haveVerilogKeyWordOrOperator(port.portDefName))
        {
          shouldHaveEscapeCharacter = true;
          ofs << "\\";
        }
        ofs << port.portDefName;
        if(shouldHaveEscapeCharacter)
        {
          ofs << " ";
          shouldHaveEscapeCharacter = false;
        }
        ofs << ";" << std::endl;
      }

      // Every time print one assign statement, every assign statement only has
      // one bit data;
      for(auto oneAssign: oneModule.assigns)
      {
        ofs << "  assign ";
        if(haveVerilogKeyWordOrOperator(
             oneModule.ports[oneAssign.lValue.varRefIndex].portDefName))
        {
          shouldHaveEscapeCharacter = true;
          ofs << "\\";
        }
        ofs << oneModule.ports[oneAssign.lValue.varRefIndex].portDefName;
        if(shouldHaveEscapeCharacter)
        {
          ofs << " ";
          shouldHaveEscapeCharacter = false;
        }
        if(oneAssign.lValue.varRefIndex != UINT_MAX)
        {
          if(oneModule.ports[oneAssign.lValue.varRefIndex].isVector)
            ofs << "[" << oneAssign.lValue.index << "]";
        }
        else
        {
          throw std::runtime_error(
            "Assign left value can not be const value or x or z.");
        }
        ofs << " = ";
        // rValue is a consta value or x or z
        if(oneAssign.rValue.varRefIndex == UINT_MAX)
        {
          switch(oneAssign.rValue.valueAndValueX)
          {
          case ONE:
            ofs << "1'b1";
            break;
          case ZERO:
            ofs << "1'b0";
            break;
          case X:
            ofs << "1'bx";
            break;
          case Z:
            ofs << "1'bz";
            break;
          default:
            ofs << "1'be"; // e = error valuex
            break;
          }
        }
        else
        {
          if(haveVerilogKeyWordOrOperator(
               oneModule.ports[oneAssign.rValue.varRefIndex].portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
          }
          ofs << oneModule.ports[oneAssign.rValue.varRefIndex].portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            shouldHaveEscapeCharacter = false;
          }
          if(oneModule.ports[oneAssign.rValue.varRefIndex].isVector)
            ofs << "[" << oneAssign.rValue.index << "]";
        }
        ofs << ";" << std::endl;
      }

      // Every time print one submodule instance
      uint32_t subModuleIndex = 0;
      for(const auto &onesubModuleInstanceName:
          oneModule.subModuleInstanceNames)
      {
        totalCharactersEveryLine = 0;
        ofs << "  "
            << hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
                 .moduleDefName
            << " ";
        if(haveVerilogKeyWordOrOperator(onesubModuleInstanceName))
        {
          ofs << "\\";
          totalCharactersEveryLine++;
        }
        ofs << onesubModuleInstanceName << " "
            << "(";
        totalCharactersEveryLine =
          totalCharactersEveryLine + 5 +
          hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
            .moduleDefName.size() +
          onesubModuleInstanceName.size();
        // Every time print one port assignment
        uint32_t portDefIndex = 0;
        for(const auto &onePortAssignment:
            oneModule.portAssignmentsOfSubModuleInstances[subModuleIndex])
        {
          if(totalCharactersEveryLine + 1 +
               hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
                 .ports[portDefIndex]
                 .portDefName.size() >
             maxCharactersEveryLine)
          {
            ofs << std::endl << "      ";
            totalCharactersEveryLine = 6;
          }
          ofs << ".";
          if(haveVerilogKeyWordOrOperator(
               hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
                 .ports[portDefIndex]
                 .portDefName))
          {
            shouldHaveEscapeCharacter = true;
            ofs << "\\";
            totalCharactersEveryLine++;
          }
          ofs << hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
                   .ports[portDefIndex]
                   .portDefName;
          if(shouldHaveEscapeCharacter)
          {
            ofs << " ";
            totalCharactersEveryLine++;
            shouldHaveEscapeCharacter = false;
          }
          ofs << "(";
          totalCharactersEveryLine =
            totalCharactersEveryLine + 2 +
            hierNetlist[oneModule.subModuleDefIndex[subModuleIndex]]
              .ports[portDefIndex]
              .portDefName.size();
          if(onePortAssignment.varRefs.size() > 1)
          {
            ofs << "{";
            totalCharactersEveryLine++;
          }
          for(uint32_t indexOfVarRefs = onePortAssignment.varRefs.size();
              indexOfVarRefs > 0; indexOfVarRefs--)
          {
            auto &varRef = onePortAssignment.varRefs[indexOfVarRefs - 1];
            if(varRef.varRefIndex == UINT_MAX)
            {
              if(totalCharactersEveryLine + 4 > maxCharactersEveryLine)
              {
                ofs << std::endl << "      ";
                totalCharactersEveryLine = 6;
              }
              switch(varRef.valueAndValueX)
              {
              case ONE:
                ofs << "1'b1";
                break;
              case ZERO:
                ofs << "1'b0";
                break;
              case X:
                ofs << "1'bx";
                break;
              case Z:
                ofs << "1'bz";
                break;
              default:
                ofs << "1'be"; // e = error valuex
                break;
              }
              totalCharactersEveryLine = totalCharactersEveryLine + 4;
            }
            else
            {
              if(oneModule.ports[varRef.varRefIndex].isVector)
              {
                if(totalCharactersEveryLine +
                     oneModule.ports[varRef.varRefIndex].portDefName.size() +
                     2 + getDecimalNumberLength(varRef.index) >
                   maxCharactersEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharactersEveryLine = 6;
                }
              }
              else
              {
                if(totalCharactersEveryLine +
                     oneModule.ports[varRef.varRefIndex].portDefName.size() >
                   maxCharactersEveryLine)
                {
                  ofs << std::endl << "      ";
                  totalCharactersEveryLine = 6;
                }
              }
              if(haveVerilogKeyWordOrOperator(
                   oneModule.ports[varRef.varRefIndex].portDefName))
              {
                shouldHaveEscapeCharacter = true;
                ofs << "\\";
                totalCharactersEveryLine++;
              }
              ofs << oneModule.ports[varRef.varRefIndex].portDefName;
              totalCharactersEveryLine =
                totalCharactersEveryLine +
                oneModule.ports[varRef.varRefIndex].portDefName.size();
              if(shouldHaveEscapeCharacter)
              {
                ofs << " ";
                totalCharactersEveryLine++;
                shouldHaveEscapeCharacter = false;
              }
              if(oneModule.ports[varRef.varRefIndex].isVector)
              {
                ofs << "[" << varRef.index << "]";
                totalCharactersEveryLine =
                  totalCharactersEveryLine + 2 +
                  getDecimalNumberLength(varRef.index);
              }
            }
            ofs << ",";
            totalCharactersEveryLine++;
          }
          if(onePortAssignment.varRefs.size() >= 1)
          {
            ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
            totalCharactersEveryLine--;
          }
          if(onePortAssignment.varRefs.size() > 1)
          {
            ofs << "}";
            totalCharactersEveryLine++;
          }
          ofs << ")";
          ofs << ", ";
          totalCharactersEveryLine = totalCharactersEveryLine + 3;
          portDefIndex++;
        }
        ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one ","
        ofs.seekp(ofs.tellp() - std::streampos(1)); // delete one " "
        ofs << ");";
        ofs << std::endl;
        subModuleIndex++;
      }
      ofs << "endmodule" << std::endl << std::endl;
    }
  }
  ofs.close();
}

// Use case2 as a example to demonstrate.
void EmitHierNetlist::emitFlattenedNetlists(
  std::vector<Module> &hierNetlist, std::vector<Module> &flatNetlist,
  uint32_t &theNumberOfStdCellsShouldUse)
{
  flatNetlist = hierNetlist;
  // Use to not flatten such module which only have standard cells or assign
  // statement; Sometimes, theNumberOfStdCellsShouldUse = 0.
  auto &theMostDepthLevelExcludingStdCells = hierNetlist.back().level;
  for(uint32_t moduleDefIndex = hierNetlist.size() - 1;
      moduleDefIndex >= theNumberOfStdCellsShouldUse &&
      moduleDefIndex != UINT_MAX;
      moduleDefIndex--)
  {
    // full_adder definition
    const auto &oneModuleH = hierNetlist[moduleDefIndex];
    auto &oneModuleF = flatNetlist[moduleDefIndex];
    if(oneModuleH.level < theMostDepthLevelExcludingStdCells)
    {
      oneModuleF.subModuleInstanceNames.clear();
      oneModuleF.subModuleDefIndex.clear();
      oneModuleF.portAssignmentsOfSubModuleInstances.clear();
      uint32_t subModuleInstanceIndex = 0;
      // full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
      for(auto &subModuleDefIndex: oneModuleH.subModuleDefIndex)
      {
        // subModule is a stdCell
        if(subModuleDefIndex < theNumberOfStdCellsShouldUse)
        {
          oneModuleF.subModuleInstanceNames.push_back(
            oneModuleH.subModuleInstanceNames[subModuleInstanceIndex]);
          oneModuleF.subModuleDefIndex.push_back(subModuleDefIndex);
          oneModuleF.portAssignmentsOfSubModuleInstances.push_back(
            oneModuleH
              .portAssignmentsOfSubModuleInstances[subModuleInstanceIndex]);
        }
        else
        { // U1, subModule is not a stdCell
          const std::string &subModuleInstanceName =
            oneModuleH.subModuleInstanceNames[subModuleInstanceIndex];
          // (.co(co), .a(a), .b(b), .ci(ci));
          const auto &portAssignmentsOfSubModuleInstance =
            oneModuleH
              .portAssignmentsOfSubModuleInstances[subModuleInstanceIndex];
          // full_adder_co definition
          auto &oneSubModule = flatNetlist[subModuleDefIndex];
          uint32_t oneModuleFPortsNumber = oneModuleF.ports.size();
          uint32_t oneSubModuleWirePosition =
            oneSubModule.theNumberOfPortExcludingWire;
          oneModuleF.ports.resize(oneModuleFPortsNumber +
                                  oneSubModule.ports.size() -
                                  oneSubModuleWirePosition);
          // full_adder_co wires,n_0_0 become U1_n_0_0
          for(uint32_t i = oneModuleFPortsNumber; i < oneModuleF.ports.size();
              i++)
          {
            oneModuleF.ports[i] = oneSubModule.ports[oneSubModuleWirePosition];
            oneModuleF.ports[i].portDefName.insert(0, "_");
            oneModuleF.ports[i].portDefName.insert(0, subModuleInstanceName);
            oneSubModuleWirePosition++;
          }
          oneModuleF.subModuleDefIndex.insert(
            oneModuleF.subModuleDefIndex.end(),
            oneSubModule.subModuleDefIndex.begin(),
            oneSubModule.subModuleDefIndex.end());
          uint32_t stdCellInstanceNameIndex = 0;
          // INV_X1_LVT i_0_0 (.A(a), .ZN(n_0_0));
          for(auto oneStdCellIns:
              oneSubModule.portAssignmentsOfSubModuleInstances)
          {
            // stdInstanceName i_0_0 becomes U1_i_0_0
            oneModuleF.subModuleInstanceNames.push_back(
              oneSubModule.subModuleInstanceNames[stdCellInstanceNameIndex]);
            stdCellInstanceNameIndex++;
            oneModuleF.subModuleInstanceNames.back().insert(0, "_");
            oneModuleF.subModuleInstanceNames.back().insert(
              0, subModuleInstanceName);
            // .A(a)
            for(auto &portAssignmentOfStdCell: oneStdCellIns)
            {
              for(auto &oneVarRef: portAssignmentOfStdCell.varRefs)
              {
                // Now, oneVarRef is a wire
                if(oneVarRef.varRefIndex >=
                     oneSubModule.theNumberOfPortExcludingWire &&
                   oneVarRef.varRefIndex < UINT_MAX)
                {
                  oneVarRef.varRefIndex =
                    oneVarRef.varRefIndex -
                    oneSubModule.theNumberOfPortExcludingWire +
                    oneModuleFPortsNumber;
                }
                // Now,oneVarRef is a input, output or inout
                else if(oneVarRef.varRefIndex <
                        oneSubModule.theNumberOfPortExcludingWire)
                { // If the port of full_adder_co instance is empty.
                  if(portAssignmentsOfSubModuleInstance[oneVarRef.varRefIndex]
                       .varRefs.empty())
                  {
                    portAssignmentOfStdCell.varRefs.clear();
                  }
                  else
                    oneVarRef =
                      portAssignmentsOfSubModuleInstance[oneVarRef.varRefIndex]
                        .varRefs[oneVarRef.index];
                }
                // Now,oneVarRef is a const value or x or z
                // else{}
              }
            }
            oneModuleF.portAssignmentsOfSubModuleInstances.push_back(
              std::move(oneStdCellIns));
          }
          for(auto oneAssign: oneSubModule.assigns)
          {
            bool _curAssignConnectToEmptySignal = false;
            if(oneAssign.lValue.varRefIndex >=
                 oneSubModule.theNumberOfPortExcludingWire &&
               oneAssign.lValue.varRefIndex < UINT_MAX)
            {
              oneAssign.lValue.varRefIndex =
                oneAssign.lValue.varRefIndex -
                oneSubModule.theNumberOfPortExcludingWire +
                oneModuleFPortsNumber;
            }
            else if(oneAssign.lValue.varRefIndex <
                    oneSubModule.theNumberOfPortExcludingWire)
            {
              if(portAssignmentsOfSubModuleInstance[oneAssign.lValue
                                                      .varRefIndex]
                   .varRefs.empty())
                _curAssignConnectToEmptySignal = true;
              else
                oneAssign.lValue =
                  portAssignmentsOfSubModuleInstance[oneAssign.lValue
                                                       .varRefIndex]
                    .varRefs[oneAssign.lValue.index];
            }
            if(oneAssign.rValue.varRefIndex >=
                 oneSubModule.theNumberOfPortExcludingWire &&
               oneAssign.rValue.varRefIndex < UINT_MAX)
            {
              oneAssign.rValue.varRefIndex =
                oneAssign.rValue.varRefIndex -
                oneSubModule.theNumberOfPortExcludingWire +
                oneModuleFPortsNumber;
            }
            else if(oneAssign.rValue.varRefIndex <
                    oneSubModule.theNumberOfPortExcludingWire)
            {
              if(portAssignmentsOfSubModuleInstance[oneAssign.rValue
                                                      .varRefIndex]
                   .varRefs.empty())
                _curAssignConnectToEmptySignal = true;
              else
                oneAssign.rValue =
                  portAssignmentsOfSubModuleInstance[oneAssign.rValue
                                                       .varRefIndex]
                    .varRefs[oneAssign.rValue.index];
            }
            if(_curAssignConnectToEmptySignal)
              _curAssignConnectToEmptySignal = false;
            else
              oneModuleF.assigns.push_back(std::move(oneAssign));
          }
        }
        subModuleInstanceIndex++;
      }
    }
  }
}
