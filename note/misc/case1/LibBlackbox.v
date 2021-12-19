module PLL(BYPASS, DIVF0, DIVF1, DIVF2,DIVF3, DIVF4, DIVF5, DIVF6,DIVF7, DIVQ0, DIVQ1, DIVQ2,
   DIVR0, DIVR1, DIVR2, DIVR3,DIVR4, DIVR5, FB, FSE,LOCK, PLLOUT, RANGE0, RANGE1,RANGE2, REF, RESET);
  input BYPASS;
  input DIVF0;
  input DIVF1;
  input DIVF2;
  input DIVF3;
  input DIVF4;
  input DIVF5;
  input DIVF6;
  input DIVF7;
  input DIVQ0;
  input DIVQ1;
  input DIVQ2;
  input DIVR0;
  input DIVR1;
  input DIVR2;
  input DIVR3;
  input DIVR4;
  input DIVR5;
  input FB;
  input FSE;
  input RANGE0;
  input RANGE1;
  input RANGE2;
  input REF;
  input RESET;
  output LOCK;
  output PLLOUT;
endmodule

module PADBID(C, I, OEN, PAD);
  input I;
  input OEN;
  inout PAD;
  output C;
endmodule

module PADCLK(C, PAD);
  input PAD;
  output C;
endmodule

module AON_BUF_X1(A, Z);
  input A;
  output Z;
endmodule

module AON_BUF_X2(A, Z);
  input A;
  output Z;
endmodule

module AON_BUF_X4(A, Z);
  input A;
  output Z;
endmodule

module AON_INV_X1(A, Z);
  input A;
  output Z;
endmodule

module AON_INV_X2(A, Z);
  input A;
  output Z;
endmodule

module AON_INV_X4(A, Z);
  input A;
  output Z;
endmodule

module HEADER_OE_X1(SLEEP, SLEEPOUT);
  input SLEEP;
  output SLEEPOUT;
endmodule

module HEADER_OE_X2(SLEEP, SLEEPOUT);
  input SLEEP;
  output SLEEPOUT;
endmodule

module HEADER_OE_X4(SLEEP, SLEEPOUT);
  input SLEEP;
  output SLEEPOUT;
endmodule

module HEADER_X1(SLEEP);
  input SLEEP;
endmodule

module HEADER_X2(SLEEP);
  input SLEEP;
endmodule

module HEADER_X4(SLEEP);
  input SLEEP;
endmodule

module ISO_FENCE0N_X1(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE0N_X2(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE0N_X4(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE0_X1(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE0_X2(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE0_X4(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE1N_X1(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE1N_X2(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE1N_X4(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE1_X1(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE1_X2(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module ISO_FENCE1_X4(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module LS_HLEN_X1(A, ISOLN, Z);
  input A;
  input ISOLN;
  output Z;
endmodule

module LS_HLEN_X2(A, ISOLN, Z);
  input A;
  input ISOLN;
  output Z;
endmodule

module LS_HLEN_X4(A, ISOLN, Z);
  input A;
  input ISOLN;
  output Z;
endmodule

module LS_HL_X1(A, Z);
  input A;
  output Z;
endmodule

module LS_HL_X2(A, Z);
  input A;
  output Z;
endmodule

module LS_HL_X4(A, Z);
  input A;
  output Z;
endmodule

module LS_LHEN_X1(A, ISOLN, Z);
  input A;
  input ISOLN;
  output Z;
endmodule

module LS_LHEN_X2(A, ISOLN, Z);
  input A;
  input ISOLN;
  output Z;
endmodule

module LS_LHEN_X4(A, ISOLN, Z);
  input A;
  input ISOLN;
  output Z;
endmodule

module LS_LH_X1(A, Z);
  input A;
  output Z;
endmodule

module LS_LH_X2(A, Z);
  input A;
  output Z;
endmodule

module LS_LH_X4(A, Z);
  input A;
  output Z;
endmodule

module AND2_X1_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND2_X2_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND2_X4_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND3_X1_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND3_X2_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND3_X4_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND4_X1_HVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module AND4_X2_HVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module AND4_X4_HVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module ANTENNA_X1_HVT(A);
  input A;
endmodule

module AOI211_X1_HVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI211_X2_HVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI211_X4_HVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI21_X1_HVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI21_X2_HVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI21_X4_HVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI221_X1_HVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI221_X2_HVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI221_X4_HVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X1_HVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X2_HVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X4_HVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI22_X1_HVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI22_X2_HVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI22_X4_HVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module BUF_X16_HVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X1_HVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X2_HVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X32_HVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X4_HVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X8_HVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X1_HVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X2_HVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X3_HVT(A, Z);
  input A;
  output Z;
endmodule

/* module "CLKGATETST_X1_HVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X1_HVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X2_HVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X2_HVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X4_HVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X4_HVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X8_HVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X8_HVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATE_X1_HVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X1_HVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X2_HVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X2_HVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X4_HVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X4_HVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X8_HVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X8_HVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

module DFFRS_X1_HVT(CK, D, Q, QN,RN, SN);
  input CK;
  input D;
  input RN;
  input SN;
  output Q;
  output QN;
endmodule

module DFFRS_X2_HVT(CK, D, Q, QN,RN, SN);
  input CK;
  input D;
  input RN;
  input SN;
  output Q;
  output QN;
endmodule

module DFFR_X1_HVT(CK, D, Q, QN,RN);
  input CK;
  input D;
  input RN;
  output Q;
  output QN;
endmodule

module DFFR_X2_HVT(CK, D, Q, QN,RN);
  input CK;
  input D;
  input RN;
  output Q;
  output QN;
endmodule

module DFFS_X1_HVT(CK, D, Q, QN, SN);
  input CK;
  input D;
  input SN;
  output Q;
  output QN;
endmodule

module DFFS_X2_HVT(CK, D, Q, QN, SN);
  input CK;
  input D;
  input SN;
  output Q;
  output QN;
endmodule

module DFF_X1_HVT(CK, D, Q, QN);
  input CK;
  input D;
  output Q;
  output QN;
endmodule

module DFF_X2_HVT(CK, D, Q, QN);
  input CK;
  input D;
  output Q;
  output QN;
endmodule

module DLH_X1_HVT(D, G, Q);
  input D;
  input G;
  output Q;
endmodule

module DLH_X2_HVT(D, G, Q);
  input D;
  input G;
  output Q;
endmodule

module DLL_X1_HVT(D, GN, Q);
  input D;
  input GN;
  output Q;
endmodule

module DLL_X2_HVT(D, GN, Q);
  input D;
  input GN;
  output Q;
endmodule

module FA_X1_HVT(A, B, CI, CO,S);
  input A;
  input B;
  input CI;
  output CO;
  output S;
endmodule

module FILLCELL_X16_HVT();
endmodule

module FILLCELL_X1_HVT( );
endmodule

module FILLCELL_X2_HVT( );
endmodule

module FILLCELL_X32_HVT( );
endmodule

module FILLCELL_X4_HVT( );
endmodule

module FILLCELL_X8_HVT( );
endmodule

module HA_X1_HVT(A, B, CO, S);
  input A;
  input B;
  output CO;
  output S;
endmodule

module INV_X16_HVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X1_HVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X2_HVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X32_HVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X4_HVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X8_HVT(A, ZN);
  input A;
  output ZN;
endmodule

module LOGIC0_X1_HVT(Z);
  output Z;
endmodule

module LOGIC1_X1_HVT(Z);
  output Z;
endmodule

module MUX2_X1_HVT(A, B, S, Z);
  input A;
  input B;
  input S;
  output Z;
endmodule

module MUX2_X2_HVT(A, B, S, Z);
  input A;
  input B;
  input S;
  output Z;
endmodule

module NAND2_X1_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND2_X2_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND2_X4_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND3_X1_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND3_X2_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND3_X4_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND4_X1_HVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NAND4_X2_HVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NAND4_X4_HVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR2_X1_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR2_X2_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR2_X4_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR3_X1_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR3_X2_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR3_X4_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR4_X1_HVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR4_X2_HVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR4_X4_HVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OAI211_X1_HVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI211_X2_HVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI211_X4_HVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI21_X1_HVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI21_X2_HVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI21_X4_HVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI221_X1_HVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI221_X2_HVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI221_X4_HVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X1_HVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X2_HVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X4_HVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI22_X1_HVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI22_X2_HVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI22_X4_HVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI33_X1_HVT(A1, A2, A3, B1,B2, B3, ZN);
  input A1;
  input A2;
  input A3;
  input B1;
  input B2;
  input B3;
  output ZN;
endmodule

module OR2_X1_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR2_X2_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR2_X4_HVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR3_X1_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR3_X2_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR3_X4_HVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR4_X1_HVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OR4_X2_HVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OR4_X4_HVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module SDFFRS_X1_HVT(CK, D, Q, QN,RN, SE, SI, SN);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFRS_X2_HVT(CK, D, Q, QN,RN, SE, SI, SN);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFR_X1_HVT(CK, D, Q, QN,RN, SE, SI);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFFR_X2_HVT(CK, D, Q, QN,RN, SE, SI);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFFS_X1_HVT(CK, D, Q, QN, SE, SI, SN);
  input CK;
  input D;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFS_X2_HVT(CK, D, Q, QN, SE, SI, SN);
  input CK;
  input D;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFF_X1_HVT(CK, D, Q, QN,SE, SI);
  input CK;
  input D;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFF_X2_HVT(CK, D, Q, QN,SE, SI);
  input CK;
  input D;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module TBUF_X16_HVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X1_HVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X2_HVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X4_HVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X8_HVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TINV_X1_HVT(EN, I, ZN);
  input EN;
  input I;
  output ZN;
endmodule

module TLAT_X1_HVT(D, G, OE, Q);
  input D;
  input G;
  input OE;
  output Q;
endmodule

module XNOR2_X1_HVT(A, B, ZN);
  input A;
  input B;
  output ZN;
endmodule

module XNOR2_X2_HVT(A, B, ZN);
  input A;
  input B;
  output ZN;
endmodule

module XOR2_X1_HVT(A, B, Z);
  input A;
  input B;
  output Z;
endmodule

module XOR2_X2_HVT(A, B, Z);
  input A;
  input B;
  output Z;
endmodule

module AND2_X1_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND2_X2_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND2_X4_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND3_X1_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND3_X2_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND3_X4_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND4_X1_LVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module AND4_X2_LVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module AND4_X4_LVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module ANTENNA_X1_LVT(A);
  input A;
endmodule

module AOI211_X1_LVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI211_X2_LVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI211_X4_LVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI21_X1_LVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI21_X2_LVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI21_X4_LVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI221_X1_LVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI221_X2_LVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI221_X4_LVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X1_LVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X2_LVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X4_LVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI22_X1_LVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI22_X2_LVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI22_X4_LVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module BUF_X16_LVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X1_LVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X2_LVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X32_LVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X4_LVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X8_LVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X1_LVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X2_LVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X3_LVT(A, Z);
  input A;
  output Z;
endmodule

/* module "CLKGATETST_X1_LVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X1_LVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X2_LVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X2_LVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X4_LVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X4_LVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X8_LVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X8_LVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATE_X1_LVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X1_LVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X2_LVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X2_LVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X4_LVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X4_LVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X8_LVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X8_LVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

module DFFRS_X1_LVT(CK, D, Q, QN,RN, SN);
  input CK;
  input D;
  input RN;
  input SN;
  output Q;
  output QN;
endmodule

module DFFRS_X2_LVT(CK, D, Q, QN,RN, SN);
  input CK;
  input D;
  input RN;
  input SN;
  output Q;
  output QN;
endmodule

module DFFR_X1_LVT(CK, D, Q, QN,RN);
  input CK;
  input D;
  input RN;
  output Q;
  output QN;
endmodule

module DFFR_X2_LVT(CK, D, Q, QN,RN);
  input CK;
  input D;
  input RN;
  output Q;
  output QN;
endmodule

module DFFS_X1_LVT(CK, D, Q, QN, SN);
  input CK;
  input D;
  input SN;
  output Q;
  output QN;
endmodule

module DFFS_X2_LVT(CK, D, Q, QN, SN);
  input CK;
  input D;
  input SN;
  output Q;
  output QN;
endmodule

module DFF_X1_LVT(CK, D, Q, QN);
  input CK;
  input D;
  output Q;
  output QN;
endmodule

module DFF_X2_LVT(CK, D, Q, QN);
  input CK;
  input D;
  output Q;
  output QN;
endmodule

module DLH_X1_LVT(D, G, Q);
  input D;
  input G;
  output Q;
endmodule

module DLH_X2_LVT(D, G, Q);
  input D;
  input G;
  output Q;
endmodule

module DLL_X1_LVT(D, GN, Q);
  input D;
  input GN;
  output Q;
endmodule

module DLL_X2_LVT(D, GN, Q);
  input D;
  input GN;
  output Q;
endmodule

module FA_X1_LVT(A, B, CI, CO,S);
  input A;
  input B;
  input CI;
  output CO;
  output S;
endmodule

module FILLCELL_X16_LVT();
endmodule

module FILLCELL_X1_LVT( );
endmodule

module FILLCELL_X2_LVT( );
endmodule

module FILLCELL_X32_LVT( );
endmodule

module FILLCELL_X4_LVT( );
endmodule

module FILLCELL_X8_LVT( );
endmodule

module HA_X1_LVT(A, B, CO, S);
  input A;
  input B;
  output CO;
  output S;
endmodule

module INV_X16_LVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X1_LVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X2_LVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X32_LVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X4_LVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X8_LVT(A, ZN);
  input A;
  output ZN;
endmodule

module LOGIC0_X1_LVT(Z);
  output Z;
endmodule

module LOGIC1_X1_LVT(Z);
  output Z;
endmodule

module MUX2_X1_LVT(A, B, S, Z);
  input A;
  input B;
  input S;
  output Z;
endmodule

module MUX2_X2_LVT(A, B, S, Z);
  input A;
  input B;
  input S;
  output Z;
endmodule

module NAND2_X1_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND2_X2_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND2_X4_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND3_X1_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND3_X2_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND3_X4_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND4_X1_LVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NAND4_X2_LVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NAND4_X4_LVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR2_X1_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR2_X2_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR2_X4_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR3_X1_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR3_X2_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR3_X4_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR4_X1_LVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR4_X2_LVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR4_X4_LVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OAI211_X1_LVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI211_X2_LVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI211_X4_LVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI21_X1_LVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI21_X2_LVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI21_X4_LVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI221_X1_LVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI221_X2_LVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI221_X4_LVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X1_LVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X2_LVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X4_LVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI22_X1_LVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI22_X2_LVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI22_X4_LVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI33_X1_LVT(A1, A2, A3, B1,B2, B3, ZN);
  input A1;
  input A2;
  input A3;
  input B1;
  input B2;
  input B3;
  output ZN;
endmodule

module OR2_X1_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR2_X2_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR2_X4_LVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR3_X1_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR3_X2_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR3_X4_LVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR4_X1_LVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OR4_X2_LVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OR4_X4_LVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module SDFFRS_X1_LVT(CK, D, Q, QN,RN, SE, SI, SN);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFRS_X2_LVT(CK, D, Q, QN,RN, SE, SI, SN);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFR_X1_LVT(CK, D, Q, QN,RN, SE, SI);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFFR_X2_LVT(CK, D, Q, QN,RN, SE, SI);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFFS_X1_LVT(CK, D, Q, QN, SE, SI, SN);
  input CK;
  input D;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFS_X2_LVT(CK, D, Q, QN, SE, SI, SN);
  input CK;
  input D;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFF_X1_LVT(CK, D, Q, QN,SE, SI);
  input CK;
  input D;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFF_X2_LVT(CK, D, Q, QN,SE, SI);
  input CK;
  input D;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module TBUF_X16_LVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X1_LVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X2_LVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X4_LVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X8_LVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TINV_X1_LVT(EN, I, ZN);
  input EN;
  input I;
  output ZN;
endmodule

module TLAT_X1_LVT(D, G, OE, Q);
  input D;
  input G;
  input OE;
  output Q;
endmodule

module XNOR2_X1_LVT(A, B, ZN);
  input A;
  input B;
  output ZN;
endmodule

module XNOR2_X2_LVT(A, B, ZN);
  input A;
  input B;
  output ZN;
endmodule

module XOR2_X1_LVT(A, B, Z);
  input A;
  input B;
  output Z;
endmodule

module XOR2_X2_LVT(A, B, Z);
  input A;
  input B;
  output Z;
endmodule

module AND2_X1_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND2_X2_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND2_X4_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND3_X1_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND3_X2_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND3_X4_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND4_X1_SVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module AND4_X2_SVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module AND4_X4_SVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module ANTENNA_X1_SVT(A);
  input A;
endmodule

module AOI211_X1_SVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI211_X2_SVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI211_X4_SVT(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI21_X1_SVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI21_X2_SVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI21_X4_SVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI221_X1_SVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI221_X2_SVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI221_X4_SVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X1_SVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X2_SVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X4_SVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI22_X1_SVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI22_X2_SVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI22_X4_SVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module BUF_X16_SVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X1_SVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X2_SVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X32_SVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X4_SVT(A, Z);
  input A;
  output Z;
endmodule

module BUF_X8_SVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X1_SVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X2_SVT(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X3_SVT(A, Z);
  input A;
  output Z;
endmodule

/* module "CLKGATETST_X1_SVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X1_SVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X2_SVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X2_SVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X4_SVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X4_SVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X8_SVT_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X8_SVT(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATE_X1_SVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X1_SVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X2_SVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X2_SVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X4_SVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X4_SVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X8_SVT_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X8_SVT(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

module DFFRS_X1_SVT(CK, D, Q, QN,RN, SN);
  input CK;
  input D;
  input RN;
  input SN;
  output Q;
  output QN;
endmodule

module DFFRS_X2_SVT(CK, D, Q, QN,RN, SN);
  input CK;
  input D;
  input RN;
  input SN;
  output Q;
  output QN;
endmodule

module DFFR_X1_SVT(CK, D, Q, QN,RN);
  input CK;
  input D;
  input RN;
  output Q;
  output QN;
endmodule

module DFFR_X2_SVT(CK, D, Q, QN,RN);
  input CK;
  input D;
  input RN;
  output Q;
  output QN;
endmodule

module DFFS_X1_SVT(CK, D, Q, QN, SN);
  input CK;
  input D;
  input SN;
  output Q;
  output QN;
endmodule

module DFFS_X2_SVT(CK, D, Q, QN, SN);
  input CK;
  input D;
  input SN;
  output Q;
  output QN;
endmodule

module DFF_X1_SVT(CK, D, Q, QN);
  input CK;
  input D;
  output Q;
  output QN;
endmodule

module DFF_X2_SVT(CK, D, Q, QN);
  input CK;
  input D;
  output Q;
  output QN;
endmodule

module DLH_X1_SVT(D, G, Q);
  input D;
  input G;
  output Q;
endmodule

module DLH_X2_SVT(D, G, Q);
  input D;
  input G;
  output Q;
endmodule

module DLL_X1_SVT(D, GN, Q);
  input D;
  input GN;
  output Q;
endmodule

module DLL_X2_SVT(D, GN, Q);
  input D;
  input GN;
  output Q;
endmodule

module FA_X1_SVT(A, B, CI, CO,S);
  input A;
  input B;
  input CI;
  output CO;
  output S;
endmodule

module FILLCELL_X16_SVT();
endmodule

module FILLCELL_X1_SVT( );
endmodule

module FILLCELL_X2_SVT( );
endmodule

module FILLCELL_X32_SVT( );
endmodule

module FILLCELL_X4_SVT( );
endmodule

module FILLCELL_X8_SVT( );
endmodule

module HA_X1_SVT(A, B, CO, S);
  input A;
  input B;
  output CO;
  output S;
endmodule

module INV_X16_SVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X1_SVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X2_SVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X32_SVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X4_SVT(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X8_SVT(A, ZN);
  input A;
  output ZN;
endmodule

module LOGIC0_X1_SVT(Z);
  output Z;
endmodule

module LOGIC1_X1_SVT(Z);
  output Z;
endmodule

module MUX2_X1_SVT(A, B, S, Z);
  input A;
  input B;
  input S;
  output Z;
endmodule

module MUX2_X2_SVT(A, B, S, Z);
  input A;
  input B;
  input S;
  output Z;
endmodule

module NAND2_X1_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND2_X2_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND2_X4_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND3_X1_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND3_X2_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND3_X4_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND4_X1_SVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NAND4_X2_SVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NAND4_X4_SVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR2_X1_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR2_X2_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR2_X4_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR3_X1_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR3_X2_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR3_X4_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR4_X1_SVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR4_X2_SVT(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR4_X4_SVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OAI211_X1_SVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI211_X2_SVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI211_X4_SVT(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI21_X1_SVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI21_X2_SVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI21_X4_SVT(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI221_X1_SVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI221_X2_SVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI221_X4_SVT(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X1_SVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X2_SVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X4_SVT(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI22_X1_SVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI22_X2_SVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI22_X4_SVT(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI33_X1_SVT(A1, A2, A3, B1,B2, B3, ZN);
  input A1;
  input A2;
  input A3;
  input B1;
  input B2;
  input B3;
  output ZN;
endmodule

module OR2_X1_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR2_X2_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR2_X4_SVT(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR3_X1_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR3_X2_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR3_X4_SVT(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR4_X1_SVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OR4_X2_SVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OR4_X4_SVT(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module SDFFRS_X1_SVT(CK, D, Q, QN,RN, SE, SI, SN);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFRS_X2_SVT(CK, D, Q, QN,RN, SE, SI, SN);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFR_X1_SVT(CK, D, Q, QN,RN, SE, SI);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFFR_X2_SVT(CK, D, Q, QN,RN, SE, SI);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFFS_X1_SVT(CK, D, Q, QN, SE, SI, SN);
  input CK;
  input D;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFS_X2_SVT(CK, D, Q, QN, SE, SI, SN);
  input CK;
  input D;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFF_X1_SVT(CK, D, Q, QN,SE, SI);
  input CK;
  input D;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFF_X2_SVT(CK, D, Q, QN,SE, SI);
  input CK;
  input D;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module TBUF_X16_SVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X1_SVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X2_SVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X4_SVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X8_SVT(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TINV_X1_SVT(EN, I, ZN);
  input EN;
  input I;
  output ZN;
endmodule

module TLAT_X1_SVT(D, G, OE, Q);
  input D;
  input G;
  input OE;
  output Q;
endmodule

module XNOR2_X1_SVT(A, B, ZN);
  input A;
  input B;
  output ZN;
endmodule

module XNOR2_X2_SVT(A, B, ZN);
  input A;
  input B;
  output ZN;
endmodule

module XOR2_X1_SVT(A, B, Z);
  input A;
  input B;
  output Z;
endmodule

module XOR2_X2_SVT(A, B, Z);
  input A;
  input B;
  output Z;
endmodule

module AND2_X1(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND2_X2(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND2_X4(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module AND3_X1(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND3_X2(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND3_X4(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module AND4_X1(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module AND4_X2(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module AND4_X4(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module ANTENNA_X1(A);
  input A;
endmodule

module AOI211_X1(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI211_X2(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI211_X4(A, B, C1, C2,ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI21_X1(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI21_X2(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI21_X4(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI221_X1(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI221_X2(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI221_X4(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X1(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X2(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI222_X4(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module AOI22_X1(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI22_X2(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module AOI22_X4(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module BUF_X16(A, Z);
  input A;
  output Z;
endmodule

module BUF_X1(A, Z);
  input A;
  output Z;
endmodule

module BUF_X2(A, Z);
  input A;
  output Z;
endmodule

module BUF_X32(A, Z);
  input A;
  output Z;
endmodule

module BUF_X4(A, Z);
  input A;
  output Z;
endmodule

module BUF_X8(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X1(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X2(A, Z);
  input A;
  output Z;
endmodule

module CLKBUF_X3(A, Z);
  input A;
  output Z;
endmodule

/* module "CLKGATETST_X1_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X1(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X2_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X2(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X4_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X4(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATETST_X8_$_IQ"(CK, E, SE, IQ);
 *   input CK;
 *   input E;
 *   input SE;
 *   output IQ;
 * endmodule */

module CLKGATETST_X8(CK, E, GCK, SE);
    input CK;
    input E;
    input SE;
    output GCK;
endmodule

/* module "CLKGATE_X1_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X1(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X2_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X2(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X4_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X4(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

/* module "CLKGATE_X8_$_IQ"(CK, E, IQ);
 *     input CK;
 *     input E;
 *     output IQ;
 * endmodule */

module CLKGATE_X8(CK, E, GCK);
  input CK;
  input E;
  output GCK;
endmodule

module DFFRS_X1(CK, D, Q, QN,RN, SN);
  input CK;
  input D;
  input RN;
  input SN;
  output Q;
  output QN;
endmodule

module DFFRS_X2(CK, D, Q, QN,RN, SN);
  input CK;
  input D;
  input RN;
  input SN;
  output Q;
  output QN;
endmodule

module DFFR_X1(CK, D, Q, QN,RN);
  input CK;
  input D;
  input RN;
  output Q;
  output QN;
endmodule

module DFFR_X2(CK, D, Q, QN,RN);
  input CK;
  input D;
  input RN;
  output Q;
  output QN;
endmodule

module DFFS_X1(CK, D, Q, QN, SN);
  input CK;
  input D;
  input SN;
  output Q;
  output QN;
endmodule

module DFFS_X2(CK, D, Q, QN, SN);
  input CK;
  input D;
  input SN;
  output Q;
  output QN;
endmodule

module DFF_X1(CK, D, Q, QN);
  input CK;
  input D;
  output Q;
  output QN;
endmodule

module DFF_X2(CK, D, Q, QN);
  input CK;
  input D;
  output Q;
  output QN;
endmodule

module DLH_X1(D, G, Q);
  input D;
  input G;
  output Q;
endmodule

module DLH_X2(D, G, Q);
  input D;
  input G;
  output Q;
endmodule

module DLL_X1(D, GN, Q);
  input D;
  input GN;
  output Q;
endmodule

module DLL_X2(D, GN, Q);
  input D;
  input GN;
  output Q;
endmodule

module FA_X1(A, B, CI, CO,S);
  input A;
  input B;
  input CI;
  output CO;
  output S;
endmodule

module FILLCELL_X16();
endmodule

module FILLCELL_X1( );
endmodule

module FILLCELL_X2( );
endmodule

module FILLCELL_X32( );
endmodule

module FILLCELL_X4( );
endmodule

module FILLCELL_X8( );
endmodule

module HA_X1(A, B, CO, S);
  input A;
  input B;
  output CO;
  output S;
endmodule

module INV_X16(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X1(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X2(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X32(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X4(A, ZN);
  input A;
  output ZN;
endmodule

module INV_X8(A, ZN);
  input A;
  output ZN;
endmodule

module LOGIC0_X1(Z);
  output Z;
endmodule

module LOGIC1_X1(Z);
  output Z;
endmodule

module MUX2_X1(A, B, S, Z);
  input A;
  input B;
  input S;
  output Z;
endmodule

module MUX2_X2(A, B, S, Z);
  input A;
  input B;
  input S;
  output Z;
endmodule

module NAND2_X1(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND2_X2(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND2_X4(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NAND3_X1(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND3_X2(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND3_X4(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NAND4_X1(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NAND4_X2(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NAND4_X4(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR2_X1(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR2_X2(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR2_X4(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module NOR3_X1(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR3_X2(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR3_X4(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module NOR4_X1(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR4_X2(A1, A2, A3, A4,ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module NOR4_X4(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OAI211_X1(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI211_X2(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI211_X4(A, B, C1, C2, ZN);
  input A;
  input B;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI21_X1(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI21_X2(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI21_X4(A, B1, B2, ZN);
  input A;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI221_X1(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI221_X2(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI221_X4(A, B1, B2, C1,C2, ZN);
  input A;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X1(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X2(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI222_X4(A1, A2, B1, B2,C1, C2, ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  input C1;
  input C2;
  output ZN;
endmodule

module OAI22_X1(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI22_X2(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI22_X4(A1, A2, B1, B2,ZN);
  input A1;
  input A2;
  input B1;
  input B2;
  output ZN;
endmodule

module OAI33_X1(A1, A2, A3, B1,B2, B3, ZN);
  input A1;
  input A2;
  input A3;
  input B1;
  input B2;
  input B3;
  output ZN;
endmodule

module OR2_X1(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR2_X2(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR2_X4(A1, A2, ZN);
  input A1;
  input A2;
  output ZN;
endmodule

module OR3_X1(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR3_X2(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR3_X4(A1, A2, A3, ZN);
  input A1;
  input A2;
  input A3;
  output ZN;
endmodule

module OR4_X1(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OR4_X2(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module OR4_X4(A1, A2, A3, A4, ZN);
  input A1;
  input A2;
  input A3;
  input A4;
  output ZN;
endmodule

module SDFFRS_X1(CK, D, Q, QN,RN, SE, SI, SN);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFRS_X2(CK, D, Q, QN,RN, SE, SI, SN);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFR_X1(CK, D, Q, QN,RN, SE, SI);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFFR_X2(CK, D, Q, QN,RN, SE, SI);
  input CK;
  input D;
  input RN;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFFS_X1(CK, D, Q, QN, SE, SI, SN);
  input CK;
  input D;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFFS_X2(CK, D, Q, QN, SE, SI, SN);
  input CK;
  input D;
  input SE;
  input SI;
  input SN;
  output Q;
  output QN;
endmodule

module SDFF_X1(CK, D, Q, QN,SE, SI);
  input CK;
  input D;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module SDFF_X2(CK, D, Q, QN,SE, SI);
  input CK;
  input D;
  input SE;
  input SI;
  output Q;
  output QN;
endmodule

module TBUF_X16(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X1(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X2(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X4(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TBUF_X8(A, EN, Z);
  input A;
  input EN;
  output Z;
endmodule

module TINV_X1(EN, I, ZN);
  input EN;
  input I;
  output ZN;
endmodule

module TLAT_X1(D, G, OE, Q);
  input D;
  input G;
  input OE;
  output Q;
endmodule

module XNOR2_X1(A, B, ZN);
  input A;
  input B;
  output ZN;
endmodule

module XNOR2_X2(A, B, ZN);
  input A;
  input B;
  output ZN;
endmodule

module XOR2_X1(A, B, Z);
  input A;
  input B;
  output Z;
endmodule

module XOR2_X2(A, B, Z);
  input A;
  input B;
  output Z;
endmodule

module MemGen_16_10(chip_en, wr_en, addr, wr_data, clock, rd_en, rd_data);
	input chip_en;
	input wr_en;
  input[9:0] addr;
  input[15:0] wr_data;
  input clock;
  input rd_en;
  output[15:0] rd_data;
endmodule
