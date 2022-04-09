`celldefine

module PLL (LOCK, PLLOUT, BYPASS, DIVF0, DIVF1, DIVF2, DIVF3, DIVF4, DIVF5, DIVF6, DIVF7, DIVQ0, DIVQ1, DIVQ2, DIVR0, DIVR1, DIVR2, DIVR3, DIVR4, DIVR5, FB, FSE, RANGE0, RANGE1, RANGE2, REF, RESET);
output LOCK, PLLOUT;
input BYPASS, DIVF0, DIVF1, DIVF2, DIVF3, DIVF4, DIVF5, DIVF6, DIVF7, DIVQ0, DIVQ1, DIVQ2, DIVR0, DIVR1, DIVR2, DIVR3, DIVR4, DIVR5, FB, FSE, RANGE0, RANGE1, RANGE2, REF, RESET;
endmodule

module PADBID (C, I, OEN, PAD);
output C;
input I, OEN, PAD;
endmodule

module PADCLK (C, PAD);
output C;
input PAD;
endmodule

module AON_BUF_X1 (Z, A);
output Z;
input A;
endmodule

module AON_BUF_X2 (Z, A);
output Z;
input A;
endmodule

module AON_BUF_X4 (Z, A);
output Z;
input A;
endmodule

module AON_INV_X1 (Z, A);
output Z;
input A;
endmodule

module AON_INV_X2 (Z, A);
output Z;
input A;
endmodule

module AON_INV_X4 (Z, A);
output Z;
input A;
endmodule

module HEADER_OE_X1 (SLEEPOUT, SLEEP);
output SLEEPOUT;
input SLEEP;
endmodule

module HEADER_OE_X2 (SLEEPOUT, SLEEP);
output SLEEPOUT;
input SLEEP;
endmodule

module HEADER_OE_X4 (SLEEPOUT, SLEEP);
output SLEEPOUT;
input SLEEP;
endmodule

module HEADER_X1 (SLEEP);
input SLEEP;
endmodule

module HEADER_X2 (SLEEP);
input SLEEP;
endmodule

module HEADER_X4 (SLEEP);
input SLEEP;
endmodule

module ISO_FENCE0N_X1 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE0N_X2 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE0N_X4 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE0_X1 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE0_X2 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE0_X4 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE1N_X1 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE1N_X2 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE1N_X4 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE1_X1 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE1_X2 (Z, A, EN);
output Z;
input A, EN;
endmodule

module ISO_FENCE1_X4 (Z, A, EN);
output Z;
input A, EN;
endmodule

module LS_HLEN_X1 (Z, A, ISOLN);
output Z;
input A, ISOLN;
endmodule

module LS_HLEN_X2 (Z, A, ISOLN);
output Z;
input A, ISOLN;
endmodule

module LS_HLEN_X4 (Z, A, ISOLN);
output Z;
input A, ISOLN;
endmodule

module LS_HL_X1 (Z, A);
output Z;
input A;
endmodule

module LS_HL_X2 (Z, A);
output Z;
input A;
endmodule

module LS_HL_X4 (Z, A);
output Z;
input A;
endmodule

module LS_LHEN_X1 (Z, A, ISOLN);
output Z;
input A, ISOLN;
endmodule

module LS_LHEN_X2 (Z, A, ISOLN);
output Z;
input A, ISOLN;
endmodule

module LS_LHEN_X4 (Z, A, ISOLN);
output Z;
input A, ISOLN;
endmodule

module LS_LH_X1 (Z, A);
output Z;
input A;
endmodule

module LS_LH_X2 (Z, A);
output Z;
input A;
endmodule

module LS_LH_X4 (Z, A);
output Z;
input A;
endmodule

module MemGen_16_10 (rd_data[15:0], chip_en, wr_en, addr[9:0], wr_data[15:0], clock, rd_en);
output[15:0] rd_data;
input chip_en, wr_en, clock, rd_en;
input[9:0] addr;
input[15:0] wr_data;
endmodule

module AND2_X1 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X2 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X4 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X1_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X2_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X4_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X1_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X2_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X4_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X1_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X2_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND2_X4_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module AND3_X1 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X2 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X4 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X1_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X2_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X4_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X1_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X2_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X4_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X1_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X2_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND3_X4_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module AND4_X1 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X2 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X4 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X1_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X2_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X4_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X1_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X2_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X4_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X1_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X2_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module AND4_X4_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module ANTENNA_X1 (A);
input A;
endmodule

module ANTENNA_X1_LVT (A);
input A;
endmodule

module ANTENNA_X1_SVT (A);
input A;
endmodule

module ANTENNA_X1_HVT (A);
input A;
endmodule

module AOI211_X1 (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X2 (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X4 (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X1_LVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X2_LVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X4_LVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X1_SVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X2_SVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X4_SVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X1_HVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X2_HVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI211_X4_HVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module AOI21_X1 (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X2 (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X4 (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X1_LVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X2_LVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X4_LVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X1_SVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X2_SVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X4_SVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X1_HVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X2_HVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI21_X4_HVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module AOI221_X1 (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X2 (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X4 (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X1_LVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X2_LVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X4_LVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X1_SVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X2_SVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X4_SVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X1_HVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X2_HVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI221_X4_HVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module AOI222_X1 (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X2 (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X4 (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X1_LVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X2_LVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X4_LVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X1_SVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X2_SVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X4_SVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X1_HVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X2_HVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI222_X4_HVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module AOI22_X1 (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X2 (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X4 (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X1_LVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X2_LVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X4_LVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X1_SVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X2_SVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X4_SVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X1_HVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X2_HVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module AOI22_X4_HVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module BUF_X1 (Z, A);
output Z;
input A;
endmodule

module BUF_X2 (Z, A);
output Z;
input A;
endmodule

module BUF_X4 (Z, A);
output Z;
input A;
endmodule

module BUF_X8 (Z, A);
output Z;
input A;
endmodule

module BUF_X16 (Z, A);
output Z;
input A;
endmodule

module BUF_X32 (Z, A);
output Z;
input A;
endmodule

module BUF_X1_LVT (Z, A);
output Z;
input A;
endmodule

module BUF_X2_LVT (Z, A);
output Z;
input A;
endmodule

module BUF_X4_LVT (Z, A);
output Z;
input A;
endmodule

module BUF_X8_LVT (Z, A);
output Z;
input A;
endmodule

module BUF_X16_LVT (Z, A);
output Z;
input A;
endmodule

module BUF_X32_LVT (Z, A);
output Z;
input A;
endmodule

module BUF_X1_SVT (Z, A);
output Z;
input A;
endmodule

module BUF_X2_SVT (Z, A);
output Z;
input A;
endmodule

module BUF_X4_SVT (Z, A);
output Z;
input A;
endmodule

module BUF_X8_SVT (Z, A);
output Z;
input A;
endmodule

module BUF_X16_SVT (Z, A);
output Z;
input A;
endmodule

module BUF_X32_SVT (Z, A);
output Z;
input A;
endmodule

module BUF_X1_HVT (Z, A);
output Z;
input A;
endmodule

module BUF_X2_HVT (Z, A);
output Z;
input A;
endmodule

module BUF_X4_HVT (Z, A);
output Z;
input A;
endmodule

module BUF_X8_HVT (Z, A);
output Z;
input A;
endmodule

module BUF_X16_HVT (Z, A);
output Z;
input A;
endmodule

module BUF_X32_HVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X1 (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X2 (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X3 (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X1_LVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X2_LVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X3_LVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X1_SVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X2_SVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X3_SVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X1_HVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X2_HVT (Z, A);
output Z;
input A;
endmodule

module CLKBUF_X3_HVT (Z, A);
output Z;
input A;
endmodule

module CLKGATETST_X1 (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X2 (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X4 (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X8 (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X1_LVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X2_LVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X4_LVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X8_LVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X1_SVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X2_SVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X4_SVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X8_SVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X1_HVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X2_HVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X4_HVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATETST_X8_HVT (GCK, CK, E, SE);
output GCK;
input CK, E, SE;
endmodule

module CLKGATE_X1 (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X2 (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X4 (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X8 (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X1_LVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X2_LVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X4_LVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X8_LVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X1_SVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X2_SVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X4_SVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X8_SVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X1_HVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X2_HVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X4_HVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module CLKGATE_X8_HVT (GCK, CK, E);
output GCK;
input CK, E;
endmodule

module DFFRS_X1 (Q, QN, CK, D, RN, SN);
output Q, QN;
input CK, D, RN, SN;
endmodule

module DFFRS_X2 (Q, QN, CK, D, RN, SN);
output Q, QN;
input CK, D, RN, SN;
endmodule

module DFFRS_X1_LVT (Q, QN, CK, D, RN, SN);
output Q, QN;
input CK, D, RN, SN;
endmodule

module DFFRS_X2_LVT (Q, QN, CK, D, RN, SN);
output Q, QN;
input CK, D, RN, SN;
endmodule

module DFFRS_X1_SVT (Q, QN, CK, D, RN, SN);
output Q, QN;
input CK, D, RN, SN;
endmodule

module DFFRS_X2_SVT (Q, QN, CK, D, RN, SN);
output Q, QN;
input CK, D, RN, SN;
endmodule

module DFFRS_X1_HVT (Q, QN, CK, D, RN, SN);
output Q, QN;
input CK, D, RN, SN;
endmodule

module DFFRS_X2_HVT (Q, QN, CK, D, RN, SN);
output Q, QN;
input CK, D, RN, SN;
endmodule

module DFFR_X1 (Q, QN, CK, D, RN);
output Q, QN;
input CK, D, RN;
endmodule

module DFFR_X2 (Q, QN, CK, D, RN);
output Q, QN;
input CK, D, RN;
endmodule

module DFFR_X1_LVT (Q, QN, CK, D, RN);
output Q, QN;
input CK, D, RN;
endmodule

module DFFR_X2_LVT (Q, QN, CK, D, RN);
output Q, QN;
input CK, D, RN;
endmodule

module DFFR_X1_SVT (Q, QN, CK, D, RN);
output Q, QN;
input CK, D, RN;
endmodule

module DFFR_X2_SVT (Q, QN, CK, D, RN);
output Q, QN;
input CK, D, RN;
endmodule

module DFFR_X1_HVT (Q, QN, CK, D, RN);
output Q, QN;
input CK, D, RN;
endmodule

module DFFR_X2_HVT (Q, QN, CK, D, RN);
output Q, QN;
input CK, D, RN;
endmodule

module DFFS_X1 (Q, QN, CK, D, SN);
output Q, QN;
input CK, D, SN;
endmodule

module DFFS_X2 (Q, QN, CK, D, SN);
output Q, QN;
input CK, D, SN;
endmodule

module DFFS_X1_LVT (Q, QN, CK, D, SN);
output Q, QN;
input CK, D, SN;
endmodule

module DFFS_X2_LVT (Q, QN, CK, D, SN);
output Q, QN;
input CK, D, SN;
endmodule

module DFFS_X1_SVT (Q, QN, CK, D, SN);
output Q, QN;
input CK, D, SN;
endmodule

module DFFS_X2_SVT (Q, QN, CK, D, SN);
output Q, QN;
input CK, D, SN;
endmodule

module DFFS_X1_HVT (Q, QN, CK, D, SN);
output Q, QN;
input CK, D, SN;
endmodule

module DFFS_X2_HVT (Q, QN, CK, D, SN);
output Q, QN;
input CK, D, SN;
endmodule

module DFF_X1 (Q, QN, CK, D);
output Q, QN;
input CK, D;
endmodule

module DFF_X2 (Q, QN, CK, D);
output Q, QN;
input CK, D;
endmodule

module DFF_X1_LVT (Q, QN, CK, D);
output Q, QN;
input CK, D;
endmodule

module DFF_X2_LVT (Q, QN, CK, D);
output Q, QN;
input CK, D;
endmodule

module DFF_X1_SVT (Q, QN, CK, D);
output Q, QN;
input CK, D;
endmodule

module DFF_X2_SVT (Q, QN, CK, D);
output Q, QN;
input CK, D;
endmodule

module DFF_X1_HVT (Q, QN, CK, D);
output Q, QN;
input CK, D;
endmodule

module DFF_X2_HVT (Q, QN, CK, D);
output Q, QN;
input CK, D;
endmodule

module DLH_X1 (Q, D, G);
output Q;
input D, G;
endmodule

module DLH_X2 (Q, D, G);
output Q;
input D, G;
endmodule

module DLH_X1_LVT (Q, D, G);
output Q;
input D, G;
endmodule

module DLH_X2_LVT (Q, D, G);
output Q;
input D, G;
endmodule

module DLH_X1_SVT (Q, D, G);
output Q;
input D, G;
endmodule

module DLH_X2_SVT (Q, D, G);
output Q;
input D, G;
endmodule

module DLH_X1_HVT (Q, D, G);
output Q;
input D, G;
endmodule

module DLH_X2_HVT (Q, D, G);
output Q;
input D, G;
endmodule

module DLL_X1 (Q, D, GN);
output Q;
input D, GN;
endmodule

module DLL_X2 (Q, D, GN);
output Q;
input D, GN;
endmodule

module DLL_X1_LVT (Q, D, GN);
output Q;
input D, GN;
endmodule

module DLL_X2_LVT (Q, D, GN);
output Q;
input D, GN;
endmodule

module DLL_X1_SVT (Q, D, GN);
output Q;
input D, GN;
endmodule

module DLL_X2_SVT (Q, D, GN);
output Q;
input D, GN;
endmodule

module DLL_X1_HVT (Q, D, GN);
output Q;
input D, GN;
endmodule

module DLL_X2_HVT (Q, D, GN);
output Q;
input D, GN;
endmodule

module FA_X1 (CO, S, A, B, CI);
output CO, S;
input A, B, CI;
endmodule

module FA_X1_LVT (CO, S, A, B, CI);
output CO, S;
input A, B, CI;
endmodule

module FA_X1_SVT (CO, S, A, B, CI);
output CO, S;
input A, B, CI;
endmodule

module FA_X1_HVT (CO, S, A, B, CI);
output CO, S;
input A, B, CI;
endmodule

module FILLCELL_X1 ();
endmodule

module FILLCELL_X2 ();
endmodule

module FILLCELL_X4 ();
endmodule

module FILLCELL_X8 ();
endmodule

module FILLCELL_X16 ();
endmodule

module FILLCELL_X32 ();
endmodule

module FILLCELL_X1_LVT ();
endmodule

module FILLCELL_X2_LVT ();
endmodule

module FILLCELL_X4_LVT ();
endmodule

module FILLCELL_X8_LVT ();
endmodule

module FILLCELL_X16_LVT ();
endmodule

module FILLCELL_X32_LVT ();
endmodule

module FILLCELL_X1_SVT ();
endmodule

module FILLCELL_X2_SVT ();
endmodule

module FILLCELL_X4_SVT ();
endmodule

module FILLCELL_X8_SVT ();
endmodule

module FILLCELL_X16_SVT ();
endmodule

module FILLCELL_X32_SVT ();
endmodule

module FILLCELL_X1_HVT ();
endmodule

module FILLCELL_X2_HVT ();
endmodule

module FILLCELL_X4_HVT ();
endmodule

module FILLCELL_X8_HVT ();
endmodule

module FILLCELL_X16_HVT ();
endmodule

module FILLCELL_X32_HVT ();
endmodule

module HA_X1 (CO, S, A, B);
output CO, S;
input A, B;
endmodule

module HA_X1_LVT (CO, S, A, B);
output CO, S;
input A, B;
endmodule

module HA_X1_SVT (CO, S, A, B);
output CO, S;
input A, B;
endmodule

module HA_X1_HVT (CO, S, A, B);
output CO, S;
input A, B;
endmodule

module INV_X1 (ZN, A);
output ZN;
input A;
endmodule

module INV_X2 (ZN, A);
output ZN;
input A;
endmodule

module INV_X4 (ZN, A);
output ZN;
input A;
endmodule

module INV_X8 (ZN, A);
output ZN;
input A;
endmodule

module INV_X16 (ZN, A);
output ZN;
input A;
endmodule

module INV_X32 (ZN, A);
output ZN;
input A;
endmodule

module INV_X1_LVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X2_LVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X4_LVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X8_LVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X16_LVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X32_LVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X1_SVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X2_SVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X4_SVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X8_SVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X16_SVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X32_SVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X1_HVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X2_HVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X4_HVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X8_HVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X16_HVT (ZN, A);
output ZN;
input A;
endmodule

module INV_X32_HVT (ZN, A);
output ZN;
input A;
endmodule

module LOGIC0_X1 (Z);
output Z;
endmodule

module LOGIC0_X1_LVT (Z);
output Z;
endmodule

module LOGIC0_X1_SVT (Z);
output Z;
endmodule

module LOGIC0_X1_HVT (Z);
output Z;
endmodule

module LOGIC1_X1 (Z);
output Z;
endmodule

module LOGIC1_X1_LVT (Z);
output Z;
endmodule

module LOGIC1_X1_SVT (Z);
output Z;
endmodule

module LOGIC1_X1_HVT (Z);
output Z;
endmodule

module MUX2_X1 (Z, A, B, S);
output Z;
input A, B, S;
endmodule

module MUX2_X2 (Z, A, B, S);
output Z;
input A, B, S;
endmodule

module MUX2_X1_LVT (Z, A, B, S);
output Z;
input A, B, S;
endmodule

module MUX2_X2_LVT (Z, A, B, S);
output Z;
input A, B, S;
endmodule

module MUX2_X1_SVT (Z, A, B, S);
output Z;
input A, B, S;
endmodule

module MUX2_X2_SVT (Z, A, B, S);
output Z;
input A, B, S;
endmodule

module MUX2_X1_HVT (Z, A, B, S);
output Z;
input A, B, S;
endmodule

module MUX2_X2_HVT (Z, A, B, S);
output Z;
input A, B, S;
endmodule

module NAND2_X1 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X2 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X4 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X1_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X2_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X4_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X1_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X2_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X4_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X1_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X2_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND2_X4_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NAND3_X1 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X2 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X4 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X1_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X2_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X4_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X1_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X2_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X4_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X1_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X2_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND3_X4_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NAND4_X1 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X2 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X4 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X1_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X2_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X4_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X1_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X2_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X4_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X1_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X2_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NAND4_X4_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR2_X1 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X2 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X4 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X1_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X2_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X4_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X1_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X2_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X4_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X1_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X2_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR2_X4_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module NOR3_X1 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X2 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X4 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X1_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X2_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X4_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X1_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X2_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X4_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X1_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X2_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR3_X4_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module NOR4_X1 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X2 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X4 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X1_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X2_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X4_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X1_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X2_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X4_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X1_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X2_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module NOR4_X4_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OAI211_X1 (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X2 (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X4 (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X1_LVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X2_LVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X4_LVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X1_SVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211OAI211_X2_SVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X4_SVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X1_HVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X2_HVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI211_X4_HVT (ZN, A, B, C1, C2);
output ZN;
input A, B, C1, C2;
endmodule

module OAI21_X1 (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X2 (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X4 (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X1_LVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X2_LVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X4_LVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X1_SVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X2_SVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X4_SVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X1_HVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X2_HVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI21_X4_HVT (ZN, A, B1, B2);
output ZN;
input A, B1, B2;
endmodule

module OAI221_X1 (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X2 (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X4 (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X1_LVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X2_LVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X4_LVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X1_SVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X2_SVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X4_SVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X1_HVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X2_HVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI221_X4_HVT (ZN, A, B1, B2, C1, C2);
output ZN;
input A, B1, B2, C1, C2;
endmodule

module OAI222_X1 (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X2 (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X4 (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X1_LVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X2_LVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X4_LVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X1_SVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X2_SVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X4_SVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X1_HVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X2_HVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI222_X4_HVT (ZN, A1, A2, B1, B2, C1, C2);
output ZN;
input A1, A2, B1, B2, C1, C2;
endmodule

module OAI22_X1 (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X2 (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X4 (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X1_LVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X2_LVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X4_LVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X1_SVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X2_SVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X4_SVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X1_HVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X2_HVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI22_X4_HVT (ZN, A1, A2, B1, B2);
output ZN;
input A1, A2, B1, B2;
endmodule

module OAI33_X1 (ZN, A1, A2, A3, B1, B2, B3);
output ZN;
input A1, A2, A3, B1, B2, B3;
endmodule

module OAI33_X1_LVT (ZN, A1, A2, A3, B1, B2, B3);
output ZN;
input A1, A2, A3, B1, B2, B3;
endmodule

module OAI33_X1_SVT (ZN, A1, A2, A3, B1, B2, B3);
output ZN;
input A1, A2, A3, B1, B2, B3;
endmodule

module OAI33_X1_HVT (ZN, A1, A2, A3, B1, B2, B3);
output ZN;
input A1, A2, A3, B1, B2, B3;
endmodule

module OR2_X1 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X2 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X4 (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X1_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X2_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X4_LVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X1_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X2_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X4_SVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X1_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X2_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR2_X4_HVT (ZN, A1, A2);
output ZN;
input A1, A2;
endmodule

module OR3_X1 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X2 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X4 (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X1_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X2_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X4_LVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X1_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X2_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X4_SVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X1_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X2_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR3_X4_HVT (ZN, A1, A2, A3);
output ZN;
input A1, A2, A3;
endmodule

module OR4_X1 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X2 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X4 (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X1_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X2_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X4_LVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X1_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X2_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X4_SVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X1_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X2_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module OR4_X4_HVT (ZN, A1, A2, A3, A4);
output ZN;
input A1, A2, A3, A4;
endmodule

module SDFFRS_X1 (Q, QN, CK, D, RN, SE, SI, SN);
output Q, QN;
input CK, D, RN, SE, SI, SN;
endmodule

module SDFFRS_X2 (Q, QN, CK, D, RN, SE, SI, SN);
output Q, QN;
input CK, D, RN, SE, SI, SN;
endmodule

module SDFFRS_X1_LVT (Q, QN, CK, D, RN, SE, SI, SN);
output Q, QN;
input CK, D, RN, SE, SI, SN;
endmodule

module SDFFRS_X2_LVT (Q, QN, CK, D, RN, SE, SI, SN);
output Q, QN;
input CK, D, RN, SE, SI, SN;
endmodule

module SDFFRS_X1_SVT (Q, QN, CK, D, RN, SE, SI, SN);
output Q, QN;
input CK, D, RN, SE, SI, SN;
endmodule

module SDFFRS_X2_SVT (Q, QN, CK, D, RN, SE, SI, SN);
output Q, QN;
input CK, D, RN, SE, SI, SN;
endmodule

module SDFFRS_X1_HVT (Q, QN, CK, D, RN, SE, SI, SN);
output Q, QN;
input CK, D, RN, SE, SI, SN;
endmodule

module SDFFRS_X2_HVT (Q, QN, CK, D, RN, SE, SI, SN);
output Q, QN;
input CK, D, RN, SE, SI, SN;
endmodule

module SDFFR_X1 (Q, QN, CK, D, RN, SE, SI);
output Q, QN;
input CK, D, RN, SE, SI;
endmodule

module SDFFR_X2 (Q, QN, CK, D, RN, SE, SI);
output Q, QN;
input CK, D, RN, SE, SI;
endmodule

module SDFFR_X1_LVT (Q, QN, CK, D, RN, SE, SI);
output Q, QN;
input CK, D, RN, SE, SI;
endmodule

module SDFFR_X2_LVT (Q, QN, CK, D, RN, SE, SI);
output Q, QN;
input CK, D, RN, SE, SI;
endmodule

module SDFFR_X1_SVT (Q, QN, CK, D, RN, SE, SI);
output Q, QN;
input CK, D, RN, SE, SI;
endmodule

module SDFFR_X2_SVT (Q, QN, CK, D, RN, SE, SI);
output Q, QN;
input CK, D, RN, SE, SI;
endmodule

module SDFFR_X1_HVT (Q, QN, CK, D, RN, SE, SI);
output Q, QN;
input CK, D, RN, SE, SI;
endmodule

module SDFFR_X2_HVT (Q, QN, CK, D, RN, SE, SI);
output Q, QN;
input CK, D, RN, SE, SI;
endmodule

module SDFFS_X1 (Q, QN, CK, D, SE, SI, SN);
output Q, QN;
input CK, D, SE, SI, SN;
endmodule

module SDFFS_X2 (Q, QN, CK, D, SE, SI, SN);
output Q, QN;
input CK, D, SE, SI, SN;
endmodule

module SDFFS_X1_LVT (Q, QN, CK, D, SE, SI, SN);
output Q, QN;
input CK, D, SE, SI, SN;
endmodule

module SDFFS_X2_LVT (Q, QN, CK, D, SE, SI, SN);
output Q, QN;
input CK, D, SE, SI, SN;
endmodule

module SDFFS_X1_SVT (Q, QN, CK, D, SE, SI, SN);
output Q, QN;
input CK, D, SE, SI, SN;
endmodule

module SDFFS_X2_SVT (Q, QN, CK, D, SE, SI, SN);
output Q, QN;
input CK, D, SE, SI, SN;
endmodule

module SDFFS_X1_HVT (Q, QN, CK, D, SE, SI, SN);
output Q, QN;
input CK, D, SE, SI, SN;
endmodule

module SDFFS_X2_HVT (Q, QN, CK, D, SE, SI, SN);
output Q, QN;
input CK, D, SE, SI, SN;
endmodule

module SDFF_X1 (Q, QN, CK, D, SE, SI);
output Q, QN;
input CK, D, SE, SI;
endmodule

module SDFF_X2 (Q, QN, CK, D, SE, SI);
output Q, QN;
input CK, D, SE, SI;
endmodule

module SDFF_X1_LVT (Q, QN, CK, D, SE, SI);
output Q, QN;
input CK, D, SE, SI;
endmodule

module SDFF_X2_LVT (Q, QN, CK, D, SE, SI);
output Q, QN;
input CK, D, SE, SI;
endmodule

module SDFF_X1_SVT (Q, QN, CK, D, SE, SI);
output Q, QN;
input CK, D, SE, SI;
endmodule

module SDFF_X2_SVT (Q, QN, CK, D, SE, SI);
output Q, QN;
input CK, D, SE, SI;
endmodule

module SDFF_X1_HVT (Q, QN, CK, D, SE, SI);
output Q, QN;
input CK, D, SE, SI;
endmodule

module SDFF_X2_HVT (Q, QN, CK, D, SE, SI);
output Q, QN;
input CK, D, SE, SI;
endmodule

module TBUF_X1 (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X2 (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X4 (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X8 (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X16 (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X1_LVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X2_LVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X4_LVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X8_LVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X16_LVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X1_SVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X2_SVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X4_SVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X8_SVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X16_SVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X1_HVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X2_HVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X4_HVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X8_HVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TBUF_X16_HVT (Z, A, EN);
output Z;
input A, EN;
endmodule

module TINV_X1 (ZN, EN, I);
output ZN;
input EN, I;
endmodule

module TINV_X1_LVT (ZN, EN, I);
output ZN;
input EN, I;
endmodule

module TINV_X1_SVT (ZN, EN, I);
output ZN;
input EN, I;
endmodule

module TINV_X1_HVT (ZN, EN, I);
output ZN;
input EN, I;
endmodule

module TLAT_X1 (Q, D, G, OE);
output Q;
input D, G, OE;
endmodule

module TLAT_X1_LVT (Q, D, G, OE);
output Q;
input D, G, OE;
endmodule

module TLAT_X1_SVT (Q, D, G, OE);
output Q;
input D, G, OE;
endmodule

module TLAT_X1_HVT (Q, D, G, OE);
output Q;
input D, G, OE;
endmodule

module XNOR2_X1 (ZN, A, B);
output ZN;
input A, B;
endmodule

module XNOR2_X2 (ZN, A, B);
output ZN;
input A, B;
endmodule

module XNOR2_X1_LVT (ZN, A, B);
output ZN;
input A, B;
endmodule

module XNOR2_X2_LVT (ZN, A, B);
output ZN;
input A, B;
endmodule

module XNOR2_X1_SVT (ZN, A, B);
output ZN;
input A, B;
endmodule

module XNOR2_X2_SVT (ZN, A, B);
output ZN;
input A, B;
endmodule

module XNOR2_X1_HVT (ZN, A, B);
output ZN;
input A, B;
endmodule

module XNOR2_X2_HVT (ZN, A, B);
output ZN;
input A, B;
endmodule

module XOR2_X1 (Z, A, B);
output Z;
input A, B;
endmodule

module XOR2_X2 (Z, A, B);
output Z;
input A, B;
endmodule

module XOR2_X1_LVT (Z, A, B);
output Z;
input A, B;
endmodule

module XOR2_X2_LVT (Z, A, B);
output Z;
input A, B;
endmodule

module XOR2_X1_SVT (Z, A, B);
output Z;
input A, B;
endmodule

module XOR2_X2_SVT (Z, A, B);
output Z;
input A, B;
endmodule

module XOR2_X1_HVT (Z, A, B);
output Z;
input A, B;
endmodule

module XOR2_X2_HVT (Z, A, B);
output Z;
input A, B;
endmodule

`endcelldefine
