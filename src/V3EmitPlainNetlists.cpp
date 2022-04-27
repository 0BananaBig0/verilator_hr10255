#include "V3EmitNetlists.h"

#include <algorithm>
#include <cstdlib>
#include <exception>
#include <fstream>
#include <iostream>
#include <unordered_map>
#include <unordered_set>

namespace OneBitNetlist
{
/**
 * @brief       是否是标准单元
 * @param[in]
 */
static bool IsStdCell(const std::string &moduleName)
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

static void
PlainModule(Module &moduleMsg,
            std::unordered_map<std::string, Module> &hierCellsNetLists)
{
  /**
   * @brief       moduleMsg 初始化拷贝
   * @param[in]   moduleMsg : 原值
   * @return      拷贝对象
   * @sa          参见具体使用处
   */
  auto initModuleMsgCopy = [](const Module &moduleMsg) -> Module
  {
    Module result;
    result.moduleDefName = moduleMsg.moduleDefName;
    result.inputs = moduleMsg.inputs;
    result.outputs = moduleMsg.outputs;
    result.inouts = moduleMsg.inouts;
    result.wires = moduleMsg.wires;
    result.assigns = moduleMsg.assigns;
    return result;
  };

  Module result = initModuleMsgCopy(moduleMsg);

  for(const auto &subModuleInstanceName: moduleMsg.subModuleInstanceNames)
  {
    const std::string subModuleDefName =
      moduleMsg.subModInsNameMapSubModDefName[subModuleInstanceName];
    // 1 - 判断子模块是否是标准单元
    // Hint : 标准单元不需要展开，直接拷贝走就可以了
    if(IsStdCell(subModuleDefName))
    {
      result.subModuleInstanceNames.push_back(subModuleInstanceName);
      result.subModInsNameMapSubModDefName[subModuleInstanceName] =
        moduleMsg.subModInsNameMapSubModDefName[subModuleInstanceName];
      result.subModInsNameMapPortAssignments[subModuleInstanceName] =
        moduleMsg.subModInsNameMapPortAssignments[subModuleInstanceName];
      continue;
    }
    // 2 - 展开非标准单元的子模块
    // Hint : 本质上是 const 的,但是这样我操作 map 就很麻烦了，下同
    /* const */ Module &subModuleMsg = hierCellsNetLists[subModuleDefName];
    /**
     * @brief 简单的 hash 算子
     * @note  这个是还要优化的
     */
    struct PortMsgHash
    {
        size_t operate(const PortDefinition &portMsg)
        {
          return static_cast<size_t>(portMsg.bitWidth * 2 +
                                     portMsg.portDefName.size() * 5);
        }
    };

    // 2.1 - 往父模块中插入子模块的 wire
    // Hint : 为了确保唯一性，加上子模块的实例名称
    for(auto originPortMsg: subModuleMsg.wires)
    {
      PortDefinition portMsg = originPortMsg;
      portMsg.portDefName =
        subModuleInstanceName + "_" + originPortMsg.portDefName;
      result.wires.push_back(portMsg);
    }

    // 2.2 - 做子模块的 in, out, inout 到父模块的映射
    std::unordered_map<std::string, std::vector<VarRef>> portsDefInstanceMap;
    auto &subModulePorts =
      moduleMsg.subModInsNameMapPortAssignments[subModuleInstanceName];
    for(auto &subModulePort: subModulePorts)
    {
      portsDefInstanceMap[subModulePort.portDefName] = subModulePort.varRefs;
    }

    // 3 - 将子模块中的标准单元实例搬移到 result 中去
    for(const auto &originSubSubModuleInstanceName:
        subModuleMsg.subModuleInstanceNames)
    {
      // 3.1 - 插入新的标准单元实例名称
      std::string subSubModuleInstanceName =
        subModuleInstanceName + originSubSubModuleInstanceName;
      result.subModuleInstanceNames.push_back(subSubModuleInstanceName);

      // 3.2 - 记录新的标准单元实例的类型
      result.subModInsNameMapSubModDefName[subSubModuleInstanceName] =
        subModuleMsg
          .subModInsNameMapSubModDefName[originSubSubModuleInstanceName];

      // 3.3 - 将原来的标准单元的形参替换为新的映射关系
      {
        const auto &originSubPortInstanceMsgs =
          subModuleMsg
            .subModInsNameMapPortAssignments[originSubSubModuleInstanceName];
        std::vector<PortAssignment> subPortInstanceMsgs;
        for(const auto &originPortInstanceMsg: originSubPortInstanceMsgs)
        {
          PortAssignment portInstanceMsg;

          // 3.3.1 引脚定义名称不变，这是从标准单元来的
          portInstanceMsg.portDefName = originPortInstanceMsg.portDefName;

          // 3.3.2 修改引脚实例名称，分情况讨论
          auto &subModulePorts =
            moduleMsg.subModInsNameMapPortAssignments[subModuleInstanceName];
          for(auto &originVarRefMsg: originPortInstanceMsg.varRefs)
          {

            VarRef varRefMsg;
            // 1 - 匿名赋值直接拷贝
            if(originVarRefMsg.varRefName == "anonymous")
            {
              varRefMsg = originVarRefMsg;
            }
            // 2- in, out, inout 做端口映射
            else if(portsDefInstanceMap.count(originVarRefMsg.varRefName) != 0)
            {
              if(originVarRefMsg.isVector == false)
              {
                varRefMsg = portsDefInstanceMap[originVarRefMsg.varRefName][0];
              }
              else
              {
                int index = originVarRefMsg.index;
                // 这种情况算下端口转发，verilator没有捕获到
                // TODO : 此处应该被列为 bug 修复
                if(portsDefInstanceMap[originVarRefMsg.varRefName].size() ==
                     1 &&
                   portsDefInstanceMap[originVarRefMsg.varRefName][0]
                       .isVector == false)
                {
                  varRefMsg =
                    portsDefInstanceMap[originVarRefMsg.varRefName][0];
                  varRefMsg.isVector = true;
                  varRefMsg.index = index;
                }
                else
                {
                  varRefMsg =
                    portsDefInstanceMap[originVarRefMsg.varRefName][index];
                }
              }
            }
            // 3 - wire 类型向父类做转换
            else
            {
              varRefMsg = originVarRefMsg;
              varRefMsg.varRefName =
                subModuleInstanceName + "_" + varRefMsg.varRefName;
              std::cout << "originVarRefMsg."
                           "varRefName is "
                        << originVarRefMsg.varRefName << std::endl;
            }
            portInstanceMsg.varRefs.push_back(varRefMsg);
          }
          subPortInstanceMsgs.push_back(portInstanceMsg);
        }
        result.subModInsNameMapPortAssignments[subSubModuleInstanceName] =
          subPortInstanceMsgs;
      }
    }
  }

  moduleMsg = result;

  return;
}

/**
 * @brief 用于扁平化网表
 */
class NetListsPlain final
{
  public:
    NetListsPlain(std::unordered_map<std::string, Module> &hierCellsNetLists);
    NetListsPlain() = default;

  public:
    /**
     * @brief 获取扁平化的网表
     */
    std::unordered_map<std::string, Module> GetPlainNetLists();

  private:
    std::unordered_map<std::string, Module> _plainCellsNetLists;
};

NetListsPlain::NetListsPlain(
  std::unordered_map<std::string, Module> &hierCellsNetLists)
{
  std::vector<std::string> moduleDefNameOrderByLevel;
  for(const auto &module: hierCellsNetLists)
  {
    moduleDefNameOrderByLevel.push_back(module.second.moduleDefName);
  }
  std::sort(
    moduleDefNameOrderByLevel.begin(), moduleDefNameOrderByLevel.end(),
    [&hierCellsNetLists](const std::string &left, const std::string &right) {
      return hierCellsNetLists[left].level > hierCellsNetLists[right].level;
    });

  for(const auto &moduleDefName: moduleDefNameOrderByLevel)
  {
    // 标准单元无需扁平
    if(IsStdCell(moduleDefName))
    {
      continue;
    }
    Module &moduleMsg = hierCellsNetLists[moduleDefName];
    PlainModule(moduleMsg, hierCellsNetLists);
  }
  _plainCellsNetLists = hierCellsNetLists;
}

std::unordered_map<std::string, Module> NetListsPlain::GetPlainNetLists()
{
  return std::move(_plainCellsNetLists);
}

void V3EmitPlainNetLists::emitPlainNetLists(
  std::unordered_map<std::string, Module> &hierCellsNetLists,
  std::unordered_map<std::string, Module> &plainCellsNetLists)
{
  auto tmp = hierCellsNetLists;
  NetListsPlain netListsPlain(tmp);
  plainCellsNetLists = netListsPlain.GetPlainNetLists();
}
}
