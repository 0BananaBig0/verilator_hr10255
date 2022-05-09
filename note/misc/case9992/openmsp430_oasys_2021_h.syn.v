/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 21.1-p005 on Thu Dec  9 08:43:36 2021
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 3628784443 */

module omsp_sync_reset__0_1432(rst_s, clk, rst_a);
   output rst_s;
   input clk;
   input rst_a;

   INV_X1_LVT i_0_0 (.A(rst_a), .ZN(n_0));
   DFFS_X1_LVT \data_sync_reg[0]  (.D(1'b0), .SN(n_0), .CK(clk), .Q(n_1), .QN());
   DFFS_X1_LVT \data_sync_reg[1]  (.D(n_1), .SN(n_0), .CK(clk), .Q(rst_s), .QN());
endmodule

module omsp_scan_mux__0_1427(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_sync_cell__1_13(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_sync_cell__1_11(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_sync_cell__0_1430(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_scan_mux__1_9(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_scan_mux__1_7(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_wakeup_cell__0_1428(wkup_out, scan_clk, scan_mode, scan_rst, 
      wkup_clear, wkup_event);
   output wkup_out;
   input scan_clk;
   input scan_mode;
   input scan_rst;
   input wkup_clear;
   input wkup_event;

   wire wkup_rst;
   wire wkup_clk;

   omsp_scan_mux__1_9 scan_mux_clk (.data_out(wkup_clk), .data_in_scan(scan_clk), 
      .data_in_func(wkup_event), .scan_mode(scan_mode));
   omsp_scan_mux__1_7 scan_mux_rst (.data_out(wkup_rst), .data_in_scan(scan_rst), 
      .data_in_func(wkup_clear), .scan_mode(scan_mode));
   INV_X1_LVT i_0_0 (.A(wkup_rst), .ZN(n_0));
   DFFR_X1_LVT wkup_out_reg (.D(1'b1), .RN(n_0), .CK(wkup_clk), .Q(wkup_out), 
      .QN());
endmodule

module omsp_and_gate__0_1424(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_watchdog(per_dout, wdt_irq, wdt_reset, wdt_wkup, wdtifg, wdtnmies, 
      aclk, aclk_en, dbg_freeze, mclk, per_addr, per_din, per_en, per_we, por, 
      puc_rst, scan_enable, scan_mode, smclk, smclk_en, wdtie, wdtifg_irq_clr, 
      wdtifg_sw_clr, wdtifg_sw_set);
   output [15:0]per_dout;
   output wdt_irq;
   output wdt_reset;
   output wdt_wkup;
   output wdtifg;
   output wdtnmies;
   input aclk;
   input aclk_en;
   input dbg_freeze;
   input mclk;
   input [13:0]per_addr;
   input [15:0]per_din;
   input per_en;
   input [1:0]per_we;
   input por;
   input puc_rst;
   input scan_enable;
   input scan_mode;
   input smclk;
   input smclk_en;
   input wdtie;
   input wdtifg_irq_clr;
   input wdtifg_sw_clr;
   input wdtifg_sw_set;

   wire wdt_rst_noscan;
   wire wdt_rst;
   wire wdtcnt_incr;
   wire wdtcnt_clr_sync;
   wire wdt_evt_toggle_sync;
   wire wdt_wkup_pre;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire n_0_4;
   wire reg_wr;
   wire [7:0]wdtctl;
   wire n_8_0;
   wire n_8_1;
   wire n_8_2;
   wire wdtpw_error;
   wire wdt_evt_toggle_sync_dly;
   wire n_9_0;
   wire wdtifg_set;
   wire n_10_0;
   wire wdtifg_clr;
   wire n_13_0;
   wire n_13_1;
   wire n_17_0;
   wire wdtcnt_clr_sync_dly;
   wire n_19_0;
   wire wdtcnt_clr;
   wire [15:0]wdtcnt;
   wire n_21_0;
   wire n_22_0;
   wire n_22_1;
   wire [15:0]wdtcnt_nxt;
   wire n_24_0;
   wire n_24_1;
   wire n_24_2;
   wire n_24_3;
   wire n_24_4;
   wire n_24_5;
   wire n_24_6;
   wire n_24_7;
   wire n_24_8;
   wire n_24_9;
   wire n_24_10;
   wire n_24_11;
   wire n_24_12;
   wire n_24_13;
   wire n_24_14;
   wire [1:0]wdtisx_ss;
   wire [1:0]wdtisx_s;
   wire n_28_0;
   wire n_28_1;
   wire n_28_2;
   wire n_28_3;
   wire n_28_4;
   wire n_28_5;
   wire n_28_6;
   wire n_28_7;
   wire n_28_8;
   wire wdtqn_reg;
   wire wdtqn_edge;
   wire wdt_evt_toggle;
   wire wdt_wkup_en;
   wire n_35_0;
   wire n_35_1;
   wire n_37_0;
   wire wdtcnt_clr_detect;
   wire wdtcnt_clr_toggle;
   wire wdtifg_clr_reg;
   wire wdtqn_edge_reg;

   assign per_dout[15] = 1'b0;
   assign per_dout[14] = per_dout[5];
   assign per_dout[13] = per_dout[5];
   assign per_dout[12] = 1'b0;
   assign per_dout[11] = per_dout[5];
   assign per_dout[10] = 1'b0;
   assign per_dout[9] = 1'b0;
   assign per_dout[8] = per_dout[5];

   NOR2_X1_LVT i_1_0 (.A1(per_we[0]), .A2(per_we[1]), .ZN(n_1));
   NAND3_X1_LVT i_0_0 (.A1(per_addr[4]), .A2(per_addr[7]), .A3(per_en), .ZN(
      n_0_0));
   NOR4_X1_LVT i_0_1 (.A1(n_0_0), .A2(per_addr[12]), .A3(per_addr[13]), .A4(
      per_addr[0]), .ZN(n_0_1));
   NOR4_X1_LVT i_0_2 (.A1(per_addr[2]), .A2(per_addr[3]), .A3(per_addr[5]), 
      .A4(per_addr[6]), .ZN(n_0_2));
   NOR4_X1_LVT i_0_3 (.A1(per_addr[8]), .A2(per_addr[9]), .A3(per_addr[10]), 
      .A4(per_addr[11]), .ZN(n_0_3));
   NAND3_X1_LVT i_0_4 (.A1(n_0_1), .A2(n_0_2), .A3(n_0_3), .ZN(n_0_4));
   NOR2_X1_LVT i_0_5 (.A1(n_0_4), .A2(per_addr[1]), .ZN(n_0));
   AND2_X1_LVT i_2_0 (.A1(n_1), .A2(n_0), .ZN(per_dout[5]));
   OR2_X1_LVT i_3_0 (.A1(per_we[0]), .A2(per_we[1]), .ZN(n_2));
   AND2_X1_LVT i_4_0 (.A1(n_2), .A2(n_0), .ZN(reg_wr));
   CLKGATETST_X1_LVT clk_gate_wdtctl_reg (.CK(mclk), .E(reg_wr), .SE(1'b0), 
      .GCK(n_3));
   INV_X1_LVT i_5_0 (.A(puc_rst), .ZN(n_4));
   DFFR_X1_LVT \wdtctl_reg[7]  (.D(per_din[7]), .RN(n_4), .CK(n_3), .Q(wdtctl[7]), 
      .QN());
   AND2_X1_LVT i_7_6 (.A1(per_dout[5]), .A2(wdtctl[7]), .ZN(per_dout[7]));
   DFFR_X1_LVT \wdtctl_reg[6]  (.D(per_din[6]), .RN(n_4), .CK(n_3), .Q(wdtnmies), 
      .QN());
   AND2_X1_LVT i_7_5 (.A1(per_dout[5]), .A2(wdtnmies), .ZN(per_dout[6]));
   DFFR_X1_LVT \wdtctl_reg[4]  (.D(per_din[4]), .RN(n_4), .CK(n_3), .Q(wdtctl[4]), 
      .QN());
   AND2_X1_LVT i_7_4 (.A1(per_dout[5]), .A2(wdtctl[4]), .ZN(per_dout[4]));
   DFFR_X1_LVT \wdtctl_reg[3]  (.D(1'b0), .RN(n_4), .CK(n_3), .Q(wdtctl[3]), 
      .QN());
   AND2_X1_LVT i_7_3 (.A1(per_dout[5]), .A2(wdtctl[3]), .ZN(per_dout[3]));
   DFFR_X1_LVT \wdtctl_reg[2]  (.D(1'b0), .RN(n_4), .CK(n_3), .Q(wdtctl[2]), 
      .QN());
   AND2_X1_LVT i_7_2 (.A1(per_dout[5]), .A2(wdtctl[2]), .ZN(per_dout[2]));
   DFFR_X1_LVT \wdtctl_reg[1]  (.D(per_din[1]), .RN(n_4), .CK(n_3), .Q(wdtctl[1]), 
      .QN());
   AND2_X1_LVT i_7_1 (.A1(per_dout[5]), .A2(wdtctl[1]), .ZN(per_dout[1]));
   DFFR_X1_LVT \wdtctl_reg[0]  (.D(per_din[0]), .RN(n_4), .CK(n_3), .Q(wdtctl[0]), 
      .QN());
   AND2_X1_LVT i_7_0 (.A1(wdtctl[0]), .A2(per_dout[5]), .ZN(per_dout[0]));
   INV_X1_LVT i_32_0 (.A(wdt_evt_toggle), .ZN(n_30));
   omsp_sync_reset__0_1432 sync_reset_por (.rst_s(wdt_rst_noscan), .clk(smclk), 
      .rst_a(puc_rst));
   omsp_scan_mux__0_1427 scan_mux_wdt_rst (.data_out(wdt_rst), .data_in_scan(
      puc_rst), .data_in_func(wdt_rst_noscan), .scan_mode(scan_mode));
   INV_X1_LVT i_30_0 (.A(wdt_rst), .ZN(n_29));
   DFFR_X1_LVT \wdtisx_s_reg[0]  (.D(wdtctl[0]), .RN(n_29), .CK(smclk), .Q(
      wdtisx_s[0]), .QN());
   DFFR_X1_LVT \wdtisx_ss_reg[0]  (.D(wdtisx_s[0]), .RN(n_29), .CK(smclk), 
      .Q(wdtisx_ss[0]), .QN());
   INV_X1_LVT i_28_0 (.A(wdtisx_ss[0]), .ZN(n_28_0));
   DFFR_X1_LVT \wdtisx_s_reg[1]  (.D(wdtctl[1]), .RN(n_29), .CK(smclk), .Q(
      wdtisx_s[1]), .QN());
   DFFR_X1_LVT \wdtisx_ss_reg[1]  (.D(wdtisx_s[1]), .RN(n_29), .CK(smclk), 
      .Q(wdtisx_ss[1]), .QN());
   AND2_X1_LVT i_28_1 (.A1(n_28_0), .A2(wdtisx_ss[1]), .ZN(n_28_1));
   NOR2_X1_LVT i_28_2 (.A1(n_28_0), .A2(wdtisx_ss[1]), .ZN(n_28_2));
   NOR2_X1_LVT i_28_3 (.A1(wdtisx_ss[0]), .A2(wdtisx_ss[1]), .ZN(n_28_3));
   INV_X1_LVT i_40_0 (.A(wdtcnt_clr_toggle), .ZN(n_35));
   AND2_X1_LVT i_38_0 (.A1(per_din[3]), .A2(reg_wr), .ZN(wdtcnt_clr_detect));
   CLKGATETST_X1_LVT clk_gate_wdtcnt_clr_toggle_reg (.CK(mclk), .E(
      wdtcnt_clr_detect), .SE(1'b0), .GCK(n_34));
   DFFR_X1_LVT wdtcnt_clr_toggle_reg (.D(n_35), .RN(n_4), .CK(n_34), .Q(
      wdtcnt_clr_toggle), .QN());
   omsp_sync_cell__1_13 sync_cell_wdtcnt_clr (.data_out(wdtcnt_clr_sync), 
      .clk(smclk), .data_in(wdtcnt_clr_toggle), .rst(wdt_rst));
   DFFR_X1_LVT wdtcnt_clr_sync_dly_reg (.D(wdtcnt_clr_sync), .RN(n_29), .CK(
      smclk), .Q(wdtcnt_clr_sync_dly), .QN());
   XOR2_X1_LVT i_19_0 (.A(wdtcnt_clr_sync), .B(wdtcnt_clr_sync_dly), .Z(n_19_0));
   OR2_X1_LVT i_19_1 (.A1(n_19_0), .A2(wdtqn_edge), .ZN(wdtcnt_clr));
   INV_X1_LVT i_21_0 (.A(wdtcnt_clr), .ZN(n_21_0));
   AND2_X1_LVT i_21_7 (.A1(n_21_0), .A2(wdtcnt_nxt[6]), .ZN(n_17));
   INV_X1_LVT i_34_0 (.A(wdtctl[7]), .ZN(n_31));
   INV_X1_LVT i_37_0 (.A(n_31), .ZN(n_37_0));
   NOR2_X1_LVT i_37_1 (.A1(n_37_0), .A2(dbg_freeze), .ZN(n_33));
   omsp_sync_cell__1_11 sync_cell_wdtcnt_incr (.data_out(wdtcnt_incr), .clk(
      smclk), .data_in(n_33), .rst(wdt_rst));
   INV_X1_LVT i_22_1 (.A(wdtcnt_incr), .ZN(n_22_1));
   INV_X1_LVT i_22_0 (.A(wdtcnt_clr), .ZN(n_22_0));
   NAND2_X1_LVT i_22_2 (.A1(n_22_1), .A2(n_22_0), .ZN(n_27));
   CLKGATETST_X1_LVT clk_gate_wdtcnt_reg (.CK(smclk), .E(n_27), .SE(1'b0), 
      .GCK(n_10));
   DFFR_X1_LVT \wdtcnt_reg[6]  (.D(n_17), .RN(n_29), .CK(n_10), .Q(wdtcnt[6]), 
      .QN());
   AND2_X1_LVT i_21_6 (.A1(n_21_0), .A2(wdtcnt_nxt[5]), .ZN(n_16));
   DFFR_X1_LVT \wdtcnt_reg[5]  (.D(n_16), .RN(n_29), .CK(n_10), .Q(wdtcnt[5]), 
      .QN());
   AND2_X1_LVT i_21_5 (.A1(n_21_0), .A2(wdtcnt_nxt[4]), .ZN(n_15));
   DFFR_X1_LVT \wdtcnt_reg[4]  (.D(n_15), .RN(n_29), .CK(n_10), .Q(wdtcnt[4]), 
      .QN());
   AND2_X1_LVT i_21_4 (.A1(n_21_0), .A2(wdtcnt_nxt[3]), .ZN(n_14));
   DFFR_X1_LVT \wdtcnt_reg[3]  (.D(n_14), .RN(n_29), .CK(n_10), .Q(wdtcnt[3]), 
      .QN());
   AND2_X1_LVT i_21_3 (.A1(n_21_0), .A2(wdtcnt_nxt[2]), .ZN(n_13));
   DFFR_X1_LVT \wdtcnt_reg[2]  (.D(n_13), .RN(n_29), .CK(n_10), .Q(wdtcnt[2]), 
      .QN());
   AND2_X1_LVT i_21_2 (.A1(n_21_0), .A2(wdtcnt_nxt[1]), .ZN(n_12));
   DFFR_X1_LVT \wdtcnt_reg[1]  (.D(n_12), .RN(n_29), .CK(n_10), .Q(wdtcnt[1]), 
      .QN());
   INV_X1_LVT i_24_0 (.A(wdtcnt[0]), .ZN(wdtcnt_nxt[0]));
   AND2_X1_LVT i_21_1 (.A1(n_21_0), .A2(wdtcnt_nxt[0]), .ZN(n_11));
   DFFR_X1_LVT \wdtcnt_reg[0]  (.D(n_11), .RN(n_29), .CK(n_10), .Q(wdtcnt[0]), 
      .QN());
   HA_X1_LVT i_24_1 (.A(wdtcnt[1]), .B(wdtcnt[0]), .CO(n_24_0), .S(wdtcnt_nxt[1]));
   HA_X1_LVT i_24_2 (.A(wdtcnt[2]), .B(n_24_0), .CO(n_24_1), .S(wdtcnt_nxt[2]));
   HA_X1_LVT i_24_3 (.A(wdtcnt[3]), .B(n_24_1), .CO(n_24_2), .S(wdtcnt_nxt[3]));
   HA_X1_LVT i_24_4 (.A(wdtcnt[4]), .B(n_24_2), .CO(n_24_3), .S(wdtcnt_nxt[4]));
   HA_X1_LVT i_24_5 (.A(wdtcnt[5]), .B(n_24_3), .CO(n_24_4), .S(wdtcnt_nxt[5]));
   HA_X1_LVT i_24_6 (.A(wdtcnt[6]), .B(n_24_4), .CO(n_24_5), .S(wdtcnt_nxt[6]));
   INV_X1_LVT i_28_4 (.A(wdtcnt_nxt[6]), .ZN(n_28_4));
   OR4_X1_LVT i_28_5 (.A1(n_28_1), .A2(n_28_2), .A3(n_28_3), .A4(n_28_4), 
      .ZN(n_28_5));
   AND2_X1_LVT i_21_16 (.A1(n_21_0), .A2(wdtcnt_nxt[15]), .ZN(n_26));
   DFFR_X1_LVT \wdtcnt_reg[15]  (.D(n_26), .RN(n_29), .CK(n_10), .Q(wdtcnt[15]), 
      .QN());
   AND2_X1_LVT i_21_15 (.A1(n_21_0), .A2(wdtcnt_nxt[14]), .ZN(n_25));
   DFFR_X1_LVT \wdtcnt_reg[14]  (.D(n_25), .RN(n_29), .CK(n_10), .Q(wdtcnt[14]), 
      .QN());
   AND2_X1_LVT i_21_14 (.A1(n_21_0), .A2(wdtcnt_nxt[13]), .ZN(n_24));
   DFFR_X1_LVT \wdtcnt_reg[13]  (.D(n_24), .RN(n_29), .CK(n_10), .Q(wdtcnt[13]), 
      .QN());
   AND2_X1_LVT i_21_13 (.A1(n_21_0), .A2(wdtcnt_nxt[12]), .ZN(n_23));
   DFFR_X1_LVT \wdtcnt_reg[12]  (.D(n_23), .RN(n_29), .CK(n_10), .Q(wdtcnt[12]), 
      .QN());
   AND2_X1_LVT i_21_12 (.A1(n_21_0), .A2(wdtcnt_nxt[11]), .ZN(n_22));
   DFFR_X1_LVT \wdtcnt_reg[11]  (.D(n_22), .RN(n_29), .CK(n_10), .Q(wdtcnt[11]), 
      .QN());
   AND2_X1_LVT i_21_11 (.A1(n_21_0), .A2(wdtcnt_nxt[10]), .ZN(n_21));
   DFFR_X1_LVT \wdtcnt_reg[10]  (.D(n_21), .RN(n_29), .CK(n_10), .Q(wdtcnt[10]), 
      .QN());
   AND2_X1_LVT i_21_10 (.A1(n_21_0), .A2(wdtcnt_nxt[9]), .ZN(n_20));
   DFFR_X1_LVT \wdtcnt_reg[9]  (.D(n_20), .RN(n_29), .CK(n_10), .Q(wdtcnt[9]), 
      .QN());
   AND2_X1_LVT i_21_9 (.A1(n_21_0), .A2(wdtcnt_nxt[8]), .ZN(n_19));
   DFFR_X1_LVT \wdtcnt_reg[8]  (.D(n_19), .RN(n_29), .CK(n_10), .Q(wdtcnt[8]), 
      .QN());
   AND2_X1_LVT i_21_8 (.A1(n_21_0), .A2(wdtcnt_nxt[7]), .ZN(n_18));
   DFFR_X1_LVT \wdtcnt_reg[7]  (.D(n_18), .RN(n_29), .CK(n_10), .Q(wdtcnt[7]), 
      .QN());
   HA_X1_LVT i_24_7 (.A(wdtcnt[7]), .B(n_24_5), .CO(n_24_6), .S(wdtcnt_nxt[7]));
   HA_X1_LVT i_24_8 (.A(wdtcnt[8]), .B(n_24_6), .CO(n_24_7), .S(wdtcnt_nxt[8]));
   HA_X1_LVT i_24_9 (.A(wdtcnt[9]), .B(n_24_7), .CO(n_24_8), .S(wdtcnt_nxt[9]));
   HA_X1_LVT i_24_10 (.A(wdtcnt[10]), .B(n_24_8), .CO(n_24_9), .S(wdtcnt_nxt[10]));
   HA_X1_LVT i_24_11 (.A(wdtcnt[11]), .B(n_24_9), .CO(n_24_10), .S(
      wdtcnt_nxt[11]));
   HA_X1_LVT i_24_12 (.A(wdtcnt[12]), .B(n_24_10), .CO(n_24_11), .S(
      wdtcnt_nxt[12]));
   HA_X1_LVT i_24_13 (.A(wdtcnt[13]), .B(n_24_11), .CO(n_24_12), .S(
      wdtcnt_nxt[13]));
   HA_X1_LVT i_24_14 (.A(wdtcnt[14]), .B(n_24_12), .CO(n_24_13), .S(
      wdtcnt_nxt[14]));
   XNOR2_X1_LVT i_24_15 (.A(wdtcnt[15]), .B(n_24_13), .ZN(n_24_14));
   INV_X1_LVT i_24_16 (.A(n_24_14), .ZN(wdtcnt_nxt[15]));
   NAND2_X1_LVT i_28_6 (.A1(n_28_3), .A2(wdtcnt_nxt[15]), .ZN(n_28_6));
   NAND2_X1_LVT i_28_7 (.A1(n_28_2), .A2(wdtcnt_nxt[13]), .ZN(n_28_7));
   NAND2_X1_LVT i_28_8 (.A1(n_28_1), .A2(wdtcnt_nxt[9]), .ZN(n_28_8));
   NAND4_X1_LVT i_28_9 (.A1(n_28_5), .A2(n_28_6), .A3(n_28_7), .A4(n_28_8), 
      .ZN(wdtqn_reg));
   AND2_X1_LVT i_29_0 (.A1(wdtqn_reg), .A2(wdtcnt_incr), .ZN(wdtqn_edge));
   CLKGATETST_X1_LVT clk_gate_wdt_evt_toggle_reg (.CK(smclk), .E(wdtqn_edge), 
      .SE(1'b0), .GCK(n_28));
   DFFR_X1_LVT wdt_evt_toggle_reg (.D(n_30), .RN(n_29), .CK(n_28), .Q(
      wdt_evt_toggle), .QN());
   omsp_sync_cell__0_1430 sync_cell_wdt_evt (.data_out(wdt_evt_toggle_sync), 
      .clk(mclk), .data_in(wdt_evt_toggle), .rst(puc_rst));
   DFFR_X1_LVT wdt_evt_toggle_sync_dly_reg (.D(wdt_evt_toggle_sync), .RN(n_4), 
      .CK(mclk), .Q(wdt_evt_toggle_sync_dly), .QN());
   XOR2_X1_LVT i_9_0 (.A(wdt_evt_toggle_sync_dly), .B(wdt_evt_toggle_sync), 
      .Z(n_9_0));
   INV_X1_LVT i_8_0 (.A(reg_wr), .ZN(n_8_0));
   AND4_X1_LVT i_8_1 (.A1(per_din[9]), .A2(per_din[11]), .A3(per_din[12]), 
      .A4(per_din[14]), .ZN(n_8_1));
   NOR4_X1_LVT i_8_2 (.A1(per_din[8]), .A2(per_din[10]), .A3(per_din[13]), 
      .A4(per_din[15]), .ZN(n_8_2));
   AOI21_X1_LVT i_8_3 (.A(n_8_0), .B1(n_8_1), .B2(n_8_2), .ZN(wdtpw_error));
   OR3_X1_LVT i_9_1 (.A1(n_9_0), .A2(wdtifg_sw_set), .A3(wdtpw_error), .ZN(
      wdtifg_set));
   AOI21_X1_LVT i_10_0 (.A(wdtifg_sw_clr), .B1(wdtifg_irq_clr), .B2(wdtctl[4]), 
      .ZN(n_10_0));
   INV_X1_LVT i_10_1 (.A(n_10_0), .ZN(wdtifg_clr));
   INV_X1_LVT i_13_1 (.A(wdtifg_clr), .ZN(n_13_1));
   INV_X1_LVT i_13_0 (.A(wdtifg_set), .ZN(n_13_0));
   NAND2_X1_LVT i_13_2 (.A1(n_13_1), .A2(n_13_0), .ZN(n_7));
   CLKGATETST_X1_LVT clk_gate_wdtifg_reg (.CK(mclk), .E(n_7), .SE(1'b0), 
      .GCK(n_5));
   INV_X1_LVT i_11_0 (.A(por), .ZN(n_6));
   DFFR_X1_LVT wdtifg_reg (.D(wdtifg_set), .RN(n_6), .CK(n_5), .Q(wdtifg), .QN());
   AND3_X1_LVT i_15_0 (.A1(wdtctl[4]), .A2(wdtie), .A3(wdtifg), .ZN(wdt_irq));
   INV_X1_LVT i_16_0 (.A(wdtctl[4]), .ZN(n_8));
   AOI21_X1_LVT i_17_0 (.A(wdtpw_error), .B1(wdtifg_set), .B2(n_8), .ZN(n_17_0));
   INV_X1_LVT i_17_1 (.A(n_17_0), .ZN(n_9));
   DFFR_X1_LVT wdt_reset_reg (.D(n_9), .RN(n_6), .CK(mclk), .Q(wdt_reset), .QN());
   DFFS_X1_LVT wdtifg_clr_reg_reg (.D(wdtifg_clr), .SN(n_4), .CK(mclk), .Q(
      wdtifg_clr_reg), .QN());
   DFFR_X1_LVT wdtqn_edge_reg_reg (.D(wdtqn_edge), .RN(n_29), .CK(smclk), 
      .Q(wdtqn_edge_reg), .QN());
   omsp_wakeup_cell__0_1428 wakeup_cell_wdog (.wkup_out(wdt_wkup_pre), .scan_clk(
      mclk), .scan_mode(scan_mode), .scan_rst(puc_rst), .wkup_clear(
      wdtifg_clr_reg), .wkup_event(wdtqn_edge_reg));
   NOR2_X1_LVT i_35_2 (.A1(wdtie), .A2(n_8), .ZN(n_35_1));
   INV_X1_LVT i_35_0 (.A(n_31), .ZN(n_35_0));
   NOR2_X1_LVT i_35_1 (.A1(n_35_1), .A2(n_35_0), .ZN(n_32));
   DFFR_X1_LVT wdt_wkup_en_reg (.D(n_32), .RN(n_4), .CK(mclk), .Q(wdt_wkup_en), 
      .QN());
   omsp_and_gate__0_1424 and_wdt_wkup (.y(wdt_wkup), .a(wdt_wkup_pre), .b(
      wdt_wkup_en));
   DFFR_X1_LVT \wdtctl_reg[5]  (.D(1'b0), .RN(n_4), .CK(n_3), .Q(wdtctl[5]), 
      .QN());
endmodule

module omsp_scan_mux(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_scan_mux__2_71(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_wakeup_cell(wkup_out, scan_clk, scan_mode, scan_rst, wkup_clear, 
      wkup_event);
   output wkup_out;
   input scan_clk;
   input scan_mode;
   input scan_rst;
   input wkup_clear;
   input wkup_event;

   wire wkup_rst;
   wire wkup_clk;

   omsp_scan_mux scan_mux_clk (.data_out(wkup_clk), .data_in_scan(scan_clk), 
      .data_in_func(wkup_event), .scan_mode(scan_mode));
   omsp_scan_mux__2_71 scan_mux_rst (.data_out(wkup_rst), .data_in_scan(scan_rst), 
      .data_in_func(wkup_clear), .scan_mode(scan_mode));
   INV_X1_LVT i_0_0 (.A(wkup_rst), .ZN(n_0));
   DFFR_X1_LVT wkup_out_reg (.D(1'b1), .RN(n_0), .CK(wkup_clk), .Q(wkup_out), 
      .QN());
endmodule

module omsp_sync_cell__2_27(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_and_gate(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_sfr(cpu_id, nmi_pnd, nmi_wkup, per_dout, wdtie, wdtifg_sw_clr, 
      wdtifg_sw_set, cpu_nr_inst, cpu_nr_total, mclk, nmi, nmi_acc, per_addr, 
      per_din, per_en, per_we, puc_rst, scan_mode, wdtifg, wdtnmies);
   output [31:0]cpu_id;
   output nmi_pnd;
   output nmi_wkup;
   output [15:0]per_dout;
   output wdtie;
   output wdtifg_sw_clr;
   output wdtifg_sw_set;
   input [7:0]cpu_nr_inst;
   input [7:0]cpu_nr_total;
   input mclk;
   input nmi;
   input nmi_acc;
   input [13:0]per_addr;
   input [15:0]per_din;
   input per_en;
   input [1:0]per_we;
   input puc_rst;
   input scan_mode;
   input wdtifg;
   input wdtnmies;

   wire nmi_capture;
   wire nmi_s;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire reg_sel;
   wire reg_lo_write;
   wire n_2_0;
   wire n_2_1;
   wire n_2_2;
   wire n_2_3;
   wire n_2_4;
   wire n_2_5;
   wire n_2_6;
   wire ifg1_wr;
   wire nmi_capture_rst;
   wire n_4_0;
   wire nmie;
   wire n_7_0;
   wire n_8_0;
   wire n_8_1;
   wire nmi_dly;
   wire n_10_0;
   wire nmi_edge;
   wire nmiifg;
   wire n_13_0;
   wire n_13_1;
   wire n_14_0;
   wire n_14_1;
   wire reg_read;
   wire n_27_0;
   wire n_28_0;
   wire nmi_pol;

   assign cpu_id[31] = 1'b0;
   assign cpu_id[30] = 1'b0;
   assign cpu_id[29] = 1'b0;
   assign cpu_id[28] = 1'b1;
   assign cpu_id[27] = 1'b0;
   assign cpu_id[26] = 1'b0;
   assign cpu_id[25] = 1'b0;
   assign cpu_id[24] = 1'b0;
   assign cpu_id[23] = 1'b0;
   assign cpu_id[22] = 1'b0;
   assign cpu_id[21] = 1'b0;
   assign cpu_id[20] = 1'b1;
   assign cpu_id[19] = 1'b0;
   assign cpu_id[18] = 1'b0;
   assign cpu_id[17] = 1'b0;
   assign cpu_id[16] = 1'b1;
   assign cpu_id[15] = 1'b0;
   assign cpu_id[14] = 1'b0;
   assign cpu_id[13] = 1'b0;
   assign cpu_id[12] = 1'b0;
   assign cpu_id[11] = 1'b0;
   assign cpu_id[10] = 1'b0;
   assign cpu_id[9] = 1'b1;
   assign cpu_id[8] = 1'b0;
   assign cpu_id[7] = 1'b0;
   assign cpu_id[6] = 1'b0;
   assign cpu_id[5] = 1'b0;
   assign cpu_id[4] = 1'b0;
   assign cpu_id[3] = 1'b1;
   assign cpu_id[2] = 1'b0;
   assign cpu_id[1] = 1'b1;
   assign cpu_id[0] = 1'b1;

   INV_X1_LVT i_13_1 (.A(per_din[4]), .ZN(n_13_1));
   INV_X1_LVT i_0_0 (.A(per_en), .ZN(n_0_0));
   NOR4_X1_LVT i_0_1 (.A1(n_0_0), .A2(per_addr[11]), .A3(per_addr[12]), .A4(
      per_addr[13]), .ZN(n_0_1));
   NOR4_X1_LVT i_0_2 (.A1(per_addr[3]), .A2(per_addr[4]), .A3(per_addr[5]), 
      .A4(per_addr[6]), .ZN(n_0_2));
   NOR4_X1_LVT i_0_3 (.A1(per_addr[7]), .A2(per_addr[8]), .A3(per_addr[9]), 
      .A4(per_addr[10]), .ZN(n_0_3));
   AND3_X1_LVT i_0_4 (.A1(n_0_1), .A2(n_0_2), .A3(n_0_3), .ZN(reg_sel));
   AND2_X1_LVT i_1_0 (.A1(per_we[0]), .A2(reg_sel), .ZN(reg_lo_write));
   INV_X1_LVT i_2_1 (.A(per_addr[1]), .ZN(n_2_1));
   NAND2_X1_LVT i_2_3 (.A1(per_addr[0]), .A2(n_2_1), .ZN(n_2_3));
   NOR2_X1_LVT i_2_8 (.A1(n_2_3), .A2(per_addr[2]), .ZN(n_1));
   AND2_X1_LVT i_3_1 (.A1(reg_lo_write), .A2(n_1), .ZN(ifg1_wr));
   INV_X1_LVT i_4_0 (.A(ifg1_wr), .ZN(n_4_0));
   NOR2_X1_LVT i_4_1 (.A1(n_4_0), .A2(per_din[4]), .ZN(n_6));
   INV_X1_LVT i_11_0 (.A(puc_rst), .ZN(n_11));
   DFFS_X1_LVT nmi_capture_rst_reg (.D(n_6), .SN(n_11), .CK(mclk), .Q(
      nmi_capture_rst), .QN());
   XOR2_X1_LVT i_31_0 (.A(nmi), .B(wdtnmies), .Z(nmi_pol));
   omsp_wakeup_cell wakeup_cell_nmi (.wkup_out(nmi_capture), .scan_clk(mclk), 
      .scan_mode(scan_mode), .scan_rst(puc_rst), .wkup_clear(nmi_capture_rst), 
      .wkup_event(nmi_pol));
   omsp_sync_cell__2_27 sync_cell_nmi (.data_out(nmi_s), .clk(mclk), .data_in(
      nmi_capture), .rst(puc_rst));
   INV_X1_LVT i_10_0 (.A(nmi_s), .ZN(n_10_0));
   DFFR_X1_LVT nmi_dly_reg (.D(nmi_s), .RN(n_11), .CK(mclk), .Q(nmi_dly), .QN());
   NOR2_X1_LVT i_10_1 (.A1(n_10_0), .A2(nmi_dly), .ZN(nmi_edge));
   INV_X1_LVT i_13_0 (.A(nmi_edge), .ZN(n_13_0));
   NAND2_X1_LVT i_13_2 (.A1(n_13_1), .A2(n_13_0), .ZN(n_12));
   INV_X1_LVT i_14_1 (.A(ifg1_wr), .ZN(n_14_1));
   INV_X1_LVT i_14_0 (.A(nmi_edge), .ZN(n_14_0));
   NAND2_X1_LVT i_14_2 (.A1(n_14_1), .A2(n_14_0), .ZN(n_13));
   CLKGATETST_X1_LVT clk_gate_nmiifg_reg (.CK(mclk), .E(n_13), .SE(1'b0), 
      .GCK(n_10));
   DFFR_X1_LVT nmiifg_reg (.D(n_12), .RN(n_11), .CK(n_10), .Q(nmiifg), .QN());
   INV_X1_LVT i_7_0 (.A(per_din[4]), .ZN(n_7_0));
   NOR2_X1_LVT i_7_1 (.A1(n_7_0), .A2(nmi_acc), .ZN(n_8));
   INV_X1_LVT i_2_0 (.A(per_addr[0]), .ZN(n_2_0));
   NAND2_X1_LVT i_2_2 (.A1(n_2_0), .A2(n_2_1), .ZN(n_2_2));
   NOR2_X1_LVT i_2_7 (.A1(n_2_2), .A2(per_addr[2]), .ZN(n_0));
   AND2_X1_LVT i_3_0 (.A1(n_0), .A2(reg_lo_write), .ZN(n_5));
   INV_X1_LVT i_8_1 (.A(n_5), .ZN(n_8_1));
   INV_X1_LVT i_8_0 (.A(nmi_acc), .ZN(n_8_0));
   NAND2_X1_LVT i_8_2 (.A1(n_8_1), .A2(n_8_0), .ZN(n_9));
   CLKGATETST_X1_LVT clk_gate_nmie_reg (.CK(mclk), .E(n_9), .SE(1'b0), .GCK(n_7));
   DFFR_X1_LVT nmie_reg (.D(n_8), .RN(n_11), .CK(n_7), .Q(nmie), .QN());
   AND2_X1_LVT i_16_0 (.A1(nmiifg), .A2(nmie), .ZN(nmi_pnd));
   XOR2_X1_LVT i_30_0 (.A(nmi_capture), .B(nmi_dly), .Z(n_31));
   omsp_and_gate and_nmi_wkup (.y(nmi_wkup), .a(n_31), .b(nmie));
   NOR2_X1_LVT i_17_0 (.A1(per_we[0]), .A2(per_we[1]), .ZN(n_14));
   AND2_X1_LVT i_18_0 (.A1(n_14), .A2(reg_sel), .ZN(reg_read));
   INV_X1_LVT i_2_6 (.A(per_addr[2]), .ZN(n_2_6));
   NOR2_X1_LVT i_2_11 (.A1(n_2_2), .A2(n_2_6), .ZN(n_4));
   AND2_X1_LVT i_19_4 (.A1(reg_read), .A2(n_4), .ZN(n_19));
   AND2_X1_LVT i_21_7 (.A1(n_19), .A2(cpu_nr_total[7]), .ZN(per_dout[15]));
   AND2_X1_LVT i_21_6 (.A1(n_19), .A2(cpu_nr_total[6]), .ZN(per_dout[14]));
   AND2_X1_LVT i_21_5 (.A1(n_19), .A2(cpu_nr_total[5]), .ZN(per_dout[13]));
   NAND2_X1_LVT i_2_5 (.A1(per_addr[0]), .A2(per_addr[1]), .ZN(n_2_5));
   NOR2_X1_LVT i_2_10 (.A1(n_2_5), .A2(per_addr[2]), .ZN(n_3));
   AND2_X1_LVT i_19_3 (.A1(reg_read), .A2(n_3), .ZN(n_18));
   AND2_X1_LVT i_21_4 (.A1(n_19), .A2(cpu_nr_total[4]), .ZN(n_25));
   OR2_X1_LVT i_27_6 (.A1(n_18), .A2(n_25), .ZN(per_dout[12]));
   AND2_X1_LVT i_21_3 (.A1(n_19), .A2(cpu_nr_total[3]), .ZN(per_dout[11]));
   AND2_X1_LVT i_21_2 (.A1(n_19), .A2(cpu_nr_total[2]), .ZN(per_dout[10]));
   NAND2_X1_LVT i_2_4 (.A1(n_2_0), .A2(per_addr[1]), .ZN(n_2_4));
   NOR2_X1_LVT i_2_9 (.A1(n_2_4), .A2(per_addr[2]), .ZN(n_2));
   AND2_X1_LVT i_19_2 (.A1(reg_read), .A2(n_2), .ZN(n_17));
   AND2_X1_LVT i_21_1 (.A1(n_19), .A2(cpu_nr_total[1]), .ZN(n_24));
   OR2_X1_LVT i_27_5 (.A1(n_17), .A2(n_24), .ZN(per_dout[9]));
   AND2_X1_LVT i_21_0 (.A1(cpu_nr_total[0]), .A2(n_19), .ZN(per_dout[8]));
   AND2_X1_LVT i_20_7 (.A1(n_19), .A2(cpu_nr_inst[7]), .ZN(per_dout[7]));
   AND2_X1_LVT i_20_6 (.A1(n_19), .A2(cpu_nr_inst[6]), .ZN(per_dout[6]));
   AND2_X1_LVT i_20_5 (.A1(n_19), .A2(cpu_nr_inst[5]), .ZN(per_dout[5]));
   AND2_X1_LVT i_19_0 (.A1(n_0), .A2(reg_read), .ZN(n_15));
   AND2_X1_LVT i_26_0 (.A1(nmie), .A2(n_15), .ZN(n_30));
   AND2_X1_LVT i_19_1 (.A1(reg_read), .A2(n_1), .ZN(n_16));
   AND2_X1_LVT i_23_0 (.A1(nmiifg), .A2(n_16), .ZN(n_27));
   AND2_X1_LVT i_20_4 (.A1(n_19), .A2(cpu_nr_inst[4]), .ZN(n_23));
   OR4_X1_LVT i_27_4 (.A1(n_30), .A2(n_27), .A3(n_18), .A4(n_23), .ZN(
      per_dout[4]));
   AND2_X1_LVT i_20_3 (.A1(n_19), .A2(cpu_nr_inst[3]), .ZN(n_22));
   OR2_X1_LVT i_27_3 (.A1(n_17), .A2(n_22), .ZN(per_dout[3]));
   AND2_X1_LVT i_20_2 (.A1(n_19), .A2(cpu_nr_inst[2]), .ZN(per_dout[2]));
   AND2_X1_LVT i_20_1 (.A1(n_19), .A2(cpu_nr_inst[1]), .ZN(n_21));
   OR2_X1_LVT i_27_2 (.A1(n_17), .A2(n_21), .ZN(per_dout[1]));
   AND2_X1_LVT i_22_0 (.A1(wdtifg), .A2(n_16), .ZN(n_26));
   AND2_X1_LVT i_20_0 (.A1(cpu_nr_inst[0]), .A2(n_19), .ZN(n_20));
   OR4_X1_LVT i_27_0 (.A1(n_26), .A2(n_17), .A3(n_18), .A4(n_20), .ZN(n_27_0));
   CLKGATETST_X1_LVT clk_gate_wdtie_reg (.CK(mclk), .E(n_5), .SE(1'b0), .GCK(
      n_28));
   DFFR_X1_LVT wdtie_reg (.D(per_din[0]), .RN(n_11), .CK(n_28), .Q(wdtie), .QN());
   AND2_X1_LVT i_25_0 (.A1(wdtie), .A2(n_15), .ZN(n_29));
   OR2_X1_LVT i_27_1 (.A1(n_27_0), .A2(n_29), .ZN(per_dout[0]));
   INV_X1_LVT i_28_0 (.A(ifg1_wr), .ZN(n_28_0));
   NOR2_X1_LVT i_28_1 (.A1(n_28_0), .A2(per_din[0]), .ZN(wdtifg_sw_clr));
   AND2_X1_LVT i_29_0 (.A1(ifg1_wr), .A2(per_din[0]), .ZN(wdtifg_sw_set));
endmodule

module omsp_sync_cell(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_dbg_uart(dbg_addr, dbg_din, dbg_rd, dbg_uart_txd, dbg_wr, dbg_clk, 
      dbg_dout, dbg_rd_rdy, dbg_rst, dbg_uart_rxd, mem_burst, mem_burst_end, 
      mem_burst_rd, mem_burst_wr, mem_bw);
   output [5:0]dbg_addr;
   output [15:0]dbg_din;
   output dbg_rd;
   output dbg_uart_txd;
   output dbg_wr;
   input dbg_clk;
   input [15:0]dbg_dout;
   input dbg_rd_rdy;
   input dbg_rst;
   input dbg_uart_rxd;
   input mem_burst;
   input mem_burst_end;
   input mem_burst_rd;
   input mem_burst_wr;
   input mem_bw;

   wire uart_rxd_n;
   wire uart_rxd;
   wire [1:0]rxd_buf;
   wire n_2_0;
   wire n_2_1;
   wire n_2_2;
   wire rxd_maj_nxt;
   wire [19:0]xfer_buf;
   wire n_4_0;
   wire n_4_1;
   wire n_4_2;
   wire n_4_3;
   wire n_4_4;
   wire n_4_5;
   wire n_4_6;
   wire n_4_7;
   wire n_4_8;
   wire n_4_9;
   wire n_4_10;
   wire n_4_11;
   wire n_4_12;
   wire n_4_13;
   wire n_4_14;
   wire n_4_15;
   wire n_4_16;
   wire n_4_17;
   wire n_4_18;
   wire n_5_0;
   wire n_5_1;
   wire rxd_maj;
   wire n_7_0;
   wire n_8_0;
   wire n_8_1;
   wire n_8_2;
   wire n_8_3;
   wire n_8_4;
   wire n_8_5;
   wire n_8_6;
   wire n_8_7;
   wire n_8_8;
   wire n_8_9;
   wire n_8_10;
   wire n_8_11;
   wire n_8_12;
   wire n_8_13;
   wire n_8_14;
   wire n_8_15;
   wire n_8_16;
   wire n_8_17;
   wire n_8_18;
   wire n_8_19;
   wire n_8_20;
   wire n_8_21;
   wire n_8_22;
   wire n_8_23;
   wire n_8_24;
   wire [2:0]uart_state_nxt_reg;
   wire n_8_25;
   wire n_8_26;
   wire n_8_27;
   wire n_8_28;
   wire n_8_29;
   wire [2:0]uart_state;
   wire n_11_0;
   wire n_11_1;
   wire n_13_0;
   wire n_13_1;
   wire n_13_2;
   wire n_14_0;
   wire n_15_0;
   wire rxd_fe;
   wire sync_busy;
   wire [15:0]bit_cnt_max;
   wire n_21_0;
   wire n_21_1;
   wire n_21_2;
   wire n_21_3;
   wire n_21_4;
   wire n_21_5;
   wire n_21_6;
   wire n_21_7;
   wire n_21_8;
   wire n_21_9;
   wire n_21_10;
   wire n_21_11;
   wire n_21_12;
   wire n_21_13;
   wire n_21_14;
   wire n_21_15;
   wire n_21_16;
   wire n_21_17;
   wire n_22_0;
   wire n_22_1;
   wire n_24_0;
   wire txd_start;
   wire rx_active;
   wire [15:0]xfer_cnt;
   wire n_27_0;
   wire n_27_1;
   wire n_27_2;
   wire n_27_3;
   wire n_27_4;
   wire n_27_5;
   wire n_27_6;
   wire n_27_7;
   wire n_27_8;
   wire n_27_9;
   wire n_27_10;
   wire n_27_11;
   wire n_27_12;
   wire n_27_13;
   wire n_29_0;
   wire n_30_0;
   wire n_31_0;
   wire n_31_1;
   wire n_31_2;
   wire n_31_3;
   wire n_31_4;
   wire n_31_5;
   wire n_31_6;
   wire n_31_7;
   wire n_31_8;
   wire n_31_9;
   wire n_31_10;
   wire n_31_11;
   wire n_31_12;
   wire n_31_13;
   wire n_31_14;
   wire n_31_15;
   wire n_31_16;
   wire n_31_17;
   wire n_31_18;
   wire n_31_19;
   wire n_31_20;
   wire n_31_21;
   wire n_31_22;
   wire n_31_23;
   wire n_31_24;
   wire n_31_25;
   wire n_31_26;
   wire n_31_27;
   wire n_31_28;
   wire n_31_29;
   wire n_31_30;
   wire n_31_31;
   wire n_31_32;
   wire n_32_0;
   wire n_32_1;
   wire n_32_2;
   wire n_32_3;
   wire n_33_0;
   wire n_33_1;
   wire n_33_2;
   wire n_35_0;
   wire n_35_1;
   wire n_35_2;
   wire n_35_3;
   wire n_35_4;
   wire n_35_5;
   wire xfer_bit_inc;
   wire [3:0]xfer_bit;
   wire n_39_0;
   wire n_39_1;
   wire n_39_2;
   wire n_40_0;
   wire n_41_0;
   wire n_41_1;
   wire n_42_0;
   wire n_42_1;
   wire n_42_2;
   wire n_44_0;
   wire n_44_1;
   wire n_44_2;
   wire n_44_3;
   wire xfer_done;
   wire cmd_valid;
   wire dbg_bw;
   wire n_49_0;
   wire n_49_1;
   wire n_49_2;
   wire n_49_3;
   wire n_49_4;
   wire n_49_5;
   wire n_49_6;
   wire n_49_7;
   wire n_49_8;
   wire n_49_9;
   wire n_49_10;
   wire n_50_0;
   wire n_50_1;
   wire n_52_0;
   wire n_52_1;
   wire n_54_0;

   INV_X1_LVT i_4_0 (.A(dbg_rd_rdy), .ZN(n_4_0));
   INV_X1_LVT i_57_0 (.A(dbg_uart_rxd), .ZN(n_136));
   omsp_sync_cell sync_cell_uart_rxd (.data_out(uart_rxd_n), .clk(dbg_clk), 
      .data_in(n_136), .rst(dbg_rst));
   INV_X1_LVT i_0_0 (.A(uart_rxd_n), .ZN(uart_rxd));
   INV_X1_LVT i_2_0 (.A(uart_rxd), .ZN(n_2_0));
   INV_X1_LVT i_46_0 (.A(dbg_rst), .ZN(n_130));
   DFFS_X1_LVT \rxd_buf_reg[0]  (.D(uart_rxd), .SN(n_130), .CK(dbg_clk), 
      .Q(rxd_buf[0]), .QN());
   INV_X1_LVT i_2_1 (.A(rxd_buf[0]), .ZN(n_2_1));
   DFFS_X1_LVT \rxd_buf_reg[1]  (.D(rxd_buf[0]), .SN(n_130), .CK(dbg_clk), 
      .Q(rxd_buf[1]), .QN());
   INV_X1_LVT i_2_2 (.A(rxd_buf[1]), .ZN(n_2_2));
   OAI222_X1_LVT i_2_3 (.A1(n_2_0), .A2(n_2_1), .B1(n_2_1), .B2(n_2_2), .C1(
      n_2_0), .C2(n_2_2), .ZN(rxd_maj_nxt));
   DFFS_X1_LVT rxd_maj_reg (.D(rxd_maj_nxt), .SN(n_130), .CK(dbg_clk), .Q(
      rxd_maj), .QN());
   INV_X1_LVT i_4_36 (.A(rxd_maj), .ZN(n_4_18));
   NAND2_X1_LVT i_4_37 (.A1(n_4_18), .A2(n_4_0), .ZN(n_19));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__16 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_53));
   DFFR_X1_LVT \sync_cnt_reg[1]  (.D(n_58), .RN(n_130), .CK(n_53), .Q(n_54), 
      .QN());
   INV_X1_LVT i_21_0 (.A(n_56), .ZN(n_57));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__17 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_55));
   DFFR_X1_LVT \sync_cnt_reg[0]  (.D(n_57), .RN(n_130), .CK(n_55), .Q(n_56), 
      .QN());
   HA_X1_LVT i_21_1 (.A(n_54), .B(n_56), .CO(n_21_0), .S(n_58));
   HA_X1_LVT i_21_2 (.A(n_52), .B(n_21_0), .CO(n_21_1), .S(n_59));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__15 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_51));
   DFFR_X1_LVT \sync_cnt_reg[2]  (.D(n_59), .RN(n_130), .CK(n_51), .Q(n_52), 
      .QN());
   INV_X1_LVT i_22_1 (.A(n_52), .ZN(n_22_1));
   NOR3_X1_LVT i_8_4 (.A1(n_8_3), .A2(uart_state[0]), .A3(uart_state[1]), 
      .ZN(n_8_4));
   INV_X1_LVT i_8_5 (.A(n_8_4), .ZN(n_8_5));
   NAND3_X1_LVT i_8_7 (.A1(n_8_0), .A2(uart_state[0]), .A3(uart_state[2]), 
      .ZN(n_8_7));
   INV_X1_LVT i_7_0 (.A(mem_burst), .ZN(n_7_0));
   NOR2_X1_LVT i_7_1 (.A1(n_7_0), .A2(mem_burst_end), .ZN(n_22));
   INV_X1_LVT i_8_27 (.A(n_22), .ZN(n_8_26));
   INV_X1_LVT i_8_20 (.A(mem_burst_wr), .ZN(n_8_20));
   NAND2_X1_LVT i_8_21 (.A1(n_8_20), .A2(mem_burst_rd), .ZN(n_8_21));
   INV_X1_LVT i_8_29 (.A(n_8_21), .ZN(n_8_27));
   OR2_X1_LVT i_8_15 (.A1(mem_burst_rd), .A2(mem_burst_wr), .ZN(n_8_15));
   NOR2_X1_LVT i_8_16 (.A1(n_8_15), .A2(xfer_buf[19]), .ZN(n_8_16));
   AND2_X1_LVT i_8_17 (.A1(n_8_16), .A2(xfer_buf[18]), .ZN(n_8_17));
   INV_X1_LVT i_8_30 (.A(xfer_buf[18]), .ZN(n_8_28));
   AOI211_X1_LVT i_8_31 (.A(n_8_27), .B(n_8_17), .C1(n_8_16), .C2(n_8_28), 
      .ZN(n_8_29));
   INV_X1_LVT i_8_24 (.A(n_8_10), .ZN(n_8_24));
   OAI221_X1_LVT i_8_32 (.A(n_8_5), .B1(n_8_7), .B2(n_8_26), .C1(n_8_29), 
      .C2(n_8_24), .ZN(uart_state_nxt_reg[2]));
   INV_X1_LVT i_39_0 (.A(xfer_bit[0]), .ZN(n_119));
   AOI21_X1_LVT i_41_1 (.A(n_123), .B1(n_41_0), .B2(n_119), .ZN(n_41_1));
   INV_X1_LVT i_41_2 (.A(n_41_1), .ZN(n_124));
   INV_X1_LVT i_42_0 (.A(xfer_done), .ZN(n_42_0));
   INV_X1_LVT i_42_1 (.A(n_123), .ZN(n_42_1));
   NAND3_X1_LVT i_42_2 (.A1(n_42_0), .A2(n_42_1), .A3(xfer_bit_inc), .ZN(n_42_2));
   NAND3_X1_LVT i_42_3 (.A1(n_42_2), .A2(n_42_0), .A3(n_42_1), .ZN(n_128));
   CLKGATETST_X1_LVT clk_gate_xfer_bit_reg (.CK(dbg_clk), .E(n_128), .SE(1'b0), 
      .GCK(n_118));
   DFFR_X1_LVT \xfer_bit_reg[0]  (.D(n_124), .RN(n_130), .CK(n_118), .Q(
      xfer_bit[0]), .QN());
   HA_X1_LVT i_39_1 (.A(xfer_bit[1]), .B(xfer_bit[0]), .CO(n_39_0), .S(n_120));
   AND2_X1_LVT i_41_3 (.A1(n_41_0), .A2(n_120), .ZN(n_125));
   DFFR_X1_LVT \xfer_bit_reg[1]  (.D(n_125), .RN(n_130), .CK(n_118), .Q(
      xfer_bit[1]), .QN());
   HA_X1_LVT i_39_2 (.A(xfer_bit[2]), .B(n_39_0), .CO(n_39_1), .S(n_121));
   XNOR2_X1_LVT i_39_3 (.A(xfer_bit[3]), .B(n_39_1), .ZN(n_39_2));
   INV_X1_LVT i_39_4 (.A(n_39_2), .ZN(n_122));
   AND2_X1_LVT i_41_5 (.A1(n_41_0), .A2(n_122), .ZN(n_127));
   DFFR_X1_LVT \xfer_bit_reg[3]  (.D(n_127), .RN(n_130), .CK(n_118), .Q(
      xfer_bit[3]), .QN());
   NOR4_X1_LVT i_36_0 (.A1(xfer_bit[0]), .A2(xfer_bit[1]), .A3(xfer_bit[2]), 
      .A4(xfer_bit[3]), .ZN(n_116));
   OR3_X1_LVT i_37_0 (.A1(uart_state[0]), .A2(uart_state[1]), .A3(uart_state[2]), 
      .ZN(n_117));
   INV_X1_LVT i_15_0 (.A(rxd_maj), .ZN(n_15_0));
   NOR2_X1_LVT i_15_1 (.A1(n_15_0), .A2(rxd_maj_nxt), .ZN(rxd_fe));
   AND3_X1_LVT i_40_0 (.A1(n_116), .A2(n_117), .A3(rxd_fe), .ZN(n_40_0));
   INV_X1_LVT i_13_5 (.A(uart_state[2]), .ZN(n_13_2));
   NOR3_X1_LVT i_13_6 (.A1(n_13_2), .A2(uart_state[0]), .A3(uart_state[1]), 
      .ZN(n_28));
   AOI21_X1_LVT i_24_0 (.A(dbg_rd_rdy), .B1(xfer_done), .B2(n_28), .ZN(n_24_0));
   INV_X1_LVT i_24_1 (.A(n_24_0), .ZN(txd_start));
   OR2_X1_LVT i_40_1 (.A1(n_40_0), .A2(txd_start), .ZN(n_123));
   NOR2_X1_LVT i_41_0 (.A1(xfer_done), .A2(n_123), .ZN(n_41_0));
   AND2_X1_LVT i_41_4 (.A1(n_41_0), .A2(n_121), .ZN(n_126));
   DFFR_X1_LVT \xfer_bit_reg[2]  (.D(n_126), .RN(n_130), .CK(n_118), .Q(
      xfer_bit[2]), .QN());
   INV_X1_LVT i_44_0 (.A(xfer_bit[2]), .ZN(n_44_0));
   INV_X1_LVT i_13_0 (.A(uart_state[1]), .ZN(n_13_0));
   NOR3_X1_LVT i_13_1 (.A1(n_13_0), .A2(uart_state[0]), .A3(uart_state[2]), 
      .ZN(n_25));
   INV_X1_LVT i_13_2 (.A(uart_state[0]), .ZN(n_13_1));
   NOR3_X1_LVT i_13_4 (.A1(n_13_1), .A2(uart_state[1]), .A3(uart_state[2]), 
      .ZN(n_27));
   NOR3_X1_LVT i_13_3 (.A1(n_13_0), .A2(n_13_1), .A3(uart_state[2]), .ZN(n_26));
   OR3_X1_LVT i_25_0 (.A1(n_25), .A2(n_27), .A3(n_26), .ZN(rx_active));
   NAND4_X1_LVT i_44_1 (.A1(n_44_0), .A2(xfer_bit[1]), .A3(xfer_bit[3]), 
      .A4(rx_active), .ZN(n_44_1));
   INV_X1_LVT i_44_2 (.A(rx_active), .ZN(n_44_2));
   NAND4_X1_LVT i_44_3 (.A1(n_44_2), .A2(xfer_bit[0]), .A3(xfer_bit[1]), 
      .A4(xfer_bit[3]), .ZN(n_44_3));
   OAI22_X1_LVT i_44_4 (.A1(n_44_1), .A2(xfer_bit[0]), .B1(n_44_3), .B2(
      xfer_bit[2]), .ZN(xfer_done));
   NOR3_X1_LVT i_11_0 (.A1(xfer_done), .A2(mem_burst_rd), .A3(mem_burst_wr), 
      .ZN(n_11_0));
   NAND2_X1_LVT i_14_0 (.A1(n_29), .A2(rxd_maj_nxt), .ZN(n_14_0));
   NOR2_X1_LVT i_14_1 (.A1(n_14_0), .A2(rxd_maj), .ZN(n_31));
   NAND2_X1_LVT i_11_1 (.A1(n_31), .A2(sync_busy), .ZN(n_11_1));
   NAND2_X1_LVT i_11_2 (.A1(n_11_0), .A2(n_11_1), .ZN(n_24));
   CLKGATETST_X1_LVT clk_gate_uart_state_reg (.CK(dbg_clk), .E(n_24), .SE(1'b0), 
      .GCK(n_23));
   DFFR_X1_LVT \uart_state_reg[2]  (.D(uart_state_nxt_reg[2]), .RN(n_130), 
      .CK(n_23), .Q(uart_state[2]), .QN());
   INV_X1_LVT i_8_3 (.A(uart_state[2]), .ZN(n_8_3));
   AND3_X1_LVT i_8_10 (.A1(n_8_0), .A2(n_8_3), .A3(uart_state[0]), .ZN(n_8_10));
   INV_X1_LVT i_8_18 (.A(xfer_buf[19]), .ZN(n_8_18));
   NOR2_X1_LVT i_8_19 (.A1(n_8_15), .A2(n_8_18), .ZN(n_8_19));
   OAI21_X1_LVT i_8_26 (.A(n_8_10), .B1(n_8_19), .B2(mem_burst_wr), .ZN(n_8_25));
   NAND3_X1_LVT i_8_6 (.A1(n_8_3), .A2(uart_state[0]), .A3(uart_state[1]), 
      .ZN(n_8_6));
   OAI211_X1_LVT i_8_28 (.A(n_8_25), .B(n_8_2), .C1(n_8_6), .C2(n_8_26), 
      .ZN(uart_state_nxt_reg[1]));
   DFFR_X1_LVT \uart_state_reg[1]  (.D(uart_state_nxt_reg[1]), .RN(n_130), 
      .CK(n_23), .Q(uart_state[1]), .QN());
   INV_X1_LVT i_8_0 (.A(uart_state[1]), .ZN(n_8_0));
   NOR3_X1_LVT i_8_1 (.A1(n_8_0), .A2(uart_state[0]), .A3(uart_state[2]), 
      .ZN(n_8_1));
   INV_X1_LVT i_8_2 (.A(n_8_1), .ZN(n_8_2));
   NAND4_X1_LVT i_8_8 (.A1(n_8_2), .A2(n_8_5), .A3(n_8_6), .A4(n_8_7), .ZN(n_8_8));
   NOR3_X1_LVT i_8_9 (.A1(uart_state[0]), .A2(uart_state[1]), .A3(uart_state[2]), 
      .ZN(n_8_9));
   OR3_X1_LVT i_8_11 (.A1(n_8_8), .A2(n_8_9), .A3(n_8_10), .ZN(n_8_11));
   NAND2_X1_LVT i_8_12 (.A1(mem_bw), .A2(n_22), .ZN(n_8_12));
   AOI22_X1_LVT i_8_13 (.A1(n_8_6), .A2(n_8_7), .B1(n_8_12), .B2(n_22), .ZN(
      n_8_13));
   NOR4_X1_LVT i_8_14 (.A1(n_8_13), .A2(n_8_4), .A3(n_8_1), .A4(n_8_9), .ZN(
      n_8_14));
   NAND2_X1_LVT i_8_22 (.A1(n_8_21), .A2(n_8_20), .ZN(n_8_22));
   AOI221_X1_LVT i_8_23 (.A(n_8_17), .B1(n_8_19), .B2(xfer_buf[18]), .C1(n_8_22), 
      .C2(mem_bw), .ZN(n_8_23));
   OAI211_X1_LVT i_8_25 (.A(n_8_11), .B(n_8_14), .C1(n_8_23), .C2(n_8_24), 
      .ZN(uart_state_nxt_reg[0]));
   DFFR_X1_LVT \uart_state_reg[0]  (.D(uart_state_nxt_reg[0]), .RN(n_130), 
      .CK(n_23), .Q(uart_state[0]), .QN());
   NOR3_X1_LVT i_13_7 (.A1(uart_state[0]), .A2(uart_state[1]), .A3(uart_state[2]), 
      .ZN(n_29));
   AND2_X1_LVT i_17_0 (.A1(n_29), .A2(rxd_fe), .ZN(n_33));
   OR2_X1_LVT i_18_0 (.A1(n_31), .A2(n_33), .ZN(n_34));
   CLKGATETST_X1_LVT clk_gate_sync_busy_reg (.CK(dbg_clk), .E(n_34), .SE(1'b0), 
      .GCK(n_32));
   DFFR_X1_LVT sync_busy_reg (.D(n_33), .RN(n_130), .CK(n_32), .Q(sync_busy), 
      .QN());
   INV_X1_LVT i_22_0 (.A(sync_busy), .ZN(n_22_0));
   NAND2_X1_LVT i_22_2 (.A1(n_22_1), .A2(n_22_0), .ZN(n_76));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__14 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_50));
   DFFS_X1_LVT \sync_cnt_reg[3]  (.D(n_60), .SN(n_130), .CK(n_50), .Q(
      bit_cnt_max[0]), .QN());
   HA_X1_LVT i_21_3 (.A(bit_cnt_max[0]), .B(n_21_1), .CO(n_21_2), .S(n_60));
   HA_X1_LVT i_21_4 (.A(bit_cnt_max[1]), .B(n_21_2), .CO(n_21_3), .S(n_61));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__13 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_49));
   DFFS_X1_LVT \sync_cnt_reg[4]  (.D(n_61), .SN(n_130), .CK(n_49), .Q(
      bit_cnt_max[1]), .QN());
   XOR2_X1_LVT i_29_0 (.A(rxd_maj), .B(rxd_maj_nxt), .Z(n_29_0));
   AND2_X1_LVT i_29_1 (.A1(n_29_0), .A2(rx_active), .ZN(n_95));
   OR2_X1_LVT i_28_0 (.A1(txd_start), .A2(xfer_bit_inc), .ZN(n_94));
   INV_X1_LVT i_30_1 (.A(n_94), .ZN(n_30_0));
   NOR2_X1_LVT i_30_2 (.A1(n_30_0), .A2(n_95), .ZN(n_97));
   INV_X1_LVT i_27_0 (.A(xfer_cnt[0]), .ZN(n_78));
   NOR2_X1_LVT i_30_0 (.A1(n_94), .A2(n_95), .ZN(n_96));
   AOI222_X1_LVT i_31_0 (.A1(bit_cnt_max[1]), .A2(n_95), .B1(bit_cnt_max[0]), 
      .B2(n_97), .C1(n_78), .C2(n_96), .ZN(n_31_0));
   INV_X1_LVT i_31_1 (.A(n_31_0), .ZN(n_98));
   INV_X1_LVT i_33_0 (.A(n_94), .ZN(n_33_0));
   INV_X1_LVT i_33_1 (.A(n_95), .ZN(n_33_1));
   XNOR2_X1_LVT i_27_1 (.A(xfer_cnt[1]), .B(xfer_cnt[0]), .ZN(n_79));
   NAND2_X1_LVT i_31_2 (.A1(n_96), .A2(n_79), .ZN(n_31_1));
   INV_X1_LVT i_31_3 (.A(n_95), .ZN(n_31_2));
   HA_X1_LVT i_21_5 (.A(bit_cnt_max[2]), .B(n_21_3), .CO(n_21_4), .S(n_62));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__12 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_48));
   DFFS_X1_LVT \sync_cnt_reg[5]  (.D(n_62), .SN(n_130), .CK(n_48), .Q(
      bit_cnt_max[2]), .QN());
   INV_X1_LVT i_31_4 (.A(bit_cnt_max[2]), .ZN(n_31_3));
   INV_X1_LVT i_31_5 (.A(bit_cnt_max[1]), .ZN(n_31_4));
   INV_X1_LVT i_31_6 (.A(n_97), .ZN(n_31_5));
   OAI221_X1_LVT i_31_7 (.A(n_31_1), .B1(n_31_2), .B2(n_31_3), .C1(n_31_4), 
      .C2(n_31_5), .ZN(n_99));
   DFFR_X1_LVT \xfer_cnt_reg[1]  (.D(n_99), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[1]), .QN());
   OR2_X1_LVT i_27_2 (.A1(xfer_cnt[1]), .A2(xfer_cnt[0]), .ZN(n_27_0));
   XNOR2_X1_LVT i_27_3 (.A(xfer_cnt[2]), .B(n_27_0), .ZN(n_80));
   NAND2_X1_LVT i_31_8 (.A1(n_96), .A2(n_80), .ZN(n_31_6));
   HA_X1_LVT i_21_6 (.A(bit_cnt_max[3]), .B(n_21_4), .CO(n_21_5), .S(n_63));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__11 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_47));
   DFFS_X1_LVT \sync_cnt_reg[6]  (.D(n_63), .SN(n_130), .CK(n_47), .Q(
      bit_cnt_max[3]), .QN());
   INV_X1_LVT i_31_9 (.A(bit_cnt_max[3]), .ZN(n_31_7));
   OAI221_X1_LVT i_31_10 (.A(n_31_6), .B1(n_31_2), .B2(n_31_7), .C1(n_31_5), 
      .C2(n_31_3), .ZN(n_100));
   DFFR_X1_LVT \xfer_cnt_reg[2]  (.D(n_100), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[2]), .QN());
   OR2_X1_LVT i_27_4 (.A1(xfer_cnt[2]), .A2(n_27_0), .ZN(n_27_1));
   XNOR2_X1_LVT i_27_5 (.A(xfer_cnt[3]), .B(n_27_1), .ZN(n_81));
   NAND2_X1_LVT i_31_11 (.A1(n_96), .A2(n_81), .ZN(n_31_8));
   HA_X1_LVT i_21_7 (.A(bit_cnt_max[4]), .B(n_21_5), .CO(n_21_6), .S(n_64));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__10 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_46));
   DFFS_X1_LVT \sync_cnt_reg[7]  (.D(n_64), .SN(n_130), .CK(n_46), .Q(
      bit_cnt_max[4]), .QN());
   INV_X1_LVT i_31_12 (.A(bit_cnt_max[4]), .ZN(n_31_9));
   OAI221_X1_LVT i_31_13 (.A(n_31_8), .B1(n_31_2), .B2(n_31_9), .C1(n_31_5), 
      .C2(n_31_7), .ZN(n_101));
   DFFR_X1_LVT \xfer_cnt_reg[3]  (.D(n_101), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[3]), .QN());
   NOR4_X1_LVT i_32_0 (.A1(xfer_cnt[0]), .A2(xfer_cnt[1]), .A3(xfer_cnt[2]), 
      .A4(xfer_cnt[3]), .ZN(n_32_0));
   OR2_X1_LVT i_27_6 (.A1(xfer_cnt[3]), .A2(n_27_1), .ZN(n_27_2));
   XNOR2_X1_LVT i_27_7 (.A(xfer_cnt[4]), .B(n_27_2), .ZN(n_82));
   NAND2_X1_LVT i_31_14 (.A1(n_96), .A2(n_82), .ZN(n_31_10));
   HA_X1_LVT i_21_8 (.A(bit_cnt_max[5]), .B(n_21_6), .CO(n_21_7), .S(n_65));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__9 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_45));
   DFFS_X1_LVT \sync_cnt_reg[8]  (.D(n_65), .SN(n_130), .CK(n_45), .Q(
      bit_cnt_max[5]), .QN());
   INV_X1_LVT i_31_15 (.A(bit_cnt_max[5]), .ZN(n_31_11));
   OAI221_X1_LVT i_31_16 (.A(n_31_10), .B1(n_31_2), .B2(n_31_11), .C1(n_31_5), 
      .C2(n_31_9), .ZN(n_102));
   DFFR_X1_LVT \xfer_cnt_reg[4]  (.D(n_102), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[4]), .QN());
   OR2_X1_LVT i_27_8 (.A1(xfer_cnt[4]), .A2(n_27_2), .ZN(n_27_3));
   XNOR2_X1_LVT i_27_9 (.A(xfer_cnt[5]), .B(n_27_3), .ZN(n_83));
   NAND2_X1_LVT i_31_17 (.A1(n_96), .A2(n_83), .ZN(n_31_12));
   HA_X1_LVT i_21_9 (.A(bit_cnt_max[6]), .B(n_21_7), .CO(n_21_8), .S(n_66));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__8 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_44));
   DFFS_X1_LVT \sync_cnt_reg[9]  (.D(n_66), .SN(n_130), .CK(n_44), .Q(
      bit_cnt_max[6]), .QN());
   INV_X1_LVT i_31_18 (.A(bit_cnt_max[6]), .ZN(n_31_13));
   OAI221_X1_LVT i_31_19 (.A(n_31_12), .B1(n_31_2), .B2(n_31_13), .C1(n_31_5), 
      .C2(n_31_11), .ZN(n_103));
   DFFR_X1_LVT \xfer_cnt_reg[5]  (.D(n_103), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[5]), .QN());
   OR2_X1_LVT i_27_10 (.A1(xfer_cnt[5]), .A2(n_27_3), .ZN(n_27_4));
   XNOR2_X1_LVT i_27_11 (.A(xfer_cnt[6]), .B(n_27_4), .ZN(n_84));
   NAND2_X1_LVT i_31_20 (.A1(n_96), .A2(n_84), .ZN(n_31_14));
   HA_X1_LVT i_21_10 (.A(bit_cnt_max[7]), .B(n_21_8), .CO(n_21_9), .S(n_67));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__7 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_43));
   DFFS_X1_LVT \sync_cnt_reg[10]  (.D(n_67), .SN(n_130), .CK(n_43), .Q(
      bit_cnt_max[7]), .QN());
   INV_X1_LVT i_31_21 (.A(bit_cnt_max[7]), .ZN(n_31_15));
   OAI221_X1_LVT i_31_22 (.A(n_31_14), .B1(n_31_2), .B2(n_31_15), .C1(n_31_5), 
      .C2(n_31_13), .ZN(n_104));
   DFFR_X1_LVT \xfer_cnt_reg[6]  (.D(n_104), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[6]), .QN());
   OR2_X1_LVT i_27_12 (.A1(xfer_cnt[6]), .A2(n_27_4), .ZN(n_27_5));
   XNOR2_X1_LVT i_27_13 (.A(xfer_cnt[7]), .B(n_27_5), .ZN(n_85));
   NAND2_X1_LVT i_31_23 (.A1(n_96), .A2(n_85), .ZN(n_31_16));
   HA_X1_LVT i_21_11 (.A(bit_cnt_max[8]), .B(n_21_9), .CO(n_21_10), .S(n_68));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__6 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_42));
   DFFS_X1_LVT \sync_cnt_reg[11]  (.D(n_68), .SN(n_130), .CK(n_42), .Q(
      bit_cnt_max[8]), .QN());
   INV_X1_LVT i_31_24 (.A(bit_cnt_max[8]), .ZN(n_31_17));
   OAI221_X1_LVT i_31_25 (.A(n_31_16), .B1(n_31_2), .B2(n_31_17), .C1(n_31_5), 
      .C2(n_31_15), .ZN(n_105));
   DFFR_X1_LVT \xfer_cnt_reg[7]  (.D(n_105), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[7]), .QN());
   NOR4_X1_LVT i_32_1 (.A1(xfer_cnt[4]), .A2(xfer_cnt[5]), .A3(xfer_cnt[6]), 
      .A4(xfer_cnt[7]), .ZN(n_32_1));
   OR2_X1_LVT i_27_14 (.A1(xfer_cnt[7]), .A2(n_27_5), .ZN(n_27_6));
   XNOR2_X1_LVT i_27_15 (.A(xfer_cnt[8]), .B(n_27_6), .ZN(n_86));
   NAND2_X1_LVT i_31_26 (.A1(n_96), .A2(n_86), .ZN(n_31_18));
   HA_X1_LVT i_21_12 (.A(bit_cnt_max[9]), .B(n_21_10), .CO(n_21_11), .S(n_69));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__5 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_41));
   DFFS_X1_LVT \sync_cnt_reg[12]  (.D(n_69), .SN(n_130), .CK(n_41), .Q(
      bit_cnt_max[9]), .QN());
   INV_X1_LVT i_31_27 (.A(bit_cnt_max[9]), .ZN(n_31_19));
   OAI221_X1_LVT i_31_28 (.A(n_31_18), .B1(n_31_2), .B2(n_31_19), .C1(n_31_5), 
      .C2(n_31_17), .ZN(n_106));
   DFFR_X1_LVT \xfer_cnt_reg[8]  (.D(n_106), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[8]), .QN());
   OR2_X1_LVT i_27_16 (.A1(xfer_cnt[8]), .A2(n_27_6), .ZN(n_27_7));
   XNOR2_X1_LVT i_27_17 (.A(xfer_cnt[9]), .B(n_27_7), .ZN(n_87));
   NAND2_X1_LVT i_31_29 (.A1(n_96), .A2(n_87), .ZN(n_31_20));
   HA_X1_LVT i_21_13 (.A(bit_cnt_max[10]), .B(n_21_11), .CO(n_21_12), .S(n_70));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__4 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_40));
   DFFS_X1_LVT \sync_cnt_reg[13]  (.D(n_70), .SN(n_130), .CK(n_40), .Q(
      bit_cnt_max[10]), .QN());
   INV_X1_LVT i_31_30 (.A(bit_cnt_max[10]), .ZN(n_31_21));
   OAI221_X1_LVT i_31_31 (.A(n_31_20), .B1(n_31_2), .B2(n_31_21), .C1(n_31_5), 
      .C2(n_31_19), .ZN(n_107));
   DFFR_X1_LVT \xfer_cnt_reg[9]  (.D(n_107), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[9]), .QN());
   OR2_X1_LVT i_27_18 (.A1(xfer_cnt[9]), .A2(n_27_7), .ZN(n_27_8));
   XNOR2_X1_LVT i_27_19 (.A(xfer_cnt[10]), .B(n_27_8), .ZN(n_88));
   NAND2_X1_LVT i_31_32 (.A1(n_96), .A2(n_88), .ZN(n_31_22));
   HA_X1_LVT i_21_14 (.A(bit_cnt_max[11]), .B(n_21_12), .CO(n_21_13), .S(n_71));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__3 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_39));
   DFFS_X1_LVT \sync_cnt_reg[14]  (.D(n_71), .SN(n_130), .CK(n_39), .Q(
      bit_cnt_max[11]), .QN());
   INV_X1_LVT i_31_33 (.A(bit_cnt_max[11]), .ZN(n_31_23));
   OAI221_X1_LVT i_31_34 (.A(n_31_22), .B1(n_31_2), .B2(n_31_23), .C1(n_31_5), 
      .C2(n_31_21), .ZN(n_108));
   DFFR_X1_LVT \xfer_cnt_reg[10]  (.D(n_108), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[10]), .QN());
   OR2_X1_LVT i_27_20 (.A1(xfer_cnt[10]), .A2(n_27_8), .ZN(n_27_9));
   XNOR2_X1_LVT i_27_21 (.A(xfer_cnt[11]), .B(n_27_9), .ZN(n_89));
   NAND2_X1_LVT i_31_35 (.A1(n_96), .A2(n_89), .ZN(n_31_24));
   HA_X1_LVT i_21_15 (.A(bit_cnt_max[12]), .B(n_21_13), .CO(n_21_14), .S(n_72));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__2 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_38));
   DFFS_X1_LVT \sync_cnt_reg[15]  (.D(n_72), .SN(n_130), .CK(n_38), .Q(
      bit_cnt_max[12]), .QN());
   INV_X1_LVT i_31_36 (.A(bit_cnt_max[12]), .ZN(n_31_25));
   OAI221_X1_LVT i_31_37 (.A(n_31_24), .B1(n_31_2), .B2(n_31_25), .C1(n_31_5), 
      .C2(n_31_23), .ZN(n_109));
   DFFR_X1_LVT \xfer_cnt_reg[11]  (.D(n_109), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[11]), .QN());
   NOR4_X1_LVT i_32_2 (.A1(xfer_cnt[8]), .A2(xfer_cnt[9]), .A3(xfer_cnt[10]), 
      .A4(xfer_cnt[11]), .ZN(n_32_2));
   OR2_X1_LVT i_27_22 (.A1(xfer_cnt[11]), .A2(n_27_9), .ZN(n_27_10));
   XNOR2_X1_LVT i_27_23 (.A(xfer_cnt[12]), .B(n_27_10), .ZN(n_90));
   NAND2_X1_LVT i_31_38 (.A1(n_96), .A2(n_90), .ZN(n_31_26));
   HA_X1_LVT i_21_16 (.A(bit_cnt_max[13]), .B(n_21_14), .CO(n_21_15), .S(n_73));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__1 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_37));
   DFFS_X1_LVT \sync_cnt_reg[16]  (.D(n_73), .SN(n_130), .CK(n_37), .Q(
      bit_cnt_max[13]), .QN());
   INV_X1_LVT i_31_39 (.A(bit_cnt_max[13]), .ZN(n_31_27));
   OAI221_X1_LVT i_31_40 (.A(n_31_26), .B1(n_31_2), .B2(n_31_27), .C1(n_31_5), 
      .C2(n_31_25), .ZN(n_110));
   DFFR_X1_LVT \xfer_cnt_reg[12]  (.D(n_110), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[12]), .QN());
   OR2_X1_LVT i_27_24 (.A1(xfer_cnt[12]), .A2(n_27_10), .ZN(n_27_11));
   XNOR2_X1_LVT i_27_25 (.A(xfer_cnt[13]), .B(n_27_11), .ZN(n_91));
   NAND2_X1_LVT i_31_41 (.A1(n_96), .A2(n_91), .ZN(n_31_28));
   HA_X1_LVT i_21_17 (.A(bit_cnt_max[14]), .B(n_21_15), .CO(n_21_16), .S(n_74));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg__0 (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_36));
   DFFS_X1_LVT \sync_cnt_reg[17]  (.D(n_74), .SN(n_130), .CK(n_36), .Q(
      bit_cnt_max[14]), .QN());
   INV_X1_LVT i_31_42 (.A(bit_cnt_max[14]), .ZN(n_31_29));
   OAI221_X1_LVT i_31_43 (.A(n_31_28), .B1(n_31_2), .B2(n_31_29), .C1(n_31_5), 
      .C2(n_31_27), .ZN(n_111));
   DFFR_X1_LVT \xfer_cnt_reg[13]  (.D(n_111), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[13]), .QN());
   OR2_X1_LVT i_27_26 (.A1(xfer_cnt[13]), .A2(n_27_11), .ZN(n_27_12));
   XNOR2_X1_LVT i_27_27 (.A(xfer_cnt[14]), .B(n_27_12), .ZN(n_92));
   NAND2_X1_LVT i_31_44 (.A1(n_96), .A2(n_92), .ZN(n_31_30));
   XNOR2_X1_LVT i_21_18 (.A(bit_cnt_max[15]), .B(n_21_16), .ZN(n_21_17));
   INV_X1_LVT i_21_19 (.A(n_21_17), .ZN(n_75));
   CLKGATETST_X1_LVT clk_gate_sync_cnt_reg (.CK(dbg_clk), .E(n_76), .SE(1'b0), 
      .GCK(n_35));
   DFFS_X1_LVT \sync_cnt_reg[18]  (.D(n_75), .SN(n_130), .CK(n_35), .Q(
      bit_cnt_max[15]), .QN());
   INV_X1_LVT i_31_45 (.A(bit_cnt_max[15]), .ZN(n_31_31));
   OAI221_X1_LVT i_31_46 (.A(n_31_30), .B1(n_31_2), .B2(n_31_31), .C1(n_31_5), 
      .C2(n_31_29), .ZN(n_112));
   DFFR_X1_LVT \xfer_cnt_reg[14]  (.D(n_112), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[14]), .QN());
   OR2_X1_LVT i_27_28 (.A1(xfer_cnt[14]), .A2(n_27_12), .ZN(n_27_13));
   XNOR2_X1_LVT i_27_29 (.A(xfer_cnt[15]), .B(n_27_13), .ZN(n_93));
   AOI22_X1_LVT i_31_47 (.A1(n_97), .A2(bit_cnt_max[15]), .B1(n_96), .B2(n_93), 
      .ZN(n_31_32));
   INV_X1_LVT i_31_48 (.A(n_31_32), .ZN(n_113));
   DFFR_X1_LVT \xfer_cnt_reg[15]  (.D(n_113), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[15]), .QN());
   NOR4_X1_LVT i_32_3 (.A1(xfer_cnt[12]), .A2(xfer_cnt[13]), .A3(xfer_cnt[14]), 
      .A4(xfer_cnt[15]), .ZN(n_32_3));
   NAND4_X1_LVT i_32_4 (.A1(n_32_0), .A2(n_32_1), .A3(n_32_2), .A4(n_32_3), 
      .ZN(n_114));
   NAND3_X1_LVT i_33_2 (.A1(n_33_0), .A2(n_33_1), .A3(n_114), .ZN(n_33_2));
   NAND3_X1_LVT i_33_3 (.A1(n_33_2), .A2(n_33_0), .A3(n_33_1), .ZN(n_115));
   CLKGATETST_X1_LVT clk_gate_xfer_cnt_reg (.CK(dbg_clk), .E(n_115), .SE(1'b0), 
      .GCK(n_77));
   DFFR_X1_LVT \xfer_cnt_reg[0]  (.D(n_98), .RN(n_130), .CK(n_77), .Q(
      xfer_cnt[0]), .QN());
   NOR4_X1_LVT i_35_0 (.A1(xfer_cnt[0]), .A2(xfer_cnt[1]), .A3(xfer_cnt[2]), 
      .A4(xfer_cnt[3]), .ZN(n_35_0));
   NOR4_X1_LVT i_35_1 (.A1(xfer_cnt[4]), .A2(xfer_cnt[5]), .A3(xfer_cnt[6]), 
      .A4(xfer_cnt[7]), .ZN(n_35_1));
   NOR4_X1_LVT i_35_2 (.A1(xfer_cnt[8]), .A2(xfer_cnt[9]), .A3(xfer_cnt[10]), 
      .A4(xfer_cnt[11]), .ZN(n_35_2));
   NOR4_X1_LVT i_35_3 (.A1(xfer_cnt[12]), .A2(xfer_cnt[13]), .A3(xfer_cnt[14]), 
      .A4(xfer_cnt[15]), .ZN(n_35_3));
   NAND4_X1_LVT i_35_4 (.A1(n_35_0), .A2(n_35_1), .A3(n_35_2), .A4(n_35_3), 
      .ZN(n_35_4));
   NOR4_X1_LVT i_35_5 (.A1(xfer_bit[0]), .A2(xfer_bit[1]), .A3(xfer_bit[2]), 
      .A4(xfer_bit[3]), .ZN(n_35_5));
   NOR2_X1_LVT i_35_6 (.A1(n_35_4), .A2(n_35_5), .ZN(xfer_bit_inc));
   INV_X1_LVT i_5_1 (.A(xfer_bit_inc), .ZN(n_5_1));
   INV_X1_LVT i_5_0 (.A(dbg_rd_rdy), .ZN(n_5_0));
   NAND2_X1_LVT i_5_2 (.A1(n_5_1), .A2(n_5_0), .ZN(n_21));
   CLKGATETST_X1_LVT clk_gate_xfer_buf_reg (.CK(dbg_clk), .E(n_21), .SE(1'b0), 
      .GCK(n_0));
   DFFR_X1_LVT \xfer_buf_reg[19]  (.D(n_19), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[19]), .QN());
   AOI22_X1_LVT i_4_34 (.A1(n_4_0), .A2(xfer_buf[19]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[15]), .ZN(n_4_17));
   INV_X1_LVT i_4_35 (.A(n_4_17), .ZN(n_18));
   DFFR_X1_LVT \xfer_buf_reg[18]  (.D(n_18), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[18]), .QN());
   AOI22_X1_LVT i_4_32 (.A1(n_4_0), .A2(xfer_buf[18]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[14]), .ZN(n_4_16));
   INV_X1_LVT i_4_33 (.A(n_4_16), .ZN(n_17));
   DFFR_X1_LVT \xfer_buf_reg[17]  (.D(n_17), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[17]), .QN());
   AND2_X1_LVT i_45_0 (.A1(n_27), .A2(xfer_done), .ZN(cmd_valid));
   CLKGATETST_X1_LVT clk_gate_dbg_addr_reg (.CK(dbg_clk), .E(cmd_valid), 
      .SE(1'b0), .GCK(n_129));
   DFFR_X1_LVT \dbg_addr_reg[5]  (.D(xfer_buf[17]), .RN(n_130), .CK(n_129), 
      .Q(dbg_addr[5]), .QN());
   AOI22_X1_LVT i_4_30 (.A1(n_4_0), .A2(xfer_buf[17]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[13]), .ZN(n_4_15));
   INV_X1_LVT i_4_31 (.A(n_4_15), .ZN(n_16));
   DFFR_X1_LVT \xfer_buf_reg[16]  (.D(n_16), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[16]), .QN());
   DFFR_X1_LVT \dbg_addr_reg[4]  (.D(xfer_buf[16]), .RN(n_130), .CK(n_129), 
      .Q(dbg_addr[4]), .QN());
   AOI22_X1_LVT i_4_28 (.A1(n_4_0), .A2(xfer_buf[16]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[12]), .ZN(n_4_14));
   INV_X1_LVT i_4_29 (.A(n_4_14), .ZN(n_15));
   DFFR_X1_LVT \xfer_buf_reg[15]  (.D(n_15), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[15]), .QN());
   DFFR_X1_LVT \dbg_addr_reg[3]  (.D(xfer_buf[15]), .RN(n_130), .CK(n_129), 
      .Q(dbg_addr[3]), .QN());
   AOI22_X1_LVT i_4_26 (.A1(n_4_0), .A2(xfer_buf[15]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[11]), .ZN(n_4_13));
   INV_X1_LVT i_4_27 (.A(n_4_13), .ZN(n_14));
   DFFR_X1_LVT \xfer_buf_reg[14]  (.D(n_14), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[14]), .QN());
   DFFR_X1_LVT \dbg_addr_reg[2]  (.D(xfer_buf[14]), .RN(n_130), .CK(n_129), 
      .Q(dbg_addr[2]), .QN());
   AOI22_X1_LVT i_4_24 (.A1(n_4_0), .A2(xfer_buf[14]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[10]), .ZN(n_4_12));
   INV_X1_LVT i_4_25 (.A(n_4_12), .ZN(n_13));
   DFFR_X1_LVT \xfer_buf_reg[13]  (.D(n_13), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[13]), .QN());
   DFFR_X1_LVT \dbg_addr_reg[1]  (.D(xfer_buf[13]), .RN(n_130), .CK(n_129), 
      .Q(dbg_addr[1]), .QN());
   AOI22_X1_LVT i_4_22 (.A1(n_4_0), .A2(xfer_buf[13]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[9]), .ZN(n_4_11));
   INV_X1_LVT i_4_23 (.A(n_4_11), .ZN(n_12));
   DFFR_X1_LVT \xfer_buf_reg[12]  (.D(n_12), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[12]), .QN());
   DFFR_X1_LVT \dbg_addr_reg[0]  (.D(xfer_buf[12]), .RN(n_130), .CK(n_129), 
      .Q(dbg_addr[0]), .QN());
   INV_X1_LVT i_49_0 (.A(mem_burst), .ZN(n_49_0));
   CLKGATETST_X1_LVT clk_gate_dbg_bw_reg (.CK(dbg_clk), .E(cmd_valid), .SE(1'b0), 
      .GCK(n_131));
   DFFR_X1_LVT dbg_bw_reg (.D(xfer_buf[18]), .RN(n_130), .CK(n_131), .Q(dbg_bw), 
      .QN());
   AOI22_X1_LVT i_49_1 (.A1(n_49_0), .A2(dbg_bw), .B1(mem_bw), .B2(mem_burst), 
      .ZN(n_49_1));
   AND2_X1_LVT i_49_26 (.A1(n_49_1), .A2(xfer_buf[19]), .ZN(dbg_din[15]));
   AND2_X1_LVT i_49_25 (.A1(n_49_1), .A2(xfer_buf[18]), .ZN(dbg_din[14]));
   AND2_X1_LVT i_49_24 (.A1(n_49_1), .A2(xfer_buf[17]), .ZN(dbg_din[13]));
   AND2_X1_LVT i_49_23 (.A1(n_49_1), .A2(xfer_buf[16]), .ZN(dbg_din[12]));
   AND2_X1_LVT i_49_22 (.A1(n_49_1), .A2(xfer_buf[15]), .ZN(dbg_din[11]));
   AND2_X1_LVT i_49_21 (.A1(n_49_1), .A2(xfer_buf[14]), .ZN(dbg_din[10]));
   AND2_X1_LVT i_49_20 (.A1(n_49_1), .A2(xfer_buf[13]), .ZN(dbg_din[9]));
   AND2_X1_LVT i_49_19 (.A1(n_49_1), .A2(xfer_buf[12]), .ZN(dbg_din[8]));
   INV_X1_LVT i_49_2 (.A(n_49_1), .ZN(n_49_2));
   AOI22_X1_LVT i_4_20 (.A1(n_4_0), .A2(xfer_buf[12]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[8]), .ZN(n_4_10));
   INV_X1_LVT i_4_21 (.A(n_4_10), .ZN(n_11));
   DFFR_X1_LVT \xfer_buf_reg[11]  (.D(n_11), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[11]), .QN());
   AND2_X1_LVT i_4_19 (.A1(n_4_0), .A2(xfer_buf[11]), .ZN(n_10));
   DFFR_X1_LVT \xfer_buf_reg[10]  (.D(n_10), .RN(n_130), .CK(n_0), .Q(
      xfer_buf[10]), .QN());
   AOI22_X1_LVT i_49_17 (.A1(n_49_2), .A2(xfer_buf[19]), .B1(n_49_1), .B2(
      xfer_buf[10]), .ZN(n_49_10));
   INV_X1_LVT i_49_18 (.A(n_49_10), .ZN(dbg_din[7]));
   INV_X1_LVT i_4_18 (.A(xfer_buf[10]), .ZN(n_4_9));
   NAND2_X1_LVT i_4_38 (.A1(n_4_9), .A2(n_4_0), .ZN(n_20));
   DFFR_X1_LVT \xfer_buf_reg[9]  (.D(n_20), .RN(n_130), .CK(n_0), .Q(xfer_buf[9]), 
      .QN());
   AOI22_X1_LVT i_49_15 (.A1(n_49_2), .A2(xfer_buf[18]), .B1(n_49_1), .B2(
      xfer_buf[9]), .ZN(n_49_9));
   INV_X1_LVT i_49_16 (.A(n_49_9), .ZN(dbg_din[6]));
   AOI22_X1_LVT i_4_16 (.A1(n_4_0), .A2(xfer_buf[9]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[7]), .ZN(n_4_8));
   INV_X1_LVT i_4_17 (.A(n_4_8), .ZN(n_9));
   DFFR_X1_LVT \xfer_buf_reg[8]  (.D(n_9), .RN(n_130), .CK(n_0), .Q(xfer_buf[8]), 
      .QN());
   AOI22_X1_LVT i_49_13 (.A1(n_49_2), .A2(xfer_buf[17]), .B1(n_49_1), .B2(
      xfer_buf[8]), .ZN(n_49_8));
   INV_X1_LVT i_49_14 (.A(n_49_8), .ZN(dbg_din[5]));
   AOI22_X1_LVT i_4_14 (.A1(n_4_0), .A2(xfer_buf[8]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[6]), .ZN(n_4_7));
   INV_X1_LVT i_4_15 (.A(n_4_7), .ZN(n_8));
   DFFR_X1_LVT \xfer_buf_reg[7]  (.D(n_8), .RN(n_130), .CK(n_0), .Q(xfer_buf[7]), 
      .QN());
   AOI22_X1_LVT i_49_11 (.A1(n_49_2), .A2(xfer_buf[16]), .B1(n_49_1), .B2(
      xfer_buf[7]), .ZN(n_49_7));
   INV_X1_LVT i_49_12 (.A(n_49_7), .ZN(dbg_din[4]));
   AOI22_X1_LVT i_4_12 (.A1(n_4_0), .A2(xfer_buf[7]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[5]), .ZN(n_4_6));
   INV_X1_LVT i_4_13 (.A(n_4_6), .ZN(n_7));
   DFFR_X1_LVT \xfer_buf_reg[6]  (.D(n_7), .RN(n_130), .CK(n_0), .Q(xfer_buf[6]), 
      .QN());
   AOI22_X1_LVT i_49_9 (.A1(n_49_2), .A2(xfer_buf[15]), .B1(n_49_1), .B2(
      xfer_buf[6]), .ZN(n_49_6));
   INV_X1_LVT i_49_10 (.A(n_49_6), .ZN(dbg_din[3]));
   AOI22_X1_LVT i_4_10 (.A1(n_4_0), .A2(xfer_buf[6]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[4]), .ZN(n_4_5));
   INV_X1_LVT i_4_11 (.A(n_4_5), .ZN(n_6));
   DFFR_X1_LVT \xfer_buf_reg[5]  (.D(n_6), .RN(n_130), .CK(n_0), .Q(xfer_buf[5]), 
      .QN());
   AOI22_X1_LVT i_49_7 (.A1(n_49_2), .A2(xfer_buf[14]), .B1(n_49_1), .B2(
      xfer_buf[5]), .ZN(n_49_5));
   INV_X1_LVT i_49_8 (.A(n_49_5), .ZN(dbg_din[2]));
   AOI22_X1_LVT i_4_8 (.A1(n_4_0), .A2(xfer_buf[5]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[3]), .ZN(n_4_4));
   INV_X1_LVT i_4_9 (.A(n_4_4), .ZN(n_5));
   DFFR_X1_LVT \xfer_buf_reg[4]  (.D(n_5), .RN(n_130), .CK(n_0), .Q(xfer_buf[4]), 
      .QN());
   AOI22_X1_LVT i_49_5 (.A1(n_49_2), .A2(xfer_buf[13]), .B1(n_49_1), .B2(
      xfer_buf[4]), .ZN(n_49_4));
   INV_X1_LVT i_49_6 (.A(n_49_4), .ZN(dbg_din[1]));
   AOI22_X1_LVT i_4_6 (.A1(n_4_0), .A2(xfer_buf[4]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[2]), .ZN(n_4_3));
   INV_X1_LVT i_4_7 (.A(n_4_3), .ZN(n_4));
   DFFR_X1_LVT \xfer_buf_reg[3]  (.D(n_4), .RN(n_130), .CK(n_0), .Q(xfer_buf[3]), 
      .QN());
   AOI22_X1_LVT i_49_3 (.A1(n_49_2), .A2(xfer_buf[12]), .B1(n_49_1), .B2(
      xfer_buf[3]), .ZN(n_49_3));
   INV_X1_LVT i_49_4 (.A(n_49_3), .ZN(dbg_din[0]));
   INV_X1_LVT i_52_0 (.A(mem_burst), .ZN(n_52_0));
   INV_X1_LVT i_50_0 (.A(mem_burst_rd), .ZN(n_50_0));
   INV_X1_LVT i_50_1 (.A(cmd_valid), .ZN(n_50_1));
   OAI21_X1_LVT i_50_2 (.A(n_50_0), .B1(n_50_1), .B2(xfer_buf[19]), .ZN(n_132));
   NOR3_X1_LVT i_13_8 (.A1(n_13_2), .A2(n_13_1), .A3(uart_state[1]), .ZN(n_30));
   AND2_X1_LVT i_51_0 (.A1(xfer_done), .A2(n_30), .ZN(n_133));
   AOI22_X1_LVT i_52_1 (.A1(n_52_0), .A2(n_132), .B1(n_133), .B2(mem_burst), 
      .ZN(n_52_1));
   INV_X1_LVT i_52_2 (.A(n_52_1), .ZN(dbg_rd));
   AOI22_X1_LVT i_4_4 (.A1(n_4_0), .A2(xfer_buf[3]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[1]), .ZN(n_4_2));
   INV_X1_LVT i_4_5 (.A(n_4_2), .ZN(n_3));
   DFFR_X1_LVT \xfer_buf_reg[2]  (.D(n_3), .RN(n_130), .CK(n_0), .Q(xfer_buf[2]), 
      .QN());
   AOI22_X1_LVT i_4_2 (.A1(n_4_0), .A2(xfer_buf[2]), .B1(dbg_rd_rdy), .B2(
      dbg_dout[0]), .ZN(n_4_1));
   INV_X1_LVT i_4_3 (.A(n_4_1), .ZN(n_2));
   DFFR_X1_LVT \xfer_buf_reg[1]  (.D(n_2), .RN(n_130), .CK(n_0), .Q(xfer_buf[1]), 
      .QN());
   AND2_X1_LVT i_4_1 (.A1(n_4_0), .A2(xfer_buf[1]), .ZN(n_1));
   DFFR_X1_LVT \xfer_buf_reg[0]  (.D(n_1), .RN(n_130), .CK(n_0), .Q(xfer_buf[0]), 
      .QN());
   OAI21_X1_LVT i_54_0 (.A(xfer_bit_inc), .B1(n_28), .B2(n_30), .ZN(n_54_0));
   INV_X1_LVT i_54_1 (.A(n_54_0), .ZN(n_135));
   CLKGATETST_X1_LVT clk_gate_dbg_uart_txd_reg (.CK(dbg_clk), .E(n_135), 
      .SE(1'b0), .GCK(n_134));
   DFFS_X1_LVT dbg_uart_txd_reg (.D(xfer_buf[0]), .SN(n_130), .CK(n_134), 
      .Q(dbg_uart_txd), .QN());
   AND2_X1_LVT i_56_0 (.A1(xfer_done), .A2(n_26), .ZN(dbg_wr));
endmodule

module omsp_dbg(dbg_cpu_reset, dbg_freeze, dbg_halt_cmd, dbg_i2c_sda_out, 
      dbg_mem_addr, dbg_mem_dout, dbg_mem_en, dbg_mem_wr, dbg_reg_wr, 
      dbg_uart_txd, cpu_en_s, cpu_id, cpu_nr_inst, cpu_nr_total, dbg_clk, 
      dbg_en_s, dbg_halt_st, dbg_i2c_addr, dbg_i2c_broadcast, dbg_i2c_scl, 
      dbg_i2c_sda_in, dbg_mem_din, dbg_reg_din, dbg_rst, dbg_uart_rxd, 
      decode_noirq, eu_mab, eu_mb_en, eu_mb_wr, fe_mdb_in, pc, puc_pnd_set);
   output dbg_cpu_reset;
   output dbg_freeze;
   output dbg_halt_cmd;
   output dbg_i2c_sda_out;
   output [15:0]dbg_mem_addr;
   output [15:0]dbg_mem_dout;
   output dbg_mem_en;
   output [1:0]dbg_mem_wr;
   output dbg_reg_wr;
   output dbg_uart_txd;
   input cpu_en_s;
   input [31:0]cpu_id;
   input [7:0]cpu_nr_inst;
   input [7:0]cpu_nr_total;
   input dbg_clk;
   input dbg_en_s;
   input dbg_halt_st;
   input [6:0]dbg_i2c_addr;
   input [6:0]dbg_i2c_broadcast;
   input dbg_i2c_scl;
   input dbg_i2c_sda_in;
   input [15:0]dbg_mem_din;
   input [15:0]dbg_reg_din;
   input dbg_rst;
   input dbg_uart_rxd;
   input decode_noirq;
   input [15:0]eu_mab;
   input eu_mb_en;
   input [1:0]eu_mb_wr;
   input [15:0]fe_mdb_in;
   input [15:0]pc;
   input puc_pnd_set;

   wire dbg_wr;
   wire dbg_rd;
   wire [15:0]dbg_din;
   wire [5:0]dbg_addr;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire mem_start;
   wire [3:1]mem_ctl;
   wire mem_burst_rd;
   wire mem_startb;
   wire n_6_0;
   wire n_6_1;
   wire n_8_0;
   wire n_9_0;
   wire n_9_1;
   wire n_9_2;
   wire n_9_3;
   wire n_9_4;
   wire n_9_5;
   wire [1:0]mem_state_nxt_reg;
   wire n_9_6;
   wire [1:0]mem_state;
   wire n_12_0;
   wire mem_access;
   wire n_16_0;
   wire n_17_0;
   wire n_17_1;
   wire n_17_2;
   wire n_17_3;
   wire n_17_4;
   wire n_17_5;
   wire n_17_6;
   wire n_19_0;
   wire n_19_1;
   wire n_19_2;
   wire n_19_3;
   wire n_19_4;
   wire n_19_5;
   wire n_19_6;
   wire n_19_7;
   wire n_19_8;
   wire n_19_9;
   wire n_19_10;
   wire n_19_11;
   wire n_19_12;
   wire n_19_13;
   wire n_19_14;
   wire n_19_15;
   wire n_20_0;
   wire n_20_1;
   wire n_20_2;
   wire n_20_3;
   wire n_20_4;
   wire n_20_5;
   wire n_20_6;
   wire n_20_7;
   wire n_20_8;
   wire n_20_9;
   wire n_20_10;
   wire n_20_11;
   wire n_20_12;
   wire n_20_13;
   wire n_20_14;
   wire n_20_15;
   wire n_20_16;
   wire n_22_0;
   wire dbg_reg_rd;
   wire dbg_mem_rd;
   wire dbg_mem_rd_dly;
   wire dbg_rd_rdy;
   wire n_32_0;
   wire n_32_1;
   wire n_34_0;
   wire dbg_mem_acc;
   wire n_35_0;
   wire n_35_1;
   wire n_37_0;
   wire n_37_1;
   wire n_37_2;
   wire n_37_3;
   wire n_37_4;
   wire [15:0]mem_cnt;
   wire n_39_0;
   wire n_39_1;
   wire n_39_2;
   wire n_39_3;
   wire n_39_4;
   wire n_39_5;
   wire n_39_6;
   wire n_39_7;
   wire n_39_8;
   wire n_39_9;
   wire n_39_10;
   wire n_39_11;
   wire n_39_12;
   wire n_39_13;
   wire n_39_14;
   wire n_39_15;
   wire n_39_16;
   wire n_40_0;
   wire n_40_1;
   wire n_40_2;
   wire n_40_3;
   wire n_40_4;
   wire n_40_5;
   wire n_40_6;
   wire n_40_7;
   wire n_40_8;
   wire n_40_9;
   wire n_40_10;
   wire n_40_11;
   wire n_40_12;
   wire n_40_13;
   wire n_40_14;
   wire n_40_15;
   wire n_40_16;
   wire n_42_0;
   wire n_42_1;
   wire n_42_2;
   wire n_42_3;
   wire mem_burst_start;
   wire n_44_0;
   wire mem_burst_end;
   wire mem_burst;
   wire n_46_0;
   wire n_46_1;
   wire n_48_0;
   wire [5:0]dbg_addr_in;
   wire n_48_1;
   wire n_48_2;
   wire n_49_0;
   wire n_49_1;
   wire n_49_2;
   wire n_49_3;
   wire n_49_4;
   wire n_49_5;
   wire n_49_6;
   wire n_49_7;
   wire n_49_8;
   wire n_49_9;
   wire n_49_10;
   wire n_49_11;
   wire n_49_12;
   wire n_49_13;
   wire n_49_14;
   wire n_49_15;
   wire n_49_16;
   wire n_49_17;
   wire n_49_18;
   wire n_49_19;
   wire n_49_20;
   wire n_49_21;
   wire cpu_ctl_wr;
   wire mem_ctl_wr;
   wire mem_data_wr;
   wire [6:3]cpu_ctl;
   wire n_53_0;
   wire n_53_1;
   wire n_54_0;
   wire n_54_1;
   wire n_54_2;
   wire n_54_3;
   wire n_54_4;
   wire dbg_swbrk;
   wire n_55_0;
   wire n_55_1;
   wire n_55_2;
   wire n_55_3;
   wire n_55_4;
   wire n_55_5;
   wire halt_flag_set;
   wire n_57_0;
   wire n_57_1;
   wire n_57_2;
   wire halt_flag_clr;
   wire halt_flag;
   wire n_59_0;
   wire n_60_0;
   wire n_60_1;
   wire istep;
   wire n_64_0;
   wire n_64_1;
   wire n_66_0;
   wire n_68_0;
   wire n_68_1;
   wire n_68_2;
   wire n_68_3;
   wire n_68_4;
   wire n_68_5;
   wire n_68_6;
   wire n_68_7;
   wire n_68_8;
   wire [15:0]mem_data;
   wire n_70_0;
   wire n_71_0;
   wire n_71_1;
   wire n_71_2;
   wire n_71_3;
   wire n_71_4;
   wire n_71_5;
   wire n_71_6;
   wire n_71_7;
   wire n_71_8;
   wire n_71_9;
   wire n_71_10;
   wire n_71_11;
   wire n_71_12;
   wire n_71_13;
   wire n_71_14;
   wire n_71_15;
   wire n_72_0;
   wire n_72_1;
   wire n_72_2;
   wire n_74_0;
   wire n_74_1;
   wire n_74_2;
   wire n_74_3;
   wire n_74_4;
   wire n_74_5;
   wire n_74_6;
   wire n_74_7;
   wire n_74_8;
   wire n_74_9;
   wire n_74_10;
   wire n_74_11;
   wire n_74_12;
   wire n_74_13;
   wire n_74_14;
   wire n_74_15;
   wire n_74_16;
   wire n_74_17;
   wire n_74_18;
   wire n_74_19;
   wire [3:2]cpu_stat;
   wire n_76_0;
   wire n_76_1;
   wire n_76_2;
   wire n_76_3;
   wire n_76_4;
   wire n_76_5;
   wire n_76_6;
   wire n_78_0;
   wire n_78_1;
   wire n_78_2;
   wire n_78_3;
   wire n_78_4;
   wire n_78_5;
   wire n_78_6;
   wire n_78_7;
   wire [15:0]dbg_dout;
   wire n_78_8;
   wire n_78_9;
   wire n_78_10;
   wire n_78_11;
   wire n_78_12;
   wire n_78_13;
   wire n_78_14;
   wire n_78_15;
   wire n_78_16;
   wire n_78_17;
   wire n_78_18;
   wire n_78_19;
   wire n_78_20;
   wire n_78_21;
   wire n_78_22;
   wire n_78_23;
   wire n_78_24;
   wire n_78_25;
   wire n_78_26;
   wire n_78_27;
   wire n_78_28;
   wire n_78_29;
   wire n_78_30;
   wire n_78_31;
   wire n_78_32;
   wire n_78_33;
   wire n_78_34;
   wire n_78_35;
   wire n_78_36;
   wire n_78_37;
   wire n_78_38;
   wire n_78_39;
   wire n_78_40;
   wire n_78_41;
   wire n_78_42;
   wire n_78_43;
   wire n_78_44;
   wire n_78_45;
   wire n_78_46;
   wire n_78_47;
   wire n_78_48;
   wire n_78_49;
   wire n_78_50;
   wire n_78_51;
   wire n_78_52;
   wire n_78_53;
   wire n_78_54;
   wire n_78_55;
   wire n_78_56;
   wire n_78_57;
   wire n_78_58;
   wire n_78_59;
   wire n_78_60;
   wire n_78_61;
   wire n_78_62;
   wire n_78_63;
   wire n_78_64;
   wire n_78_65;
   wire n_78_66;
   wire n_78_67;
   wire n_78_68;
   wire n_78_69;
   wire n_78_70;
   wire n_78_71;
   wire n_78_72;
   wire n_78_73;
   wire n_78_74;
   wire n_78_75;
   wire n_78_76;
   wire n_78_77;
   wire n_78_78;
   wire n_78_79;
   wire n_78_80;
   wire n_78_81;
   wire n_78_82;
   wire n_78_83;
   wire n_78_84;
   wire n_78_85;
   wire n_78_86;
   wire n_78_87;
   wire n_78_88;
   wire n_78_89;
   wire n_78_90;
   wire n_78_91;
   wire n_78_92;
   wire n_78_93;
   wire n_78_94;
   wire n_78_95;
   wire n_78_96;
   wire n_78_97;
   wire n_78_98;
   wire n_78_99;
   wire n_78_100;
   wire n_78_101;
   wire n_78_102;
   wire n_78_103;
   wire n_78_104;
   wire n_78_105;
   wire n_78_106;
   wire n_78_107;
   wire n_78_108;
   wire n_78_109;
   wire n_78_110;
   wire n_78_111;
   wire n_78_112;
   wire n_78_113;
   wire n_78_114;
   wire n_78_115;
   wire mem_burst_wr;

   assign dbg_i2c_sda_out = 1'b1;

   INV_X1_LVT i_48_2 (.A(dbg_addr[1]), .ZN(n_48_1));
   NAND2_X1_LVT i_48_7 (.A1(n_48_1), .A2(n_48_0), .ZN(dbg_addr_in[1]));
   NOR2_X1_LVT i_49_2 (.A1(dbg_addr_in[0]), .A2(dbg_addr_in[1]), .ZN(n_49_2));
   INV_X1_LVT i_48_3 (.A(dbg_addr[2]), .ZN(n_48_2));
   NAND2_X1_LVT i_48_8 (.A1(n_48_2), .A2(n_48_0), .ZN(dbg_addr_in[2]));
   NAND2_X1_LVT i_49_11 (.A1(n_49_2), .A2(dbg_addr_in[2]), .ZN(n_49_11));
   AND2_X1_LVT i_48_4 (.A1(n_48_0), .A2(dbg_addr[3]), .ZN(dbg_addr_in[3]));
   INV_X1_LVT i_49_15 (.A(dbg_addr_in[3]), .ZN(n_49_15));
   AND2_X1_LVT i_48_5 (.A1(n_48_0), .A2(dbg_addr[4]), .ZN(dbg_addr_in[4]));
   AND2_X1_LVT i_48_6 (.A1(n_48_0), .A2(dbg_addr[5]), .ZN(dbg_addr_in[5]));
   NOR2_X1_LVT i_49_16 (.A1(dbg_addr_in[4]), .A2(dbg_addr_in[5]), .ZN(n_49_16));
   NAND2_X1_LVT i_49_20 (.A1(n_49_15), .A2(n_49_16), .ZN(n_49_20));
   NOR2_X1_LVT i_49_26 (.A1(n_49_11), .A2(n_49_20), .ZN(n_95));
   AND2_X1_LVT i_50_2 (.A1(dbg_wr), .A2(n_95), .ZN(mem_ctl_wr));
   AND2_X1_LVT i_1_0 (.A1(mem_ctl_wr), .A2(dbg_din[0]), .ZN(n_1));
   INV_X1_LVT i_51_0 (.A(dbg_rst), .ZN(n_104));
   DFFR_X1_LVT mem_start_reg (.D(n_1), .RN(n_104), .CK(dbg_clk), .Q(mem_start), 
      .QN());
   AND2_X1_LVT i_50_5 (.A1(dbg_wr), .A2(n_98), .ZN(n_102));
   INV_X1_LVT i_40_0 (.A(n_102), .ZN(n_40_0));
   INV_X1_LVT i_39_3 (.A(mem_cnt[0]), .ZN(n_39_2));
   NAND2_X1_LVT i_39_2 (.A1(n_55), .A2(n_39_2), .ZN(n_39_1));
   XNOR2_X1_LVT i_39_4 (.A(mem_cnt[1]), .B(n_39_1), .ZN(n_57));
   AOI22_X1_LVT i_40_3 (.A1(n_40_0), .A2(n_57), .B1(n_102), .B2(dbg_din[1]), 
      .ZN(n_40_2));
   INV_X1_LVT i_40_4 (.A(n_40_2), .ZN(n_73));
   DFFR_X1_LVT \mem_cnt_reg[1]  (.D(n_73), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[1]), .QN());
   OR2_X1_LVT i_39_5 (.A1(mem_cnt[1]), .A2(n_39_1), .ZN(n_39_3));
   XNOR2_X1_LVT i_39_6 (.A(mem_cnt[2]), .B(n_39_3), .ZN(n_58));
   AOI22_X1_LVT i_40_5 (.A1(n_40_0), .A2(n_58), .B1(n_102), .B2(dbg_din[2]), 
      .ZN(n_40_3));
   INV_X1_LVT i_40_6 (.A(n_40_3), .ZN(n_74));
   DFFR_X1_LVT \mem_cnt_reg[2]  (.D(n_74), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[2]), .QN());
   OR2_X1_LVT i_39_7 (.A1(mem_cnt[2]), .A2(n_39_3), .ZN(n_39_4));
   XNOR2_X1_LVT i_39_8 (.A(mem_cnt[3]), .B(n_39_4), .ZN(n_59));
   AOI22_X1_LVT i_40_7 (.A1(n_40_0), .A2(n_59), .B1(n_102), .B2(dbg_din[3]), 
      .ZN(n_40_4));
   INV_X1_LVT i_40_8 (.A(n_40_4), .ZN(n_75));
   DFFR_X1_LVT \mem_cnt_reg[3]  (.D(n_75), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[3]), .QN());
   NOR4_X1_LVT i_37_0 (.A1(mem_cnt[0]), .A2(mem_cnt[1]), .A3(mem_cnt[2]), 
      .A4(mem_cnt[3]), .ZN(n_37_0));
   OR2_X1_LVT i_39_9 (.A1(mem_cnt[3]), .A2(n_39_4), .ZN(n_39_5));
   XNOR2_X1_LVT i_39_10 (.A(mem_cnt[4]), .B(n_39_5), .ZN(n_60));
   AOI22_X1_LVT i_40_9 (.A1(n_40_0), .A2(n_60), .B1(n_102), .B2(dbg_din[4]), 
      .ZN(n_40_5));
   INV_X1_LVT i_40_10 (.A(n_40_5), .ZN(n_76));
   DFFR_X1_LVT \mem_cnt_reg[4]  (.D(n_76), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[4]), .QN());
   OR2_X1_LVT i_39_11 (.A1(mem_cnt[4]), .A2(n_39_5), .ZN(n_39_6));
   XNOR2_X1_LVT i_39_12 (.A(mem_cnt[5]), .B(n_39_6), .ZN(n_61));
   AOI22_X1_LVT i_40_11 (.A1(n_40_0), .A2(n_61), .B1(n_102), .B2(dbg_din[5]), 
      .ZN(n_40_6));
   INV_X1_LVT i_40_12 (.A(n_40_6), .ZN(n_77));
   DFFR_X1_LVT \mem_cnt_reg[5]  (.D(n_77), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[5]), .QN());
   OR2_X1_LVT i_39_13 (.A1(mem_cnt[5]), .A2(n_39_6), .ZN(n_39_7));
   XNOR2_X1_LVT i_39_14 (.A(mem_cnt[6]), .B(n_39_7), .ZN(n_62));
   AOI22_X1_LVT i_40_13 (.A1(n_40_0), .A2(n_62), .B1(n_102), .B2(dbg_din[6]), 
      .ZN(n_40_7));
   INV_X1_LVT i_40_14 (.A(n_40_7), .ZN(n_78));
   DFFR_X1_LVT \mem_cnt_reg[6]  (.D(n_78), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[6]), .QN());
   OR2_X1_LVT i_39_15 (.A1(mem_cnt[6]), .A2(n_39_7), .ZN(n_39_8));
   XNOR2_X1_LVT i_39_16 (.A(mem_cnt[7]), .B(n_39_8), .ZN(n_63));
   AOI22_X1_LVT i_40_15 (.A1(n_40_0), .A2(n_63), .B1(n_102), .B2(dbg_din[7]), 
      .ZN(n_40_8));
   INV_X1_LVT i_40_16 (.A(n_40_8), .ZN(n_79));
   DFFR_X1_LVT \mem_cnt_reg[7]  (.D(n_79), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[7]), .QN());
   NOR4_X1_LVT i_37_1 (.A1(mem_cnt[4]), .A2(mem_cnt[5]), .A3(mem_cnt[6]), 
      .A4(mem_cnt[7]), .ZN(n_37_1));
   OR2_X1_LVT i_39_17 (.A1(mem_cnt[7]), .A2(n_39_8), .ZN(n_39_9));
   XNOR2_X1_LVT i_39_18 (.A(mem_cnt[8]), .B(n_39_9), .ZN(n_64));
   AOI22_X1_LVT i_40_17 (.A1(n_40_0), .A2(n_64), .B1(n_102), .B2(dbg_din[8]), 
      .ZN(n_40_9));
   INV_X1_LVT i_40_18 (.A(n_40_9), .ZN(n_80));
   DFFR_X1_LVT \mem_cnt_reg[8]  (.D(n_80), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[8]), .QN());
   OR2_X1_LVT i_39_19 (.A1(mem_cnt[8]), .A2(n_39_9), .ZN(n_39_10));
   XNOR2_X1_LVT i_39_20 (.A(mem_cnt[9]), .B(n_39_10), .ZN(n_65));
   AOI22_X1_LVT i_40_19 (.A1(n_40_0), .A2(n_65), .B1(n_102), .B2(dbg_din[9]), 
      .ZN(n_40_10));
   INV_X1_LVT i_40_20 (.A(n_40_10), .ZN(n_81));
   DFFR_X1_LVT \mem_cnt_reg[9]  (.D(n_81), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[9]), .QN());
   OR2_X1_LVT i_39_21 (.A1(mem_cnt[9]), .A2(n_39_10), .ZN(n_39_11));
   XNOR2_X1_LVT i_39_22 (.A(mem_cnt[10]), .B(n_39_11), .ZN(n_66));
   AOI22_X1_LVT i_40_21 (.A1(n_40_0), .A2(n_66), .B1(n_102), .B2(dbg_din[10]), 
      .ZN(n_40_11));
   INV_X1_LVT i_40_22 (.A(n_40_11), .ZN(n_82));
   DFFR_X1_LVT \mem_cnt_reg[10]  (.D(n_82), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[10]), .QN());
   OR2_X1_LVT i_39_23 (.A1(mem_cnt[10]), .A2(n_39_11), .ZN(n_39_12));
   XNOR2_X1_LVT i_39_24 (.A(mem_cnt[11]), .B(n_39_12), .ZN(n_67));
   AOI22_X1_LVT i_40_23 (.A1(n_40_0), .A2(n_67), .B1(n_102), .B2(dbg_din[11]), 
      .ZN(n_40_12));
   INV_X1_LVT i_40_24 (.A(n_40_12), .ZN(n_83));
   DFFR_X1_LVT \mem_cnt_reg[11]  (.D(n_83), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[11]), .QN());
   NOR4_X1_LVT i_37_2 (.A1(mem_cnt[8]), .A2(mem_cnt[9]), .A3(mem_cnt[10]), 
      .A4(mem_cnt[11]), .ZN(n_37_2));
   OR2_X1_LVT i_39_25 (.A1(mem_cnt[11]), .A2(n_39_12), .ZN(n_39_13));
   XNOR2_X1_LVT i_39_26 (.A(mem_cnt[12]), .B(n_39_13), .ZN(n_68));
   AOI22_X1_LVT i_40_25 (.A1(n_40_0), .A2(n_68), .B1(n_102), .B2(dbg_din[12]), 
      .ZN(n_40_13));
   INV_X1_LVT i_40_26 (.A(n_40_13), .ZN(n_84));
   DFFR_X1_LVT \mem_cnt_reg[12]  (.D(n_84), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[12]), .QN());
   OR2_X1_LVT i_39_27 (.A1(mem_cnt[12]), .A2(n_39_13), .ZN(n_39_14));
   XNOR2_X1_LVT i_39_28 (.A(mem_cnt[13]), .B(n_39_14), .ZN(n_69));
   AOI22_X1_LVT i_40_27 (.A1(n_40_0), .A2(n_69), .B1(n_102), .B2(dbg_din[13]), 
      .ZN(n_40_14));
   INV_X1_LVT i_40_28 (.A(n_40_14), .ZN(n_85));
   DFFR_X1_LVT \mem_cnt_reg[13]  (.D(n_85), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[13]), .QN());
   OR2_X1_LVT i_39_29 (.A1(mem_cnt[13]), .A2(n_39_14), .ZN(n_39_15));
   XNOR2_X1_LVT i_39_30 (.A(mem_cnt[14]), .B(n_39_15), .ZN(n_70));
   AOI22_X1_LVT i_40_29 (.A1(n_40_0), .A2(n_70), .B1(n_102), .B2(dbg_din[14]), 
      .ZN(n_40_15));
   INV_X1_LVT i_40_30 (.A(n_40_15), .ZN(n_86));
   DFFR_X1_LVT \mem_cnt_reg[14]  (.D(n_86), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[14]), .QN());
   OR2_X1_LVT i_39_31 (.A1(mem_cnt[14]), .A2(n_39_15), .ZN(n_39_16));
   XNOR2_X1_LVT i_39_32 (.A(mem_cnt[15]), .B(n_39_16), .ZN(n_71));
   AOI22_X1_LVT i_40_31 (.A1(n_40_0), .A2(n_71), .B1(n_102), .B2(dbg_din[15]), 
      .ZN(n_40_16));
   INV_X1_LVT i_40_32 (.A(n_40_16), .ZN(n_87));
   DFFR_X1_LVT \mem_cnt_reg[15]  (.D(n_87), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[15]), .QN());
   NOR4_X1_LVT i_37_3 (.A1(mem_cnt[12]), .A2(mem_cnt[13]), .A3(mem_cnt[14]), 
      .A4(mem_cnt[15]), .ZN(n_37_3));
   NAND4_X1_LVT i_37_4 (.A1(n_37_0), .A2(n_37_1), .A3(n_37_2), .A4(n_37_3), 
      .ZN(n_37_4));
   CLKGATETST_X1_LVT clk_gate_mem_ctl_reg (.CK(dbg_clk), .E(mem_ctl_wr), 
      .SE(1'b0), .GCK(n_2));
   DFFR_X1_LVT \mem_ctl_reg[1]  (.D(dbg_din[1]), .RN(n_104), .CK(n_2), .Q(
      mem_ctl[1]), .QN());
   OAI21_X1_LVT i_6_0 (.A(mem_burst), .B1(dbg_wr), .B2(dbg_rd), .ZN(n_6_0));
   INV_X1_LVT i_4_0 (.A(mem_ctl[1]), .ZN(n_3));
   AND2_X1_LVT i_5_0 (.A1(n_3), .A2(mem_burst_start), .ZN(mem_burst_rd));
   INV_X1_LVT i_6_1 (.A(mem_burst_rd), .ZN(n_6_1));
   NAND2_X1_LVT i_6_2 (.A1(n_6_0), .A2(n_6_1), .ZN(n_4));
   DFFR_X1_LVT mem_startb_reg (.D(n_4), .RN(n_104), .CK(dbg_clk), .Q(mem_startb), 
      .QN());
   NOR4_X1_LVT i_0_0 (.A1(mem_cnt[0]), .A2(mem_cnt[1]), .A3(mem_cnt[2]), 
      .A4(mem_cnt[3]), .ZN(n_0_0));
   NOR4_X1_LVT i_0_1 (.A1(mem_cnt[4]), .A2(mem_cnt[5]), .A3(mem_cnt[6]), 
      .A4(mem_cnt[7]), .ZN(n_0_1));
   NOR4_X1_LVT i_0_2 (.A1(mem_cnt[8]), .A2(mem_cnt[9]), .A3(mem_cnt[10]), 
      .A4(mem_cnt[11]), .ZN(n_0_2));
   NOR4_X1_LVT i_0_3 (.A1(mem_cnt[12]), .A2(mem_cnt[13]), .A3(mem_cnt[14]), 
      .A4(mem_cnt[15]), .ZN(n_0_3));
   AND4_X1_LVT i_0_4 (.A1(n_0_0), .A2(n_0_1), .A3(n_0_2), .A4(n_0_3), .ZN(n_0));
   AOI21_X1_LVT i_8_0 (.A(mem_startb), .B1(n_0), .B2(mem_start), .ZN(n_8_0));
   INV_X1_LVT i_8_1 (.A(n_8_0), .ZN(n_5));
   NAND2_X1_LVT i_9_0 (.A1(dbg_halt_st), .A2(n_5), .ZN(n_9_0));
   INV_X1_LVT i_9_1 (.A(n_9_0), .ZN(n_9_1));
   INV_X1_LVT i_9_7 (.A(dbg_halt_st), .ZN(n_9_6));
   AOI21_X1_LVT i_9_2 (.A(n_9_1), .B1(n_9_6), .B2(n_5), .ZN(n_9_2));
   INV_X1_LVT i_9_4 (.A(mem_state[1]), .ZN(n_9_4));
   NAND2_X1_LVT i_9_5 (.A1(n_9_4), .A2(mem_state[0]), .ZN(n_9_5));
   OAI22_X1_LVT i_9_8 (.A1(n_9_3), .A2(n_9_0), .B1(n_9_5), .B2(n_9_6), .ZN(
      mem_state_nxt_reg[1]));
   DFFR_X1_LVT \mem_state_reg[1]  (.D(mem_state_nxt_reg[1]), .RN(n_104), 
      .CK(dbg_clk), .Q(mem_state[1]), .QN());
   OR2_X1_LVT i_9_3 (.A1(mem_state[0]), .A2(mem_state[1]), .ZN(n_9_3));
   OAI22_X1_LVT i_9_6 (.A1(n_9_2), .A2(n_9_3), .B1(n_9_5), .B2(dbg_halt_st), 
      .ZN(mem_state_nxt_reg[0]));
   DFFR_X1_LVT \mem_state_reg[0]  (.D(mem_state_nxt_reg[0]), .RN(n_104), 
      .CK(dbg_clk), .Q(mem_state[0]), .QN());
   AND2_X1_LVT i_12_0 (.A1(mem_state[0]), .A2(mem_state[1]), .ZN(n_6));
   INV_X1_LVT i_12_1 (.A(mem_state[1]), .ZN(n_12_0));
   NOR2_X1_LVT i_12_2 (.A1(n_12_0), .A2(mem_state[0]), .ZN(n_7));
   OR2_X1_LVT i_13_0 (.A1(n_6), .A2(n_7), .ZN(mem_access));
   DFFR_X1_LVT \mem_ctl_reg[2]  (.D(dbg_din[2]), .RN(n_104), .CK(n_2), .Q(
      mem_ctl[2]), .QN());
   INV_X1_LVT i_23_0 (.A(mem_ctl[2]), .ZN(n_47));
   AND2_X1_LVT i_24_0 (.A1(mem_access), .A2(n_47), .ZN(dbg_mem_en));
   AND2_X1_LVT i_25_0 (.A1(mem_ctl[1]), .A2(dbg_mem_en), .ZN(n_48));
   NOR2_X1_LVT i_49_3 (.A1(n_49_0), .A2(dbg_addr_in[1]), .ZN(n_49_3));
   NAND2_X1_LVT i_49_12 (.A1(n_49_3), .A2(dbg_addr_in[2]), .ZN(n_49_12));
   NOR2_X1_LVT i_49_27 (.A1(n_49_12), .A2(n_49_20), .ZN(n_96));
   AND2_X1_LVT i_50_3 (.A1(dbg_wr), .A2(n_96), .ZN(n_101));
   INV_X1_LVT i_20_0 (.A(n_101), .ZN(n_20_0));
   NOR4_X1_LVT i_17_0 (.A1(mem_cnt[0]), .A2(mem_cnt[1]), .A3(mem_cnt[2]), 
      .A4(mem_cnt[3]), .ZN(n_17_0));
   NOR4_X1_LVT i_17_1 (.A1(mem_cnt[4]), .A2(mem_cnt[5]), .A3(mem_cnt[6]), 
      .A4(mem_cnt[7]), .ZN(n_17_1));
   NOR4_X1_LVT i_17_2 (.A1(mem_cnt[8]), .A2(mem_cnt[9]), .A3(mem_cnt[10]), 
      .A4(mem_cnt[11]), .ZN(n_17_2));
   NOR4_X1_LVT i_17_3 (.A1(mem_cnt[12]), .A2(mem_cnt[13]), .A3(mem_cnt[14]), 
      .A4(mem_cnt[15]), .ZN(n_17_3));
   NAND4_X1_LVT i_17_4 (.A1(n_17_0), .A2(n_17_1), .A3(n_17_2), .A4(n_17_3), 
      .ZN(n_17_4));
   INV_X1_LVT i_16_0 (.A(dbg_mem_acc), .ZN(n_16_0));
   DFFR_X1_LVT \mem_ctl_reg[3]  (.D(dbg_din[3]), .RN(n_104), .CK(n_2), .Q(
      mem_ctl[3]), .QN());
   NOR2_X1_LVT i_16_1 (.A1(n_16_0), .A2(mem_ctl[3]), .ZN(n_10));
   NAND2_X1_LVT i_17_5 (.A1(n_10), .A2(mem_burst), .ZN(n_17_5));
   AND4_X1_LVT i_17_6 (.A1(n_17_4), .A2(n_17_5), .A3(mem_burst), .A4(n_53), 
      .ZN(n_11));
   HA_X1_LVT i_19_0 (.A(n_11), .B(dbg_mem_addr[0]), .CO(n_19_0), .S(n_13));
   AOI22_X1_LVT i_20_1 (.A1(n_20_0), .A2(n_13), .B1(dbg_din[0]), .B2(n_101), 
      .ZN(n_20_1));
   INV_X1_LVT i_20_2 (.A(n_20_1), .ZN(n_29));
   DFFR_X1_LVT \mem_addr_reg[0]  (.D(n_29), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[0]), .QN());
   NAND2_X1_LVT i_22_2 (.A1(dbg_mem_addr[0]), .A2(mem_ctl[3]), .ZN(n_46));
   AND2_X1_LVT i_26_0 (.A1(n_48), .A2(n_46), .ZN(dbg_mem_wr[0]));
   INV_X1_LVT i_22_0 (.A(dbg_mem_addr[0]), .ZN(n_22_0));
   NAND2_X1_LVT i_22_1 (.A1(n_22_0), .A2(mem_ctl[3]), .ZN(n_45));
   AND2_X1_LVT i_26_1 (.A1(n_48), .A2(n_45), .ZN(dbg_mem_wr[1]));
   OR2_X1_LVT i_27_0 (.A1(dbg_mem_wr[0]), .A2(dbg_mem_wr[1]), .ZN(n_49));
   OR2_X1_LVT i_31_0 (.A1(mem_burst), .A2(mem_burst_rd), .ZN(n_51));
   INV_X1_LVT i_32_0 (.A(n_51), .ZN(n_32_0));
   AND2_X1_LVT i_14_0 (.A1(mem_ctl[2]), .A2(mem_access), .ZN(n_9));
   AND2_X1_LVT i_28_0 (.A1(n_3), .A2(n_9), .ZN(dbg_reg_rd));
   AND2_X1_LVT i_29_0 (.A1(n_3), .A2(dbg_mem_en), .ZN(dbg_mem_rd));
   DFFR_X1_LVT dbg_mem_rd_dly_reg (.D(dbg_mem_rd), .RN(n_104), .CK(dbg_clk), 
      .Q(dbg_mem_rd_dly), .QN());
   OR2_X1_LVT i_30_0 (.A1(dbg_reg_rd), .A2(dbg_mem_rd_dly), .ZN(n_50));
   AOI22_X1_LVT i_32_1 (.A1(n_32_0), .A2(dbg_rd), .B1(n_50), .B2(n_51), .ZN(
      n_32_1));
   INV_X1_LVT i_32_2 (.A(n_32_1), .ZN(n_52));
   DFFR_X1_LVT dbg_rd_rdy_reg (.D(n_52), .RN(n_104), .CK(dbg_clk), .Q(dbg_rd_rdy), 
      .QN());
   AOI21_X1_LVT i_34_0 (.A(n_49), .B1(dbg_rd_rdy), .B2(n_47), .ZN(n_34_0));
   INV_X1_LVT i_34_1 (.A(n_34_0), .ZN(dbg_mem_acc));
   AND2_X1_LVT i_15_0 (.A1(mem_ctl[1]), .A2(n_9), .ZN(dbg_reg_wr));
   NOR2_X1_LVT i_35_0 (.A1(dbg_mem_acc), .A2(dbg_reg_wr), .ZN(n_35_0));
   NAND2_X1_LVT i_35_1 (.A1(mem_ctl[2]), .A2(dbg_rd_rdy), .ZN(n_35_1));
   NAND2_X1_LVT i_35_2 (.A1(n_35_0), .A2(n_35_1), .ZN(n_53));
   AND2_X1_LVT i_36_0 (.A1(n_53), .A2(mem_burst), .ZN(n_54));
   AND2_X1_LVT i_37_5 (.A1(n_37_4), .A2(n_54), .ZN(n_55));
   XNOR2_X1_LVT i_39_0 (.A(n_55), .B(mem_cnt[0]), .ZN(n_39_0));
   INV_X1_LVT i_39_1 (.A(n_39_0), .ZN(n_56));
   AOI22_X1_LVT i_40_1 (.A1(n_40_0), .A2(n_56), .B1(dbg_din[0]), .B2(n_102), 
      .ZN(n_40_1));
   INV_X1_LVT i_40_2 (.A(n_40_1), .ZN(n_72));
   DFFR_X1_LVT \mem_cnt_reg[0]  (.D(n_72), .RN(n_104), .CK(dbg_clk), .Q(
      mem_cnt[0]), .QN());
   NOR4_X1_LVT i_42_0 (.A1(mem_cnt[0]), .A2(mem_cnt[1]), .A3(mem_cnt[2]), 
      .A4(mem_cnt[3]), .ZN(n_42_0));
   NOR4_X1_LVT i_42_1 (.A1(mem_cnt[4]), .A2(mem_cnt[5]), .A3(mem_cnt[6]), 
      .A4(mem_cnt[7]), .ZN(n_42_1));
   NOR4_X1_LVT i_42_2 (.A1(mem_cnt[8]), .A2(mem_cnt[9]), .A3(mem_cnt[10]), 
      .A4(mem_cnt[11]), .ZN(n_42_2));
   NOR4_X1_LVT i_42_3 (.A1(mem_cnt[12]), .A2(mem_cnt[13]), .A3(mem_cnt[14]), 
      .A4(mem_cnt[15]), .ZN(n_42_3));
   NAND4_X1_LVT i_42_4 (.A1(n_42_0), .A2(n_42_1), .A3(n_42_2), .A4(n_42_3), 
      .ZN(n_88));
   AND2_X1_LVT i_43_0 (.A1(mem_start), .A2(n_88), .ZN(mem_burst_start));
   OAI21_X1_LVT i_44_0 (.A(n_0), .B1(dbg_wr), .B2(dbg_rd_rdy), .ZN(n_44_0));
   INV_X1_LVT i_44_1 (.A(n_44_0), .ZN(mem_burst_end));
   INV_X1_LVT i_46_1 (.A(mem_burst_end), .ZN(n_46_1));
   INV_X1_LVT i_46_0 (.A(mem_burst_start), .ZN(n_46_0));
   NAND2_X1_LVT i_46_2 (.A1(n_46_1), .A2(n_46_0), .ZN(n_90));
   CLKGATETST_X1_LVT clk_gate_mem_burst_reg (.CK(dbg_clk), .E(n_90), .SE(1'b0), 
      .GCK(n_89));
   DFFR_X1_LVT mem_burst_reg (.D(mem_burst_start), .RN(n_104), .CK(n_89), 
      .Q(mem_burst), .QN());
   INV_X1_LVT i_48_0 (.A(mem_burst), .ZN(n_48_0));
   AND2_X1_LVT i_48_1 (.A1(n_48_0), .A2(dbg_addr[0]), .ZN(dbg_addr_in[0]));
   INV_X1_LVT i_49_0 (.A(dbg_addr_in[0]), .ZN(n_49_0));
   INV_X1_LVT i_49_1 (.A(dbg_addr_in[1]), .ZN(n_49_1));
   NOR2_X1_LVT i_49_5 (.A1(n_49_0), .A2(n_49_1), .ZN(n_49_5));
   NAND2_X1_LVT i_49_14 (.A1(n_49_5), .A2(dbg_addr_in[2]), .ZN(n_49_14));
   NOR2_X1_LVT i_49_29 (.A1(n_49_14), .A2(n_49_20), .ZN(n_98));
   NAND2_X1_LVT i_78_125 (.A1(n_98), .A2(mem_cnt[15]), .ZN(n_78_110));
   AOI22_X1_LVT i_20_29 (.A1(n_20_0), .A2(n_27), .B1(n_101), .B2(dbg_din[14]), 
      .ZN(n_20_15));
   INV_X1_LVT i_20_30 (.A(n_20_15), .ZN(n_43));
   DFFR_X1_LVT \mem_addr_reg[14]  (.D(n_43), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[14]), .QN());
   AOI22_X1_LVT i_20_27 (.A1(n_20_0), .A2(n_26), .B1(n_101), .B2(dbg_din[13]), 
      .ZN(n_20_14));
   INV_X1_LVT i_20_28 (.A(n_20_14), .ZN(n_42));
   DFFR_X1_LVT \mem_addr_reg[13]  (.D(n_42), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[13]), .QN());
   AOI22_X1_LVT i_20_25 (.A1(n_20_0), .A2(n_25), .B1(n_101), .B2(dbg_din[12]), 
      .ZN(n_20_13));
   INV_X1_LVT i_20_26 (.A(n_20_13), .ZN(n_41));
   DFFR_X1_LVT \mem_addr_reg[12]  (.D(n_41), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[12]), .QN());
   AOI22_X1_LVT i_20_23 (.A1(n_20_0), .A2(n_24), .B1(n_101), .B2(dbg_din[11]), 
      .ZN(n_20_12));
   INV_X1_LVT i_20_24 (.A(n_20_12), .ZN(n_40));
   DFFR_X1_LVT \mem_addr_reg[11]  (.D(n_40), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[11]), .QN());
   AOI22_X1_LVT i_20_21 (.A1(n_20_0), .A2(n_23), .B1(n_101), .B2(dbg_din[10]), 
      .ZN(n_20_11));
   INV_X1_LVT i_20_22 (.A(n_20_11), .ZN(n_39));
   DFFR_X1_LVT \mem_addr_reg[10]  (.D(n_39), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[10]), .QN());
   AOI22_X1_LVT i_20_19 (.A1(n_20_0), .A2(n_22), .B1(n_101), .B2(dbg_din[9]), 
      .ZN(n_20_10));
   INV_X1_LVT i_20_20 (.A(n_20_10), .ZN(n_38));
   DFFR_X1_LVT \mem_addr_reg[9]  (.D(n_38), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[9]), .QN());
   AOI22_X1_LVT i_20_17 (.A1(n_20_0), .A2(n_21), .B1(n_101), .B2(dbg_din[8]), 
      .ZN(n_20_9));
   INV_X1_LVT i_20_18 (.A(n_20_9), .ZN(n_37));
   DFFR_X1_LVT \mem_addr_reg[8]  (.D(n_37), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[8]), .QN());
   AOI22_X1_LVT i_20_15 (.A1(n_20_0), .A2(n_20), .B1(n_101), .B2(dbg_din[7]), 
      .ZN(n_20_8));
   INV_X1_LVT i_20_16 (.A(n_20_8), .ZN(n_36));
   DFFR_X1_LVT \mem_addr_reg[7]  (.D(n_36), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[7]), .QN());
   AOI22_X1_LVT i_20_13 (.A1(n_20_0), .A2(n_19), .B1(n_101), .B2(dbg_din[6]), 
      .ZN(n_20_7));
   INV_X1_LVT i_20_14 (.A(n_20_7), .ZN(n_35));
   DFFR_X1_LVT \mem_addr_reg[6]  (.D(n_35), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[6]), .QN());
   AOI22_X1_LVT i_20_11 (.A1(n_20_0), .A2(n_18), .B1(n_101), .B2(dbg_din[5]), 
      .ZN(n_20_6));
   INV_X1_LVT i_20_12 (.A(n_20_6), .ZN(n_34));
   DFFR_X1_LVT \mem_addr_reg[5]  (.D(n_34), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[5]), .QN());
   AOI22_X1_LVT i_20_9 (.A1(n_20_0), .A2(n_17), .B1(n_101), .B2(dbg_din[4]), 
      .ZN(n_20_5));
   INV_X1_LVT i_20_10 (.A(n_20_5), .ZN(n_33));
   DFFR_X1_LVT \mem_addr_reg[4]  (.D(n_33), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[4]), .QN());
   AOI22_X1_LVT i_20_7 (.A1(n_20_0), .A2(n_16), .B1(n_101), .B2(dbg_din[3]), 
      .ZN(n_20_4));
   INV_X1_LVT i_20_8 (.A(n_20_4), .ZN(n_32));
   DFFR_X1_LVT \mem_addr_reg[3]  (.D(n_32), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[3]), .QN());
   AOI22_X1_LVT i_20_5 (.A1(n_20_0), .A2(n_15), .B1(n_101), .B2(dbg_din[2]), 
      .ZN(n_20_3));
   INV_X1_LVT i_20_6 (.A(n_20_3), .ZN(n_31));
   DFFR_X1_LVT \mem_addr_reg[2]  (.D(n_31), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[2]), .QN());
   INV_X1_LVT i_17_7 (.A(n_17_4), .ZN(n_17_6));
   NOR2_X1_LVT i_17_8 (.A1(n_17_6), .A2(n_17_5), .ZN(n_12));
   AOI22_X1_LVT i_20_3 (.A1(n_20_0), .A2(n_14), .B1(n_101), .B2(dbg_din[1]), 
      .ZN(n_20_2));
   INV_X1_LVT i_20_4 (.A(n_20_2), .ZN(n_30));
   DFFR_X1_LVT \mem_addr_reg[1]  (.D(n_30), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[1]), .QN());
   FA_X1_LVT i_19_1 (.A(n_12), .B(dbg_mem_addr[1]), .CI(n_19_0), .CO(n_19_1), 
      .S(n_14));
   HA_X1_LVT i_19_2 (.A(dbg_mem_addr[2]), .B(n_19_1), .CO(n_19_2), .S(n_15));
   HA_X1_LVT i_19_3 (.A(dbg_mem_addr[3]), .B(n_19_2), .CO(n_19_3), .S(n_16));
   HA_X1_LVT i_19_4 (.A(dbg_mem_addr[4]), .B(n_19_3), .CO(n_19_4), .S(n_17));
   HA_X1_LVT i_19_5 (.A(dbg_mem_addr[5]), .B(n_19_4), .CO(n_19_5), .S(n_18));
   HA_X1_LVT i_19_6 (.A(dbg_mem_addr[6]), .B(n_19_5), .CO(n_19_6), .S(n_19));
   HA_X1_LVT i_19_7 (.A(dbg_mem_addr[7]), .B(n_19_6), .CO(n_19_7), .S(n_20));
   HA_X1_LVT i_19_8 (.A(dbg_mem_addr[8]), .B(n_19_7), .CO(n_19_8), .S(n_21));
   HA_X1_LVT i_19_9 (.A(dbg_mem_addr[9]), .B(n_19_8), .CO(n_19_9), .S(n_22));
   HA_X1_LVT i_19_10 (.A(dbg_mem_addr[10]), .B(n_19_9), .CO(n_19_10), .S(n_23));
   HA_X1_LVT i_19_11 (.A(dbg_mem_addr[11]), .B(n_19_10), .CO(n_19_11), .S(n_24));
   HA_X1_LVT i_19_12 (.A(dbg_mem_addr[12]), .B(n_19_11), .CO(n_19_12), .S(n_25));
   HA_X1_LVT i_19_13 (.A(dbg_mem_addr[13]), .B(n_19_12), .CO(n_19_13), .S(n_26));
   HA_X1_LVT i_19_14 (.A(dbg_mem_addr[14]), .B(n_19_13), .CO(n_19_14), .S(n_27));
   XNOR2_X1_LVT i_19_15 (.A(dbg_mem_addr[15]), .B(n_19_14), .ZN(n_19_15));
   INV_X1_LVT i_19_16 (.A(n_19_15), .ZN(n_28));
   AOI22_X1_LVT i_20_31 (.A1(n_20_0), .A2(n_28), .B1(n_101), .B2(dbg_din[15]), 
      .ZN(n_20_16));
   INV_X1_LVT i_20_32 (.A(n_20_16), .ZN(n_44));
   DFFR_X1_LVT \mem_addr_reg[15]  (.D(n_44), .RN(n_104), .CK(dbg_clk), .Q(
      dbg_mem_addr[15]), .QN());
   NAND2_X1_LVT i_78_126 (.A1(n_96), .A2(dbg_mem_addr[15]), .ZN(n_78_111));
   NOR2_X1_LVT i_49_4 (.A1(dbg_addr_in[0]), .A2(n_49_1), .ZN(n_49_4));
   NAND2_X1_LVT i_49_13 (.A1(n_49_4), .A2(dbg_addr_in[2]), .ZN(n_49_13));
   NOR2_X1_LVT i_49_28 (.A1(n_49_13), .A2(n_49_20), .ZN(n_97));
   AND2_X1_LVT i_50_4 (.A1(dbg_wr), .A2(n_97), .ZN(mem_data_wr));
   INV_X1_LVT i_70_1 (.A(dbg_reg_rd), .ZN(n_70_0));
   NOR2_X1_LVT i_70_2 (.A1(n_70_0), .A2(mem_data_wr), .ZN(n_136));
   NOR2_X1_LVT i_70_0 (.A1(dbg_reg_rd), .A2(mem_data_wr), .ZN(n_135));
   INV_X1_LVT i_67_0 (.A(mem_ctl[3]), .ZN(n_115));
   AND2_X1_LVT i_68_24 (.A1(n_115), .A2(dbg_mem_din[15]), .ZN(n_133));
   AOI222_X1_LVT i_71_30 (.A1(mem_data_wr), .A2(dbg_din[15]), .B1(n_136), 
      .B2(dbg_reg_din[15]), .C1(n_135), .C2(n_133), .ZN(n_71_15));
   INV_X1_LVT i_71_31 (.A(n_71_15), .ZN(n_152));
   INV_X1_LVT i_72_0 (.A(dbg_reg_rd), .ZN(n_72_0));
   INV_X1_LVT i_72_1 (.A(mem_data_wr), .ZN(n_72_1));
   NAND3_X1_LVT i_72_2 (.A1(n_72_0), .A2(n_72_1), .A3(dbg_mem_rd_dly), .ZN(
      n_72_2));
   NAND3_X1_LVT i_72_3 (.A1(n_72_2), .A2(n_72_0), .A3(n_72_1), .ZN(n_153));
   CLKGATETST_X1_LVT clk_gate_mem_data_reg (.CK(dbg_clk), .E(n_153), .SE(1'b0), 
      .GCK(n_134));
   DFFR_X1_LVT \mem_data_reg[15]  (.D(n_152), .RN(n_104), .CK(n_134), .Q(
      mem_data[15]), .QN());
   NAND2_X1_LVT i_78_127 (.A1(n_97), .A2(mem_data[15]), .ZN(n_78_112));
   INV_X1_LVT i_49_6 (.A(dbg_addr_in[2]), .ZN(n_49_6));
   NAND2_X1_LVT i_49_8 (.A1(n_49_3), .A2(n_49_6), .ZN(n_49_8));
   NOR2_X1_LVT i_49_23 (.A1(n_49_8), .A2(n_49_20), .ZN(n_92));
   NAND2_X1_LVT i_78_128 (.A1(n_92), .A2(cpu_id[31]), .ZN(n_78_113));
   NAND4_X1_LVT i_78_129 (.A1(n_78_110), .A2(n_78_111), .A3(n_78_112), .A4(
      n_78_113), .ZN(n_78_114));
   NAND2_X1_LVT i_49_7 (.A1(n_49_2), .A2(n_49_6), .ZN(n_49_7));
   NOR2_X1_LVT i_49_22 (.A1(n_49_7), .A2(n_49_20), .ZN(n_91));
   INV_X1_LVT i_49_18 (.A(dbg_addr_in[5]), .ZN(n_49_18));
   NAND2_X1_LVT i_49_17 (.A1(dbg_addr_in[4]), .A2(n_49_18), .ZN(n_49_17));
   INV_X1_LVT i_49_19 (.A(n_49_17), .ZN(n_49_19));
   NAND2_X1_LVT i_49_21 (.A1(dbg_addr_in[3]), .A2(n_49_19), .ZN(n_49_21));
   NOR2_X1_LVT i_49_30 (.A1(n_49_7), .A2(n_49_21), .ZN(n_99));
   AOI221_X1_LVT i_78_130 (.A(n_78_114), .B1(n_91), .B2(cpu_id[15]), .C1(n_99), 
      .C2(cpu_nr_total[7]), .ZN(n_78_115));
   INV_X1_LVT i_78_131 (.A(n_78_115), .ZN(dbg_dout[15]));
   NAND2_X1_LVT i_78_118 (.A1(n_98), .A2(mem_cnt[14]), .ZN(n_78_104));
   NAND2_X1_LVT i_78_119 (.A1(n_96), .A2(dbg_mem_addr[14]), .ZN(n_78_105));
   AND2_X1_LVT i_68_23 (.A1(n_115), .A2(dbg_mem_din[14]), .ZN(n_132));
   AOI222_X1_LVT i_71_28 (.A1(mem_data_wr), .A2(dbg_din[14]), .B1(n_136), 
      .B2(dbg_reg_din[14]), .C1(n_135), .C2(n_132), .ZN(n_71_14));
   INV_X1_LVT i_71_29 (.A(n_71_14), .ZN(n_151));
   DFFR_X1_LVT \mem_data_reg[14]  (.D(n_151), .RN(n_104), .CK(n_134), .Q(
      mem_data[14]), .QN());
   NAND2_X1_LVT i_78_120 (.A1(n_97), .A2(mem_data[14]), .ZN(n_78_106));
   NAND2_X1_LVT i_78_121 (.A1(n_92), .A2(cpu_id[30]), .ZN(n_78_107));
   NAND4_X1_LVT i_78_122 (.A1(n_78_104), .A2(n_78_105), .A3(n_78_106), .A4(
      n_78_107), .ZN(n_78_108));
   AOI221_X1_LVT i_78_123 (.A(n_78_108), .B1(n_91), .B2(cpu_id[14]), .C1(n_99), 
      .C2(cpu_nr_total[6]), .ZN(n_78_109));
   INV_X1_LVT i_78_124 (.A(n_78_109), .ZN(dbg_dout[14]));
   NAND2_X1_LVT i_78_111 (.A1(n_98), .A2(mem_cnt[13]), .ZN(n_78_98));
   NAND2_X1_LVT i_78_112 (.A1(n_96), .A2(dbg_mem_addr[13]), .ZN(n_78_99));
   AND2_X1_LVT i_68_22 (.A1(n_115), .A2(dbg_mem_din[13]), .ZN(n_131));
   AOI222_X1_LVT i_71_26 (.A1(mem_data_wr), .A2(dbg_din[13]), .B1(n_136), 
      .B2(dbg_reg_din[13]), .C1(n_135), .C2(n_131), .ZN(n_71_13));
   INV_X1_LVT i_71_27 (.A(n_71_13), .ZN(n_150));
   DFFR_X1_LVT \mem_data_reg[13]  (.D(n_150), .RN(n_104), .CK(n_134), .Q(
      mem_data[13]), .QN());
   NAND2_X1_LVT i_78_113 (.A1(n_97), .A2(mem_data[13]), .ZN(n_78_100));
   NAND2_X1_LVT i_78_114 (.A1(n_92), .A2(cpu_id[29]), .ZN(n_78_101));
   NAND4_X1_LVT i_78_115 (.A1(n_78_98), .A2(n_78_99), .A3(n_78_100), .A4(
      n_78_101), .ZN(n_78_102));
   AOI221_X1_LVT i_78_116 (.A(n_78_102), .B1(n_91), .B2(cpu_id[13]), .C1(n_99), 
      .C2(cpu_nr_total[5]), .ZN(n_78_103));
   INV_X1_LVT i_78_117 (.A(n_78_103), .ZN(dbg_dout[13]));
   NAND2_X1_LVT i_78_104 (.A1(n_98), .A2(mem_cnt[12]), .ZN(n_78_92));
   NAND2_X1_LVT i_78_105 (.A1(n_96), .A2(dbg_mem_addr[12]), .ZN(n_78_93));
   AND2_X1_LVT i_68_21 (.A1(n_115), .A2(dbg_mem_din[12]), .ZN(n_130));
   AOI222_X1_LVT i_71_24 (.A1(mem_data_wr), .A2(dbg_din[12]), .B1(n_136), 
      .B2(dbg_reg_din[12]), .C1(n_135), .C2(n_130), .ZN(n_71_12));
   INV_X1_LVT i_71_25 (.A(n_71_12), .ZN(n_149));
   DFFR_X1_LVT \mem_data_reg[12]  (.D(n_149), .RN(n_104), .CK(n_134), .Q(
      mem_data[12]), .QN());
   NAND2_X1_LVT i_78_106 (.A1(n_97), .A2(mem_data[12]), .ZN(n_78_94));
   NAND2_X1_LVT i_78_107 (.A1(n_92), .A2(cpu_id[28]), .ZN(n_78_95));
   NAND4_X1_LVT i_78_108 (.A1(n_78_92), .A2(n_78_93), .A3(n_78_94), .A4(n_78_95), 
      .ZN(n_78_96));
   AOI221_X1_LVT i_78_109 (.A(n_78_96), .B1(n_91), .B2(cpu_id[12]), .C1(n_99), 
      .C2(cpu_nr_total[4]), .ZN(n_78_97));
   INV_X1_LVT i_78_110 (.A(n_78_97), .ZN(dbg_dout[12]));
   NAND2_X1_LVT i_78_97 (.A1(n_98), .A2(mem_cnt[11]), .ZN(n_78_86));
   NAND2_X1_LVT i_78_98 (.A1(n_96), .A2(dbg_mem_addr[11]), .ZN(n_78_87));
   AND2_X1_LVT i_68_20 (.A1(n_115), .A2(dbg_mem_din[11]), .ZN(n_129));
   AOI222_X1_LVT i_71_22 (.A1(mem_data_wr), .A2(dbg_din[11]), .B1(n_136), 
      .B2(dbg_reg_din[11]), .C1(n_135), .C2(n_129), .ZN(n_71_11));
   INV_X1_LVT i_71_23 (.A(n_71_11), .ZN(n_148));
   DFFR_X1_LVT \mem_data_reg[11]  (.D(n_148), .RN(n_104), .CK(n_134), .Q(
      mem_data[11]), .QN());
   NAND2_X1_LVT i_78_99 (.A1(n_97), .A2(mem_data[11]), .ZN(n_78_88));
   NAND2_X1_LVT i_78_100 (.A1(n_92), .A2(cpu_id[27]), .ZN(n_78_89));
   NAND4_X1_LVT i_78_101 (.A1(n_78_86), .A2(n_78_87), .A3(n_78_88), .A4(n_78_89), 
      .ZN(n_78_90));
   AOI221_X1_LVT i_78_102 (.A(n_78_90), .B1(n_91), .B2(cpu_id[11]), .C1(n_99), 
      .C2(cpu_nr_total[3]), .ZN(n_78_91));
   INV_X1_LVT i_78_103 (.A(n_78_91), .ZN(dbg_dout[11]));
   NAND2_X1_LVT i_78_90 (.A1(n_98), .A2(mem_cnt[10]), .ZN(n_78_80));
   NAND2_X1_LVT i_78_91 (.A1(n_96), .A2(dbg_mem_addr[10]), .ZN(n_78_81));
   AND2_X1_LVT i_68_19 (.A1(n_115), .A2(dbg_mem_din[10]), .ZN(n_128));
   AOI222_X1_LVT i_71_20 (.A1(mem_data_wr), .A2(dbg_din[10]), .B1(n_136), 
      .B2(dbg_reg_din[10]), .C1(n_135), .C2(n_128), .ZN(n_71_10));
   INV_X1_LVT i_71_21 (.A(n_71_10), .ZN(n_147));
   DFFR_X1_LVT \mem_data_reg[10]  (.D(n_147), .RN(n_104), .CK(n_134), .Q(
      mem_data[10]), .QN());
   NAND2_X1_LVT i_78_92 (.A1(n_97), .A2(mem_data[10]), .ZN(n_78_82));
   NAND2_X1_LVT i_78_93 (.A1(n_92), .A2(cpu_id[26]), .ZN(n_78_83));
   NAND4_X1_LVT i_78_94 (.A1(n_78_80), .A2(n_78_81), .A3(n_78_82), .A4(n_78_83), 
      .ZN(n_78_84));
   AOI221_X1_LVT i_78_95 (.A(n_78_84), .B1(n_91), .B2(cpu_id[10]), .C1(n_99), 
      .C2(cpu_nr_total[2]), .ZN(n_78_85));
   INV_X1_LVT i_78_96 (.A(n_78_85), .ZN(dbg_dout[10]));
   NAND2_X1_LVT i_78_83 (.A1(n_98), .A2(mem_cnt[9]), .ZN(n_78_74));
   NAND2_X1_LVT i_78_84 (.A1(n_96), .A2(dbg_mem_addr[9]), .ZN(n_78_75));
   AND2_X1_LVT i_68_18 (.A1(n_115), .A2(dbg_mem_din[9]), .ZN(n_127));
   AOI222_X1_LVT i_71_18 (.A1(mem_data_wr), .A2(dbg_din[9]), .B1(n_136), 
      .B2(dbg_reg_din[9]), .C1(n_135), .C2(n_127), .ZN(n_71_9));
   INV_X1_LVT i_71_19 (.A(n_71_9), .ZN(n_146));
   DFFR_X1_LVT \mem_data_reg[9]  (.D(n_146), .RN(n_104), .CK(n_134), .Q(
      mem_data[9]), .QN());
   NAND2_X1_LVT i_78_85 (.A1(n_97), .A2(mem_data[9]), .ZN(n_78_76));
   NAND2_X1_LVT i_78_86 (.A1(n_92), .A2(cpu_id[25]), .ZN(n_78_77));
   NAND4_X1_LVT i_78_87 (.A1(n_78_74), .A2(n_78_75), .A3(n_78_76), .A4(n_78_77), 
      .ZN(n_78_78));
   AOI221_X1_LVT i_78_88 (.A(n_78_78), .B1(n_91), .B2(cpu_id[9]), .C1(n_99), 
      .C2(cpu_nr_total[1]), .ZN(n_78_79));
   INV_X1_LVT i_78_89 (.A(n_78_79), .ZN(dbg_dout[9]));
   NAND2_X1_LVT i_78_76 (.A1(n_98), .A2(mem_cnt[8]), .ZN(n_78_68));
   NAND2_X1_LVT i_78_77 (.A1(n_96), .A2(dbg_mem_addr[8]), .ZN(n_78_69));
   AND2_X1_LVT i_68_17 (.A1(dbg_mem_din[8]), .A2(n_115), .ZN(n_126));
   AOI222_X1_LVT i_71_16 (.A1(mem_data_wr), .A2(dbg_din[8]), .B1(n_136), 
      .B2(dbg_reg_din[8]), .C1(n_135), .C2(n_126), .ZN(n_71_8));
   INV_X1_LVT i_71_17 (.A(n_71_8), .ZN(n_145));
   DFFR_X1_LVT \mem_data_reg[8]  (.D(n_145), .RN(n_104), .CK(n_134), .Q(
      mem_data[8]), .QN());
   NAND2_X1_LVT i_78_78 (.A1(n_97), .A2(mem_data[8]), .ZN(n_78_70));
   NAND2_X1_LVT i_78_79 (.A1(n_92), .A2(cpu_id[24]), .ZN(n_78_71));
   NAND4_X1_LVT i_78_80 (.A1(n_78_68), .A2(n_78_69), .A3(n_78_70), .A4(n_78_71), 
      .ZN(n_78_72));
   AOI221_X1_LVT i_78_81 (.A(n_78_72), .B1(n_91), .B2(cpu_id[8]), .C1(n_99), 
      .C2(cpu_nr_total[0]), .ZN(n_78_73));
   INV_X1_LVT i_78_82 (.A(n_78_73), .ZN(dbg_dout[8]));
   NAND2_X1_LVT i_78_69 (.A1(n_98), .A2(mem_cnt[7]), .ZN(n_78_62));
   NAND2_X1_LVT i_78_70 (.A1(n_96), .A2(dbg_mem_addr[7]), .ZN(n_78_63));
   NOR2_X1_LVT i_67_1 (.A1(n_115), .A2(dbg_mem_addr[0]), .ZN(n_116));
   OR2_X1_LVT i_68_0 (.A1(n_115), .A2(n_116), .ZN(n_68_0));
   AND2_X1_LVT i_67_2 (.A1(dbg_mem_addr[0]), .A2(mem_ctl[3]), .ZN(n_117));
   AOI22_X1_LVT i_68_15 (.A1(n_68_0), .A2(dbg_mem_din[7]), .B1(n_117), .B2(
      dbg_mem_din[15]), .ZN(n_68_8));
   INV_X1_LVT i_68_16 (.A(n_68_8), .ZN(n_125));
   AOI222_X1_LVT i_71_14 (.A1(mem_data_wr), .A2(dbg_din[7]), .B1(n_136), 
      .B2(dbg_reg_din[7]), .C1(n_135), .C2(n_125), .ZN(n_71_7));
   INV_X1_LVT i_71_15 (.A(n_71_7), .ZN(n_144));
   DFFR_X1_LVT \mem_data_reg[7]  (.D(n_144), .RN(n_104), .CK(n_134), .Q(
      mem_data[7]), .QN());
   NAND2_X1_LVT i_78_71 (.A1(n_97), .A2(mem_data[7]), .ZN(n_78_64));
   NAND2_X1_LVT i_78_72 (.A1(n_92), .A2(cpu_id[23]), .ZN(n_78_65));
   NAND4_X1_LVT i_78_73 (.A1(n_78_62), .A2(n_78_63), .A3(n_78_64), .A4(n_78_65), 
      .ZN(n_78_66));
   AOI221_X1_LVT i_78_74 (.A(n_78_66), .B1(n_91), .B2(cpu_id[7]), .C1(n_99), 
      .C2(cpu_nr_inst[7]), .ZN(n_78_67));
   INV_X1_LVT i_78_75 (.A(n_78_67), .ZN(dbg_dout[7]));
   NAND2_X1_LVT i_78_60 (.A1(n_96), .A2(dbg_mem_addr[6]), .ZN(n_78_54));
   AOI22_X1_LVT i_68_13 (.A1(n_68_0), .A2(dbg_mem_din[6]), .B1(n_117), .B2(
      dbg_mem_din[14]), .ZN(n_68_7));
   INV_X1_LVT i_68_14 (.A(n_68_7), .ZN(n_124));
   AOI222_X1_LVT i_71_12 (.A1(mem_data_wr), .A2(dbg_din[6]), .B1(n_136), 
      .B2(dbg_reg_din[6]), .C1(n_135), .C2(n_124), .ZN(n_71_6));
   INV_X1_LVT i_71_13 (.A(n_71_6), .ZN(n_143));
   DFFR_X1_LVT \mem_data_reg[6]  (.D(n_143), .RN(n_104), .CK(n_134), .Q(
      mem_data[6]), .QN());
   NAND2_X1_LVT i_78_61 (.A1(n_97), .A2(mem_data[6]), .ZN(n_78_55));
   NAND2_X1_LVT i_49_9 (.A1(n_49_4), .A2(n_49_6), .ZN(n_49_9));
   NOR2_X1_LVT i_49_24 (.A1(n_49_9), .A2(n_49_20), .ZN(n_93));
   NAND2_X1_LVT i_78_62 (.A1(n_93), .A2(dbg_cpu_reset), .ZN(n_78_56));
   NAND2_X1_LVT i_78_63 (.A1(n_92), .A2(cpu_id[22]), .ZN(n_78_57));
   AND4_X1_LVT i_78_64 (.A1(n_78_54), .A2(n_78_55), .A3(n_78_56), .A4(n_78_57), 
      .ZN(n_78_58));
   NAND2_X1_LVT i_78_65 (.A1(n_91), .A2(cpu_id[6]), .ZN(n_78_59));
   NAND2_X1_LVT i_78_66 (.A1(n_99), .A2(cpu_nr_inst[6]), .ZN(n_78_60));
   NAND2_X1_LVT i_78_67 (.A1(n_98), .A2(mem_cnt[6]), .ZN(n_78_61));
   NAND4_X1_LVT i_78_68 (.A1(n_78_58), .A2(n_78_59), .A3(n_78_60), .A4(n_78_61), 
      .ZN(dbg_dout[6]));
   NAND2_X1_LVT i_78_51 (.A1(n_96), .A2(dbg_mem_addr[5]), .ZN(n_78_46));
   AOI22_X1_LVT i_68_11 (.A1(n_68_0), .A2(dbg_mem_din[5]), .B1(n_117), .B2(
      dbg_mem_din[13]), .ZN(n_68_6));
   INV_X1_LVT i_68_12 (.A(n_68_6), .ZN(n_123));
   AOI222_X1_LVT i_71_10 (.A1(mem_data_wr), .A2(dbg_din[5]), .B1(n_136), 
      .B2(dbg_reg_din[5]), .C1(n_135), .C2(n_123), .ZN(n_71_5));
   INV_X1_LVT i_71_11 (.A(n_71_5), .ZN(n_142));
   DFFR_X1_LVT \mem_data_reg[5]  (.D(n_142), .RN(n_104), .CK(n_134), .Q(
      mem_data[5]), .QN());
   NAND2_X1_LVT i_78_52 (.A1(n_97), .A2(mem_data[5]), .ZN(n_78_47));
   AND2_X1_LVT i_50_0 (.A1(dbg_wr), .A2(n_93), .ZN(cpu_ctl_wr));
   CLKGATETST_X1_LVT clk_gate_cpu_ctl_reg__0 (.CK(dbg_clk), .E(cpu_ctl_wr), 
      .SE(1'b0), .GCK(n_105));
   DFFS_X1_LVT \cpu_ctl_reg[5]  (.D(dbg_din[5]), .SN(n_104), .CK(n_105), 
      .Q(cpu_ctl[5]), .QN());
   NAND2_X1_LVT i_78_53 (.A1(n_93), .A2(cpu_ctl[5]), .ZN(n_78_48));
   NAND2_X1_LVT i_78_54 (.A1(n_92), .A2(cpu_id[21]), .ZN(n_78_49));
   AND4_X1_LVT i_78_55 (.A1(n_78_46), .A2(n_78_47), .A3(n_78_48), .A4(n_78_49), 
      .ZN(n_78_50));
   NAND2_X1_LVT i_78_56 (.A1(n_91), .A2(cpu_id[5]), .ZN(n_78_51));
   NAND2_X1_LVT i_78_57 (.A1(n_99), .A2(cpu_nr_inst[5]), .ZN(n_78_52));
   NAND2_X1_LVT i_78_58 (.A1(n_98), .A2(mem_cnt[5]), .ZN(n_78_53));
   NAND4_X1_LVT i_78_59 (.A1(n_78_50), .A2(n_78_51), .A3(n_78_52), .A4(n_78_53), 
      .ZN(dbg_dout[5]));
   NAND2_X1_LVT i_78_42 (.A1(n_96), .A2(dbg_mem_addr[4]), .ZN(n_78_38));
   AOI22_X1_LVT i_68_9 (.A1(n_68_0), .A2(dbg_mem_din[4]), .B1(n_117), .B2(
      dbg_mem_din[12]), .ZN(n_68_5));
   INV_X1_LVT i_68_10 (.A(n_68_5), .ZN(n_122));
   AOI222_X1_LVT i_71_8 (.A1(mem_data_wr), .A2(dbg_din[4]), .B1(n_136), .B2(
      dbg_reg_din[4]), .C1(n_135), .C2(n_122), .ZN(n_71_4));
   INV_X1_LVT i_71_9 (.A(n_71_4), .ZN(n_141));
   DFFR_X1_LVT \mem_data_reg[4]  (.D(n_141), .RN(n_104), .CK(n_134), .Q(
      mem_data[4]), .QN());
   NAND2_X1_LVT i_78_43 (.A1(n_97), .A2(mem_data[4]), .ZN(n_78_39));
   CLKGATETST_X1_LVT clk_gate_cpu_ctl_reg__1 (.CK(dbg_clk), .E(cpu_ctl_wr), 
      .SE(1'b0), .GCK(n_106));
   DFFS_X1_LVT \cpu_ctl_reg[4]  (.D(dbg_din[4]), .SN(n_104), .CK(n_106), 
      .Q(cpu_ctl[4]), .QN());
   NAND2_X1_LVT i_78_44 (.A1(n_93), .A2(cpu_ctl[4]), .ZN(n_78_40));
   NAND2_X1_LVT i_78_45 (.A1(n_92), .A2(cpu_id[20]), .ZN(n_78_41));
   AND4_X1_LVT i_78_46 (.A1(n_78_38), .A2(n_78_39), .A3(n_78_40), .A4(n_78_41), 
      .ZN(n_78_42));
   NAND2_X1_LVT i_78_47 (.A1(n_91), .A2(cpu_id[4]), .ZN(n_78_43));
   NAND2_X1_LVT i_78_48 (.A1(n_99), .A2(cpu_nr_inst[4]), .ZN(n_78_44));
   NAND2_X1_LVT i_78_49 (.A1(n_98), .A2(mem_cnt[4]), .ZN(n_78_45));
   NAND4_X1_LVT i_78_50 (.A1(n_78_42), .A2(n_78_43), .A3(n_78_44), .A4(n_78_45), 
      .ZN(dbg_dout[4]));
   NAND2_X1_LVT i_78_29 (.A1(n_99), .A2(cpu_nr_inst[3]), .ZN(n_78_26));
   NAND2_X1_LVT i_78_30 (.A1(n_98), .A2(mem_cnt[3]), .ZN(n_78_27));
   NAND2_X1_LVT i_78_31 (.A1(n_96), .A2(dbg_mem_addr[3]), .ZN(n_78_28));
   AOI22_X1_LVT i_68_7 (.A1(n_68_0), .A2(dbg_mem_din[3]), .B1(n_117), .B2(
      dbg_mem_din[11]), .ZN(n_68_4));
   INV_X1_LVT i_68_8 (.A(n_68_4), .ZN(n_121));
   AOI222_X1_LVT i_71_6 (.A1(mem_data_wr), .A2(dbg_din[3]), .B1(n_136), .B2(
      dbg_reg_din[3]), .C1(n_135), .C2(n_121), .ZN(n_71_3));
   INV_X1_LVT i_71_7 (.A(n_71_3), .ZN(n_140));
   DFFR_X1_LVT \mem_data_reg[3]  (.D(n_140), .RN(n_104), .CK(n_134), .Q(
      mem_data[3]), .QN());
   NAND2_X1_LVT i_78_32 (.A1(n_97), .A2(mem_data[3]), .ZN(n_78_29));
   NAND4_X1_LVT i_78_33 (.A1(n_78_26), .A2(n_78_27), .A3(n_78_28), .A4(n_78_29), 
      .ZN(n_78_30));
   NAND2_X1_LVT i_78_34 (.A1(n_95), .A2(mem_ctl[3]), .ZN(n_78_31));
   NAND2_X1_LVT i_49_10 (.A1(n_49_5), .A2(n_49_6), .ZN(n_49_10));
   NOR2_X1_LVT i_49_25 (.A1(n_49_10), .A2(n_49_20), .ZN(n_94));
   NAND4_X1_LVT i_54_0 (.A1(fe_mdb_in[0]), .A2(fe_mdb_in[1]), .A3(fe_mdb_in[6]), 
      .A4(fe_mdb_in[8]), .ZN(n_54_0));
   CLKGATETST_X1_LVT clk_gate_cpu_ctl_reg__2 (.CK(dbg_clk), .E(cpu_ctl_wr), 
      .SE(1'b0), .GCK(n_107));
   DFFR_X1_LVT \cpu_ctl_reg[3]  (.D(dbg_din[3]), .RN(n_104), .CK(n_107), 
      .Q(cpu_ctl[3]), .QN());
   NAND4_X1_LVT i_54_1 (.A1(fe_mdb_in[9]), .A2(fe_mdb_in[14]), .A3(cpu_ctl[3]), 
      .A4(decode_noirq), .ZN(n_54_1));
   NOR4_X1_LVT i_54_2 (.A1(n_54_0), .A2(n_54_1), .A3(fe_mdb_in[13]), .A4(
      fe_mdb_in[15]), .ZN(n_54_2));
   NOR4_X1_LVT i_54_3 (.A1(fe_mdb_in[2]), .A2(fe_mdb_in[3]), .A3(fe_mdb_in[4]), 
      .A4(fe_mdb_in[5]), .ZN(n_54_3));
   NOR4_X1_LVT i_54_4 (.A1(fe_mdb_in[7]), .A2(fe_mdb_in[10]), .A3(fe_mdb_in[11]), 
      .A4(fe_mdb_in[12]), .ZN(n_54_4));
   AND3_X1_LVT i_54_5 (.A1(n_54_2), .A2(n_54_3), .A3(n_54_4), .ZN(dbg_swbrk));
   INV_X1_LVT i_76_5 (.A(dbg_din[3]), .ZN(n_76_4));
   AOI21_X1_LVT i_76_6 (.A(dbg_swbrk), .B1(n_76_4), .B2(cpu_stat[3]), .ZN(n_76_5));
   AND2_X1_LVT i_50_1 (.A1(dbg_wr), .A2(n_94), .ZN(n_100));
   INV_X1_LVT i_76_2 (.A(n_100), .ZN(n_76_2));
   NOR2_X1_LVT i_76_7 (.A1(cpu_stat[3]), .A2(dbg_swbrk), .ZN(n_76_6));
   OAI22_X1_LVT i_76_8 (.A1(n_76_5), .A2(n_76_2), .B1(n_76_6), .B2(n_100), 
      .ZN(n_155));
   DFFR_X1_LVT \cpu_stat_reg[3]  (.D(n_155), .RN(n_104), .CK(dbg_clk), .Q(
      cpu_stat[3]), .QN());
   NAND2_X1_LVT i_78_35 (.A1(n_94), .A2(cpu_stat[3]), .ZN(n_78_32));
   NAND2_X1_LVT i_78_36 (.A1(n_93), .A2(cpu_ctl[3]), .ZN(n_78_33));
   NAND2_X1_LVT i_78_37 (.A1(n_92), .A2(cpu_id[19]), .ZN(n_78_34));
   NAND4_X1_LVT i_78_38 (.A1(n_78_31), .A2(n_78_32), .A3(n_78_33), .A4(n_78_34), 
      .ZN(n_78_35));
   NOR2_X1_LVT i_78_39 (.A1(n_78_30), .A2(n_78_35), .ZN(n_78_36));
   NAND2_X1_LVT i_78_40 (.A1(n_91), .A2(cpu_id[3]), .ZN(n_78_37));
   NAND2_X1_LVT i_78_41 (.A1(n_78_36), .A2(n_78_37), .ZN(dbg_dout[3]));
   NAND2_X1_LVT i_78_18 (.A1(n_91), .A2(cpu_id[2]), .ZN(n_78_16));
   NAND2_X1_LVT i_78_19 (.A1(n_99), .A2(cpu_nr_inst[2]), .ZN(n_78_17));
   NAND2_X1_LVT i_78_20 (.A1(n_98), .A2(mem_cnt[2]), .ZN(n_78_18));
   NAND2_X1_LVT i_78_21 (.A1(n_96), .A2(dbg_mem_addr[2]), .ZN(n_78_19));
   NAND4_X1_LVT i_78_22 (.A1(n_78_16), .A2(n_78_17), .A3(n_78_18), .A4(n_78_19), 
      .ZN(n_78_20));
   AOI22_X1_LVT i_68_5 (.A1(n_68_0), .A2(dbg_mem_din[2]), .B1(n_117), .B2(
      dbg_mem_din[10]), .ZN(n_68_3));
   INV_X1_LVT i_68_6 (.A(n_68_3), .ZN(n_120));
   AOI222_X1_LVT i_71_4 (.A1(mem_data_wr), .A2(dbg_din[2]), .B1(n_136), .B2(
      dbg_reg_din[2]), .C1(n_135), .C2(n_120), .ZN(n_71_2));
   INV_X1_LVT i_71_5 (.A(n_71_2), .ZN(n_139));
   DFFR_X1_LVT \mem_data_reg[2]  (.D(n_139), .RN(n_104), .CK(n_134), .Q(
      mem_data[2]), .QN());
   NAND2_X1_LVT i_78_23 (.A1(n_97), .A2(mem_data[2]), .ZN(n_78_21));
   NAND2_X1_LVT i_78_24 (.A1(n_95), .A2(mem_ctl[2]), .ZN(n_78_22));
   INV_X1_LVT i_76_0 (.A(dbg_din[2]), .ZN(n_76_0));
   AOI21_X1_LVT i_76_1 (.A(puc_pnd_set), .B1(n_76_0), .B2(cpu_stat[2]), .ZN(
      n_76_1));
   NOR2_X1_LVT i_76_3 (.A1(cpu_stat[2]), .A2(puc_pnd_set), .ZN(n_76_3));
   OAI22_X1_LVT i_76_4 (.A1(n_76_1), .A2(n_76_2), .B1(n_76_3), .B2(n_100), 
      .ZN(n_154));
   DFFR_X1_LVT \cpu_stat_reg[2]  (.D(n_154), .RN(n_104), .CK(dbg_clk), .Q(
      cpu_stat[2]), .QN());
   NAND2_X1_LVT i_78_25 (.A1(n_94), .A2(cpu_stat[2]), .ZN(n_78_23));
   NAND2_X1_LVT i_78_26 (.A1(n_92), .A2(cpu_id[18]), .ZN(n_78_24));
   NAND4_X1_LVT i_78_27 (.A1(n_78_21), .A2(n_78_22), .A3(n_78_23), .A4(n_78_24), 
      .ZN(n_78_25));
   OR2_X1_LVT i_78_28 (.A1(n_78_20), .A2(n_78_25), .ZN(dbg_dout[2]));
   NAND2_X1_LVT i_78_9 (.A1(n_96), .A2(dbg_mem_addr[1]), .ZN(n_78_8));
   AOI22_X1_LVT i_68_3 (.A1(n_68_0), .A2(dbg_mem_din[1]), .B1(n_117), .B2(
      dbg_mem_din[9]), .ZN(n_68_2));
   INV_X1_LVT i_68_4 (.A(n_68_2), .ZN(n_119));
   AOI222_X1_LVT i_71_2 (.A1(mem_data_wr), .A2(dbg_din[1]), .B1(n_136), .B2(
      dbg_reg_din[1]), .C1(n_135), .C2(n_119), .ZN(n_71_1));
   INV_X1_LVT i_71_3 (.A(n_71_1), .ZN(n_138));
   DFFR_X1_LVT \mem_data_reg[1]  (.D(n_138), .RN(n_104), .CK(n_134), .Q(
      mem_data[1]), .QN());
   NAND2_X1_LVT i_78_10 (.A1(n_97), .A2(mem_data[1]), .ZN(n_78_9));
   NAND2_X1_LVT i_78_11 (.A1(n_95), .A2(mem_ctl[1]), .ZN(n_78_10));
   NAND2_X1_LVT i_78_12 (.A1(n_92), .A2(cpu_id[17]), .ZN(n_78_11));
   AND4_X1_LVT i_78_13 (.A1(n_78_8), .A2(n_78_9), .A3(n_78_10), .A4(n_78_11), 
      .ZN(n_78_12));
   NAND2_X1_LVT i_78_14 (.A1(n_91), .A2(cpu_id[1]), .ZN(n_78_13));
   NAND2_X1_LVT i_78_15 (.A1(n_99), .A2(cpu_nr_inst[1]), .ZN(n_78_14));
   NAND2_X1_LVT i_78_16 (.A1(n_98), .A2(mem_cnt[1]), .ZN(n_78_15));
   NAND4_X1_LVT i_78_17 (.A1(n_78_12), .A2(n_78_13), .A3(n_78_14), .A4(n_78_15), 
      .ZN(dbg_dout[1]));
   NAND2_X1_LVT i_78_0 (.A1(dbg_mem_addr[0]), .A2(n_96), .ZN(n_78_0));
   AOI22_X1_LVT i_68_1 (.A1(n_68_0), .A2(dbg_mem_din[0]), .B1(dbg_mem_din[8]), 
      .B2(n_117), .ZN(n_68_1));
   INV_X1_LVT i_68_2 (.A(n_68_1), .ZN(n_118));
   AOI222_X1_LVT i_71_0 (.A1(dbg_din[0]), .A2(mem_data_wr), .B1(dbg_reg_din[0]), 
      .B2(n_136), .C1(n_118), .C2(n_135), .ZN(n_71_0));
   INV_X1_LVT i_71_1 (.A(n_71_0), .ZN(n_137));
   DFFR_X1_LVT \mem_data_reg[0]  (.D(n_137), .RN(n_104), .CK(n_134), .Q(
      mem_data[0]), .QN());
   NAND2_X1_LVT i_78_1 (.A1(mem_data[0]), .A2(n_97), .ZN(n_78_1));
   NAND2_X1_LVT i_78_2 (.A1(dbg_halt_st), .A2(n_94), .ZN(n_78_2));
   NAND2_X1_LVT i_78_3 (.A1(cpu_id[16]), .A2(n_92), .ZN(n_78_3));
   AND4_X1_LVT i_78_4 (.A1(n_78_0), .A2(n_78_1), .A3(n_78_2), .A4(n_78_3), 
      .ZN(n_78_4));
   NAND2_X1_LVT i_78_5 (.A1(cpu_id[0]), .A2(n_91), .ZN(n_78_5));
   NAND2_X1_LVT i_78_6 (.A1(cpu_nr_inst[0]), .A2(n_99), .ZN(n_78_6));
   NAND2_X1_LVT i_78_7 (.A1(mem_cnt[0]), .A2(n_98), .ZN(n_78_7));
   NAND4_X1_LVT i_78_8 (.A1(n_78_4), .A2(n_78_5), .A3(n_78_6), .A4(n_78_7), 
      .ZN(dbg_dout[0]));
   AND2_X1_LVT i_79_0 (.A1(mem_ctl[1]), .A2(mem_burst_start), .ZN(mem_burst_wr));
   omsp_dbg_uart dbg_uart_0 (.dbg_addr(dbg_addr), .dbg_din(dbg_din), .dbg_rd(
      dbg_rd), .dbg_uart_txd(dbg_uart_txd), .dbg_wr(dbg_wr), .dbg_clk(dbg_clk), 
      .dbg_dout(dbg_dout), .dbg_rd_rdy(dbg_rd_rdy), .dbg_rst(dbg_rst), 
      .dbg_uart_rxd(dbg_uart_rxd), .mem_burst(mem_burst), .mem_burst_end(
      mem_burst_end), .mem_burst_rd(mem_burst_rd), .mem_burst_wr(mem_burst_wr), 
      .mem_bw(mem_ctl[3]));
   CLKGATETST_X1_LVT clk_gate_cpu_ctl_reg (.CK(dbg_clk), .E(cpu_ctl_wr), 
      .SE(1'b0), .GCK(n_103));
   DFFR_X1_LVT \cpu_ctl_reg[6]  (.D(dbg_din[6]), .RN(n_104), .CK(n_103), 
      .Q(dbg_cpu_reset), .QN());
   INV_X1_LVT i_53_0 (.A(cpu_en_s), .ZN(n_53_0));
   OAI21_X1_LVT i_53_1 (.A(dbg_halt_st), .B1(n_53_0), .B2(cpu_ctl[4]), .ZN(
      n_53_1));
   INV_X1_LVT i_53_2 (.A(n_53_1), .ZN(dbg_freeze));
   INV_X1_LVT i_55_0 (.A(dbg_halt_st), .ZN(n_55_0));
   NAND3_X1_LVT i_55_1 (.A1(n_55_0), .A2(cpu_ctl_wr), .A3(dbg_din[0]), .ZN(
      n_55_1));
   INV_X1_LVT i_55_2 (.A(mem_state_nxt_reg[1]), .ZN(n_55_2));
   NOR2_X1_LVT i_12_3 (.A1(mem_state[0]), .A2(mem_state[1]), .ZN(n_8));
   NAND3_X1_LVT i_55_3 (.A1(n_55_2), .A2(mem_state_nxt_reg[0]), .A3(n_8), 
      .ZN(n_55_3));
   NAND3_X1_LVT i_55_4 (.A1(puc_pnd_set), .A2(cpu_ctl[5]), .A3(dbg_en_s), 
      .ZN(n_55_4));
   INV_X1_LVT i_55_5 (.A(dbg_swbrk), .ZN(n_55_5));
   NAND4_X1_LVT i_55_6 (.A1(n_55_1), .A2(n_55_3), .A3(n_55_4), .A4(n_55_5), 
      .ZN(halt_flag_set));
   INV_X1_LVT i_59_0 (.A(halt_flag_set), .ZN(n_59_0));
   INV_X1_LVT i_57_0 (.A(n_7), .ZN(n_57_0));
   NOR3_X1_LVT i_57_1 (.A1(n_57_0), .A2(mem_state_nxt_reg[0]), .A3(
      mem_state_nxt_reg[1]), .ZN(n_57_1));
   AND2_X1_LVT i_56_0 (.A1(dbg_halt_st), .A2(cpu_ctl_wr), .ZN(n_108));
   AOI21_X1_LVT i_57_2 (.A(n_57_1), .B1(dbg_din[1]), .B2(n_108), .ZN(n_57_2));
   INV_X1_LVT i_57_3 (.A(n_57_2), .ZN(halt_flag_clr));
   NOR2_X1_LVT i_59_1 (.A1(n_59_0), .A2(halt_flag_clr), .ZN(n_110));
   INV_X1_LVT i_60_1 (.A(halt_flag_set), .ZN(n_60_1));
   INV_X1_LVT i_60_0 (.A(halt_flag_clr), .ZN(n_60_0));
   NAND2_X1_LVT i_60_2 (.A1(n_60_1), .A2(n_60_0), .ZN(n_111));
   CLKGATETST_X1_LVT clk_gate_halt_flag_reg (.CK(dbg_clk), .E(n_111), .SE(1'b0), 
      .GCK(n_109));
   DFFR_X1_LVT halt_flag_reg (.D(n_110), .RN(n_104), .CK(n_109), .Q(halt_flag), 
      .QN());
   NOR2_X1_LVT i_66_0 (.A1(halt_flag), .A2(halt_flag_set), .ZN(n_66_0));
   AND2_X1_LVT i_62_0 (.A1(dbg_din[2]), .A2(n_108), .ZN(istep));
   DFFR_X1_LVT \inc_step_reg[0]  (.D(istep), .RN(n_104), .CK(dbg_clk), .Q(n_113), 
      .QN());
   INV_X1_LVT i_64_1 (.A(n_113), .ZN(n_64_1));
   INV_X1_LVT i_64_0 (.A(istep), .ZN(n_64_0));
   NAND2_X1_LVT i_64_2 (.A1(n_64_1), .A2(n_64_0), .ZN(n_114));
   DFFR_X1_LVT \inc_step_reg[1]  (.D(n_114), .RN(n_104), .CK(dbg_clk), .Q(n_112), 
      .QN());
   NOR2_X1_LVT i_66_1 (.A1(n_66_0), .A2(n_112), .ZN(dbg_halt_cmd));
   NAND2_X1_LVT i_74_18 (.A1(dbg_mem_addr[0]), .A2(mem_ctl[3]), .ZN(n_74_10));
   INV_X1_LVT i_74_16 (.A(mem_data[7]), .ZN(n_74_9));
   INV_X1_LVT i_74_33 (.A(mem_data[15]), .ZN(n_74_18));
   OAI22_X1_LVT i_74_34 (.A1(n_74_10), .A2(n_74_9), .B1(mem_ctl[3]), .B2(n_74_18), 
      .ZN(dbg_mem_dout[15]));
   INV_X1_LVT i_74_14 (.A(mem_data[6]), .ZN(n_74_8));
   INV_X1_LVT i_74_31 (.A(mem_data[14]), .ZN(n_74_17));
   OAI22_X1_LVT i_74_32 (.A1(n_74_10), .A2(n_74_8), .B1(mem_ctl[3]), .B2(n_74_17), 
      .ZN(dbg_mem_dout[14]));
   INV_X1_LVT i_74_12 (.A(mem_data[5]), .ZN(n_74_7));
   INV_X1_LVT i_74_29 (.A(mem_data[13]), .ZN(n_74_16));
   OAI22_X1_LVT i_74_30 (.A1(n_74_10), .A2(n_74_7), .B1(mem_ctl[3]), .B2(n_74_16), 
      .ZN(dbg_mem_dout[13]));
   INV_X1_LVT i_74_10 (.A(mem_data[4]), .ZN(n_74_6));
   INV_X1_LVT i_74_27 (.A(mem_data[12]), .ZN(n_74_15));
   OAI22_X1_LVT i_74_28 (.A1(n_74_10), .A2(n_74_6), .B1(mem_ctl[3]), .B2(n_74_15), 
      .ZN(dbg_mem_dout[12]));
   INV_X1_LVT i_74_8 (.A(mem_data[3]), .ZN(n_74_5));
   INV_X1_LVT i_74_25 (.A(mem_data[11]), .ZN(n_74_14));
   OAI22_X1_LVT i_74_26 (.A1(n_74_10), .A2(n_74_5), .B1(mem_ctl[3]), .B2(n_74_14), 
      .ZN(dbg_mem_dout[11]));
   INV_X1_LVT i_74_6 (.A(mem_data[2]), .ZN(n_74_4));
   INV_X1_LVT i_74_23 (.A(mem_data[10]), .ZN(n_74_13));
   OAI22_X1_LVT i_74_24 (.A1(n_74_10), .A2(n_74_4), .B1(mem_ctl[3]), .B2(n_74_13), 
      .ZN(dbg_mem_dout[10]));
   INV_X1_LVT i_74_4 (.A(mem_data[1]), .ZN(n_74_3));
   INV_X1_LVT i_74_21 (.A(mem_data[9]), .ZN(n_74_12));
   OAI22_X1_LVT i_74_22 (.A1(n_74_10), .A2(n_74_3), .B1(mem_ctl[3]), .B2(n_74_12), 
      .ZN(dbg_mem_dout[9]));
   INV_X1_LVT i_74_2 (.A(mem_data[0]), .ZN(n_74_2));
   INV_X1_LVT i_74_19 (.A(mem_data[8]), .ZN(n_74_11));
   OAI22_X1_LVT i_74_20 (.A1(n_74_10), .A2(n_74_2), .B1(mem_ctl[3]), .B2(n_74_11), 
      .ZN(dbg_mem_dout[8]));
   INV_X1_LVT i_74_1 (.A(dbg_mem_addr[0]), .ZN(n_74_1));
   INV_X1_LVT i_74_0 (.A(mem_ctl[3]), .ZN(n_74_0));
   NOR2_X1_LVT i_74_35 (.A1(n_74_1), .A2(n_74_0), .ZN(n_74_19));
   NOR2_X1_LVT i_74_17 (.A1(n_74_19), .A2(n_74_9), .ZN(dbg_mem_dout[7]));
   NOR2_X1_LVT i_74_15 (.A1(n_74_19), .A2(n_74_8), .ZN(dbg_mem_dout[6]));
   NOR2_X1_LVT i_74_13 (.A1(n_74_19), .A2(n_74_7), .ZN(dbg_mem_dout[5]));
   NOR2_X1_LVT i_74_11 (.A1(n_74_19), .A2(n_74_6), .ZN(dbg_mem_dout[4]));
   NOR2_X1_LVT i_74_9 (.A1(n_74_19), .A2(n_74_5), .ZN(dbg_mem_dout[3]));
   NOR2_X1_LVT i_74_7 (.A1(n_74_19), .A2(n_74_4), .ZN(dbg_mem_dout[2]));
   NOR2_X1_LVT i_74_5 (.A1(n_74_19), .A2(n_74_3), .ZN(dbg_mem_dout[1]));
   NOR2_X1_LVT i_74_3 (.A1(n_74_19), .A2(n_74_2), .ZN(dbg_mem_dout[0]));
endmodule

module omsp_multiplier(per_dout, mclk, per_addr, per_din, per_en, per_we, 
      puc_rst, scan_enable);
   output [15:0]per_dout;
   input mclk;
   input [13:0]per_addr;
   input [15:0]per_din;
   input per_en;
   input [1:0]per_we;
   input puc_rst;
   input scan_enable;

   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire reg_sel;
   wire reg_read;
   wire n_3_0;
   wire n_3_1;
   wire n_3_2;
   wire reg_rd1;
   wire reg_rd15;
   wire reg_write;
   wire op2_wr;
   wire reslo_wr;
   wire reshi_wr;
   wire [15:0]per_din_msk;
   wire [15:0]op2_reg;
   wire [1:0]cycle;
   wire result_wr;
   wire op1_wr;
   wire sign_sel;
   wire [8:0]op2_hi_xp;
   wire n_29_0;
   wire n_29_1;
   wire [8:0]op2_xp;
   wire n_29_2;
   wire n_29_3;
   wire n_29_4;
   wire n_29_5;
   wire n_29_6;
   wire n_29_7;
   wire n_29_8;
   wire [15:0]op1;
   wire [16:0]op1_xp;
   wire n_32_0;
   wire n_32_1;
   wire n_32_2;
   wire n_32_3;
   wire n_32_4;
   wire n_32_5;
   wire n_32_6;
   wire n_32_7;
   wire n_32_8;
   wire n_32_9;
   wire n_32_10;
   wire n_32_11;
   wire n_32_12;
   wire n_32_13;
   wire n_32_14;
   wire n_32_15;
   wire n_32_16;
   wire n_32_17;
   wire n_32_18;
   wire n_32_19;
   wire n_32_20;
   wire n_32_21;
   wire n_32_22;
   wire n_32_23;
   wire n_32_24;
   wire n_32_25;
   wire n_32_26;
   wire n_32_27;
   wire n_32_28;
   wire n_32_29;
   wire n_32_30;
   wire n_32_31;
   wire n_32_32;
   wire n_32_33;
   wire n_32_34;
   wire n_32_35;
   wire n_32_36;
   wire n_32_37;
   wire n_32_38;
   wire n_32_39;
   wire n_32_40;
   wire n_32_41;
   wire n_32_42;
   wire n_32_43;
   wire n_32_44;
   wire n_32_45;
   wire n_32_46;
   wire n_32_47;
   wire n_32_48;
   wire n_32_49;
   wire n_32_50;
   wire n_32_51;
   wire n_32_52;
   wire n_32_53;
   wire n_32_54;
   wire n_32_55;
   wire n_32_56;
   wire n_32_57;
   wire n_32_58;
   wire n_32_59;
   wire n_32_60;
   wire n_32_61;
   wire n_32_62;
   wire n_32_63;
   wire n_32_64;
   wire n_32_65;
   wire n_32_66;
   wire n_32_67;
   wire n_32_68;
   wire n_32_69;
   wire n_32_70;
   wire n_32_71;
   wire n_32_72;
   wire n_32_73;
   wire n_32_74;
   wire n_32_75;
   wire n_32_76;
   wire n_32_77;
   wire n_32_78;
   wire n_32_79;
   wire n_32_80;
   wire n_32_81;
   wire n_32_82;
   wire n_32_83;
   wire n_32_84;
   wire n_32_85;
   wire n_32_86;
   wire n_32_87;
   wire n_32_88;
   wire n_32_89;
   wire n_32_90;
   wire n_32_91;
   wire n_32_92;
   wire n_32_93;
   wire n_32_94;
   wire n_32_95;
   wire n_32_96;
   wire n_32_97;
   wire n_32_98;
   wire n_32_99;
   wire n_32_100;
   wire n_32_101;
   wire n_32_102;
   wire n_32_103;
   wire n_32_104;
   wire n_32_105;
   wire n_32_106;
   wire n_32_107;
   wire n_32_108;
   wire n_32_109;
   wire n_32_110;
   wire n_32_111;
   wire n_32_112;
   wire n_32_113;
   wire n_32_114;
   wire n_32_115;
   wire n_32_116;
   wire n_32_117;
   wire n_32_118;
   wire n_32_119;
   wire n_32_120;
   wire n_32_121;
   wire n_32_122;
   wire n_32_123;
   wire n_32_124;
   wire n_32_125;
   wire n_32_126;
   wire n_32_127;
   wire n_32_128;
   wire n_32_129;
   wire n_32_130;
   wire n_32_131;
   wire n_32_132;
   wire n_32_133;
   wire n_32_134;
   wire n_32_135;
   wire n_32_136;
   wire n_32_137;
   wire n_32_138;
   wire n_32_139;
   wire n_32_140;
   wire n_32_141;
   wire n_32_142;
   wire n_32_143;
   wire n_32_144;
   wire n_32_145;
   wire n_32_146;
   wire n_32_147;
   wire n_32_148;
   wire n_32_149;
   wire n_32_150;
   wire n_32_151;
   wire n_32_152;
   wire n_32_153;
   wire n_32_154;
   wire n_32_155;
   wire n_32_156;
   wire n_32_157;
   wire n_32_158;
   wire n_32_159;
   wire n_32_160;
   wire n_32_161;
   wire n_32_162;
   wire n_32_163;
   wire n_32_164;
   wire n_32_165;
   wire n_32_166;
   wire n_32_167;
   wire n_32_168;
   wire n_32_169;
   wire n_32_170;
   wire n_32_171;
   wire n_32_172;
   wire n_32_173;
   wire n_32_174;
   wire n_32_175;
   wire n_32_176;
   wire n_32_177;
   wire n_32_178;
   wire n_32_179;
   wire n_32_180;
   wire n_32_181;
   wire n_32_182;
   wire n_32_183;
   wire n_32_184;
   wire n_32_185;
   wire n_32_186;
   wire n_32_187;
   wire n_32_188;
   wire n_32_189;
   wire n_32_190;
   wire n_32_191;
   wire n_32_192;
   wire n_32_193;
   wire n_32_194;
   wire n_32_195;
   wire n_32_196;
   wire n_32_197;
   wire n_32_198;
   wire n_32_199;
   wire n_32_200;
   wire n_32_201;
   wire n_32_202;
   wire n_32_203;
   wire n_32_204;
   wire n_32_205;
   wire n_32_206;
   wire n_32_207;
   wire n_32_208;
   wire n_32_209;
   wire n_32_210;
   wire n_32_211;
   wire n_32_212;
   wire n_32_213;
   wire n_32_214;
   wire n_32_215;
   wire n_32_216;
   wire n_32_217;
   wire n_32_218;
   wire n_32_219;
   wire n_32_220;
   wire n_32_221;
   wire n_32_222;
   wire n_32_223;
   wire n_32_224;
   wire n_32_225;
   wire n_32_226;
   wire n_32_227;
   wire n_32_228;
   wire n_32_229;
   wire n_32_230;
   wire n_32_231;
   wire n_32_232;
   wire n_32_233;
   wire n_32_234;
   wire n_32_235;
   wire n_32_236;
   wire n_32_237;
   wire n_32_238;
   wire n_32_239;
   wire n_32_240;
   wire n_32_241;
   wire n_32_242;
   wire n_32_243;
   wire n_32_244;
   wire n_32_245;
   wire n_32_246;
   wire n_32_247;
   wire n_32_248;
   wire n_32_249;
   wire n_32_250;
   wire n_32_251;
   wire n_32_252;
   wire n_32_253;
   wire n_32_254;
   wire n_32_255;
   wire n_32_256;
   wire n_32_257;
   wire n_32_258;
   wire n_32_259;
   wire n_32_260;
   wire n_32_261;
   wire n_32_262;
   wire n_32_263;
   wire n_32_264;
   wire n_32_265;
   wire n_32_266;
   wire n_32_267;
   wire n_32_268;
   wire n_32_269;
   wire n_32_270;
   wire n_32_271;
   wire n_32_272;
   wire n_32_273;
   wire n_32_274;
   wire n_32_275;
   wire n_32_276;
   wire n_32_277;
   wire n_32_278;
   wire n_32_279;
   wire n_32_280;
   wire n_32_281;
   wire n_32_282;
   wire n_32_283;
   wire n_32_284;
   wire n_32_285;
   wire n_32_286;
   wire n_32_287;
   wire n_32_288;
   wire n_32_289;
   wire n_32_290;
   wire n_32_291;
   wire n_32_292;
   wire n_32_293;
   wire n_32_294;
   wire n_32_295;
   wire n_32_296;
   wire n_32_297;
   wire n_32_298;
   wire n_32_299;
   wire n_32_300;
   wire n_32_301;
   wire n_32_302;
   wire n_32_303;
   wire n_32_304;
   wire n_32_305;
   wire n_32_306;
   wire n_32_307;
   wire n_32_308;
   wire n_32_309;
   wire n_32_310;
   wire n_32_311;
   wire n_32_312;
   wire n_32_313;
   wire n_32_314;
   wire n_32_315;
   wire n_32_316;
   wire n_32_317;
   wire n_32_318;
   wire n_32_319;
   wire n_32_320;
   wire n_32_321;
   wire n_32_322;
   wire n_32_323;
   wire n_32_324;
   wire n_32_325;
   wire n_32_326;
   wire n_32_327;
   wire n_32_328;
   wire n_32_329;
   wire n_32_330;
   wire n_32_331;
   wire n_32_332;
   wire n_32_333;
   wire n_32_334;
   wire n_32_335;
   wire n_32_336;
   wire n_32_337;
   wire n_32_338;
   wire n_32_339;
   wire n_32_340;
   wire n_32_341;
   wire n_32_342;
   wire n_32_343;
   wire n_32_344;
   wire n_32_345;
   wire n_32_346;
   wire n_32_347;
   wire n_32_348;
   wire n_32_349;
   wire n_32_350;
   wire n_32_351;
   wire n_32_352;
   wire n_32_353;
   wire n_32_354;
   wire n_32_355;
   wire n_32_356;
   wire n_32_357;
   wire n_32_358;
   wire n_32_359;
   wire n_32_360;
   wire n_32_361;
   wire n_32_362;
   wire n_32_363;
   wire n_32_364;
   wire n_32_365;
   wire n_32_366;
   wire n_32_367;
   wire n_32_368;
   wire n_32_369;
   wire n_32_370;
   wire n_32_371;
   wire n_32_372;
   wire n_32_373;
   wire n_32_374;
   wire n_32_375;
   wire n_32_376;
   wire n_32_377;
   wire n_32_378;
   wire n_32_379;
   wire n_32_380;
   wire n_32_381;
   wire n_32_382;
   wire n_32_383;
   wire n_32_384;
   wire n_32_385;
   wire n_32_386;
   wire n_32_387;
   wire n_32_388;
   wire n_32_389;
   wire n_32_390;
   wire n_32_391;
   wire n_32_392;
   wire n_32_393;
   wire n_32_394;
   wire n_32_395;
   wire n_32_396;
   wire n_32_397;
   wire n_32_398;
   wire n_32_399;
   wire n_32_400;
   wire n_32_401;
   wire n_32_402;
   wire n_32_403;
   wire n_32_404;
   wire n_32_405;
   wire n_32_406;
   wire n_32_407;
   wire n_32_408;
   wire n_32_409;
   wire n_32_410;
   wire n_32_411;
   wire n_32_412;
   wire n_32_413;
   wire n_32_414;
   wire n_32_415;
   wire n_32_416;
   wire n_32_417;
   wire n_32_418;
   wire n_32_419;
   wire n_32_420;
   wire n_32_421;
   wire n_32_422;
   wire n_32_423;
   wire n_32_424;
   wire n_32_425;
   wire n_32_426;
   wire n_32_427;
   wire n_32_428;
   wire n_32_429;
   wire n_32_430;
   wire n_32_431;
   wire n_32_432;
   wire n_32_433;
   wire n_32_434;
   wire n_32_435;
   wire n_32_436;
   wire n_32_437;
   wire n_32_438;
   wire n_32_439;
   wire n_32_440;
   wire n_32_441;
   wire n_32_442;
   wire n_32_443;
   wire n_32_444;
   wire n_32_445;
   wire n_32_446;
   wire n_32_447;
   wire n_32_448;
   wire n_32_449;
   wire n_32_450;
   wire n_32_451;
   wire n_32_452;
   wire n_32_453;
   wire n_32_454;
   wire n_32_455;
   wire n_32_456;
   wire n_32_457;
   wire n_32_458;
   wire n_32_459;
   wire n_32_460;
   wire n_32_461;
   wire n_32_462;
   wire n_32_463;
   wire n_32_464;
   wire n_32_465;
   wire n_32_466;
   wire n_32_467;
   wire n_32_468;
   wire n_32_469;
   wire n_32_470;
   wire n_32_471;
   wire n_32_472;
   wire n_32_473;
   wire n_32_474;
   wire n_32_475;
   wire n_32_476;
   wire n_32_477;
   wire n_32_478;
   wire n_32_479;
   wire n_32_480;
   wire n_32_481;
   wire n_32_482;
   wire n_32_483;
   wire n_32_484;
   wire n_32_485;
   wire n_32_486;
   wire n_32_487;
   wire n_32_488;
   wire n_32_489;
   wire n_32_490;
   wire n_32_491;
   wire n_32_492;
   wire n_32_493;
   wire n_32_494;
   wire n_32_495;
   wire n_32_496;
   wire n_32_497;
   wire n_32_498;
   wire n_32_499;
   wire n_32_500;
   wire n_32_501;
   wire n_32_502;
   wire n_32_503;
   wire n_32_504;
   wire n_32_505;
   wire n_32_506;
   wire n_32_507;
   wire n_32_508;
   wire n_32_509;
   wire n_32_510;
   wire n_32_511;
   wire n_32_512;
   wire n_32_513;
   wire n_32_514;
   wire n_32_515;
   wire n_32_516;
   wire n_32_517;
   wire n_32_518;
   wire n_32_519;
   wire n_32_520;
   wire n_32_521;
   wire n_32_522;
   wire n_32_523;
   wire n_32_524;
   wire n_32_525;
   wire n_32_526;
   wire n_32_527;
   wire n_32_528;
   wire n_32_529;
   wire n_32_530;
   wire n_32_531;
   wire n_32_532;
   wire n_32_533;
   wire n_32_534;
   wire n_32_535;
   wire n_32_536;
   wire n_32_537;
   wire n_32_538;
   wire n_32_539;
   wire n_32_540;
   wire n_32_541;
   wire n_32_542;
   wire n_32_543;
   wire n_32_544;
   wire n_32_545;
   wire n_32_546;
   wire n_32_547;
   wire n_32_548;
   wire n_32_549;
   wire n_32_550;
   wire n_32_551;
   wire n_32_552;
   wire n_32_553;
   wire n_32_554;
   wire n_32_555;
   wire n_32_556;
   wire n_32_557;
   wire n_32_558;
   wire n_32_559;
   wire n_32_560;
   wire n_32_561;
   wire n_32_562;
   wire n_32_563;
   wire n_32_564;
   wire n_32_565;
   wire n_32_566;
   wire n_32_567;
   wire n_32_568;
   wire n_32_569;
   wire n_32_570;
   wire n_32_571;
   wire n_32_572;
   wire n_32_573;
   wire n_32_574;
   wire n_32_575;
   wire n_32_576;
   wire n_32_577;
   wire n_32_578;
   wire n_32_579;
   wire n_32_580;
   wire n_32_581;
   wire n_32_582;
   wire n_32_583;
   wire n_32_584;
   wire n_32_585;
   wire n_32_586;
   wire n_32_587;
   wire n_32_588;
   wire n_32_589;
   wire n_32_590;
   wire n_32_591;
   wire n_32_592;
   wire n_32_593;
   wire n_32_594;
   wire n_32_595;
   wire n_32_596;
   wire n_32_597;
   wire n_32_598;
   wire n_32_599;
   wire n_32_600;
   wire n_32_601;
   wire n_32_602;
   wire n_32_603;
   wire n_32_604;
   wire n_32_605;
   wire n_32_606;
   wire n_32_607;
   wire n_32_608;
   wire n_32_609;
   wire n_32_610;
   wire n_32_611;
   wire n_32_612;
   wire n_32_613;
   wire n_32_614;
   wire n_32_615;
   wire n_32_616;
   wire n_32_617;
   wire n_32_618;
   wire n_32_619;
   wire n_32_620;
   wire n_32_621;
   wire n_32_622;
   wire n_32_623;
   wire n_32_624;
   wire n_32_625;
   wire n_32_626;
   wire n_32_627;
   wire n_32_628;
   wire n_32_629;
   wire n_32_630;
   wire n_32_631;
   wire n_32_632;
   wire n_32_633;
   wire n_32_634;
   wire n_32_635;
   wire n_32_636;
   wire n_32_637;
   wire n_32_638;
   wire n_32_639;
   wire n_32_640;
   wire n_32_641;
   wire n_32_642;
   wire n_32_643;
   wire n_32_644;
   wire n_32_645;
   wire n_32_646;
   wire n_32_647;
   wire n_32_648;
   wire n_32_649;
   wire n_32_650;
   wire n_32_651;
   wire n_32_652;
   wire n_32_653;
   wire n_32_654;
   wire n_32_655;
   wire n_32_656;
   wire n_32_657;
   wire n_32_658;
   wire n_32_659;
   wire n_32_660;
   wire n_32_661;
   wire n_32_662;
   wire n_32_663;
   wire n_32_664;
   wire n_32_665;
   wire n_32_666;
   wire n_32_667;
   wire n_32_668;
   wire n_32_669;
   wire n_32_670;
   wire n_32_671;
   wire n_32_672;
   wire n_32_673;
   wire n_32_674;
   wire n_34_0;
   wire [31:0]product_xp;
   wire n_34_1;
   wire n_34_2;
   wire n_34_3;
   wire n_34_4;
   wire n_34_5;
   wire n_34_6;
   wire n_34_7;
   wire n_34_8;
   wire n_34_9;
   wire n_34_10;
   wire n_34_11;
   wire n_34_12;
   wire n_34_13;
   wire n_34_14;
   wire n_34_15;
   wire n_34_16;
   wire n_34_17;
   wire n_34_18;
   wire n_34_19;
   wire n_34_20;
   wire n_34_21;
   wire n_34_22;
   wire n_34_23;
   wire n_34_24;
   wire n_34_25;
   wire acc_sel;
   wire n_38_0;
   wire result_clr;
   wire n_39_0;
   wire n_39_1;
   wire [15:0]reshi;
   wire n_41_0;
   wire n_41_1;
   wire n_41_2;
   wire n_41_3;
   wire n_41_4;
   wire n_41_5;
   wire n_41_6;
   wire n_41_7;
   wire n_41_8;
   wire n_41_9;
   wire n_41_10;
   wire n_41_11;
   wire n_41_12;
   wire n_41_13;
   wire n_41_14;
   wire n_41_15;
   wire n_41_16;
   wire n_42_0;
   wire n_42_1;
   wire n_45_0;
   wire n_45_1;
   wire n_45_2;
   wire n_45_3;
   wire n_45_4;
   wire n_45_5;
   wire n_45_6;
   wire n_45_7;
   wire n_45_8;
   wire n_45_9;
   wire n_45_10;
   wire n_45_11;
   wire n_45_12;
   wire n_45_13;
   wire n_45_14;
   wire n_45_15;
   wire n_45_16;
   wire n_46_0;
   wire n_46_1;
   wire n_48_0;
   wire n_48_1;
   wire n_48_2;
   wire n_48_3;
   wire n_48_4;
   wire n_48_5;
   wire n_48_6;
   wire n_48_7;
   wire n_48_8;
   wire n_48_9;
   wire n_48_10;
   wire n_48_11;
   wire n_48_12;
   wire n_48_13;
   wire n_48_14;
   wire n_48_15;
   wire [15:0]reshi_nxt;
   wire n_48_16;
   wire n_48_17;
   wire n_48_18;
   wire n_48_19;
   wire n_48_20;
   wire n_48_21;
   wire n_48_22;
   wire n_48_23;
   wire n_48_24;
   wire n_48_25;
   wire n_48_26;
   wire n_48_27;
   wire n_48_28;
   wire n_48_29;
   wire n_48_30;
   wire n_50_0;
   wire n_50_1;
   wire [1:0]sumext_s_nxt;
   wire [1:0]sumext_s;
   wire n_52_0;
   wire n_53_0;
   wire n_53_1;
   wire n_55_0;
   wire n_55_1;
   wire n_55_2;
   wire n_57_0;
   wire n_57_1;
   wire n_60_0;
   wire n_60_1;
   wire n_60_2;
   wire n_60_3;
   wire n_60_4;
   wire n_60_5;
   wire n_60_6;
   wire n_60_7;
   wire n_60_8;
   wire n_60_9;
   wire n_60_10;
   wire n_60_11;
   wire n_60_12;
   wire n_60_13;
   wire n_60_14;
   wire n_60_15;
   wire n_60_16;
   wire n_60_17;
   wire n_60_18;
   wire n_60_19;
   wire n_60_20;
   wire n_60_21;
   wire n_60_22;
   wire n_60_23;
   wire n_60_24;
   wire n_60_25;
   wire n_60_26;
   wire n_60_27;
   wire n_60_28;
   wire n_60_29;
   wire n_60_30;
   wire n_60_31;
   wire n_60_32;
   wire n_60_33;
   wire n_60_34;
   wire n_60_35;
   wire n_60_36;
   wire n_60_37;
   wire n_60_38;
   wire n_60_39;
   wire n_60_40;
   wire n_60_41;
   wire n_60_42;
   wire n_60_43;
   wire n_60_44;
   wire n_60_45;
   wire n_60_46;
   wire n_60_47;
   wire n_60_48;
   wire n_60_49;
   wire n_60_50;
   wire n_60_51;
   wire n_60_52;
   wire n_60_53;
   wire n_60_54;
   wire n_60_55;
   wire n_60_56;
   wire n_60_57;
   wire n_60_58;
   wire n_60_59;
   wire n_60_60;
   wire n_60_61;
   wire n_60_62;
   wire n_60_63;
   wire n_60_64;
   wire n_60_65;
   wire n_60_66;
   wire n_60_67;
   wire n_60_68;
   wire n_60_69;
   wire n_60_70;
   wire n_60_71;
   wire n_60_72;
   wire n_60_73;
   wire n_60_74;
   wire n_60_75;
   wire n_60_76;
   wire n_60_77;
   wire n_60_78;
   wire n_60_79;
   wire n_60_80;
   wire n_60_81;
   wire n_60_82;

   OR2_X1_LVT i_5_0 (.A1(per_we[0]), .A2(per_we[1]), .ZN(n_15));
   NAND4_X1_LVT i_0_0 (.A1(per_addr[3]), .A2(per_addr[4]), .A3(per_addr[7]), 
      .A4(per_en), .ZN(n_0_0));
   NOR4_X1_LVT i_0_1 (.A1(n_0_0), .A2(per_addr[11]), .A3(per_addr[12]), .A4(
      per_addr[13]), .ZN(n_0_1));
   NOR4_X1_LVT i_0_2 (.A1(per_addr[6]), .A2(per_addr[8]), .A3(per_addr[9]), 
      .A4(per_addr[10]), .ZN(n_0_2));
   NAND2_X1_LVT i_0_3 (.A1(n_0_1), .A2(n_0_2), .ZN(n_0_3));
   NOR2_X1_LVT i_0_4 (.A1(n_0_3), .A2(per_addr[5]), .ZN(reg_sel));
   AND2_X1_LVT i_6_0 (.A1(n_15), .A2(reg_sel), .ZN(reg_write));
   INV_X1_LVT i_3_6 (.A(per_addr[2]), .ZN(n_3_2));
   NOR3_X1_LVT i_3_7 (.A1(n_3_2), .A2(per_addr[0]), .A3(per_addr[1]), .ZN(n_5));
   AND2_X1_LVT i_7_4 (.A1(reg_write), .A2(n_5), .ZN(op2_wr));
   INV_X1_LVT i_21_0 (.A(puc_rst), .ZN(n_38));
   DFFR_X1_LVT \cycle_reg[0]  (.D(op2_wr), .RN(n_38), .CK(mclk), .Q(cycle[0]), 
      .QN());
   DFFR_X1_LVT \cycle_reg[1]  (.D(cycle[0]), .RN(n_38), .CK(mclk), .Q(cycle[1]), 
      .QN());
   INV_X1_LVT i_60_0 (.A(cycle[1]), .ZN(n_60_0));
   INV_X1_LVT i_38_0 (.A(op2_wr), .ZN(n_38_0));
   INV_X1_LVT i_3_3 (.A(per_addr[1]), .ZN(n_3_1));
   NOR3_X1_LVT i_3_4 (.A1(n_3_1), .A2(per_addr[0]), .A3(per_addr[2]), .ZN(n_3));
   AND2_X1_LVT i_7_2 (.A1(reg_write), .A2(n_3), .ZN(n_18));
   INV_X1_LVT i_3_1 (.A(per_addr[0]), .ZN(n_3_0));
   NOR3_X1_LVT i_3_5 (.A1(n_3_1), .A2(n_3_0), .A3(per_addr[2]), .ZN(n_4));
   AND2_X1_LVT i_7_3 (.A1(reg_write), .A2(n_4), .ZN(n_19));
   OR2_X1_LVT i_36_0 (.A1(n_18), .A2(n_19), .ZN(n_68));
   NOR3_X1_LVT i_3_0 (.A1(per_addr[0]), .A2(per_addr[1]), .A3(per_addr[2]), 
      .ZN(n_1));
   AND2_X1_LVT i_7_0 (.A1(n_1), .A2(reg_write), .ZN(n_16));
   NOR3_X1_LVT i_3_2 (.A1(n_3_0), .A2(per_addr[1]), .A3(per_addr[2]), .ZN(n_2));
   AND2_X1_LVT i_7_1 (.A1(reg_write), .A2(n_2), .ZN(n_17));
   OR4_X1_LVT i_24_0 (.A1(n_16), .A2(n_19), .A3(n_18), .A4(n_17), .ZN(op1_wr));
   CLKGATETST_X1_LVT clk_gate_acc_sel_reg (.CK(mclk), .E(op1_wr), .SE(1'b0), 
      .GCK(n_67));
   DFFR_X1_LVT acc_sel_reg (.D(n_68), .RN(n_38), .CK(n_67), .Q(acc_sel), .QN());
   NOR2_X1_LVT i_38_1 (.A1(n_38_0), .A2(acc_sel), .ZN(result_clr));
   NOR3_X1_LVT i_3_8 (.A1(n_3_2), .A2(n_3_0), .A3(per_addr[1]), .ZN(n_6));
   AND2_X1_LVT i_7_5 (.A1(reg_write), .A2(n_6), .ZN(reslo_wr));
   NOR2_X1_LVT i_45_0 (.A1(result_clr), .A2(reslo_wr), .ZN(n_45_0));
   INV_X1_LVT i_34_16 (.A(cycle[0]), .ZN(n_34_8));
   INV_X1_LVT i_29_0 (.A(cycle[0]), .ZN(n_29_0));
   CLKGATETST_X1_LVT clk_gate_op2_reg (.CK(mclk), .E(op2_wr), .SE(1'b0), 
      .GCK(n_20));
   DFFR_X1_LVT \op2_reg[4]  (.D(per_din[4]), .RN(n_38), .CK(n_20), .Q(op2_reg[4]), 
      .QN());
   AND2_X1_LVT i_8_4 (.A1(per_we[1]), .A2(per_din[12]), .ZN(per_din_msk[12]));
   CLKGATETST_X1_LVT clk_gate_op2_reg__0 (.CK(mclk), .E(op2_wr), .SE(1'b0), 
      .GCK(n_21));
   DFFR_X1_LVT \op2_reg[12]  (.D(per_din_msk[12]), .RN(n_38), .CK(n_21), 
      .Q(op2_reg[12]), .QN());
   AOI22_X1_LVT i_29_9 (.A1(n_29_0), .A2(op2_reg[4]), .B1(cycle[0]), .B2(
      op2_reg[12]), .ZN(n_29_5));
   INV_X1_LVT i_29_10 (.A(n_29_5), .ZN(op2_xp[4]));
   CLKGATETST_X1_LVT clk_gate_op1_reg (.CK(mclk), .E(op1_wr), .SE(1'b0), 
      .GCK(n_41));
   DFFR_X1_LVT \op1_reg[3]  (.D(per_din[3]), .RN(n_38), .CK(n_41), .Q(op1[3]), 
      .QN());
   NAND2_X1_LVT i_32_71 (.A1(op2_xp[4]), .A2(op1[3]), .ZN(n_32_71));
   DFFR_X1_LVT \op2_reg[3]  (.D(per_din[3]), .RN(n_38), .CK(n_20), .Q(op2_reg[3]), 
      .QN());
   AND2_X1_LVT i_8_3 (.A1(per_we[1]), .A2(per_din[11]), .ZN(per_din_msk[11]));
   DFFR_X1_LVT \op2_reg[11]  (.D(per_din_msk[11]), .RN(n_38), .CK(n_21), 
      .Q(op2_reg[11]), .QN());
   AOI22_X1_LVT i_29_7 (.A1(n_29_0), .A2(op2_reg[3]), .B1(cycle[0]), .B2(
      op2_reg[11]), .ZN(n_29_4));
   INV_X1_LVT i_29_8 (.A(n_29_4), .ZN(op2_xp[3]));
   DFFR_X1_LVT \op1_reg[4]  (.D(per_din[4]), .RN(n_38), .CK(n_41), .Q(op1[4]), 
      .QN());
   NAND2_X1_LVT i_32_55 (.A1(op2_xp[3]), .A2(op1[4]), .ZN(n_32_55));
   XNOR2_X1_LVT i_32_229 (.A(n_32_71), .B(n_32_55), .ZN(n_32_234));
   DFFR_X1_LVT \op2_reg[2]  (.D(per_din[2]), .RN(n_38), .CK(n_20), .Q(op2_reg[2]), 
      .QN());
   AND2_X1_LVT i_8_2 (.A1(per_we[1]), .A2(per_din[10]), .ZN(per_din_msk[10]));
   DFFR_X1_LVT \op2_reg[10]  (.D(per_din_msk[10]), .RN(n_38), .CK(n_21), 
      .Q(op2_reg[10]), .QN());
   AOI22_X1_LVT i_29_5 (.A1(n_29_0), .A2(op2_reg[2]), .B1(cycle[0]), .B2(
      op2_reg[10]), .ZN(n_29_3));
   INV_X1_LVT i_29_6 (.A(n_29_3), .ZN(op2_xp[2]));
   DFFR_X1_LVT \op1_reg[5]  (.D(per_din[5]), .RN(n_38), .CK(n_41), .Q(op1[5]), 
      .QN());
   NAND2_X1_LVT i_32_39 (.A1(op2_xp[2]), .A2(op1[5]), .ZN(n_32_39));
   XNOR2_X1_LVT i_32_230 (.A(n_32_234), .B(n_32_39), .ZN(n_32_235));
   INV_X1_LVT i_32_231 (.A(n_32_235), .ZN(n_32_236));
   DFFR_X1_LVT \op2_reg[7]  (.D(per_din[7]), .RN(n_38), .CK(n_20), .Q(op2_reg[7]), 
      .QN());
   AND2_X1_LVT i_8_7 (.A1(per_we[1]), .A2(per_din[15]), .ZN(per_din_msk[15]));
   DFFR_X1_LVT \op2_reg[15]  (.D(per_din_msk[15]), .RN(n_38), .CK(n_21), 
      .Q(op2_reg[15]), .QN());
   AOI22_X1_LVT i_29_15 (.A1(n_29_0), .A2(op2_reg[7]), .B1(cycle[0]), .B2(
      op2_reg[15]), .ZN(n_29_8));
   INV_X1_LVT i_29_16 (.A(n_29_8), .ZN(op2_xp[7]));
   DFFR_X1_LVT \op1_reg[0]  (.D(per_din[0]), .RN(n_38), .CK(n_41), .Q(op1[0]), 
      .QN());
   NAND2_X1_LVT i_32_119 (.A1(op2_xp[7]), .A2(op1[0]), .ZN(n_32_119));
   DFFR_X1_LVT \op2_reg[6]  (.D(per_din[6]), .RN(n_38), .CK(n_20), .Q(op2_reg[6]), 
      .QN());
   AND2_X1_LVT i_8_6 (.A1(per_we[1]), .A2(per_din[14]), .ZN(per_din_msk[14]));
   DFFR_X1_LVT \op2_reg[14]  (.D(per_din_msk[14]), .RN(n_38), .CK(n_21), 
      .Q(op2_reg[14]), .QN());
   AOI22_X1_LVT i_29_13 (.A1(n_29_0), .A2(op2_reg[6]), .B1(cycle[0]), .B2(
      op2_reg[14]), .ZN(n_29_7));
   INV_X1_LVT i_29_14 (.A(n_29_7), .ZN(op2_xp[6]));
   DFFR_X1_LVT \op1_reg[1]  (.D(per_din[1]), .RN(n_38), .CK(n_41), .Q(op1[1]), 
      .QN());
   NAND2_X1_LVT i_32_103 (.A1(op2_xp[6]), .A2(op1[1]), .ZN(n_32_103));
   XNOR2_X1_LVT i_32_222 (.A(n_32_119), .B(n_32_103), .ZN(n_32_227));
   DFFR_X1_LVT \op2_reg[5]  (.D(per_din[5]), .RN(n_38), .CK(n_20), .Q(op2_reg[5]), 
      .QN());
   AND2_X1_LVT i_8_5 (.A1(per_we[1]), .A2(per_din[13]), .ZN(per_din_msk[13]));
   DFFR_X1_LVT \op2_reg[13]  (.D(per_din_msk[13]), .RN(n_38), .CK(n_21), 
      .Q(op2_reg[13]), .QN());
   AOI22_X1_LVT i_29_11 (.A1(n_29_0), .A2(op2_reg[5]), .B1(cycle[0]), .B2(
      op2_reg[13]), .ZN(n_29_6));
   INV_X1_LVT i_29_12 (.A(n_29_6), .ZN(op2_xp[5]));
   DFFR_X1_LVT \op1_reg[2]  (.D(per_din[2]), .RN(n_38), .CK(n_41), .Q(op1[2]), 
      .QN());
   NAND2_X1_LVT i_32_87 (.A1(op2_xp[5]), .A2(op1[2]), .ZN(n_32_87));
   XNOR2_X1_LVT i_32_223 (.A(n_32_227), .B(n_32_87), .ZN(n_32_228));
   INV_X1_LVT i_32_224 (.A(n_32_228), .ZN(n_32_229));
   NAND2_X1_LVT i_32_85 (.A1(op2_xp[5]), .A2(op1[0]), .ZN(n_32_85));
   NAND2_X1_LVT i_32_69 (.A1(op2_xp[4]), .A2(op1[1]), .ZN(n_32_69));
   XNOR2_X1_LVT i_32_182 (.A(n_32_85), .B(n_32_69), .ZN(n_32_183));
   NAND2_X1_LVT i_32_53 (.A1(op2_xp[3]), .A2(op1[2]), .ZN(n_32_53));
   XNOR2_X1_LVT i_32_183 (.A(n_32_183), .B(n_32_53), .ZN(n_32_184));
   INV_X1_LVT i_32_184 (.A(n_32_184), .ZN(n_32_185));
   NAND2_X1_LVT i_32_35 (.A1(op2_xp[2]), .A2(op1[1]), .ZN(n_32_35));
   NAND2_X1_LVT i_32_51 (.A1(op2_xp[3]), .A2(op1[0]), .ZN(n_32_51));
   NOR2_X1_LVT i_32_159 (.A1(n_32_35), .A2(n_32_51), .ZN(n_32_159));
   DFFR_X1_LVT \op2_reg[1]  (.D(per_din[1]), .RN(n_38), .CK(n_20), .Q(op2_reg[1]), 
      .QN());
   AND2_X1_LVT i_8_1 (.A1(per_we[1]), .A2(per_din[9]), .ZN(per_din_msk[9]));
   DFFR_X1_LVT \op2_reg[9]  (.D(per_din_msk[9]), .RN(n_38), .CK(n_21), .Q(
      op2_reg[9]), .QN());
   AOI22_X1_LVT i_29_3 (.A1(n_29_0), .A2(op2_reg[1]), .B1(cycle[0]), .B2(
      op2_reg[9]), .ZN(n_29_2));
   INV_X1_LVT i_29_4 (.A(n_29_2), .ZN(op2_xp[1]));
   NAND2_X1_LVT i_32_19 (.A1(op2_xp[1]), .A2(op1[2]), .ZN(n_32_19));
   NOR2_X1_LVT i_32_160 (.A1(n_32_19), .A2(n_32_51), .ZN(n_32_160));
   NOR2_X1_LVT i_32_161 (.A1(n_32_19), .A2(n_32_35), .ZN(n_32_161));
   OR3_X1_LVT i_32_158 (.A1(n_32_159), .A2(n_32_160), .A3(n_32_161), .ZN(
      n_32_158));
   NAND2_X1_LVT i_32_20 (.A1(op2_xp[1]), .A2(op1[3]), .ZN(n_32_20));
   DFFR_X1_LVT \op2_reg[0]  (.D(per_din[0]), .RN(n_38), .CK(n_20), .Q(op2_reg[0]), 
      .QN());
   AND2_X1_LVT i_8_0 (.A1(per_din[8]), .A2(per_we[1]), .ZN(per_din_msk[8]));
   DFFR_X1_LVT \op2_reg[8]  (.D(per_din_msk[8]), .RN(n_38), .CK(n_21), .Q(
      op2_reg[8]), .QN());
   AOI22_X1_LVT i_29_1 (.A1(n_29_0), .A2(op2_reg[0]), .B1(op2_reg[8]), .B2(
      cycle[0]), .ZN(n_29_1));
   INV_X1_LVT i_29_2 (.A(n_29_1), .ZN(op2_xp[0]));
   NAND2_X1_LVT i_32_4 (.A1(op2_xp[0]), .A2(op1[4]), .ZN(n_32_4));
   XNOR2_X1_LVT i_32_173 (.A(n_32_20), .B(n_32_4), .ZN(n_32_173));
   NAND2_X1_LVT i_32_18 (.A1(op2_xp[1]), .A2(op1[1]), .ZN(n_32_18));
   NAND2_X1_LVT i_32_34 (.A1(op2_xp[2]), .A2(op1[0]), .ZN(n_32_34));
   NOR2_X1_LVT i_32_154 (.A1(n_32_18), .A2(n_32_34), .ZN(n_32_154));
   NAND2_X1_LVT i_32_3 (.A1(op2_xp[0]), .A2(op1[3]), .ZN(n_32_3));
   INV_X1_LVT i_32_164 (.A(n_32_3), .ZN(n_32_164));
   NAND2_X1_LVT i_32_163 (.A1(n_32_154), .A2(n_32_164), .ZN(n_32_163));
   INV_X1_LVT i_32_165 (.A(n_32_163), .ZN(n_32_165));
   XNOR2_X1_LVT i_32_174 (.A(n_32_173), .B(n_32_165), .ZN(n_32_174));
   HA_X1_LVT i_32_181 (.A(n_32_158), .B(n_32_174), .CO(n_32_182), .S(n_32_181));
   HA_X1_LVT i_32_197 (.A(n_32_185), .B(n_32_182), .CO(n_32_200), .S(n_32_199));
   NAND2_X1_LVT i_32_52 (.A1(op2_xp[3]), .A2(op1[1]), .ZN(n_32_52));
   NAND2_X1_LVT i_32_68 (.A1(op2_xp[4]), .A2(op1[0]), .ZN(n_32_68));
   NOR2_X1_LVT i_32_170 (.A1(n_32_52), .A2(n_32_68), .ZN(n_32_170));
   NAND2_X1_LVT i_32_36 (.A1(op2_xp[2]), .A2(op1[2]), .ZN(n_32_36));
   NOR2_X1_LVT i_32_171 (.A1(n_32_36), .A2(n_32_68), .ZN(n_32_171));
   NOR2_X1_LVT i_32_172 (.A1(n_32_36), .A2(n_32_52), .ZN(n_32_172));
   OR3_X1_LVT i_32_169 (.A1(n_32_170), .A2(n_32_171), .A3(n_32_172), .ZN(
      n_32_169));
   OR2_X1_LVT i_32_176 (.A1(n_32_4), .A2(n_32_20), .ZN(n_32_176));
   INV_X1_LVT i_32_178 (.A(n_32_20), .ZN(n_32_178));
   NAND2_X1_LVT i_32_177 (.A1(n_32_165), .A2(n_32_178), .ZN(n_32_177));
   INV_X1_LVT i_32_180 (.A(n_32_4), .ZN(n_32_180));
   NAND2_X1_LVT i_32_179 (.A1(n_32_165), .A2(n_32_180), .ZN(n_32_179));
   NAND3_X1_LVT i_32_175 (.A1(n_32_176), .A2(n_32_177), .A3(n_32_179), .ZN(
      n_32_175));
   NAND2_X1_LVT i_32_37 (.A1(op2_xp[2]), .A2(op1[3]), .ZN(n_32_37));
   NAND2_X1_LVT i_32_21 (.A1(op2_xp[1]), .A2(op1[4]), .ZN(n_32_21));
   XNOR2_X1_LVT i_32_189 (.A(n_32_37), .B(n_32_21), .ZN(n_32_190));
   NAND2_X1_LVT i_32_5 (.A1(op2_xp[0]), .A2(op1[5]), .ZN(n_32_5));
   XNOR2_X1_LVT i_32_190 (.A(n_32_190), .B(n_32_5), .ZN(n_32_191));
   INV_X1_LVT i_32_191 (.A(n_32_191), .ZN(n_32_192));
   FA_X1_LVT i_32_196 (.A(n_32_169), .B(n_32_175), .CI(n_32_192), .CO(n_32_198), 
      .S(n_32_197));
   HA_X1_LVT i_32_221 (.A(n_32_200), .B(n_32_198), .CO(n_32_226), .S(n_32_225));
   FA_X1_LVT i_32_245 (.A(n_32_236), .B(n_32_229), .CI(n_32_226), .CO(n_32_252), 
      .S(n_32_251));
   NAND2_X1_LVT i_32_86 (.A1(op2_xp[5]), .A2(op1[1]), .ZN(n_32_86));
   NAND2_X1_LVT i_32_102 (.A1(op2_xp[6]), .A2(op1[0]), .ZN(n_32_102));
   NOR2_X1_LVT i_32_202 (.A1(n_32_86), .A2(n_32_102), .ZN(n_32_205));
   NAND2_X1_LVT i_32_70 (.A1(op2_xp[4]), .A2(op1[2]), .ZN(n_32_70));
   NOR2_X1_LVT i_32_203 (.A1(n_32_70), .A2(n_32_102), .ZN(n_32_206));
   NOR2_X1_LVT i_32_204 (.A1(n_32_70), .A2(n_32_86), .ZN(n_32_207));
   OR3_X1_LVT i_32_201 (.A1(n_32_205), .A2(n_32_206), .A3(n_32_207), .ZN(
      n_32_204));
   NOR2_X1_LVT i_32_193 (.A1(n_32_21), .A2(n_32_37), .ZN(n_32_194));
   NOR2_X1_LVT i_32_194 (.A1(n_32_5), .A2(n_32_37), .ZN(n_32_195));
   NOR2_X1_LVT i_32_195 (.A1(n_32_5), .A2(n_32_21), .ZN(n_32_196));
   OR3_X1_LVT i_32_192 (.A1(n_32_194), .A2(n_32_195), .A3(n_32_196), .ZN(
      n_32_193));
   DFFR_X1_LVT \op1_reg[6]  (.D(per_din[6]), .RN(n_38), .CK(n_41), .Q(op1[6]), 
      .QN());
   NAND2_X1_LVT i_32_6 (.A1(op2_xp[0]), .A2(op1[6]), .ZN(n_32_6));
   INV_X1_LVT i_32_217 (.A(n_32_6), .ZN(n_32_220));
   NAND2_X1_LVT i_32_216 (.A1(n_32_193), .A2(n_32_220), .ZN(n_32_219));
   NOR2_X1_LVT i_32_186 (.A1(n_32_69), .A2(n_32_85), .ZN(n_32_187));
   NOR2_X1_LVT i_32_187 (.A1(n_32_53), .A2(n_32_85), .ZN(n_32_188));
   NOR2_X1_LVT i_32_188 (.A1(n_32_53), .A2(n_32_69), .ZN(n_32_189));
   OR3_X1_LVT i_32_185 (.A1(n_32_187), .A2(n_32_188), .A3(n_32_189), .ZN(
      n_32_186));
   NAND2_X1_LVT i_32_218 (.A1(n_32_186), .A2(n_32_220), .ZN(n_32_221));
   NAND2_X1_LVT i_32_219 (.A1(n_32_186), .A2(n_32_193), .ZN(n_32_222));
   NAND3_X1_LVT i_32_215 (.A1(n_32_219), .A2(n_32_221), .A3(n_32_222), .ZN(
      n_32_218));
   NAND2_X1_LVT i_32_23 (.A1(op2_xp[1]), .A2(op1[6]), .ZN(n_32_23));
   DFFR_X1_LVT \op1_reg[7]  (.D(per_din[7]), .RN(n_38), .CK(n_41), .Q(op1[7]), 
      .QN());
   NAND2_X1_LVT i_32_7 (.A1(op2_xp[0]), .A2(op1[7]), .ZN(n_32_7));
   XNOR2_X1_LVT i_32_236 (.A(n_32_23), .B(n_32_7), .ZN(n_32_241));
   NAND2_X1_LVT i_32_38 (.A1(op2_xp[2]), .A2(op1[4]), .ZN(n_32_38));
   NAND2_X1_LVT i_32_54 (.A1(op2_xp[3]), .A2(op1[3]), .ZN(n_32_54));
   NOR2_X1_LVT i_32_209 (.A1(n_32_38), .A2(n_32_54), .ZN(n_32_212));
   NAND2_X1_LVT i_32_22 (.A1(op2_xp[1]), .A2(op1[5]), .ZN(n_32_22));
   NOR2_X1_LVT i_32_210 (.A1(n_32_22), .A2(n_32_54), .ZN(n_32_213));
   NOR2_X1_LVT i_32_211 (.A1(n_32_22), .A2(n_32_38), .ZN(n_32_214));
   OR3_X1_LVT i_32_208 (.A1(n_32_212), .A2(n_32_213), .A3(n_32_214), .ZN(
      n_32_211));
   XNOR2_X1_LVT i_32_237 (.A(n_32_241), .B(n_32_211), .ZN(n_32_242));
   FA_X1_LVT i_32_244 (.A(n_32_204), .B(n_32_218), .CI(n_32_242), .CO(n_32_250), 
      .S(n_32_249));
   XNOR2_X1_LVT i_32_205 (.A(n_32_54), .B(n_32_38), .ZN(n_32_208));
   XNOR2_X1_LVT i_32_206 (.A(n_32_208), .B(n_32_22), .ZN(n_32_209));
   INV_X1_LVT i_32_207 (.A(n_32_209), .ZN(n_32_210));
   XNOR2_X1_LVT i_32_198 (.A(n_32_102), .B(n_32_86), .ZN(n_32_201));
   XNOR2_X1_LVT i_32_199 (.A(n_32_201), .B(n_32_70), .ZN(n_32_202));
   INV_X1_LVT i_32_200 (.A(n_32_202), .ZN(n_32_203));
   XNOR2_X1_LVT i_32_212 (.A(n_32_6), .B(n_32_193), .ZN(n_32_215));
   XNOR2_X1_LVT i_32_213 (.A(n_32_215), .B(n_32_186), .ZN(n_32_216));
   INV_X1_LVT i_32_214 (.A(n_32_216), .ZN(n_32_217));
   FA_X1_LVT i_32_220 (.A(n_32_210), .B(n_32_203), .CI(n_32_217), .CO(n_32_224), 
      .S(n_32_223));
   HA_X1_LVT i_32_246 (.A(n_32_249), .B(n_32_224), .CO(n_32_254), .S(n_32_253));
   XNOR2_X1_LVT i_32_166 (.A(n_32_68), .B(n_32_52), .ZN(n_32_166));
   XNOR2_X1_LVT i_32_167 (.A(n_32_166), .B(n_32_36), .ZN(n_32_167));
   INV_X1_LVT i_32_168 (.A(n_32_167), .ZN(n_32_168));
   XNOR2_X1_LVT i_32_162 (.A(n_32_3), .B(n_32_154), .ZN(n_32_162));
   XNOR2_X1_LVT i_32_155 (.A(n_32_51), .B(n_32_35), .ZN(n_32_155));
   XNOR2_X1_LVT i_32_156 (.A(n_32_155), .B(n_32_19), .ZN(n_32_156));
   INV_X1_LVT i_32_157 (.A(n_32_156), .ZN(n_32_157));
   XNOR2_X1_LVT i_32_152 (.A(n_32_34), .B(n_32_18), .ZN(n_32_152));
   INV_X1_LVT i_32_153 (.A(n_32_152), .ZN(n_32_153));
   NAND2_X1_LVT i_32_2 (.A1(op2_xp[0]), .A2(op1[2]), .ZN(n_32_2));
   INV_X1_LVT i_32_594 (.A(n_32_2), .ZN(n_32_651));
   NAND2_X1_LVT i_32_593 (.A1(n_32_153), .A2(n_32_651), .ZN(n_32_650));
   NAND2_X1_LVT i_32_1 (.A1(op2_xp[0]), .A2(op1[1]), .ZN(n_32_1));
   NAND2_X1_LVT i_32_17 (.A1(op2_xp[1]), .A2(op1[0]), .ZN(n_32_17));
   NOR2_X1_LVT i_32_588 (.A1(n_32_1), .A2(n_32_17), .ZN(n_32_646));
   NAND2_X1_LVT i_32_595 (.A1(n_32_646), .A2(n_32_651), .ZN(n_32_652));
   NAND2_X1_LVT i_32_596 (.A1(n_32_646), .A2(n_32_153), .ZN(n_32_653));
   NAND3_X1_LVT i_32_592 (.A1(n_32_650), .A2(n_32_652), .A3(n_32_653), .ZN(
      n_32_649));
   FA_X1_LVT i_32_597 (.A(n_32_162), .B(n_32_157), .CI(n_32_649), .CO(n_32_654), 
      .S(n_45));
   FA_X1_LVT i_32_598 (.A(n_32_168), .B(n_32_181), .CI(n_32_654), .CO(n_32_655), 
      .S(n_46));
   FA_X1_LVT i_32_599 (.A(n_32_197), .B(n_32_199), .CI(n_32_655), .CO(n_32_656), 
      .S(n_47));
   FA_X1_LVT i_32_600 (.A(n_32_225), .B(n_32_223), .CI(n_32_656), .CO(n_32_657), 
      .S(n_48));
   FA_X1_LVT i_32_601 (.A(n_32_251), .B(n_32_253), .CI(n_32_657), .CO(n_32_658), 
      .S(n_49));
   INV_X1_LVT i_34_14 (.A(n_49), .ZN(n_34_7));
   OR2_X1_LVT i_26_0 (.A1(n_17), .A2(n_19), .ZN(n_40));
   CLKGATETST_X1_LVT clk_gate_sign_sel_reg (.CK(mclk), .E(op1_wr), .SE(1'b0), 
      .GCK(n_39));
   DFFR_X1_LVT sign_sel_reg (.D(n_40), .RN(n_38), .CK(n_39), .Q(sign_sel), .QN());
   AND2_X1_LVT i_28_0 (.A1(op2_reg[15]), .A2(sign_sel), .ZN(op2_hi_xp[8]));
   AND2_X1_LVT i_29_17 (.A1(cycle[0]), .A2(op2_hi_xp[8]), .ZN(op2_xp[8]));
   NAND2_X1_LVT i_32_141 (.A1(op2_xp[8]), .A2(op1[5]), .ZN(n_32_141));
   NAND2_X1_LVT i_32_125 (.A1(op2_xp[7]), .A2(op1[6]), .ZN(n_32_125));
   XNOR2_X1_LVT i_32_380 (.A(n_32_141), .B(n_32_125), .ZN(n_32_407));
   NAND2_X1_LVT i_32_109 (.A1(op2_xp[6]), .A2(op1[7]), .ZN(n_32_109));
   XNOR2_X1_LVT i_32_381 (.A(n_32_407), .B(n_32_109), .ZN(n_32_408));
   DFFR_X1_LVT \op1_reg[11]  (.D(per_din_msk[11]), .RN(n_38), .CK(n_41), 
      .Q(op1[11]), .QN());
   NAND2_X1_LVT i_32_28 (.A1(op2_xp[1]), .A2(op1[11]), .ZN(n_32_28));
   DFFR_X1_LVT \op1_reg[10]  (.D(per_din_msk[10]), .RN(n_38), .CK(n_41), 
      .Q(op1[10]), .QN());
   NAND2_X1_LVT i_32_44 (.A1(op2_xp[2]), .A2(op1[10]), .ZN(n_32_44));
   NOR2_X1_LVT i_32_373 (.A1(n_32_28), .A2(n_32_44), .ZN(n_32_396));
   DFFR_X1_LVT \op1_reg[12]  (.D(per_din_msk[12]), .RN(n_38), .CK(n_41), 
      .Q(op1[12]), .QN());
   NAND2_X1_LVT i_32_12 (.A1(op2_xp[0]), .A2(op1[12]), .ZN(n_32_12));
   NOR2_X1_LVT i_32_374 (.A1(n_32_12), .A2(n_32_44), .ZN(n_32_397));
   NOR2_X1_LVT i_32_375 (.A1(n_32_12), .A2(n_32_28), .ZN(n_32_398));
   OR3_X1_LVT i_32_372 (.A1(n_32_396), .A2(n_32_397), .A3(n_32_398), .ZN(
      n_32_395));
   DFFR_X1_LVT \op1_reg[8]  (.D(per_din_msk[8]), .RN(n_38), .CK(n_41), .Q(op1[8]), 
      .QN());
   NAND2_X1_LVT i_32_76 (.A1(op2_xp[4]), .A2(op1[8]), .ZN(n_32_76));
   NAND2_X1_LVT i_32_92 (.A1(op2_xp[5]), .A2(op1[7]), .ZN(n_32_92));
   NOR2_X1_LVT i_32_366 (.A1(n_32_76), .A2(n_32_92), .ZN(n_32_389));
   DFFR_X1_LVT \op1_reg[9]  (.D(per_din_msk[9]), .RN(n_38), .CK(n_41), .Q(op1[9]), 
      .QN());
   NAND2_X1_LVT i_32_60 (.A1(op2_xp[3]), .A2(op1[9]), .ZN(n_32_60));
   NOR2_X1_LVT i_32_367 (.A1(n_32_60), .A2(n_32_92), .ZN(n_32_390));
   NOR2_X1_LVT i_32_368 (.A1(n_32_60), .A2(n_32_76), .ZN(n_32_391));
   OR3_X1_LVT i_32_365 (.A1(n_32_389), .A2(n_32_390), .A3(n_32_391), .ZN(
      n_32_388));
   NAND2_X1_LVT i_32_140 (.A1(op2_xp[8]), .A2(op1[4]), .ZN(n_32_140));
   NAND2_X1_LVT i_32_124 (.A1(op2_xp[7]), .A2(op1[5]), .ZN(n_32_124));
   INV_X1_LVT i_32_358 (.A(n_32_124), .ZN(n_32_381));
   NAND2_X1_LVT i_32_357 (.A1(n_32_140), .A2(n_32_381), .ZN(n_32_380));
   NAND2_X1_LVT i_32_108 (.A1(op2_xp[6]), .A2(op1[6]), .ZN(n_32_108));
   INV_X1_LVT i_32_360 (.A(n_32_108), .ZN(n_32_383));
   NAND2_X1_LVT i_32_359 (.A1(n_32_140), .A2(n_32_383), .ZN(n_32_382));
   OR2_X1_LVT i_32_361 (.A1(n_32_108), .A2(n_32_124), .ZN(n_32_384));
   NAND3_X1_LVT i_32_356 (.A1(n_32_380), .A2(n_32_382), .A3(n_32_384), .ZN(
      n_32_379));
   FA_X1_LVT i_32_402 (.A(n_32_395), .B(n_32_388), .CI(n_32_379), .CO(n_32_430), 
      .S(n_32_429));
   NAND2_X1_LVT i_32_26 (.A1(op2_xp[1]), .A2(op1[9]), .ZN(n_32_26));
   NAND2_X1_LVT i_32_42 (.A1(op2_xp[2]), .A2(op1[8]), .ZN(n_32_42));
   NOR2_X1_LVT i_32_321 (.A1(n_32_26), .A2(n_32_42), .ZN(n_32_336));
   NAND2_X1_LVT i_32_10 (.A1(op2_xp[0]), .A2(op1[10]), .ZN(n_32_10));
   NOR2_X1_LVT i_32_322 (.A1(n_32_10), .A2(n_32_42), .ZN(n_32_337));
   NOR2_X1_LVT i_32_323 (.A1(n_32_10), .A2(n_32_26), .ZN(n_32_338));
   OR3_X1_LVT i_32_320 (.A1(n_32_336), .A2(n_32_337), .A3(n_32_338), .ZN(
      n_32_335));
   NAND2_X1_LVT i_32_74 (.A1(op2_xp[4]), .A2(op1[6]), .ZN(n_32_74));
   NAND2_X1_LVT i_32_90 (.A1(op2_xp[5]), .A2(op1[5]), .ZN(n_32_90));
   NOR2_X1_LVT i_32_314 (.A1(n_32_74), .A2(n_32_90), .ZN(n_32_329));
   NAND2_X1_LVT i_32_58 (.A1(op2_xp[3]), .A2(op1[7]), .ZN(n_32_58));
   NOR2_X1_LVT i_32_315 (.A1(n_32_58), .A2(n_32_90), .ZN(n_32_330));
   NOR2_X1_LVT i_32_316 (.A1(n_32_58), .A2(n_32_74), .ZN(n_32_331));
   OR3_X1_LVT i_32_313 (.A1(n_32_329), .A2(n_32_330), .A3(n_32_331), .ZN(
      n_32_328));
   NAND2_X1_LVT i_32_138 (.A1(op2_xp[8]), .A2(op1[2]), .ZN(n_32_138));
   NAND2_X1_LVT i_32_122 (.A1(op2_xp[7]), .A2(op1[3]), .ZN(n_32_122));
   INV_X1_LVT i_32_306 (.A(n_32_122), .ZN(n_32_321));
   NAND2_X1_LVT i_32_305 (.A1(n_32_138), .A2(n_32_321), .ZN(n_32_320));
   NAND2_X1_LVT i_32_106 (.A1(op2_xp[6]), .A2(op1[4]), .ZN(n_32_106));
   INV_X1_LVT i_32_308 (.A(n_32_106), .ZN(n_32_323));
   NAND2_X1_LVT i_32_307 (.A1(n_32_138), .A2(n_32_323), .ZN(n_32_322));
   OR2_X1_LVT i_32_309 (.A1(n_32_106), .A2(n_32_122), .ZN(n_32_324));
   NAND3_X1_LVT i_32_304 (.A1(n_32_320), .A2(n_32_322), .A3(n_32_324), .ZN(
      n_32_319));
   FA_X1_LVT i_32_350 (.A(n_32_335), .B(n_32_328), .CI(n_32_319), .CO(n_32_370), 
      .S(n_32_369));
   XNOR2_X1_LVT i_32_369 (.A(n_32_44), .B(n_32_28), .ZN(n_32_392));
   XNOR2_X1_LVT i_32_370 (.A(n_32_392), .B(n_32_12), .ZN(n_32_393));
   INV_X1_LVT i_32_371 (.A(n_32_393), .ZN(n_32_394));
   XNOR2_X1_LVT i_32_362 (.A(n_32_92), .B(n_32_76), .ZN(n_32_385));
   XNOR2_X1_LVT i_32_363 (.A(n_32_385), .B(n_32_60), .ZN(n_32_386));
   INV_X1_LVT i_32_364 (.A(n_32_386), .ZN(n_32_387));
   FA_X1_LVT i_32_377 (.A(n_32_370), .B(n_32_394), .CI(n_32_387), .CO(n_32_402), 
      .S(n_32_401));
   FA_X1_LVT i_32_404 (.A(n_32_408), .B(n_32_429), .CI(n_32_402), .CO(n_32_434), 
      .S(n_32_433));
   NAND2_X1_LVT i_32_46 (.A1(op2_xp[2]), .A2(op1[12]), .ZN(n_32_46));
   DFFR_X1_LVT \op1_reg[13]  (.D(per_din_msk[13]), .RN(n_38), .CK(n_41), 
      .Q(op1[13]), .QN());
   NAND2_X1_LVT i_32_30 (.A1(op2_xp[1]), .A2(op1[13]), .ZN(n_32_30));
   XNOR2_X1_LVT i_32_421 (.A(n_32_46), .B(n_32_30), .ZN(n_32_452));
   DFFR_X1_LVT \op1_reg[14]  (.D(per_din_msk[14]), .RN(n_38), .CK(n_41), 
      .Q(op1[14]), .QN());
   NAND2_X1_LVT i_32_14 (.A1(op2_xp[0]), .A2(op1[14]), .ZN(n_32_14));
   XNOR2_X1_LVT i_32_422 (.A(n_32_452), .B(n_32_14), .ZN(n_32_453));
   INV_X1_LVT i_32_423 (.A(n_32_453), .ZN(n_32_454));
   NAND2_X1_LVT i_32_94 (.A1(op2_xp[5]), .A2(op1[9]), .ZN(n_32_94));
   NAND2_X1_LVT i_32_78 (.A1(op2_xp[4]), .A2(op1[10]), .ZN(n_32_78));
   XNOR2_X1_LVT i_32_414 (.A(n_32_94), .B(n_32_78), .ZN(n_32_445));
   NAND2_X1_LVT i_32_62 (.A1(op2_xp[3]), .A2(op1[11]), .ZN(n_32_62));
   XNOR2_X1_LVT i_32_415 (.A(n_32_445), .B(n_32_62), .ZN(n_32_446));
   INV_X1_LVT i_32_416 (.A(n_32_446), .ZN(n_32_447));
   FA_X1_LVT i_32_429 (.A(n_32_430), .B(n_32_454), .CI(n_32_447), .CO(n_32_462), 
      .S(n_32_461));
   NAND2_X1_LVT i_32_142 (.A1(op2_xp[8]), .A2(op1[6]), .ZN(n_32_142));
   NAND2_X1_LVT i_32_126 (.A1(op2_xp[7]), .A2(op1[7]), .ZN(n_32_126));
   XNOR2_X1_LVT i_32_406 (.A(n_32_142), .B(n_32_126), .ZN(n_32_437));
   NAND2_X1_LVT i_32_110 (.A1(op2_xp[6]), .A2(op1[8]), .ZN(n_32_110));
   XNOR2_X1_LVT i_32_407 (.A(n_32_437), .B(n_32_110), .ZN(n_32_438));
   NAND2_X1_LVT i_32_29 (.A1(op2_xp[1]), .A2(op1[12]), .ZN(n_32_29));
   NAND2_X1_LVT i_32_45 (.A1(op2_xp[2]), .A2(op1[11]), .ZN(n_32_45));
   NOR2_X1_LVT i_32_399 (.A1(n_32_29), .A2(n_32_45), .ZN(n_32_426));
   NAND2_X1_LVT i_32_13 (.A1(op2_xp[0]), .A2(op1[13]), .ZN(n_32_13));
   NOR2_X1_LVT i_32_400 (.A1(n_32_13), .A2(n_32_45), .ZN(n_32_427));
   NOR2_X1_LVT i_32_401 (.A1(n_32_13), .A2(n_32_29), .ZN(n_32_428));
   OR3_X1_LVT i_32_398 (.A1(n_32_426), .A2(n_32_427), .A3(n_32_428), .ZN(
      n_32_425));
   NAND2_X1_LVT i_32_77 (.A1(op2_xp[4]), .A2(op1[9]), .ZN(n_32_77));
   NAND2_X1_LVT i_32_93 (.A1(op2_xp[5]), .A2(op1[8]), .ZN(n_32_93));
   NOR2_X1_LVT i_32_392 (.A1(n_32_77), .A2(n_32_93), .ZN(n_32_419));
   NAND2_X1_LVT i_32_61 (.A1(op2_xp[3]), .A2(op1[10]), .ZN(n_32_61));
   NOR2_X1_LVT i_32_393 (.A1(n_32_61), .A2(n_32_93), .ZN(n_32_420));
   NOR2_X1_LVT i_32_394 (.A1(n_32_61), .A2(n_32_77), .ZN(n_32_421));
   OR3_X1_LVT i_32_391 (.A1(n_32_419), .A2(n_32_420), .A3(n_32_421), .ZN(
      n_32_418));
   INV_X1_LVT i_32_384 (.A(n_32_125), .ZN(n_32_411));
   NAND2_X1_LVT i_32_383 (.A1(n_32_141), .A2(n_32_411), .ZN(n_32_410));
   INV_X1_LVT i_32_386 (.A(n_32_109), .ZN(n_32_413));
   NAND2_X1_LVT i_32_385 (.A1(n_32_141), .A2(n_32_413), .ZN(n_32_412));
   OR2_X1_LVT i_32_387 (.A1(n_32_109), .A2(n_32_125), .ZN(n_32_414));
   NAND3_X1_LVT i_32_382 (.A1(n_32_410), .A2(n_32_412), .A3(n_32_414), .ZN(
      n_32_409));
   FA_X1_LVT i_32_428 (.A(n_32_425), .B(n_32_418), .CI(n_32_409), .CO(n_32_460), 
      .S(n_32_459));
   NAND2_X1_LVT i_32_27 (.A1(op2_xp[1]), .A2(op1[10]), .ZN(n_32_27));
   NAND2_X1_LVT i_32_43 (.A1(op2_xp[2]), .A2(op1[9]), .ZN(n_32_43));
   NOR2_X1_LVT i_32_347 (.A1(n_32_27), .A2(n_32_43), .ZN(n_32_366));
   NAND2_X1_LVT i_32_11 (.A1(op2_xp[0]), .A2(op1[11]), .ZN(n_32_11));
   NOR2_X1_LVT i_32_348 (.A1(n_32_11), .A2(n_32_43), .ZN(n_32_367));
   NOR2_X1_LVT i_32_349 (.A1(n_32_11), .A2(n_32_27), .ZN(n_32_368));
   OR3_X1_LVT i_32_346 (.A1(n_32_366), .A2(n_32_367), .A3(n_32_368), .ZN(
      n_32_365));
   NAND2_X1_LVT i_32_75 (.A1(op2_xp[4]), .A2(op1[7]), .ZN(n_32_75));
   NAND2_X1_LVT i_32_91 (.A1(op2_xp[5]), .A2(op1[6]), .ZN(n_32_91));
   NOR2_X1_LVT i_32_340 (.A1(n_32_75), .A2(n_32_91), .ZN(n_32_359));
   NAND2_X1_LVT i_32_59 (.A1(op2_xp[3]), .A2(op1[8]), .ZN(n_32_59));
   NOR2_X1_LVT i_32_341 (.A1(n_32_59), .A2(n_32_91), .ZN(n_32_360));
   NOR2_X1_LVT i_32_342 (.A1(n_32_59), .A2(n_32_75), .ZN(n_32_361));
   OR3_X1_LVT i_32_339 (.A1(n_32_359), .A2(n_32_360), .A3(n_32_361), .ZN(
      n_32_358));
   NAND2_X1_LVT i_32_139 (.A1(op2_xp[8]), .A2(op1[3]), .ZN(n_32_139));
   NAND2_X1_LVT i_32_123 (.A1(op2_xp[7]), .A2(op1[4]), .ZN(n_32_123));
   INV_X1_LVT i_32_332 (.A(n_32_123), .ZN(n_32_351));
   NAND2_X1_LVT i_32_331 (.A1(n_32_139), .A2(n_32_351), .ZN(n_32_350));
   NAND2_X1_LVT i_32_107 (.A1(op2_xp[6]), .A2(op1[5]), .ZN(n_32_107));
   INV_X1_LVT i_32_334 (.A(n_32_107), .ZN(n_32_353));
   NAND2_X1_LVT i_32_333 (.A1(n_32_139), .A2(n_32_353), .ZN(n_32_352));
   OR2_X1_LVT i_32_335 (.A1(n_32_107), .A2(n_32_123), .ZN(n_32_354));
   NAND3_X1_LVT i_32_330 (.A1(n_32_350), .A2(n_32_352), .A3(n_32_354), .ZN(
      n_32_349));
   FA_X1_LVT i_32_376 (.A(n_32_365), .B(n_32_358), .CI(n_32_349), .CO(n_32_400), 
      .S(n_32_399));
   XNOR2_X1_LVT i_32_395 (.A(n_32_45), .B(n_32_29), .ZN(n_32_422));
   XNOR2_X1_LVT i_32_396 (.A(n_32_422), .B(n_32_13), .ZN(n_32_423));
   INV_X1_LVT i_32_397 (.A(n_32_423), .ZN(n_32_424));
   XNOR2_X1_LVT i_32_388 (.A(n_32_93), .B(n_32_77), .ZN(n_32_415));
   XNOR2_X1_LVT i_32_389 (.A(n_32_415), .B(n_32_61), .ZN(n_32_416));
   INV_X1_LVT i_32_390 (.A(n_32_416), .ZN(n_32_417));
   FA_X1_LVT i_32_403 (.A(n_32_400), .B(n_32_424), .CI(n_32_417), .CO(n_32_432), 
      .S(n_32_431));
   FA_X1_LVT i_32_430 (.A(n_32_438), .B(n_32_459), .CI(n_32_432), .CO(n_32_464), 
      .S(n_32_463));
   FA_X1_LVT i_32_431 (.A(n_32_434), .B(n_32_461), .CI(n_32_463), .CO(n_32_466), 
      .S(n_32_465));
   NAND2_X1_LVT i_32_47 (.A1(op2_xp[2]), .A2(op1[13]), .ZN(n_32_47));
   NAND2_X1_LVT i_32_31 (.A1(op2_xp[1]), .A2(op1[14]), .ZN(n_32_31));
   XNOR2_X1_LVT i_32_447 (.A(n_32_47), .B(n_32_31), .ZN(n_32_482));
   DFFR_X1_LVT \op1_reg[15]  (.D(per_din_msk[15]), .RN(n_38), .CK(n_41), 
      .Q(op1[15]), .QN());
   NAND2_X1_LVT i_32_15 (.A1(op2_xp[0]), .A2(op1[15]), .ZN(n_32_15));
   XNOR2_X1_LVT i_32_448 (.A(n_32_482), .B(n_32_15), .ZN(n_32_483));
   INV_X1_LVT i_32_449 (.A(n_32_483), .ZN(n_32_484));
   NAND2_X1_LVT i_32_95 (.A1(op2_xp[5]), .A2(op1[10]), .ZN(n_32_95));
   NAND2_X1_LVT i_32_79 (.A1(op2_xp[4]), .A2(op1[11]), .ZN(n_32_79));
   XNOR2_X1_LVT i_32_440 (.A(n_32_95), .B(n_32_79), .ZN(n_32_475));
   NAND2_X1_LVT i_32_63 (.A1(op2_xp[3]), .A2(op1[12]), .ZN(n_32_63));
   XNOR2_X1_LVT i_32_441 (.A(n_32_475), .B(n_32_63), .ZN(n_32_476));
   INV_X1_LVT i_32_442 (.A(n_32_476), .ZN(n_32_477));
   FA_X1_LVT i_32_455 (.A(n_32_460), .B(n_32_484), .CI(n_32_477), .CO(n_32_492), 
      .S(n_32_491));
   NAND2_X1_LVT i_32_143 (.A1(op2_xp[8]), .A2(op1[7]), .ZN(n_32_143));
   NAND2_X1_LVT i_32_127 (.A1(op2_xp[7]), .A2(op1[8]), .ZN(n_32_127));
   XNOR2_X1_LVT i_32_432 (.A(n_32_143), .B(n_32_127), .ZN(n_32_467));
   NAND2_X1_LVT i_32_111 (.A1(op2_xp[6]), .A2(op1[9]), .ZN(n_32_111));
   XNOR2_X1_LVT i_32_433 (.A(n_32_467), .B(n_32_111), .ZN(n_32_468));
   NOR2_X1_LVT i_32_425 (.A1(n_32_30), .A2(n_32_46), .ZN(n_32_456));
   NOR2_X1_LVT i_32_426 (.A1(n_32_14), .A2(n_32_46), .ZN(n_32_457));
   NOR2_X1_LVT i_32_427 (.A1(n_32_14), .A2(n_32_30), .ZN(n_32_458));
   OR3_X1_LVT i_32_424 (.A1(n_32_456), .A2(n_32_457), .A3(n_32_458), .ZN(
      n_32_455));
   NOR2_X1_LVT i_32_418 (.A1(n_32_78), .A2(n_32_94), .ZN(n_32_449));
   NOR2_X1_LVT i_32_419 (.A1(n_32_62), .A2(n_32_94), .ZN(n_32_450));
   NOR2_X1_LVT i_32_420 (.A1(n_32_62), .A2(n_32_78), .ZN(n_32_451));
   OR3_X1_LVT i_32_417 (.A1(n_32_449), .A2(n_32_450), .A3(n_32_451), .ZN(
      n_32_448));
   INV_X1_LVT i_32_410 (.A(n_32_126), .ZN(n_32_441));
   NAND2_X1_LVT i_32_409 (.A1(n_32_142), .A2(n_32_441), .ZN(n_32_440));
   INV_X1_LVT i_32_412 (.A(n_32_110), .ZN(n_32_443));
   NAND2_X1_LVT i_32_411 (.A1(n_32_142), .A2(n_32_443), .ZN(n_32_442));
   OR2_X1_LVT i_32_413 (.A1(n_32_110), .A2(n_32_126), .ZN(n_32_444));
   NAND3_X1_LVT i_32_408 (.A1(n_32_440), .A2(n_32_442), .A3(n_32_444), .ZN(
      n_32_439));
   FA_X1_LVT i_32_454 (.A(n_32_455), .B(n_32_448), .CI(n_32_439), .CO(n_32_490), 
      .S(n_32_489));
   FA_X1_LVT i_32_456 (.A(n_32_468), .B(n_32_489), .CI(n_32_462), .CO(n_32_494), 
      .S(n_32_493));
   FA_X1_LVT i_32_457 (.A(n_32_464), .B(n_32_491), .CI(n_32_493), .CO(n_32_496), 
      .S(n_32_495));
   XNOR2_X1_LVT i_32_354 (.A(n_32_140), .B(n_32_124), .ZN(n_32_377));
   XNOR2_X1_LVT i_32_355 (.A(n_32_377), .B(n_32_108), .ZN(n_32_378));
   NAND2_X1_LVT i_32_25 (.A1(op2_xp[1]), .A2(op1[8]), .ZN(n_32_25));
   NAND2_X1_LVT i_32_41 (.A1(op2_xp[2]), .A2(op1[7]), .ZN(n_32_41));
   NOR2_X1_LVT i_32_295 (.A1(n_32_25), .A2(n_32_41), .ZN(n_32_306));
   NAND2_X1_LVT i_32_9 (.A1(op2_xp[0]), .A2(op1[9]), .ZN(n_32_9));
   NOR2_X1_LVT i_32_296 (.A1(n_32_9), .A2(n_32_41), .ZN(n_32_307));
   NOR2_X1_LVT i_32_297 (.A1(n_32_9), .A2(n_32_25), .ZN(n_32_308));
   OR3_X1_LVT i_32_294 (.A1(n_32_306), .A2(n_32_307), .A3(n_32_308), .ZN(
      n_32_305));
   NAND2_X1_LVT i_32_73 (.A1(op2_xp[4]), .A2(op1[5]), .ZN(n_32_73));
   NAND2_X1_LVT i_32_89 (.A1(op2_xp[5]), .A2(op1[4]), .ZN(n_32_89));
   NOR2_X1_LVT i_32_288 (.A1(n_32_73), .A2(n_32_89), .ZN(n_32_299));
   NAND2_X1_LVT i_32_57 (.A1(op2_xp[3]), .A2(op1[6]), .ZN(n_32_57));
   NOR2_X1_LVT i_32_289 (.A1(n_32_57), .A2(n_32_89), .ZN(n_32_300));
   NOR2_X1_LVT i_32_290 (.A1(n_32_57), .A2(n_32_73), .ZN(n_32_301));
   OR3_X1_LVT i_32_287 (.A1(n_32_299), .A2(n_32_300), .A3(n_32_301), .ZN(
      n_32_298));
   NAND2_X1_LVT i_32_137 (.A1(op2_xp[8]), .A2(op1[1]), .ZN(n_32_137));
   NAND2_X1_LVT i_32_121 (.A1(op2_xp[7]), .A2(op1[2]), .ZN(n_32_121));
   INV_X1_LVT i_32_280 (.A(n_32_121), .ZN(n_32_291));
   NAND2_X1_LVT i_32_279 (.A1(n_32_137), .A2(n_32_291), .ZN(n_32_290));
   NAND2_X1_LVT i_32_105 (.A1(op2_xp[6]), .A2(op1[3]), .ZN(n_32_105));
   INV_X1_LVT i_32_282 (.A(n_32_105), .ZN(n_32_293));
   NAND2_X1_LVT i_32_281 (.A1(n_32_137), .A2(n_32_293), .ZN(n_32_292));
   OR2_X1_LVT i_32_283 (.A1(n_32_105), .A2(n_32_121), .ZN(n_32_294));
   NAND3_X1_LVT i_32_278 (.A1(n_32_290), .A2(n_32_292), .A3(n_32_294), .ZN(
      n_32_289));
   FA_X1_LVT i_32_324 (.A(n_32_305), .B(n_32_298), .CI(n_32_289), .CO(n_32_340), 
      .S(n_32_339));
   XNOR2_X1_LVT i_32_343 (.A(n_32_43), .B(n_32_27), .ZN(n_32_362));
   XNOR2_X1_LVT i_32_344 (.A(n_32_362), .B(n_32_11), .ZN(n_32_363));
   INV_X1_LVT i_32_345 (.A(n_32_363), .ZN(n_32_364));
   XNOR2_X1_LVT i_32_336 (.A(n_32_91), .B(n_32_75), .ZN(n_32_355));
   XNOR2_X1_LVT i_32_337 (.A(n_32_355), .B(n_32_59), .ZN(n_32_356));
   INV_X1_LVT i_32_338 (.A(n_32_356), .ZN(n_32_357));
   FA_X1_LVT i_32_351 (.A(n_32_340), .B(n_32_364), .CI(n_32_357), .CO(n_32_372), 
      .S(n_32_371));
   FA_X1_LVT i_32_378 (.A(n_32_378), .B(n_32_399), .CI(n_32_372), .CO(n_32_404), 
      .S(n_32_403));
   FA_X1_LVT i_32_405 (.A(n_32_404), .B(n_32_431), .CI(n_32_433), .CO(n_32_436), 
      .S(n_32_435));
   XNOR2_X1_LVT i_32_328 (.A(n_32_139), .B(n_32_123), .ZN(n_32_347));
   XNOR2_X1_LVT i_32_329 (.A(n_32_347), .B(n_32_107), .ZN(n_32_348));
   NAND2_X1_LVT i_32_40 (.A1(op2_xp[2]), .A2(op1[6]), .ZN(n_32_40));
   NAND2_X1_LVT i_32_56 (.A1(op2_xp[3]), .A2(op1[5]), .ZN(n_32_56));
   NOR2_X1_LVT i_32_262 (.A1(n_32_40), .A2(n_32_56), .ZN(n_32_270));
   NAND2_X1_LVT i_32_24 (.A1(op2_xp[1]), .A2(op1[7]), .ZN(n_32_24));
   NOR2_X1_LVT i_32_263 (.A1(n_32_24), .A2(n_32_56), .ZN(n_32_271));
   NOR2_X1_LVT i_32_264 (.A1(n_32_24), .A2(n_32_40), .ZN(n_32_272));
   OR3_X1_LVT i_32_261 (.A1(n_32_270), .A2(n_32_271), .A3(n_32_272), .ZN(
      n_32_269));
   NAND2_X1_LVT i_32_88 (.A1(op2_xp[5]), .A2(op1[3]), .ZN(n_32_88));
   NAND2_X1_LVT i_32_104 (.A1(op2_xp[6]), .A2(op1[2]), .ZN(n_32_104));
   NOR2_X1_LVT i_32_255 (.A1(n_32_88), .A2(n_32_104), .ZN(n_32_263));
   NAND2_X1_LVT i_32_72 (.A1(op2_xp[4]), .A2(op1[4]), .ZN(n_32_72));
   NOR2_X1_LVT i_32_256 (.A1(n_32_72), .A2(n_32_104), .ZN(n_32_264));
   NOR2_X1_LVT i_32_257 (.A1(n_32_72), .A2(n_32_88), .ZN(n_32_265));
   OR3_X1_LVT i_32_254 (.A1(n_32_263), .A2(n_32_264), .A3(n_32_265), .ZN(
      n_32_262));
   NAND2_X1_LVT i_32_120 (.A1(op2_xp[7]), .A2(op1[1]), .ZN(n_32_120));
   NAND2_X1_LVT i_32_136 (.A1(op2_xp[8]), .A2(op1[0]), .ZN(n_32_136));
   INV_X1_LVT i_32_250 (.A(n_32_136), .ZN(n_32_258));
   NAND2_X1_LVT i_32_249 (.A1(n_32_120), .A2(n_32_258), .ZN(n_32_257));
   FA_X1_LVT i_32_298 (.A(n_32_269), .B(n_32_262), .CI(n_32_257), .CO(n_32_310), 
      .S(n_32_309));
   XNOR2_X1_LVT i_32_317 (.A(n_32_42), .B(n_32_26), .ZN(n_32_332));
   XNOR2_X1_LVT i_32_318 (.A(n_32_332), .B(n_32_10), .ZN(n_32_333));
   INV_X1_LVT i_32_319 (.A(n_32_333), .ZN(n_32_334));
   XNOR2_X1_LVT i_32_310 (.A(n_32_90), .B(n_32_74), .ZN(n_32_325));
   XNOR2_X1_LVT i_32_311 (.A(n_32_325), .B(n_32_58), .ZN(n_32_326));
   INV_X1_LVT i_32_312 (.A(n_32_326), .ZN(n_32_327));
   FA_X1_LVT i_32_325 (.A(n_32_310), .B(n_32_334), .CI(n_32_327), .CO(n_32_342), 
      .S(n_32_341));
   FA_X1_LVT i_32_352 (.A(n_32_348), .B(n_32_369), .CI(n_32_342), .CO(n_32_374), 
      .S(n_32_373));
   FA_X1_LVT i_32_379 (.A(n_32_374), .B(n_32_401), .CI(n_32_403), .CO(n_32_406), 
      .S(n_32_405));
   XNOR2_X1_LVT i_32_302 (.A(n_32_138), .B(n_32_122), .ZN(n_32_317));
   XNOR2_X1_LVT i_32_303 (.A(n_32_317), .B(n_32_106), .ZN(n_32_318));
   NOR2_X1_LVT i_32_233 (.A1(n_32_55), .A2(n_32_71), .ZN(n_32_238));
   NOR2_X1_LVT i_32_234 (.A1(n_32_39), .A2(n_32_71), .ZN(n_32_239));
   NOR2_X1_LVT i_32_235 (.A1(n_32_39), .A2(n_32_55), .ZN(n_32_240));
   OR3_X1_LVT i_32_232 (.A1(n_32_238), .A2(n_32_239), .A3(n_32_240), .ZN(
      n_32_237));
   NAND2_X1_LVT i_32_8 (.A1(op2_xp[0]), .A2(op1[8]), .ZN(n_32_8));
   INV_X1_LVT i_32_270 (.A(n_32_8), .ZN(n_32_278));
   NAND2_X1_LVT i_32_269 (.A1(n_32_237), .A2(n_32_278), .ZN(n_32_277));
   NOR2_X1_LVT i_32_226 (.A1(n_32_103), .A2(n_32_119), .ZN(n_32_231));
   NOR2_X1_LVT i_32_227 (.A1(n_32_87), .A2(n_32_119), .ZN(n_32_232));
   NOR2_X1_LVT i_32_228 (.A1(n_32_87), .A2(n_32_103), .ZN(n_32_233));
   OR3_X1_LVT i_32_225 (.A1(n_32_231), .A2(n_32_232), .A3(n_32_233), .ZN(
      n_32_230));
   NAND2_X1_LVT i_32_271 (.A1(n_32_230), .A2(n_32_278), .ZN(n_32_279));
   NAND2_X1_LVT i_32_272 (.A1(n_32_230), .A2(n_32_237), .ZN(n_32_280));
   NAND3_X1_LVT i_32_268 (.A1(n_32_277), .A2(n_32_279), .A3(n_32_280), .ZN(
      n_32_276));
   XNOR2_X1_LVT i_32_291 (.A(n_32_41), .B(n_32_25), .ZN(n_32_302));
   XNOR2_X1_LVT i_32_292 (.A(n_32_302), .B(n_32_9), .ZN(n_32_303));
   INV_X1_LVT i_32_293 (.A(n_32_303), .ZN(n_32_304));
   XNOR2_X1_LVT i_32_284 (.A(n_32_89), .B(n_32_73), .ZN(n_32_295));
   XNOR2_X1_LVT i_32_285 (.A(n_32_295), .B(n_32_57), .ZN(n_32_296));
   INV_X1_LVT i_32_286 (.A(n_32_296), .ZN(n_32_297));
   FA_X1_LVT i_32_299 (.A(n_32_276), .B(n_32_304), .CI(n_32_297), .CO(n_32_312), 
      .S(n_32_311));
   FA_X1_LVT i_32_326 (.A(n_32_318), .B(n_32_339), .CI(n_32_312), .CO(n_32_344), 
      .S(n_32_343));
   FA_X1_LVT i_32_353 (.A(n_32_344), .B(n_32_371), .CI(n_32_373), .CO(n_32_376), 
      .S(n_32_375));
   XNOR2_X1_LVT i_32_276 (.A(n_32_137), .B(n_32_121), .ZN(n_32_287));
   XNOR2_X1_LVT i_32_277 (.A(n_32_287), .B(n_32_105), .ZN(n_32_288));
   OR2_X1_LVT i_32_239 (.A1(n_32_7), .A2(n_32_23), .ZN(n_32_244));
   INV_X1_LVT i_32_241 (.A(n_32_23), .ZN(n_32_246));
   NAND2_X1_LVT i_32_240 (.A1(n_32_211), .A2(n_32_246), .ZN(n_32_245));
   INV_X1_LVT i_32_243 (.A(n_32_7), .ZN(n_32_248));
   NAND2_X1_LVT i_32_242 (.A1(n_32_211), .A2(n_32_248), .ZN(n_32_247));
   NAND3_X1_LVT i_32_238 (.A1(n_32_244), .A2(n_32_245), .A3(n_32_247), .ZN(
      n_32_243));
   XNOR2_X1_LVT i_32_258 (.A(n_32_56), .B(n_32_40), .ZN(n_32_266));
   XNOR2_X1_LVT i_32_259 (.A(n_32_266), .B(n_32_24), .ZN(n_32_267));
   INV_X1_LVT i_32_260 (.A(n_32_267), .ZN(n_32_268));
   XNOR2_X1_LVT i_32_251 (.A(n_32_104), .B(n_32_88), .ZN(n_32_259));
   XNOR2_X1_LVT i_32_252 (.A(n_32_259), .B(n_32_72), .ZN(n_32_260));
   INV_X1_LVT i_32_253 (.A(n_32_260), .ZN(n_32_261));
   FA_X1_LVT i_32_273 (.A(n_32_243), .B(n_32_268), .CI(n_32_261), .CO(n_32_282), 
      .S(n_32_281));
   FA_X1_LVT i_32_300 (.A(n_32_288), .B(n_32_309), .CI(n_32_282), .CO(n_32_314), 
      .S(n_32_313));
   FA_X1_LVT i_32_327 (.A(n_32_314), .B(n_32_341), .CI(n_32_343), .CO(n_32_346), 
      .S(n_32_345));
   XNOR2_X1_LVT i_32_247 (.A(n_32_136), .B(n_32_120), .ZN(n_32_255));
   INV_X1_LVT i_32_248 (.A(n_32_255), .ZN(n_32_256));
   XNOR2_X1_LVT i_32_265 (.A(n_32_8), .B(n_32_237), .ZN(n_32_273));
   XNOR2_X1_LVT i_32_266 (.A(n_32_273), .B(n_32_230), .ZN(n_32_274));
   INV_X1_LVT i_32_267 (.A(n_32_274), .ZN(n_32_275));
   FA_X1_LVT i_32_274 (.A(n_32_256), .B(n_32_275), .CI(n_32_250), .CO(n_32_284), 
      .S(n_32_283));
   FA_X1_LVT i_32_301 (.A(n_32_284), .B(n_32_311), .CI(n_32_313), .CO(n_32_316), 
      .S(n_32_315));
   FA_X1_LVT i_32_275 (.A(n_32_254), .B(n_32_252), .CI(n_32_281), .CO(n_32_286), 
      .S(n_32_285));
   FA_X1_LVT i_32_602 (.A(n_32_283), .B(n_32_285), .CI(n_32_658), .CO(n_32_659), 
      .S(n_50));
   FA_X1_LVT i_32_603 (.A(n_32_286), .B(n_32_315), .CI(n_32_659), .CO(n_32_660), 
      .S(n_51));
   FA_X1_LVT i_32_604 (.A(n_32_316), .B(n_32_345), .CI(n_32_660), .CO(n_32_661), 
      .S(n_52));
   FA_X1_LVT i_32_605 (.A(n_32_346), .B(n_32_375), .CI(n_32_661), .CO(n_32_662), 
      .S(n_53));
   FA_X1_LVT i_32_606 (.A(n_32_376), .B(n_32_405), .CI(n_32_662), .CO(n_32_663), 
      .S(n_54));
   FA_X1_LVT i_32_607 (.A(n_32_406), .B(n_32_435), .CI(n_32_663), .CO(n_32_664), 
      .S(n_55));
   FA_X1_LVT i_32_608 (.A(n_32_436), .B(n_32_465), .CI(n_32_664), .CO(n_32_665), 
      .S(n_56));
   FA_X1_LVT i_32_609 (.A(n_32_466), .B(n_32_495), .CI(n_32_665), .CO(n_32_666), 
      .S(n_57));
   INV_X1_LVT i_34_31 (.A(n_57), .ZN(n_34_16));
   OAI22_X1_LVT i_34_32 (.A1(n_34_8), .A2(n_34_7), .B1(n_34_16), .B2(cycle[0]), 
      .ZN(product_xp[15]));
   INV_X1_LVT i_34_12 (.A(n_48), .ZN(n_34_6));
   INV_X1_LVT i_34_29 (.A(n_56), .ZN(n_34_15));
   OAI22_X1_LVT i_34_30 (.A1(n_34_8), .A2(n_34_6), .B1(n_34_15), .B2(cycle[0]), 
      .ZN(product_xp[14]));
   AOI22_X1_LVT i_45_29 (.A1(n_45_0), .A2(n_136), .B1(reslo_wr), .B2(
      per_din_msk[14]), .ZN(n_45_15));
   INV_X1_LVT i_45_30 (.A(n_45_15), .ZN(n_119));
   OR2_X1_LVT i_23_0 (.A1(cycle[0]), .A2(cycle[1]), .ZN(result_wr));
   INV_X1_LVT i_39_1 (.A(result_wr), .ZN(n_39_1));
   INV_X1_LVT i_39_0 (.A(result_clr), .ZN(n_39_0));
   NAND2_X1_LVT i_39_2 (.A1(n_39_1), .A2(n_39_0), .ZN(n_69));
   INV_X1_LVT i_46_1 (.A(n_69), .ZN(n_46_1));
   INV_X1_LVT i_46_0 (.A(reslo_wr), .ZN(n_46_0));
   NAND2_X1_LVT i_46_2 (.A1(n_46_1), .A2(n_46_0), .ZN(n_121));
   CLKGATETST_X1_LVT clk_gate_reslo_reg (.CK(mclk), .E(n_121), .SE(1'b0), 
      .GCK(n_88));
   DFFR_X1_LVT \reslo_reg[14]  (.D(n_119), .RN(n_38), .CK(n_88), .Q(n_90), .QN());
   INV_X1_LVT i_34_10 (.A(n_47), .ZN(n_34_5));
   INV_X1_LVT i_34_27 (.A(n_55), .ZN(n_34_14));
   OAI22_X1_LVT i_34_28 (.A1(n_34_8), .A2(n_34_5), .B1(n_34_14), .B2(cycle[0]), 
      .ZN(product_xp[13]));
   AOI22_X1_LVT i_45_27 (.A1(n_45_0), .A2(n_135), .B1(reslo_wr), .B2(
      per_din_msk[13]), .ZN(n_45_14));
   INV_X1_LVT i_45_28 (.A(n_45_14), .ZN(n_118));
   DFFR_X1_LVT \reslo_reg[13]  (.D(n_118), .RN(n_38), .CK(n_88), .Q(n_91), .QN());
   INV_X1_LVT i_34_8 (.A(n_46), .ZN(n_34_4));
   INV_X1_LVT i_34_25 (.A(n_54), .ZN(n_34_13));
   OAI22_X1_LVT i_34_26 (.A1(n_34_8), .A2(n_34_4), .B1(n_34_13), .B2(cycle[0]), 
      .ZN(product_xp[12]));
   AOI22_X1_LVT i_45_25 (.A1(n_45_0), .A2(n_134), .B1(reslo_wr), .B2(
      per_din_msk[12]), .ZN(n_45_13));
   INV_X1_LVT i_45_26 (.A(n_45_13), .ZN(n_117));
   DFFR_X1_LVT \reslo_reg[12]  (.D(n_117), .RN(n_38), .CK(n_88), .Q(n_92), .QN());
   INV_X1_LVT i_34_6 (.A(n_45), .ZN(n_34_3));
   INV_X1_LVT i_34_23 (.A(n_53), .ZN(n_34_12));
   OAI22_X1_LVT i_34_24 (.A1(n_34_8), .A2(n_34_3), .B1(n_34_12), .B2(cycle[0]), 
      .ZN(product_xp[11]));
   AOI22_X1_LVT i_45_23 (.A1(n_45_0), .A2(n_133), .B1(reslo_wr), .B2(
      per_din_msk[11]), .ZN(n_45_12));
   INV_X1_LVT i_45_24 (.A(n_45_12), .ZN(n_116));
   DFFR_X1_LVT \reslo_reg[11]  (.D(n_116), .RN(n_38), .CK(n_88), .Q(n_93), .QN());
   XNOR2_X1_LVT i_32_589 (.A(n_32_2), .B(n_32_153), .ZN(n_32_647));
   XNOR2_X1_LVT i_32_590 (.A(n_32_647), .B(n_32_646), .ZN(n_32_648));
   INV_X1_LVT i_32_591 (.A(n_32_648), .ZN(n_44));
   INV_X1_LVT i_34_4 (.A(n_44), .ZN(n_34_2));
   INV_X1_LVT i_34_21 (.A(n_52), .ZN(n_34_11));
   OAI22_X1_LVT i_34_22 (.A1(n_34_8), .A2(n_34_2), .B1(n_34_11), .B2(cycle[0]), 
      .ZN(product_xp[10]));
   AOI22_X1_LVT i_45_21 (.A1(n_45_0), .A2(n_132), .B1(reslo_wr), .B2(
      per_din_msk[10]), .ZN(n_45_11));
   INV_X1_LVT i_45_22 (.A(n_45_11), .ZN(n_115));
   DFFR_X1_LVT \reslo_reg[10]  (.D(n_115), .RN(n_38), .CK(n_88), .Q(n_94), .QN());
   XNOR2_X1_LVT i_32_586 (.A(n_32_17), .B(n_32_1), .ZN(n_32_645));
   INV_X1_LVT i_32_587 (.A(n_32_645), .ZN(n_43));
   INV_X1_LVT i_34_2 (.A(n_43), .ZN(n_34_1));
   INV_X1_LVT i_34_19 (.A(n_51), .ZN(n_34_10));
   OAI22_X1_LVT i_34_20 (.A1(n_34_8), .A2(n_34_1), .B1(n_34_10), .B2(cycle[0]), 
      .ZN(product_xp[9]));
   AOI22_X1_LVT i_45_19 (.A1(n_45_0), .A2(n_131), .B1(reslo_wr), .B2(
      per_din_msk[9]), .ZN(n_45_10));
   INV_X1_LVT i_45_20 (.A(n_45_10), .ZN(n_114));
   DFFR_X1_LVT \reslo_reg[9]  (.D(n_114), .RN(n_38), .CK(n_88), .Q(n_95), .QN());
   NAND2_X1_LVT i_32_0 (.A1(op2_xp[0]), .A2(op1[0]), .ZN(n_32_0));
   INV_X1_LVT i_32_585 (.A(n_32_0), .ZN(n_42));
   INV_X1_LVT i_34_0 (.A(n_42), .ZN(n_34_0));
   INV_X1_LVT i_34_17 (.A(n_50), .ZN(n_34_9));
   OAI22_X1_LVT i_34_18 (.A1(n_34_0), .A2(n_34_8), .B1(n_34_9), .B2(cycle[0]), 
      .ZN(product_xp[8]));
   AOI22_X1_LVT i_45_17 (.A1(n_45_0), .A2(n_130), .B1(reslo_wr), .B2(
      per_din_msk[8]), .ZN(n_45_9));
   INV_X1_LVT i_45_18 (.A(n_45_9), .ZN(n_113));
   DFFR_X1_LVT \reslo_reg[8]  (.D(n_113), .RN(n_38), .CK(n_88), .Q(n_96), .QN());
   NOR2_X1_LVT i_34_15 (.A1(n_34_7), .A2(cycle[0]), .ZN(product_xp[7]));
   AOI22_X1_LVT i_45_15 (.A1(n_45_0), .A2(n_129), .B1(reslo_wr), .B2(per_din[7]), 
      .ZN(n_45_8));
   INV_X1_LVT i_45_16 (.A(n_45_8), .ZN(n_112));
   DFFR_X1_LVT \reslo_reg[7]  (.D(n_112), .RN(n_38), .CK(n_88), .Q(n_97), .QN());
   NOR2_X1_LVT i_34_13 (.A1(n_34_6), .A2(cycle[0]), .ZN(product_xp[6]));
   AOI22_X1_LVT i_45_13 (.A1(n_45_0), .A2(n_128), .B1(reslo_wr), .B2(per_din[6]), 
      .ZN(n_45_7));
   INV_X1_LVT i_45_14 (.A(n_45_7), .ZN(n_111));
   DFFR_X1_LVT \reslo_reg[6]  (.D(n_111), .RN(n_38), .CK(n_88), .Q(n_98), .QN());
   NOR2_X1_LVT i_34_11 (.A1(n_34_5), .A2(cycle[0]), .ZN(product_xp[5]));
   AOI22_X1_LVT i_45_11 (.A1(n_45_0), .A2(n_127), .B1(reslo_wr), .B2(per_din[5]), 
      .ZN(n_45_6));
   INV_X1_LVT i_45_12 (.A(n_45_6), .ZN(n_110));
   DFFR_X1_LVT \reslo_reg[5]  (.D(n_110), .RN(n_38), .CK(n_88), .Q(n_99), .QN());
   NOR2_X1_LVT i_34_9 (.A1(n_34_4), .A2(cycle[0]), .ZN(product_xp[4]));
   AOI22_X1_LVT i_45_9 (.A1(n_45_0), .A2(n_126), .B1(reslo_wr), .B2(per_din[4]), 
      .ZN(n_45_5));
   INV_X1_LVT i_45_10 (.A(n_45_5), .ZN(n_109));
   DFFR_X1_LVT \reslo_reg[4]  (.D(n_109), .RN(n_38), .CK(n_88), .Q(n_100), .QN());
   NOR2_X1_LVT i_34_7 (.A1(n_34_3), .A2(cycle[0]), .ZN(product_xp[3]));
   AOI22_X1_LVT i_45_7 (.A1(n_45_0), .A2(n_125), .B1(reslo_wr), .B2(per_din[3]), 
      .ZN(n_45_4));
   INV_X1_LVT i_45_8 (.A(n_45_4), .ZN(n_108));
   DFFR_X1_LVT \reslo_reg[3]  (.D(n_108), .RN(n_38), .CK(n_88), .Q(n_101), .QN());
   NOR2_X1_LVT i_34_5 (.A1(n_34_2), .A2(cycle[0]), .ZN(product_xp[2]));
   AOI22_X1_LVT i_45_5 (.A1(n_45_0), .A2(n_124), .B1(reslo_wr), .B2(per_din[2]), 
      .ZN(n_45_3));
   INV_X1_LVT i_45_6 (.A(n_45_3), .ZN(n_107));
   DFFR_X1_LVT \reslo_reg[2]  (.D(n_107), .RN(n_38), .CK(n_88), .Q(n_102), .QN());
   NOR2_X1_LVT i_34_3 (.A1(n_34_1), .A2(cycle[0]), .ZN(product_xp[1]));
   AOI22_X1_LVT i_45_3 (.A1(n_45_0), .A2(n_123), .B1(reslo_wr), .B2(per_din[1]), 
      .ZN(n_45_2));
   INV_X1_LVT i_45_4 (.A(n_45_2), .ZN(n_106));
   DFFR_X1_LVT \reslo_reg[1]  (.D(n_106), .RN(n_38), .CK(n_88), .Q(n_103), .QN());
   NOR2_X1_LVT i_34_1 (.A1(n_34_0), .A2(cycle[0]), .ZN(product_xp[0]));
   AOI22_X1_LVT i_45_1 (.A1(n_45_0), .A2(n_122), .B1(per_din[0]), .B2(reslo_wr), 
      .ZN(n_45_1));
   INV_X1_LVT i_45_2 (.A(n_45_1), .ZN(n_105));
   DFFR_X1_LVT \reslo_reg[0]  (.D(n_105), .RN(n_38), .CK(n_88), .Q(n_104), .QN());
   HA_X1_LVT i_48_0 (.A(product_xp[0]), .B(n_104), .CO(n_48_0), .S(n_122));
   FA_X1_LVT i_48_1 (.A(product_xp[1]), .B(n_103), .CI(n_48_0), .CO(n_48_1), 
      .S(n_123));
   FA_X1_LVT i_48_2 (.A(product_xp[2]), .B(n_102), .CI(n_48_1), .CO(n_48_2), 
      .S(n_124));
   FA_X1_LVT i_48_3 (.A(product_xp[3]), .B(n_101), .CI(n_48_2), .CO(n_48_3), 
      .S(n_125));
   FA_X1_LVT i_48_4 (.A(product_xp[4]), .B(n_100), .CI(n_48_3), .CO(n_48_4), 
      .S(n_126));
   FA_X1_LVT i_48_5 (.A(product_xp[5]), .B(n_99), .CI(n_48_4), .CO(n_48_5), 
      .S(n_127));
   FA_X1_LVT i_48_6 (.A(product_xp[6]), .B(n_98), .CI(n_48_5), .CO(n_48_6), 
      .S(n_128));
   FA_X1_LVT i_48_7 (.A(product_xp[7]), .B(n_97), .CI(n_48_6), .CO(n_48_7), 
      .S(n_129));
   FA_X1_LVT i_48_8 (.A(product_xp[8]), .B(n_96), .CI(n_48_7), .CO(n_48_8), 
      .S(n_130));
   FA_X1_LVT i_48_9 (.A(product_xp[9]), .B(n_95), .CI(n_48_8), .CO(n_48_9), 
      .S(n_131));
   FA_X1_LVT i_48_10 (.A(product_xp[10]), .B(n_94), .CI(n_48_9), .CO(n_48_10), 
      .S(n_132));
   FA_X1_LVT i_48_11 (.A(product_xp[11]), .B(n_93), .CI(n_48_10), .CO(n_48_11), 
      .S(n_133));
   FA_X1_LVT i_48_12 (.A(product_xp[12]), .B(n_92), .CI(n_48_11), .CO(n_48_12), 
      .S(n_134));
   FA_X1_LVT i_48_13 (.A(product_xp[13]), .B(n_91), .CI(n_48_12), .CO(n_48_13), 
      .S(n_135));
   FA_X1_LVT i_48_14 (.A(product_xp[14]), .B(n_90), .CI(n_48_13), .CO(n_48_14), 
      .S(n_136));
   FA_X1_LVT i_48_15 (.A(product_xp[15]), .B(n_89), .CI(n_48_14), .CO(n_48_15), 
      .S(n_137));
   AOI22_X1_LVT i_45_31 (.A1(n_45_0), .A2(n_137), .B1(reslo_wr), .B2(
      per_din_msk[15]), .ZN(n_45_16));
   INV_X1_LVT i_45_32 (.A(n_45_16), .ZN(n_120));
   DFFR_X1_LVT \reslo_reg[15]  (.D(n_120), .RN(n_38), .CK(n_88), .Q(n_89), .QN());
   AOI22_X1_LVT i_60_93 (.A1(n_60_0), .A2(n_89), .B1(cycle[1]), .B2(n_137), 
      .ZN(n_60_78));
   NOR2_X1_LVT i_1_0 (.A1(per_we[0]), .A2(per_we[1]), .ZN(n_0));
   AND2_X1_LVT i_2_0 (.A1(n_0), .A2(reg_sel), .ZN(reg_read));
   AND2_X1_LVT i_4_5 (.A1(reg_read), .A2(n_6), .ZN(n_13));
   INV_X1_LVT i_60_2 (.A(n_13), .ZN(n_60_2));
   NOR2_X1_LVT i_60_94 (.A1(n_60_78), .A2(n_60_2), .ZN(n_60_79));
   AND2_X1_LVT i_4_0 (.A1(n_1), .A2(reg_read), .ZN(n_9));
   AND2_X1_LVT i_4_3 (.A1(reg_read), .A2(n_4), .ZN(n_11));
   AND2_X1_LVT i_4_2 (.A1(reg_read), .A2(n_3), .ZN(reg_rd1));
   AND2_X1_LVT i_4_1 (.A1(reg_read), .A2(n_2), .ZN(n_10));
   OR4_X1_LVT i_59_0 (.A1(n_9), .A2(n_11), .A3(reg_rd1), .A4(n_10), .ZN(n_150));
   AND2_X1_LVT i_60_95 (.A1(n_150), .A2(op1[15]), .ZN(n_60_80));
   INV_X1_LVT i_57_0 (.A(cycle[1]), .ZN(n_57_0));
   INV_X1_LVT i_52_0 (.A(op2_wr), .ZN(n_52_0));
   NAND2_X1_LVT i_32_151 (.A1(op2_xp[8]), .A2(op1[15]), .ZN(n_32_151));
   AND2_X1_LVT i_31_0 (.A1(op1[15]), .A2(sign_sel), .ZN(op1_xp[16]));
   NAND2_X1_LVT i_32_135 (.A1(op2_xp[7]), .A2(op1_xp[16]), .ZN(n_32_135));
   XNOR2_X1_LVT i_32_583 (.A(n_32_151), .B(n_32_135), .ZN(n_32_643));
   NAND2_X1_LVT i_32_150 (.A1(op2_xp[8]), .A2(op1[14]), .ZN(n_32_150));
   NAND2_X1_LVT i_32_134 (.A1(op2_xp[7]), .A2(op1[15]), .ZN(n_32_134));
   INV_X1_LVT i_32_579 (.A(n_32_134), .ZN(n_32_638));
   NAND2_X1_LVT i_32_578 (.A1(n_32_150), .A2(n_32_638), .ZN(n_32_637));
   NAND2_X1_LVT i_32_118 (.A1(op2_xp[6]), .A2(op1_xp[16]), .ZN(n_32_118));
   NAND2_X1_LVT i_32_580 (.A1(n_32_118), .A2(n_32_150), .ZN(n_32_639));
   NAND2_X1_LVT i_32_581 (.A1(n_32_118), .A2(n_32_638), .ZN(n_32_640));
   NAND3_X1_LVT i_32_577 (.A1(n_32_637), .A2(n_32_639), .A3(n_32_640), .ZN(
      n_32_636));
   XNOR2_X1_LVT i_32_584 (.A(n_32_643), .B(n_32_636), .ZN(n_32_644));
   NAND2_X1_LVT i_32_149 (.A1(op2_xp[8]), .A2(op1[13]), .ZN(n_32_149));
   NAND2_X1_LVT i_32_133 (.A1(op2_xp[7]), .A2(op1[14]), .ZN(n_32_133));
   INV_X1_LVT i_32_568 (.A(n_32_133), .ZN(n_32_625));
   NAND2_X1_LVT i_32_567 (.A1(n_32_149), .A2(n_32_625), .ZN(n_32_624));
   NAND2_X1_LVT i_32_117 (.A1(op2_xp[6]), .A2(op1[15]), .ZN(n_32_117));
   INV_X1_LVT i_32_570 (.A(n_32_117), .ZN(n_32_627));
   NAND2_X1_LVT i_32_569 (.A1(n_32_149), .A2(n_32_627), .ZN(n_32_626));
   OR2_X1_LVT i_32_571 (.A1(n_32_117), .A2(n_32_133), .ZN(n_32_628));
   NAND3_X1_LVT i_32_566 (.A1(n_32_624), .A2(n_32_626), .A3(n_32_628), .ZN(
      n_32_623));
   NAND2_X1_LVT i_32_101 (.A1(op2_xp[5]), .A2(op1_xp[16]), .ZN(n_32_101));
   NAND2_X1_LVT i_32_148 (.A1(op2_xp[8]), .A2(op1[12]), .ZN(n_32_148));
   NAND2_X1_LVT i_32_132 (.A1(op2_xp[7]), .A2(op1[13]), .ZN(n_32_132));
   INV_X1_LVT i_32_550 (.A(n_32_132), .ZN(n_32_605));
   NAND2_X1_LVT i_32_549 (.A1(n_32_148), .A2(n_32_605), .ZN(n_32_604));
   NAND2_X1_LVT i_32_116 (.A1(op2_xp[6]), .A2(op1[14]), .ZN(n_32_116));
   INV_X1_LVT i_32_552 (.A(n_32_116), .ZN(n_32_607));
   NAND2_X1_LVT i_32_551 (.A1(n_32_148), .A2(n_32_607), .ZN(n_32_606));
   OR2_X1_LVT i_32_553 (.A1(n_32_116), .A2(n_32_132), .ZN(n_32_608));
   NAND3_X1_LVT i_32_548 (.A1(n_32_604), .A2(n_32_606), .A3(n_32_608), .ZN(
      n_32_603));
   NAND2_X1_LVT i_32_84 (.A1(op2_xp[4]), .A2(op1_xp[16]), .ZN(n_32_84));
   NAND2_X1_LVT i_32_100 (.A1(op2_xp[5]), .A2(op1[15]), .ZN(n_32_100));
   INV_X1_LVT i_32_559 (.A(n_32_100), .ZN(n_32_614));
   NAND2_X1_LVT i_32_558 (.A1(n_32_84), .A2(n_32_614), .ZN(n_32_613));
   NAND2_X1_LVT i_32_83 (.A1(op2_xp[4]), .A2(op1[15]), .ZN(n_32_83));
   NAND2_X1_LVT i_32_99 (.A1(op2_xp[5]), .A2(op1[14]), .ZN(n_32_99));
   OR2_X1_LVT i_32_538 (.A1(n_32_83), .A2(n_32_99), .ZN(n_32_590));
   NAND2_X1_LVT i_32_67 (.A1(op2_xp[3]), .A2(op1_xp[16]), .ZN(n_32_67));
   INV_X1_LVT i_32_540 (.A(n_32_99), .ZN(n_32_592));
   NAND2_X1_LVT i_32_539 (.A1(n_32_67), .A2(n_32_592), .ZN(n_32_591));
   INV_X1_LVT i_32_542 (.A(n_32_83), .ZN(n_32_594));
   NAND2_X1_LVT i_32_541 (.A1(n_32_67), .A2(n_32_594), .ZN(n_32_593));
   NAND3_X1_LVT i_32_537 (.A1(n_32_590), .A2(n_32_591), .A3(n_32_593), .ZN(
      n_32_589));
   NAND2_X1_LVT i_32_560 (.A1(n_32_589), .A2(n_32_614), .ZN(n_32_615));
   NAND2_X1_LVT i_32_561 (.A1(n_32_589), .A2(n_32_84), .ZN(n_32_616));
   NAND3_X1_LVT i_32_557 (.A1(n_32_613), .A2(n_32_615), .A3(n_32_616), .ZN(
      n_32_612));
   FA_X1_LVT i_32_572 (.A(n_32_101), .B(n_32_603), .CI(n_32_612), .CO(n_32_630), 
      .S(n_32_629));
   XNOR2_X1_LVT i_32_574 (.A(n_32_150), .B(n_32_134), .ZN(n_32_633));
   XNOR2_X1_LVT i_32_575 (.A(n_32_633), .B(n_32_118), .ZN(n_32_634));
   INV_X1_LVT i_32_576 (.A(n_32_634), .ZN(n_32_635));
   FA_X1_LVT i_32_582 (.A(n_32_623), .B(n_32_630), .CI(n_32_635), .CO(n_32_642), 
      .S(n_32_641));
   XNOR2_X1_LVT i_32_617 (.A(n_32_644), .B(n_32_642), .ZN(n_32_674));
   XNOR2_X1_LVT i_32_564 (.A(n_32_149), .B(n_32_133), .ZN(n_32_621));
   XNOR2_X1_LVT i_32_565 (.A(n_32_621), .B(n_32_117), .ZN(n_32_622));
   NAND2_X1_LVT i_32_147 (.A1(op2_xp[8]), .A2(op1[11]), .ZN(n_32_147));
   NAND2_X1_LVT i_32_131 (.A1(op2_xp[7]), .A2(op1[12]), .ZN(n_32_131));
   INV_X1_LVT i_32_531 (.A(n_32_131), .ZN(n_32_583));
   NAND2_X1_LVT i_32_530 (.A1(n_32_147), .A2(n_32_583), .ZN(n_32_582));
   NAND2_X1_LVT i_32_115 (.A1(op2_xp[6]), .A2(op1[13]), .ZN(n_32_115));
   INV_X1_LVT i_32_533 (.A(n_32_115), .ZN(n_32_585));
   NAND2_X1_LVT i_32_532 (.A1(n_32_147), .A2(n_32_585), .ZN(n_32_584));
   OR2_X1_LVT i_32_534 (.A1(n_32_115), .A2(n_32_131), .ZN(n_32_586));
   NAND3_X1_LVT i_32_529 (.A1(n_32_582), .A2(n_32_584), .A3(n_32_586), .ZN(
      n_32_581));
   NAND2_X1_LVT i_32_82 (.A1(op2_xp[4]), .A2(op1[14]), .ZN(n_32_82));
   NAND2_X1_LVT i_32_98 (.A1(op2_xp[5]), .A2(op1[13]), .ZN(n_32_98));
   NOR2_X1_LVT i_32_520 (.A1(n_32_82), .A2(n_32_98), .ZN(n_32_568));
   NAND2_X1_LVT i_32_66 (.A1(op2_xp[3]), .A2(op1[15]), .ZN(n_32_66));
   NOR2_X1_LVT i_32_521 (.A1(n_32_66), .A2(n_32_98), .ZN(n_32_569));
   NOR2_X1_LVT i_32_522 (.A1(n_32_66), .A2(n_32_82), .ZN(n_32_570));
   OR3_X1_LVT i_32_519 (.A1(n_32_568), .A2(n_32_569), .A3(n_32_570), .ZN(
      n_32_567));
   NAND2_X1_LVT i_32_146 (.A1(op2_xp[8]), .A2(op1[10]), .ZN(n_32_146));
   NAND2_X1_LVT i_32_130 (.A1(op2_xp[7]), .A2(op1[11]), .ZN(n_32_130));
   INV_X1_LVT i_32_512 (.A(n_32_130), .ZN(n_32_560));
   NAND2_X1_LVT i_32_511 (.A1(n_32_146), .A2(n_32_560), .ZN(n_32_559));
   NAND2_X1_LVT i_32_114 (.A1(op2_xp[6]), .A2(op1[12]), .ZN(n_32_114));
   INV_X1_LVT i_32_514 (.A(n_32_114), .ZN(n_32_562));
   NAND2_X1_LVT i_32_513 (.A1(n_32_146), .A2(n_32_562), .ZN(n_32_561));
   OR2_X1_LVT i_32_515 (.A1(n_32_114), .A2(n_32_130), .ZN(n_32_563));
   NAND3_X1_LVT i_32_510 (.A1(n_32_559), .A2(n_32_561), .A3(n_32_563), .ZN(
      n_32_558));
   NAND2_X1_LVT i_32_50 (.A1(op2_xp[2]), .A2(op1_xp[16]), .ZN(n_32_50));
   NAND2_X1_LVT i_32_81 (.A1(op2_xp[4]), .A2(op1[13]), .ZN(n_32_81));
   NAND2_X1_LVT i_32_97 (.A1(op2_xp[5]), .A2(op1[12]), .ZN(n_32_97));
   NOR2_X1_LVT i_32_493 (.A1(n_32_81), .A2(n_32_97), .ZN(n_32_537));
   NAND2_X1_LVT i_32_65 (.A1(op2_xp[3]), .A2(op1[14]), .ZN(n_32_65));
   NOR2_X1_LVT i_32_494 (.A1(n_32_65), .A2(n_32_97), .ZN(n_32_538));
   NOR2_X1_LVT i_32_495 (.A1(n_32_65), .A2(n_32_81), .ZN(n_32_539));
   OR3_X1_LVT i_32_492 (.A1(n_32_537), .A2(n_32_538), .A3(n_32_539), .ZN(
      n_32_536));
   NAND2_X1_LVT i_32_145 (.A1(op2_xp[8]), .A2(op1[9]), .ZN(n_32_145));
   NAND2_X1_LVT i_32_129 (.A1(op2_xp[7]), .A2(op1[10]), .ZN(n_32_129));
   INV_X1_LVT i_32_485 (.A(n_32_129), .ZN(n_32_529));
   NAND2_X1_LVT i_32_484 (.A1(n_32_145), .A2(n_32_529), .ZN(n_32_528));
   NAND2_X1_LVT i_32_113 (.A1(op2_xp[6]), .A2(op1[11]), .ZN(n_32_113));
   INV_X1_LVT i_32_487 (.A(n_32_113), .ZN(n_32_531));
   NAND2_X1_LVT i_32_486 (.A1(n_32_145), .A2(n_32_531), .ZN(n_32_530));
   OR2_X1_LVT i_32_488 (.A1(n_32_113), .A2(n_32_129), .ZN(n_32_532));
   NAND3_X1_LVT i_32_483 (.A1(n_32_528), .A2(n_32_530), .A3(n_32_532), .ZN(
      n_32_527));
   FA_X1_LVT i_32_523 (.A(n_32_50), .B(n_32_536), .CI(n_32_527), .CO(n_32_572), 
      .S(n_32_571));
   FA_X1_LVT i_32_543 (.A(n_32_567), .B(n_32_558), .CI(n_32_572), .CO(n_32_596), 
      .S(n_32_595));
   XNOR2_X1_LVT i_32_554 (.A(n_32_100), .B(n_32_84), .ZN(n_32_609));
   XNOR2_X1_LVT i_32_555 (.A(n_32_609), .B(n_32_589), .ZN(n_32_610));
   INV_X1_LVT i_32_556 (.A(n_32_610), .ZN(n_32_611));
   FA_X1_LVT i_32_562 (.A(n_32_581), .B(n_32_596), .CI(n_32_611), .CO(n_32_618), 
      .S(n_32_617));
   FA_X1_LVT i_32_573 (.A(n_32_622), .B(n_32_629), .CI(n_32_618), .CO(n_32_632), 
      .S(n_32_631));
   XNOR2_X1_LVT i_32_546 (.A(n_32_148), .B(n_32_132), .ZN(n_32_601));
   XNOR2_X1_LVT i_32_547 (.A(n_32_601), .B(n_32_116), .ZN(n_32_602));
   XNOR2_X1_LVT i_32_535 (.A(n_32_99), .B(n_32_83), .ZN(n_32_587));
   XNOR2_X1_LVT i_32_536 (.A(n_32_587), .B(n_32_67), .ZN(n_32_588));
   XNOR2_X1_LVT i_32_527 (.A(n_32_147), .B(n_32_131), .ZN(n_32_579));
   XNOR2_X1_LVT i_32_528 (.A(n_32_579), .B(n_32_115), .ZN(n_32_580));
   FA_X1_LVT i_32_544 (.A(n_32_588), .B(n_32_580), .CI(n_32_595), .CO(n_32_598), 
      .S(n_32_597));
   FA_X1_LVT i_32_563 (.A(n_32_602), .B(n_32_598), .CI(n_32_617), .CO(n_32_620), 
      .S(n_32_619));
   NAND2_X1_LVT i_32_33 (.A1(op2_xp[1]), .A2(op1_xp[16]), .ZN(n_32_33));
   NAND2_X1_LVT i_32_49 (.A1(op2_xp[2]), .A2(op1[15]), .ZN(n_32_49));
   INV_X1_LVT i_32_501 (.A(n_32_49), .ZN(n_32_545));
   NAND2_X1_LVT i_32_500 (.A1(n_32_33), .A2(n_32_545), .ZN(n_32_544));
   NAND2_X1_LVT i_32_48 (.A1(op2_xp[2]), .A2(op1[14]), .ZN(n_32_48));
   NAND2_X1_LVT i_32_64 (.A1(op2_xp[3]), .A2(op1[13]), .ZN(n_32_64));
   NOR2_X1_LVT i_32_473 (.A1(n_32_48), .A2(n_32_64), .ZN(n_32_512));
   NAND2_X1_LVT i_32_32 (.A1(op2_xp[1]), .A2(op1[15]), .ZN(n_32_32));
   NOR2_X1_LVT i_32_474 (.A1(n_32_32), .A2(n_32_64), .ZN(n_32_513));
   NOR2_X1_LVT i_32_475 (.A1(n_32_32), .A2(n_32_48), .ZN(n_32_514));
   OR3_X1_LVT i_32_472 (.A1(n_32_512), .A2(n_32_513), .A3(n_32_514), .ZN(
      n_32_511));
   NAND2_X1_LVT i_32_502 (.A1(n_32_511), .A2(n_32_545), .ZN(n_32_546));
   NAND2_X1_LVT i_32_503 (.A1(n_32_511), .A2(n_32_33), .ZN(n_32_547));
   NAND3_X1_LVT i_32_499 (.A1(n_32_544), .A2(n_32_546), .A3(n_32_547), .ZN(
      n_32_543));
   NAND2_X1_LVT i_32_96 (.A1(op2_xp[5]), .A2(op1[11]), .ZN(n_32_96));
   NAND2_X1_LVT i_32_112 (.A1(op2_xp[6]), .A2(op1[10]), .ZN(n_32_112));
   NOR2_X1_LVT i_32_466 (.A1(n_32_96), .A2(n_32_112), .ZN(n_32_505));
   NAND2_X1_LVT i_32_80 (.A1(op2_xp[4]), .A2(op1[12]), .ZN(n_32_80));
   NOR2_X1_LVT i_32_467 (.A1(n_32_80), .A2(n_32_112), .ZN(n_32_506));
   NOR2_X1_LVT i_32_468 (.A1(n_32_80), .A2(n_32_96), .ZN(n_32_507));
   OR3_X1_LVT i_32_465 (.A1(n_32_505), .A2(n_32_506), .A3(n_32_507), .ZN(
      n_32_504));
   NAND2_X1_LVT i_32_128 (.A1(op2_xp[7]), .A2(op1[9]), .ZN(n_32_128));
   NAND2_X1_LVT i_32_144 (.A1(op2_xp[8]), .A2(op1[8]), .ZN(n_32_144));
   INV_X1_LVT i_32_461 (.A(n_32_144), .ZN(n_32_500));
   NAND2_X1_LVT i_32_460 (.A1(n_32_128), .A2(n_32_500), .ZN(n_32_499));
   NAND2_X1_LVT i_32_16 (.A1(op2_xp[0]), .A2(op1_xp[16]), .ZN(n_32_16));
   NOR2_X1_LVT i_32_451 (.A1(n_32_31), .A2(n_32_47), .ZN(n_32_486));
   NOR2_X1_LVT i_32_452 (.A1(n_32_15), .A2(n_32_47), .ZN(n_32_487));
   NOR2_X1_LVT i_32_453 (.A1(n_32_15), .A2(n_32_31), .ZN(n_32_488));
   OR3_X1_LVT i_32_450 (.A1(n_32_486), .A2(n_32_487), .A3(n_32_488), .ZN(
      n_32_485));
   NOR2_X1_LVT i_32_444 (.A1(n_32_79), .A2(n_32_95), .ZN(n_32_479));
   NOR2_X1_LVT i_32_445 (.A1(n_32_63), .A2(n_32_95), .ZN(n_32_480));
   NOR2_X1_LVT i_32_446 (.A1(n_32_63), .A2(n_32_79), .ZN(n_32_481));
   OR3_X1_LVT i_32_443 (.A1(n_32_479), .A2(n_32_480), .A3(n_32_481), .ZN(
      n_32_478));
   FA_X1_LVT i_32_476 (.A(n_32_16), .B(n_32_485), .CI(n_32_478), .CO(n_32_516), 
      .S(n_32_515));
   FA_X1_LVT i_32_504 (.A(n_32_504), .B(n_32_499), .CI(n_32_516), .CO(n_32_549), 
      .S(n_32_548));
   XNOR2_X1_LVT i_32_516 (.A(n_32_98), .B(n_32_82), .ZN(n_32_564));
   XNOR2_X1_LVT i_32_517 (.A(n_32_564), .B(n_32_66), .ZN(n_32_565));
   INV_X1_LVT i_32_518 (.A(n_32_565), .ZN(n_32_566));
   FA_X1_LVT i_32_524 (.A(n_32_543), .B(n_32_549), .CI(n_32_566), .CO(n_32_574), 
      .S(n_32_573));
   XNOR2_X1_LVT i_32_508 (.A(n_32_146), .B(n_32_130), .ZN(n_32_556));
   XNOR2_X1_LVT i_32_509 (.A(n_32_556), .B(n_32_114), .ZN(n_32_557));
   XNOR2_X1_LVT i_32_496 (.A(n_32_49), .B(n_32_33), .ZN(n_32_540));
   XNOR2_X1_LVT i_32_497 (.A(n_32_540), .B(n_32_511), .ZN(n_32_541));
   INV_X1_LVT i_32_498 (.A(n_32_541), .ZN(n_32_542));
   XNOR2_X1_LVT i_32_489 (.A(n_32_97), .B(n_32_81), .ZN(n_32_533));
   XNOR2_X1_LVT i_32_490 (.A(n_32_533), .B(n_32_65), .ZN(n_32_534));
   INV_X1_LVT i_32_491 (.A(n_32_534), .ZN(n_32_535));
   XNOR2_X1_LVT i_32_481 (.A(n_32_145), .B(n_32_129), .ZN(n_32_525));
   XNOR2_X1_LVT i_32_482 (.A(n_32_525), .B(n_32_113), .ZN(n_32_526));
   FA_X1_LVT i_32_505 (.A(n_32_542), .B(n_32_535), .CI(n_32_526), .CO(n_32_551), 
      .S(n_32_550));
   FA_X1_LVT i_32_525 (.A(n_32_557), .B(n_32_571), .CI(n_32_551), .CO(n_32_576), 
      .S(n_32_575));
   FA_X1_LVT i_32_545 (.A(n_32_574), .B(n_32_576), .CI(n_32_597), .CO(n_32_600), 
      .S(n_32_599));
   INV_X1_LVT i_32_436 (.A(n_32_127), .ZN(n_32_471));
   NAND2_X1_LVT i_32_435 (.A1(n_32_143), .A2(n_32_471), .ZN(n_32_470));
   INV_X1_LVT i_32_438 (.A(n_32_111), .ZN(n_32_473));
   NAND2_X1_LVT i_32_437 (.A1(n_32_143), .A2(n_32_473), .ZN(n_32_472));
   OR2_X1_LVT i_32_439 (.A1(n_32_111), .A2(n_32_127), .ZN(n_32_474));
   NAND3_X1_LVT i_32_434 (.A1(n_32_470), .A2(n_32_472), .A3(n_32_474), .ZN(
      n_32_469));
   XNOR2_X1_LVT i_32_469 (.A(n_32_64), .B(n_32_48), .ZN(n_32_508));
   XNOR2_X1_LVT i_32_470 (.A(n_32_508), .B(n_32_32), .ZN(n_32_509));
   INV_X1_LVT i_32_471 (.A(n_32_509), .ZN(n_32_510));
   FA_X1_LVT i_32_477 (.A(n_32_469), .B(n_32_490), .CI(n_32_510), .CO(n_32_518), 
      .S(n_32_517));
   XNOR2_X1_LVT i_32_462 (.A(n_32_112), .B(n_32_96), .ZN(n_32_501));
   XNOR2_X1_LVT i_32_463 (.A(n_32_501), .B(n_32_80), .ZN(n_32_502));
   INV_X1_LVT i_32_464 (.A(n_32_502), .ZN(n_32_503));
   XNOR2_X1_LVT i_32_458 (.A(n_32_144), .B(n_32_128), .ZN(n_32_497));
   INV_X1_LVT i_32_459 (.A(n_32_497), .ZN(n_32_498));
   FA_X1_LVT i_32_478 (.A(n_32_503), .B(n_32_498), .CI(n_32_515), .CO(n_32_520), 
      .S(n_32_519));
   FA_X1_LVT i_32_506 (.A(n_32_548), .B(n_32_518), .CI(n_32_520), .CO(n_32_553), 
      .S(n_32_552));
   FA_X1_LVT i_32_526 (.A(n_32_573), .B(n_32_553), .CI(n_32_575), .CO(n_32_578), 
      .S(n_32_577));
   FA_X1_LVT i_32_479 (.A(n_32_492), .B(n_32_517), .CI(n_32_494), .CO(n_32_522), 
      .S(n_32_521));
   FA_X1_LVT i_32_507 (.A(n_32_522), .B(n_32_550), .CI(n_32_552), .CO(n_32_555), 
      .S(n_32_554));
   HA_X1_LVT i_32_480 (.A(n_32_519), .B(n_32_521), .CO(n_32_524), .S(n_32_523));
   FA_X1_LVT i_32_610 (.A(n_32_496), .B(n_32_523), .CI(n_32_666), .CO(n_32_667), 
      .S(n_58));
   FA_X1_LVT i_32_611 (.A(n_32_524), .B(n_32_554), .CI(n_32_667), .CO(n_32_668), 
      .S(n_59));
   FA_X1_LVT i_32_612 (.A(n_32_555), .B(n_32_577), .CI(n_32_668), .CO(n_32_669), 
      .S(n_60));
   FA_X1_LVT i_32_613 (.A(n_32_599), .B(n_32_578), .CI(n_32_669), .CO(n_32_670), 
      .S(n_61));
   FA_X1_LVT i_32_614 (.A(n_32_600), .B(n_32_619), .CI(n_32_670), .CO(n_32_671), 
      .S(n_62));
   FA_X1_LVT i_32_615 (.A(n_32_620), .B(n_32_631), .CI(n_32_671), .CO(n_32_672), 
      .S(n_63));
   FA_X1_LVT i_32_616 (.A(n_32_632), .B(n_32_641), .CI(n_32_672), .CO(n_32_673), 
      .S(n_64));
   XNOR2_X1_LVT i_32_618 (.A(n_32_674), .B(n_32_673), .ZN(n_65));
   AND2_X1_LVT i_33_0 (.A1(sign_sel), .A2(n_65), .ZN(n_66));
   NAND2_X1_LVT i_34_49 (.A1(n_34_8), .A2(n_66), .ZN(n_34_25));
   INV_X1_LVT i_34_47 (.A(n_65), .ZN(n_34_24));
   OAI21_X1_LVT i_34_57 (.A(n_34_25), .B1(n_34_8), .B2(n_34_24), .ZN(
      product_xp[31]));
   NOR3_X1_LVT i_3_9 (.A1(n_3_2), .A2(n_3_1), .A3(per_addr[0]), .ZN(n_7));
   AND2_X1_LVT i_7_6 (.A1(reg_write), .A2(n_7), .ZN(reshi_wr));
   NOR2_X1_LVT i_41_0 (.A1(result_clr), .A2(reshi_wr), .ZN(n_41_0));
   AOI22_X1_LVT i_41_31 (.A1(n_41_0), .A2(reshi_nxt[15]), .B1(reshi_wr), 
      .B2(per_din_msk[15]), .ZN(n_41_16));
   INV_X1_LVT i_41_32 (.A(n_41_16), .ZN(n_86));
   INV_X1_LVT i_42_1 (.A(n_69), .ZN(n_42_1));
   INV_X1_LVT i_42_0 (.A(reshi_wr), .ZN(n_42_0));
   NAND2_X1_LVT i_42_2 (.A1(n_42_1), .A2(n_42_0), .ZN(n_87));
   CLKGATETST_X1_LVT clk_gate_reshi_reg (.CK(mclk), .E(n_87), .SE(1'b0), 
      .GCK(n_70));
   DFFR_X1_LVT \reshi_reg[15]  (.D(n_86), .RN(n_38), .CK(n_70), .Q(reshi[15]), 
      .QN());
   INV_X1_LVT i_34_45 (.A(n_64), .ZN(n_34_23));
   OAI21_X1_LVT i_34_56 (.A(n_34_25), .B1(n_34_8), .B2(n_34_23), .ZN(
      product_xp[30]));
   AOI22_X1_LVT i_41_29 (.A1(n_41_0), .A2(reshi_nxt[14]), .B1(reshi_wr), 
      .B2(per_din_msk[14]), .ZN(n_41_15));
   INV_X1_LVT i_41_30 (.A(n_41_15), .ZN(n_85));
   DFFR_X1_LVT \reshi_reg[14]  (.D(n_85), .RN(n_38), .CK(n_70), .Q(reshi[14]), 
      .QN());
   INV_X1_LVT i_34_43 (.A(n_63), .ZN(n_34_22));
   OAI21_X1_LVT i_34_55 (.A(n_34_25), .B1(n_34_8), .B2(n_34_22), .ZN(
      product_xp[29]));
   AOI22_X1_LVT i_41_27 (.A1(n_41_0), .A2(reshi_nxt[13]), .B1(reshi_wr), 
      .B2(per_din_msk[13]), .ZN(n_41_14));
   INV_X1_LVT i_41_28 (.A(n_41_14), .ZN(n_84));
   DFFR_X1_LVT \reshi_reg[13]  (.D(n_84), .RN(n_38), .CK(n_70), .Q(reshi[13]), 
      .QN());
   INV_X1_LVT i_34_41 (.A(n_62), .ZN(n_34_21));
   OAI21_X1_LVT i_34_54 (.A(n_34_25), .B1(n_34_8), .B2(n_34_21), .ZN(
      product_xp[28]));
   AOI22_X1_LVT i_41_25 (.A1(n_41_0), .A2(reshi_nxt[12]), .B1(reshi_wr), 
      .B2(per_din_msk[12]), .ZN(n_41_13));
   INV_X1_LVT i_41_26 (.A(n_41_13), .ZN(n_83));
   DFFR_X1_LVT \reshi_reg[12]  (.D(n_83), .RN(n_38), .CK(n_70), .Q(reshi[12]), 
      .QN());
   INV_X1_LVT i_34_39 (.A(n_61), .ZN(n_34_20));
   OAI21_X1_LVT i_34_53 (.A(n_34_25), .B1(n_34_8), .B2(n_34_20), .ZN(
      product_xp[27]));
   AOI22_X1_LVT i_41_23 (.A1(n_41_0), .A2(reshi_nxt[11]), .B1(reshi_wr), 
      .B2(per_din_msk[11]), .ZN(n_41_12));
   INV_X1_LVT i_41_24 (.A(n_41_12), .ZN(n_82));
   DFFR_X1_LVT \reshi_reg[11]  (.D(n_82), .RN(n_38), .CK(n_70), .Q(reshi[11]), 
      .QN());
   INV_X1_LVT i_34_37 (.A(n_60), .ZN(n_34_19));
   OAI21_X1_LVT i_34_52 (.A(n_34_25), .B1(n_34_8), .B2(n_34_19), .ZN(
      product_xp[26]));
   AOI22_X1_LVT i_41_21 (.A1(n_41_0), .A2(reshi_nxt[10]), .B1(reshi_wr), 
      .B2(per_din_msk[10]), .ZN(n_41_11));
   INV_X1_LVT i_41_22 (.A(n_41_11), .ZN(n_81));
   DFFR_X1_LVT \reshi_reg[10]  (.D(n_81), .RN(n_38), .CK(n_70), .Q(reshi[10]), 
      .QN());
   INV_X1_LVT i_34_35 (.A(n_59), .ZN(n_34_18));
   OAI21_X1_LVT i_34_51 (.A(n_34_25), .B1(n_34_8), .B2(n_34_18), .ZN(
      product_xp[25]));
   AOI22_X1_LVT i_41_19 (.A1(n_41_0), .A2(reshi_nxt[9]), .B1(reshi_wr), .B2(
      per_din_msk[9]), .ZN(n_41_10));
   INV_X1_LVT i_41_20 (.A(n_41_10), .ZN(n_80));
   DFFR_X1_LVT \reshi_reg[9]  (.D(n_80), .RN(n_38), .CK(n_70), .Q(reshi[9]), 
      .QN());
   INV_X1_LVT i_34_33 (.A(n_58), .ZN(n_34_17));
   OAI21_X1_LVT i_34_50 (.A(n_34_25), .B1(n_34_8), .B2(n_34_17), .ZN(
      product_xp[24]));
   AOI22_X1_LVT i_41_17 (.A1(n_41_0), .A2(reshi_nxt[8]), .B1(reshi_wr), .B2(
      per_din_msk[8]), .ZN(n_41_9));
   INV_X1_LVT i_41_18 (.A(n_41_9), .ZN(n_79));
   DFFR_X1_LVT \reshi_reg[8]  (.D(n_79), .RN(n_38), .CK(n_70), .Q(reshi[8]), 
      .QN());
   OAI22_X1_LVT i_34_48 (.A1(n_34_8), .A2(n_34_16), .B1(n_34_24), .B2(cycle[0]), 
      .ZN(product_xp[23]));
   AOI22_X1_LVT i_41_15 (.A1(n_41_0), .A2(reshi_nxt[7]), .B1(reshi_wr), .B2(
      per_din[7]), .ZN(n_41_8));
   INV_X1_LVT i_41_16 (.A(n_41_8), .ZN(n_78));
   DFFR_X1_LVT \reshi_reg[7]  (.D(n_78), .RN(n_38), .CK(n_70), .Q(reshi[7]), 
      .QN());
   OAI22_X1_LVT i_34_46 (.A1(n_34_8), .A2(n_34_15), .B1(n_34_23), .B2(cycle[0]), 
      .ZN(product_xp[22]));
   AOI22_X1_LVT i_41_13 (.A1(n_41_0), .A2(reshi_nxt[6]), .B1(reshi_wr), .B2(
      per_din[6]), .ZN(n_41_7));
   INV_X1_LVT i_41_14 (.A(n_41_7), .ZN(n_77));
   DFFR_X1_LVT \reshi_reg[6]  (.D(n_77), .RN(n_38), .CK(n_70), .Q(reshi[6]), 
      .QN());
   OAI22_X1_LVT i_34_44 (.A1(n_34_8), .A2(n_34_14), .B1(n_34_22), .B2(cycle[0]), 
      .ZN(product_xp[21]));
   AOI22_X1_LVT i_41_11 (.A1(n_41_0), .A2(reshi_nxt[5]), .B1(reshi_wr), .B2(
      per_din[5]), .ZN(n_41_6));
   INV_X1_LVT i_41_12 (.A(n_41_6), .ZN(n_76));
   DFFR_X1_LVT \reshi_reg[5]  (.D(n_76), .RN(n_38), .CK(n_70), .Q(reshi[5]), 
      .QN());
   OAI22_X1_LVT i_34_42 (.A1(n_34_8), .A2(n_34_13), .B1(n_34_21), .B2(cycle[0]), 
      .ZN(product_xp[20]));
   AOI22_X1_LVT i_41_9 (.A1(n_41_0), .A2(reshi_nxt[4]), .B1(reshi_wr), .B2(
      per_din[4]), .ZN(n_41_5));
   INV_X1_LVT i_41_10 (.A(n_41_5), .ZN(n_75));
   DFFR_X1_LVT \reshi_reg[4]  (.D(n_75), .RN(n_38), .CK(n_70), .Q(reshi[4]), 
      .QN());
   OAI22_X1_LVT i_34_40 (.A1(n_34_8), .A2(n_34_12), .B1(n_34_20), .B2(cycle[0]), 
      .ZN(product_xp[19]));
   AOI22_X1_LVT i_41_7 (.A1(n_41_0), .A2(reshi_nxt[3]), .B1(reshi_wr), .B2(
      per_din[3]), .ZN(n_41_4));
   INV_X1_LVT i_41_8 (.A(n_41_4), .ZN(n_74));
   DFFR_X1_LVT \reshi_reg[3]  (.D(n_74), .RN(n_38), .CK(n_70), .Q(reshi[3]), 
      .QN());
   OAI22_X1_LVT i_34_38 (.A1(n_34_8), .A2(n_34_11), .B1(n_34_19), .B2(cycle[0]), 
      .ZN(product_xp[18]));
   AOI22_X1_LVT i_41_5 (.A1(n_41_0), .A2(reshi_nxt[2]), .B1(reshi_wr), .B2(
      per_din[2]), .ZN(n_41_3));
   INV_X1_LVT i_41_6 (.A(n_41_3), .ZN(n_73));
   DFFR_X1_LVT \reshi_reg[2]  (.D(n_73), .RN(n_38), .CK(n_70), .Q(reshi[2]), 
      .QN());
   OAI22_X1_LVT i_34_36 (.A1(n_34_8), .A2(n_34_10), .B1(n_34_18), .B2(cycle[0]), 
      .ZN(product_xp[17]));
   AOI22_X1_LVT i_41_3 (.A1(n_41_0), .A2(reshi_nxt[1]), .B1(reshi_wr), .B2(
      per_din[1]), .ZN(n_41_2));
   INV_X1_LVT i_41_4 (.A(n_41_2), .ZN(n_72));
   DFFR_X1_LVT \reshi_reg[1]  (.D(n_72), .RN(n_38), .CK(n_70), .Q(reshi[1]), 
      .QN());
   OAI22_X1_LVT i_34_34 (.A1(n_34_8), .A2(n_34_9), .B1(n_34_17), .B2(cycle[0]), 
      .ZN(product_xp[16]));
   AOI22_X1_LVT i_41_1 (.A1(n_41_0), .A2(reshi_nxt[0]), .B1(per_din[0]), 
      .B2(reshi_wr), .ZN(n_41_1));
   INV_X1_LVT i_41_2 (.A(n_41_1), .ZN(n_71));
   DFFR_X1_LVT \reshi_reg[0]  (.D(n_71), .RN(n_38), .CK(n_70), .Q(reshi[0]), 
      .QN());
   FA_X1_LVT i_48_16 (.A(product_xp[16]), .B(reshi[0]), .CI(n_48_15), .CO(
      n_48_16), .S(reshi_nxt[0]));
   FA_X1_LVT i_48_17 (.A(product_xp[17]), .B(reshi[1]), .CI(n_48_16), .CO(
      n_48_17), .S(reshi_nxt[1]));
   FA_X1_LVT i_48_18 (.A(product_xp[18]), .B(reshi[2]), .CI(n_48_17), .CO(
      n_48_18), .S(reshi_nxt[2]));
   FA_X1_LVT i_48_19 (.A(product_xp[19]), .B(reshi[3]), .CI(n_48_18), .CO(
      n_48_19), .S(reshi_nxt[3]));
   FA_X1_LVT i_48_20 (.A(product_xp[20]), .B(reshi[4]), .CI(n_48_19), .CO(
      n_48_20), .S(reshi_nxt[4]));
   FA_X1_LVT i_48_21 (.A(product_xp[21]), .B(reshi[5]), .CI(n_48_20), .CO(
      n_48_21), .S(reshi_nxt[5]));
   FA_X1_LVT i_48_22 (.A(product_xp[22]), .B(reshi[6]), .CI(n_48_21), .CO(
      n_48_22), .S(reshi_nxt[6]));
   FA_X1_LVT i_48_23 (.A(product_xp[23]), .B(reshi[7]), .CI(n_48_22), .CO(
      n_48_23), .S(reshi_nxt[7]));
   FA_X1_LVT i_48_24 (.A(product_xp[24]), .B(reshi[8]), .CI(n_48_23), .CO(
      n_48_24), .S(reshi_nxt[8]));
   FA_X1_LVT i_48_25 (.A(product_xp[25]), .B(reshi[9]), .CI(n_48_24), .CO(
      n_48_25), .S(reshi_nxt[9]));
   FA_X1_LVT i_48_26 (.A(product_xp[26]), .B(reshi[10]), .CI(n_48_25), .CO(
      n_48_26), .S(reshi_nxt[10]));
   FA_X1_LVT i_48_27 (.A(product_xp[27]), .B(reshi[11]), .CI(n_48_26), .CO(
      n_48_27), .S(reshi_nxt[11]));
   FA_X1_LVT i_48_28 (.A(product_xp[28]), .B(reshi[12]), .CI(n_48_27), .CO(
      n_48_28), .S(reshi_nxt[12]));
   FA_X1_LVT i_48_29 (.A(product_xp[29]), .B(reshi[13]), .CI(n_48_28), .CO(
      n_48_29), .S(reshi_nxt[13]));
   FA_X1_LVT i_48_30 (.A(product_xp[30]), .B(reshi[14]), .CI(n_48_29), .CO(
      n_48_30), .S(reshi_nxt[14]));
   FA_X1_LVT i_48_31 (.A(product_xp[31]), .B(reshi[15]), .CI(n_48_30), .CO(n_138), 
      .S(reshi_nxt[15]));
   NAND2_X1_LVT i_50_0 (.A1(reshi_nxt[15]), .A2(sign_sel), .ZN(n_50_0));
   INV_X1_LVT i_50_3 (.A(n_50_0), .ZN(sumext_s_nxt[1]));
   AND2_X1_LVT i_52_2 (.A1(n_52_0), .A2(sumext_s_nxt[1]), .ZN(n_142));
   INV_X1_LVT i_53_1 (.A(result_wr), .ZN(n_53_1));
   INV_X1_LVT i_53_0 (.A(op2_wr), .ZN(n_53_0));
   NAND2_X1_LVT i_53_2 (.A1(n_53_1), .A2(n_53_0), .ZN(n_143));
   CLKGATETST_X1_LVT clk_gate_sumext_s_reg (.CK(mclk), .E(n_143), .SE(1'b0), 
      .GCK(n_140));
   DFFR_X1_LVT \sumext_s_reg[1]  (.D(n_142), .RN(n_38), .CK(n_140), .Q(
      sumext_s[1]), .QN());
   AOI22_X1_LVT i_57_1 (.A1(n_57_0), .A2(sumext_s[1]), .B1(sumext_s_nxt[1]), 
      .B2(cycle[1]), .ZN(n_57_1));
   INV_X1_LVT i_57_2 (.A(n_57_1), .ZN(n_148));
   NOR3_X1_LVT i_3_10 (.A1(n_3_0), .A2(n_3_1), .A3(n_3_2), .ZN(n_8));
   AND2_X1_LVT i_4_7 (.A1(reg_read), .A2(n_8), .ZN(reg_rd15));
   AND2_X1_LVT i_58_0 (.A1(n_148), .A2(reg_rd15), .ZN(n_149));
   AND2_X1_LVT i_4_4 (.A1(reg_read), .A2(n_5), .ZN(n_12));
   AND2_X1_LVT i_20_0 (.A1(op2_reg[15]), .A2(n_12), .ZN(n_37));
   NOR4_X1_LVT i_60_96 (.A1(n_60_79), .A2(n_60_80), .A3(n_149), .A4(n_37), 
      .ZN(n_60_81));
   AOI22_X1_LVT i_60_97 (.A1(n_60_0), .A2(reshi[15]), .B1(cycle[1]), .B2(
      reshi_nxt[15]), .ZN(n_60_82));
   AND2_X1_LVT i_4_6 (.A1(reg_read), .A2(n_7), .ZN(n_14));
   INV_X1_LVT i_60_7 (.A(n_14), .ZN(n_60_7));
   OAI21_X1_LVT i_60_98 (.A(n_60_81), .B1(n_60_82), .B2(n_60_7), .ZN(
      per_dout[15]));
   AOI22_X1_LVT i_60_87 (.A1(n_60_0), .A2(n_90), .B1(cycle[1]), .B2(n_136), 
      .ZN(n_60_73));
   NOR2_X1_LVT i_60_88 (.A1(n_60_73), .A2(n_60_2), .ZN(n_60_74));
   AND2_X1_LVT i_60_89 (.A1(n_150), .A2(op1[14]), .ZN(n_60_75));
   AND2_X1_LVT i_19_0 (.A1(op2_reg[14]), .A2(n_12), .ZN(n_36));
   NOR4_X1_LVT i_60_90 (.A1(n_60_74), .A2(n_60_75), .A3(n_149), .A4(n_36), 
      .ZN(n_60_76));
   AOI22_X1_LVT i_60_91 (.A1(n_60_0), .A2(reshi[14]), .B1(cycle[1]), .B2(
      reshi_nxt[14]), .ZN(n_60_77));
   OAI21_X1_LVT i_60_92 (.A(n_60_76), .B1(n_60_77), .B2(n_60_7), .ZN(
      per_dout[14]));
   AOI22_X1_LVT i_60_81 (.A1(n_60_0), .A2(n_91), .B1(cycle[1]), .B2(n_135), 
      .ZN(n_60_68));
   NOR2_X1_LVT i_60_82 (.A1(n_60_68), .A2(n_60_2), .ZN(n_60_69));
   AND2_X1_LVT i_60_83 (.A1(n_150), .A2(op1[13]), .ZN(n_60_70));
   AND2_X1_LVT i_18_0 (.A1(op2_reg[13]), .A2(n_12), .ZN(n_35));
   NOR4_X1_LVT i_60_84 (.A1(n_60_69), .A2(n_60_70), .A3(n_149), .A4(n_35), 
      .ZN(n_60_71));
   AOI22_X1_LVT i_60_85 (.A1(n_60_0), .A2(reshi[13]), .B1(cycle[1]), .B2(
      reshi_nxt[13]), .ZN(n_60_72));
   OAI21_X1_LVT i_60_86 (.A(n_60_71), .B1(n_60_72), .B2(n_60_7), .ZN(
      per_dout[13]));
   AOI22_X1_LVT i_60_75 (.A1(n_60_0), .A2(n_92), .B1(cycle[1]), .B2(n_134), 
      .ZN(n_60_63));
   NOR2_X1_LVT i_60_76 (.A1(n_60_63), .A2(n_60_2), .ZN(n_60_64));
   AND2_X1_LVT i_60_77 (.A1(n_150), .A2(op1[12]), .ZN(n_60_65));
   AND2_X1_LVT i_17_0 (.A1(op2_reg[12]), .A2(n_12), .ZN(n_34));
   NOR4_X1_LVT i_60_78 (.A1(n_60_64), .A2(n_60_65), .A3(n_149), .A4(n_34), 
      .ZN(n_60_66));
   AOI22_X1_LVT i_60_79 (.A1(n_60_0), .A2(reshi[12]), .B1(cycle[1]), .B2(
      reshi_nxt[12]), .ZN(n_60_67));
   OAI21_X1_LVT i_60_80 (.A(n_60_66), .B1(n_60_67), .B2(n_60_7), .ZN(
      per_dout[12]));
   AOI22_X1_LVT i_60_69 (.A1(n_60_0), .A2(n_93), .B1(cycle[1]), .B2(n_133), 
      .ZN(n_60_58));
   NOR2_X1_LVT i_60_70 (.A1(n_60_58), .A2(n_60_2), .ZN(n_60_59));
   AND2_X1_LVT i_60_71 (.A1(n_150), .A2(op1[11]), .ZN(n_60_60));
   AND2_X1_LVT i_16_0 (.A1(op2_reg[11]), .A2(n_12), .ZN(n_33));
   NOR4_X1_LVT i_60_72 (.A1(n_60_59), .A2(n_60_60), .A3(n_149), .A4(n_33), 
      .ZN(n_60_61));
   AOI22_X1_LVT i_60_73 (.A1(n_60_0), .A2(reshi[11]), .B1(cycle[1]), .B2(
      reshi_nxt[11]), .ZN(n_60_62));
   OAI21_X1_LVT i_60_74 (.A(n_60_61), .B1(n_60_62), .B2(n_60_7), .ZN(
      per_dout[11]));
   AOI22_X1_LVT i_60_63 (.A1(n_60_0), .A2(n_94), .B1(cycle[1]), .B2(n_132), 
      .ZN(n_60_53));
   NOR2_X1_LVT i_60_64 (.A1(n_60_53), .A2(n_60_2), .ZN(n_60_54));
   AND2_X1_LVT i_60_65 (.A1(n_150), .A2(op1[10]), .ZN(n_60_55));
   AND2_X1_LVT i_15_0 (.A1(op2_reg[10]), .A2(n_12), .ZN(n_32));
   NOR4_X1_LVT i_60_66 (.A1(n_60_54), .A2(n_60_55), .A3(n_149), .A4(n_32), 
      .ZN(n_60_56));
   AOI22_X1_LVT i_60_67 (.A1(n_60_0), .A2(reshi[10]), .B1(cycle[1]), .B2(
      reshi_nxt[10]), .ZN(n_60_57));
   OAI21_X1_LVT i_60_68 (.A(n_60_56), .B1(n_60_57), .B2(n_60_7), .ZN(
      per_dout[10]));
   AOI22_X1_LVT i_60_57 (.A1(n_60_0), .A2(n_95), .B1(cycle[1]), .B2(n_131), 
      .ZN(n_60_48));
   NOR2_X1_LVT i_60_58 (.A1(n_60_48), .A2(n_60_2), .ZN(n_60_49));
   AND2_X1_LVT i_60_59 (.A1(n_150), .A2(op1[9]), .ZN(n_60_50));
   AND2_X1_LVT i_14_0 (.A1(op2_reg[9]), .A2(n_12), .ZN(n_31));
   NOR4_X1_LVT i_60_60 (.A1(n_60_49), .A2(n_60_50), .A3(n_149), .A4(n_31), 
      .ZN(n_60_51));
   AOI22_X1_LVT i_60_61 (.A1(n_60_0), .A2(reshi[9]), .B1(cycle[1]), .B2(
      reshi_nxt[9]), .ZN(n_60_52));
   OAI21_X1_LVT i_60_62 (.A(n_60_51), .B1(n_60_52), .B2(n_60_7), .ZN(per_dout[9]));
   AOI22_X1_LVT i_60_51 (.A1(n_60_0), .A2(n_96), .B1(cycle[1]), .B2(n_130), 
      .ZN(n_60_43));
   NOR2_X1_LVT i_60_52 (.A1(n_60_43), .A2(n_60_2), .ZN(n_60_44));
   AND2_X1_LVT i_60_53 (.A1(n_150), .A2(op1[8]), .ZN(n_60_45));
   AND2_X1_LVT i_13_0 (.A1(op2_reg[8]), .A2(n_12), .ZN(n_30));
   NOR4_X1_LVT i_60_54 (.A1(n_60_44), .A2(n_60_45), .A3(n_149), .A4(n_30), 
      .ZN(n_60_46));
   AOI22_X1_LVT i_60_55 (.A1(n_60_0), .A2(reshi[8]), .B1(cycle[1]), .B2(
      reshi_nxt[8]), .ZN(n_60_47));
   OAI21_X1_LVT i_60_56 (.A(n_60_46), .B1(n_60_47), .B2(n_60_7), .ZN(per_dout[8]));
   AOI22_X1_LVT i_60_45 (.A1(n_60_0), .A2(n_97), .B1(cycle[1]), .B2(n_129), 
      .ZN(n_60_38));
   NOR2_X1_LVT i_60_46 (.A1(n_60_38), .A2(n_60_2), .ZN(n_60_39));
   AND2_X1_LVT i_60_47 (.A1(n_150), .A2(op1[7]), .ZN(n_60_40));
   AND2_X1_LVT i_12_7 (.A1(n_12), .A2(op2_reg[7]), .ZN(n_29));
   NOR4_X1_LVT i_60_48 (.A1(n_60_39), .A2(n_60_40), .A3(n_149), .A4(n_29), 
      .ZN(n_60_41));
   AOI22_X1_LVT i_60_49 (.A1(n_60_0), .A2(reshi[7]), .B1(cycle[1]), .B2(
      reshi_nxt[7]), .ZN(n_60_42));
   OAI21_X1_LVT i_60_50 (.A(n_60_41), .B1(n_60_42), .B2(n_60_7), .ZN(per_dout[7]));
   AOI22_X1_LVT i_60_39 (.A1(n_60_0), .A2(n_98), .B1(cycle[1]), .B2(n_128), 
      .ZN(n_60_33));
   NOR2_X1_LVT i_60_40 (.A1(n_60_33), .A2(n_60_2), .ZN(n_60_34));
   AND2_X1_LVT i_60_41 (.A1(n_150), .A2(op1[6]), .ZN(n_60_35));
   AND2_X1_LVT i_12_6 (.A1(n_12), .A2(op2_reg[6]), .ZN(n_28));
   NOR4_X1_LVT i_60_42 (.A1(n_60_34), .A2(n_60_35), .A3(n_149), .A4(n_28), 
      .ZN(n_60_36));
   AOI22_X1_LVT i_60_43 (.A1(n_60_0), .A2(reshi[6]), .B1(cycle[1]), .B2(
      reshi_nxt[6]), .ZN(n_60_37));
   OAI21_X1_LVT i_60_44 (.A(n_60_36), .B1(n_60_37), .B2(n_60_7), .ZN(per_dout[6]));
   AOI22_X1_LVT i_60_33 (.A1(n_60_0), .A2(n_99), .B1(cycle[1]), .B2(n_127), 
      .ZN(n_60_28));
   NOR2_X1_LVT i_60_34 (.A1(n_60_28), .A2(n_60_2), .ZN(n_60_29));
   AND2_X1_LVT i_60_35 (.A1(n_150), .A2(op1[5]), .ZN(n_60_30));
   AND2_X1_LVT i_12_5 (.A1(n_12), .A2(op2_reg[5]), .ZN(n_27));
   NOR4_X1_LVT i_60_36 (.A1(n_60_29), .A2(n_60_30), .A3(n_149), .A4(n_27), 
      .ZN(n_60_31));
   AOI22_X1_LVT i_60_37 (.A1(n_60_0), .A2(reshi[5]), .B1(cycle[1]), .B2(
      reshi_nxt[5]), .ZN(n_60_32));
   OAI21_X1_LVT i_60_38 (.A(n_60_31), .B1(n_60_32), .B2(n_60_7), .ZN(per_dout[5]));
   AOI22_X1_LVT i_60_27 (.A1(n_60_0), .A2(n_100), .B1(cycle[1]), .B2(n_126), 
      .ZN(n_60_23));
   NOR2_X1_LVT i_60_28 (.A1(n_60_23), .A2(n_60_2), .ZN(n_60_24));
   AND2_X1_LVT i_60_29 (.A1(n_150), .A2(op1[4]), .ZN(n_60_25));
   AND2_X1_LVT i_12_4 (.A1(n_12), .A2(op2_reg[4]), .ZN(n_26));
   NOR4_X1_LVT i_60_30 (.A1(n_60_24), .A2(n_60_25), .A3(n_149), .A4(n_26), 
      .ZN(n_60_26));
   AOI22_X1_LVT i_60_31 (.A1(n_60_0), .A2(reshi[4]), .B1(cycle[1]), .B2(
      reshi_nxt[4]), .ZN(n_60_27));
   OAI21_X1_LVT i_60_32 (.A(n_60_26), .B1(n_60_27), .B2(n_60_7), .ZN(per_dout[4]));
   AOI22_X1_LVT i_60_21 (.A1(n_60_0), .A2(n_101), .B1(cycle[1]), .B2(n_125), 
      .ZN(n_60_18));
   NOR2_X1_LVT i_60_22 (.A1(n_60_18), .A2(n_60_2), .ZN(n_60_19));
   AND2_X1_LVT i_60_23 (.A1(n_150), .A2(op1[3]), .ZN(n_60_20));
   AND2_X1_LVT i_12_3 (.A1(n_12), .A2(op2_reg[3]), .ZN(n_25));
   NOR4_X1_LVT i_60_24 (.A1(n_60_19), .A2(n_60_20), .A3(n_149), .A4(n_25), 
      .ZN(n_60_21));
   AOI22_X1_LVT i_60_25 (.A1(n_60_0), .A2(reshi[3]), .B1(cycle[1]), .B2(
      reshi_nxt[3]), .ZN(n_60_22));
   OAI21_X1_LVT i_60_26 (.A(n_60_21), .B1(n_60_22), .B2(n_60_7), .ZN(per_dout[3]));
   AOI22_X1_LVT i_60_15 (.A1(n_60_0), .A2(n_102), .B1(cycle[1]), .B2(n_124), 
      .ZN(n_60_13));
   NOR2_X1_LVT i_60_16 (.A1(n_60_13), .A2(n_60_2), .ZN(n_60_14));
   AND2_X1_LVT i_60_17 (.A1(n_150), .A2(op1[2]), .ZN(n_60_15));
   AND2_X1_LVT i_12_2 (.A1(n_12), .A2(op2_reg[2]), .ZN(n_24));
   NOR4_X1_LVT i_60_18 (.A1(n_60_14), .A2(n_60_15), .A3(n_149), .A4(n_24), 
      .ZN(n_60_16));
   AOI22_X1_LVT i_60_19 (.A1(n_60_0), .A2(reshi[2]), .B1(cycle[1]), .B2(
      reshi_nxt[2]), .ZN(n_60_17));
   OAI21_X1_LVT i_60_20 (.A(n_60_16), .B1(n_60_17), .B2(n_60_7), .ZN(per_dout[2]));
   AOI22_X1_LVT i_60_9 (.A1(n_60_0), .A2(n_103), .B1(cycle[1]), .B2(n_123), 
      .ZN(n_60_8));
   NOR2_X1_LVT i_60_10 (.A1(n_60_8), .A2(n_60_2), .ZN(n_60_9));
   AND2_X1_LVT i_60_11 (.A1(n_150), .A2(op1[1]), .ZN(n_60_10));
   INV_X1_LVT i_55_0 (.A(cycle[1]), .ZN(n_55_0));
   AOI22_X1_LVT i_55_3 (.A1(n_55_0), .A2(sumext_s[1]), .B1(cycle[1]), .B2(
      sumext_s_nxt[1]), .ZN(n_55_2));
   INV_X1_LVT i_55_4 (.A(n_55_2), .ZN(n_145));
   AND2_X1_LVT i_56_1 (.A1(reg_rd15), .A2(n_145), .ZN(n_147));
   AND2_X1_LVT i_12_1 (.A1(n_12), .A2(op2_reg[1]), .ZN(n_23));
   NOR4_X1_LVT i_60_12 (.A1(n_60_9), .A2(n_60_10), .A3(n_147), .A4(n_23), 
      .ZN(n_60_11));
   AOI22_X1_LVT i_60_13 (.A1(n_60_0), .A2(reshi[1]), .B1(cycle[1]), .B2(
      reshi_nxt[1]), .ZN(n_60_12));
   OAI21_X1_LVT i_60_14 (.A(n_60_11), .B1(n_60_12), .B2(n_60_7), .ZN(per_dout[1]));
   AOI22_X1_LVT i_60_1 (.A1(n_60_0), .A2(n_104), .B1(cycle[1]), .B2(n_122), 
      .ZN(n_60_1));
   NOR2_X1_LVT i_60_3 (.A1(n_60_1), .A2(n_60_2), .ZN(n_60_3));
   AND2_X1_LVT i_60_4 (.A1(op1[0]), .A2(n_150), .ZN(n_60_4));
   OR2_X1_LVT i_49_0 (.A1(n_138), .A2(sumext_s[0]), .ZN(n_139));
   INV_X1_LVT i_50_1 (.A(n_139), .ZN(n_50_1));
   OAI21_X1_LVT i_50_2 (.A(n_50_0), .B1(n_50_1), .B2(sign_sel), .ZN(
      sumext_s_nxt[0]));
   AND2_X1_LVT i_52_1 (.A1(n_52_0), .A2(sumext_s_nxt[0]), .ZN(n_141));
   DFFR_X1_LVT \sumext_s_reg[0]  (.D(n_141), .RN(n_38), .CK(n_140), .Q(
      sumext_s[0]), .QN());
   AOI22_X1_LVT i_55_1 (.A1(n_55_0), .A2(sumext_s[0]), .B1(sumext_s_nxt[0]), 
      .B2(cycle[1]), .ZN(n_55_1));
   INV_X1_LVT i_55_2 (.A(n_55_1), .ZN(n_144));
   AND2_X1_LVT i_56_0 (.A1(n_144), .A2(reg_rd15), .ZN(n_146));
   AND2_X1_LVT i_12_0 (.A1(op2_reg[0]), .A2(n_12), .ZN(n_22));
   NOR4_X1_LVT i_60_5 (.A1(n_60_3), .A2(n_60_4), .A3(n_146), .A4(n_22), .ZN(
      n_60_5));
   AOI22_X1_LVT i_60_6 (.A1(n_60_0), .A2(reshi[0]), .B1(reshi_nxt[0]), .B2(
      cycle[1]), .ZN(n_60_6));
   OAI21_X1_LVT i_60_8 (.A(n_60_5), .B1(n_60_6), .B2(n_60_7), .ZN(per_dout[0]));
endmodule

module omsp_mem_backbone(cpu_halt_cmd, dbg_mem_din, dmem_addr, dmem_cen, 
      dmem_din, dmem_wen, eu_mdb_in, fe_mdb_in, fe_pmem_wait, dma_dout, 
      dma_ready, dma_resp, per_addr, per_din, per_we, per_en, pmem_addr, 
      pmem_cen, pmem_din, pmem_wen, cpu_halt_st, dbg_halt_cmd, dbg_mem_addr, 
      dbg_mem_dout, dbg_mem_en, dbg_mem_wr, dmem_dout, eu_mab, eu_mb_en, 
      eu_mb_wr, eu_mdb_out, fe_mab, fe_mb_en, mclk, dma_addr, dma_din, dma_en, 
      dma_priority, dma_we, per_dout, pmem_dout, puc_rst, scan_enable);
   output cpu_halt_cmd;
   output [15:0]dbg_mem_din;
   output [8:0]dmem_addr;
   output dmem_cen;
   output [15:0]dmem_din;
   output [1:0]dmem_wen;
   output [15:0]eu_mdb_in;
   output [15:0]fe_mdb_in;
   output fe_pmem_wait;
   output [15:0]dma_dout;
   output dma_ready;
   output dma_resp;
   output [13:0]per_addr;
   output [15:0]per_din;
   output [1:0]per_we;
   output per_en;
   output [10:0]pmem_addr;
   output pmem_cen;
   output [15:0]pmem_din;
   output [1:0]pmem_wen;
   input cpu_halt_st;
   input dbg_halt_cmd;
   input [15:1]dbg_mem_addr;
   input [15:0]dbg_mem_dout;
   input dbg_mem_en;
   input [1:0]dbg_mem_wr;
   input [15:0]dmem_dout;
   input [14:0]eu_mab;
   input eu_mb_en;
   input [1:0]eu_mb_wr;
   input [15:0]eu_mdb_out;
   input [14:0]fe_mab;
   input fe_mb_en;
   input mclk;
   input [15:1]dma_addr;
   input [15:0]dma_din;
   input dma_en;
   input dma_priority;
   input [1:0]dma_we;
   input [15:0]per_dout;
   input [15:0]pmem_dout;
   input puc_rst;
   input scan_enable;

   wire n_0_0;
   wire [15:0]per_dout_val;
   wire n_2_0;
   wire n_2_1;
   wire [15:1]ext_mem_addr;
   wire n_2_2;
   wire n_2_3;
   wire n_2_4;
   wire n_2_5;
   wire n_2_6;
   wire n_2_7;
   wire n_2_8;
   wire n_2_9;
   wire n_2_10;
   wire n_2_11;
   wire n_2_12;
   wire n_2_13;
   wire n_2_14;
   wire n_2_15;
   wire n_3_0;
   wire ext_per_sel;
   wire ext_mem_en;
   wire n_5_0;
   wire n_5_1;
   wire n_5_2;
   wire eu_per_en;
   wire n_6_0;
   wire ext_per_en;
   wire ext_pmem_sel;
   wire n_8_0;
   wire fe_pmem_en;
   wire n_11_0;
   wire n_11_1;
   wire eu_pmem_en;
   wire n_12_0;
   wire ext_pmem_en;
   wire [1:0]ext_mem_din_sel;
   wire n_15_0;
   wire n_16_0;
   wire n_16_1;
   wire n_16_2;
   wire n_16_3;
   wire n_16_4;
   wire n_16_5;
   wire n_16_6;
   wire n_16_7;
   wire n_16_8;
   wire n_16_9;
   wire n_16_10;
   wire n_16_11;
   wire n_16_12;
   wire n_16_13;
   wire n_16_14;
   wire n_16_15;
   wire n_19_0;
   wire n_19_1;
   wire n_19_2;
   wire n_19_3;
   wire n_19_4;
   wire n_19_5;
   wire n_19_6;
   wire ext_dmem_sel;
   wire n_20_0;
   wire n_20_1;
   wire n_20_2;
   wire n_20_3;
   wire n_20_4;
   wire n_20_5;
   wire eu_dmem_en;
   wire n_21_0;
   wire ext_dmem_en;
   wire n_22_0;
   wire n_22_1;
   wire n_22_2;
   wire n_22_3;
   wire n_22_4;
   wire n_22_5;
   wire n_22_6;
   wire n_22_7;
   wire n_22_8;
   wire n_22_9;
   wire n_24_0;
   wire n_24_1;
   wire n_24_2;
   wire n_24_3;
   wire n_24_4;
   wire n_24_5;
   wire n_24_6;
   wire n_24_7;
   wire n_24_8;
   wire n_24_9;
   wire n_24_10;
   wire n_24_11;
   wire n_24_12;
   wire n_24_13;
   wire n_24_14;
   wire n_24_15;
   wire n_24_16;
   wire n_25_0;
   wire n_25_1;
   wire n_25_2;
   wire n_25_3;
   wire n_25_4;
   wire n_25_5;
   wire n_25_6;
   wire n_25_7;
   wire n_25_8;
   wire n_25_9;
   wire n_25_10;
   wire n_25_11;
   wire n_25_12;
   wire n_25_13;
   wire n_25_14;
   wire n_25_15;
   wire n_25_16;
   wire n_27_0;
   wire n_27_1;
   wire [1:0]ext_mem_wr;
   wire n_27_2;
   wire n_29_0;
   wire n_29_1;
   wire n_29_2;
   wire [1:0]eu_mdb_in_sel;
   wire n_31_0;
   wire n_32_0;
   wire n_32_1;
   wire n_32_2;
   wire n_32_3;
   wire n_32_4;
   wire n_32_5;
   wire n_32_6;
   wire n_32_7;
   wire n_32_8;
   wire n_32_9;
   wire n_32_10;
   wire n_32_11;
   wire n_32_12;
   wire n_32_13;
   wire n_32_14;
   wire n_32_15;
   wire fe_pmem_en_dly;
   wire n_33_0;
   wire fe_pmem_save;
   wire [15:0]pmem_dout_bckup;
   wire n_35_0;
   wire n_35_1;
   wire fe_pmem_restore;
   wire pmem_dout_bckup_sel;
   wire n_37_0;
   wire n_37_1;
   wire n_39_0;
   wire n_39_1;
   wire n_39_2;
   wire n_39_3;
   wire n_39_4;
   wire n_39_5;
   wire n_39_6;
   wire n_39_7;
   wire n_39_8;
   wire n_39_9;
   wire n_39_10;
   wire n_39_11;
   wire n_39_12;
   wire n_39_13;
   wire n_39_14;
   wire n_39_15;
   wire n_39_16;
   wire n_42_0;
   wire n_43_0;
   wire dma_ready_dly;
   wire n_45_0;
   wire n_45_1;
   wire n_45_2;
   wire n_45_3;
   wire n_45_4;
   wire n_45_5;
   wire n_45_6;
   wire n_45_7;
   wire n_45_8;
   wire n_46_0;
   wire n_46_1;
   wire n_46_2;
   wire n_46_3;
   wire n_46_4;
   wire n_46_5;
   wire n_46_6;
   wire n_46_7;
   wire n_46_8;
   wire n_46_9;
   wire n_46_10;
   wire n_46_11;
   wire n_46_12;
   wire n_46_13;
   wire n_46_14;
   wire n_46_15;
   wire n_46_16;
   wire n_47_0;
   wire n_47_1;
   wire n_47_2;
   wire n_49_0;
   wire n_49_1;
   wire n_49_2;
   wire n_49_3;
   wire n_49_4;
   wire n_49_5;
   wire n_49_6;
   wire n_49_7;
   wire n_49_8;
   wire n_49_9;
   wire n_49_10;
   wire n_49_11;
   wire n_51_0;
   wire n_51_1;

   assign per_addr[13] = 1'b0;
   assign per_addr[12] = 1'b0;
   assign per_addr[11] = 1'b0;
   assign per_addr[10] = 1'b0;
   assign per_addr[9] = 1'b0;
   assign per_addr[8] = 1'b0;

   AOI21_X1_LVT i_0_0 (.A(dbg_halt_cmd), .B1(dma_en), .B2(dma_priority), 
      .ZN(n_0_0));
   INV_X1_LVT i_0_1 (.A(n_0_0), .ZN(cpu_halt_cmd));
   OR2_X1_LVT i_4_0 (.A1(dbg_mem_en), .A2(dma_en), .ZN(ext_mem_en));
   AND4_X1_LVT i_8_0 (.A1(fe_mab[12]), .A2(fe_mab[13]), .A3(fe_mab[14]), 
      .A4(fe_mb_en), .ZN(n_8_0));
   AND2_X1_LVT i_8_1 (.A1(n_8_0), .A2(fe_mab[11]), .ZN(fe_pmem_en));
   INV_X1_LVT i_9_0 (.A(fe_pmem_en), .ZN(n_0));
   INV_X1_LVT i_2_0 (.A(dbg_mem_en), .ZN(n_2_0));
   AOI22_X1_LVT i_2_23 (.A1(n_2_0), .A2(dma_addr[12]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[12]), .ZN(n_2_12));
   INV_X1_LVT i_2_24 (.A(n_2_12), .ZN(ext_mem_addr[12]));
   AOI22_X1_LVT i_2_25 (.A1(n_2_0), .A2(dma_addr[13]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[13]), .ZN(n_2_13));
   INV_X1_LVT i_2_26 (.A(n_2_13), .ZN(ext_mem_addr[13]));
   AOI22_X1_LVT i_2_27 (.A1(n_2_0), .A2(dma_addr[14]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[14]), .ZN(n_2_14));
   INV_X1_LVT i_2_28 (.A(n_2_14), .ZN(ext_mem_addr[14]));
   AOI22_X1_LVT i_2_29 (.A1(n_2_0), .A2(dma_addr[15]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[15]), .ZN(n_2_15));
   INV_X1_LVT i_2_30 (.A(n_2_15), .ZN(ext_mem_addr[15]));
   AND4_X1_LVT i_7_0 (.A1(ext_mem_addr[12]), .A2(ext_mem_addr[13]), .A3(
      ext_mem_addr[14]), .A4(ext_mem_addr[15]), .ZN(ext_pmem_sel));
   NAND3_X1_LVT i_12_0 (.A1(ext_mem_en), .A2(n_0), .A3(ext_pmem_sel), .ZN(n_12_0));
   NOR2_X1_LVT i_10_0 (.A1(eu_mb_wr[0]), .A2(eu_mb_wr[1]), .ZN(n_1));
   NAND4_X1_LVT i_11_0 (.A1(eu_mab[13]), .A2(eu_mab[14]), .A3(eu_mb_en), 
      .A4(n_1), .ZN(n_11_0));
   NAND2_X1_LVT i_11_1 (.A1(eu_mab[11]), .A2(eu_mab[12]), .ZN(n_11_1));
   NOR2_X1_LVT i_11_2 (.A1(n_11_0), .A2(n_11_1), .ZN(eu_pmem_en));
   NOR2_X1_LVT i_12_1 (.A1(n_12_0), .A2(eu_pmem_en), .ZN(ext_pmem_en));
   INV_X1_LVT i_13_0 (.A(puc_rst), .ZN(n_2));
   DFFR_X1_LVT \ext_mem_din_sel_reg[1]  (.D(ext_pmem_en), .RN(n_2), .CK(mclk), 
      .Q(ext_mem_din_sel[1]), .QN());
   OR4_X1_LVT i_3_0 (.A1(ext_mem_addr[12]), .A2(ext_mem_addr[13]), .A3(
      ext_mem_addr[14]), .A4(ext_mem_addr[15]), .ZN(n_3_0));
   AOI22_X1_LVT i_2_17 (.A1(n_2_0), .A2(dma_addr[9]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[9]), .ZN(n_2_9));
   INV_X1_LVT i_2_18 (.A(n_2_9), .ZN(ext_mem_addr[9]));
   AOI22_X1_LVT i_2_19 (.A1(n_2_0), .A2(dma_addr[10]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[10]), .ZN(n_2_10));
   INV_X1_LVT i_2_20 (.A(n_2_10), .ZN(ext_mem_addr[10]));
   AOI22_X1_LVT i_2_21 (.A1(n_2_0), .A2(dma_addr[11]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[11]), .ZN(n_2_11));
   INV_X1_LVT i_2_22 (.A(n_2_11), .ZN(ext_mem_addr[11]));
   NOR4_X1_LVT i_3_1 (.A1(n_3_0), .A2(ext_mem_addr[9]), .A3(ext_mem_addr[10]), 
      .A4(ext_mem_addr[11]), .ZN(ext_per_sel));
   NAND2_X1_LVT i_6_0 (.A1(ext_mem_en), .A2(ext_per_sel), .ZN(n_6_0));
   INV_X1_LVT i_5_0 (.A(eu_mb_en), .ZN(n_5_0));
   NOR4_X1_LVT i_5_1 (.A1(n_5_0), .A2(eu_mab[12]), .A3(eu_mab[13]), .A4(
      eu_mab[14]), .ZN(n_5_1));
   NOR4_X1_LVT i_5_2 (.A1(eu_mab[8]), .A2(eu_mab[9]), .A3(eu_mab[10]), .A4(
      eu_mab[11]), .ZN(n_5_2));
   AND2_X1_LVT i_5_3 (.A1(n_5_1), .A2(n_5_2), .ZN(eu_per_en));
   NOR2_X1_LVT i_6_1 (.A1(n_6_0), .A2(eu_per_en), .ZN(ext_per_en));
   DFFR_X1_LVT \ext_mem_din_sel_reg[0]  (.D(ext_per_en), .RN(n_2), .CK(mclk), 
      .Q(ext_mem_din_sel[0]), .QN());
   INV_X1_LVT i_15_1 (.A(ext_mem_din_sel[0]), .ZN(n_15_0));
   NOR2_X1_LVT i_15_2 (.A1(n_15_0), .A2(ext_mem_din_sel[1]), .ZN(n_4));
   DFFR_X1_LVT \per_dout_val_reg[15]  (.D(per_dout[15]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[15]), .QN());
   NOR2_X1_LVT i_15_0 (.A1(ext_mem_din_sel[0]), .A2(ext_mem_din_sel[1]), 
      .ZN(n_3));
   AOI222_X1_LVT i_16_30 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[15]), .B1(n_4), 
      .B2(per_dout_val[15]), .C1(n_3), .C2(dmem_dout[15]), .ZN(n_16_15));
   INV_X1_LVT i_16_31 (.A(n_16_15), .ZN(dbg_mem_din[15]));
   DFFR_X1_LVT \per_dout_val_reg[14]  (.D(per_dout[14]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[14]), .QN());
   AOI222_X1_LVT i_16_28 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[14]), .B1(n_4), 
      .B2(per_dout_val[14]), .C1(n_3), .C2(dmem_dout[14]), .ZN(n_16_14));
   INV_X1_LVT i_16_29 (.A(n_16_14), .ZN(dbg_mem_din[14]));
   DFFR_X1_LVT \per_dout_val_reg[13]  (.D(per_dout[13]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[13]), .QN());
   AOI222_X1_LVT i_16_26 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[13]), .B1(n_4), 
      .B2(per_dout_val[13]), .C1(n_3), .C2(dmem_dout[13]), .ZN(n_16_13));
   INV_X1_LVT i_16_27 (.A(n_16_13), .ZN(dbg_mem_din[13]));
   DFFR_X1_LVT \per_dout_val_reg[12]  (.D(per_dout[12]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[12]), .QN());
   AOI222_X1_LVT i_16_24 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[12]), .B1(n_4), 
      .B2(per_dout_val[12]), .C1(n_3), .C2(dmem_dout[12]), .ZN(n_16_12));
   INV_X1_LVT i_16_25 (.A(n_16_12), .ZN(dbg_mem_din[12]));
   DFFR_X1_LVT \per_dout_val_reg[11]  (.D(per_dout[11]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[11]), .QN());
   AOI222_X1_LVT i_16_22 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[11]), .B1(n_4), 
      .B2(per_dout_val[11]), .C1(n_3), .C2(dmem_dout[11]), .ZN(n_16_11));
   INV_X1_LVT i_16_23 (.A(n_16_11), .ZN(dbg_mem_din[11]));
   DFFR_X1_LVT \per_dout_val_reg[10]  (.D(per_dout[10]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[10]), .QN());
   AOI222_X1_LVT i_16_20 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[10]), .B1(n_4), 
      .B2(per_dout_val[10]), .C1(n_3), .C2(dmem_dout[10]), .ZN(n_16_10));
   INV_X1_LVT i_16_21 (.A(n_16_10), .ZN(dbg_mem_din[10]));
   DFFR_X1_LVT \per_dout_val_reg[9]  (.D(per_dout[9]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[9]), .QN());
   AOI222_X1_LVT i_16_18 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[9]), .B1(n_4), 
      .B2(per_dout_val[9]), .C1(n_3), .C2(dmem_dout[9]), .ZN(n_16_9));
   INV_X1_LVT i_16_19 (.A(n_16_9), .ZN(dbg_mem_din[9]));
   DFFR_X1_LVT \per_dout_val_reg[8]  (.D(per_dout[8]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[8]), .QN());
   AOI222_X1_LVT i_16_16 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[8]), .B1(n_4), 
      .B2(per_dout_val[8]), .C1(n_3), .C2(dmem_dout[8]), .ZN(n_16_8));
   INV_X1_LVT i_16_17 (.A(n_16_8), .ZN(dbg_mem_din[8]));
   DFFR_X1_LVT \per_dout_val_reg[7]  (.D(per_dout[7]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[7]), .QN());
   AOI222_X1_LVT i_16_14 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[7]), .B1(n_4), 
      .B2(per_dout_val[7]), .C1(n_3), .C2(dmem_dout[7]), .ZN(n_16_7));
   INV_X1_LVT i_16_15 (.A(n_16_7), .ZN(dbg_mem_din[7]));
   DFFR_X1_LVT \per_dout_val_reg[6]  (.D(per_dout[6]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[6]), .QN());
   AOI222_X1_LVT i_16_12 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[6]), .B1(n_4), 
      .B2(per_dout_val[6]), .C1(n_3), .C2(dmem_dout[6]), .ZN(n_16_6));
   INV_X1_LVT i_16_13 (.A(n_16_6), .ZN(dbg_mem_din[6]));
   DFFR_X1_LVT \per_dout_val_reg[5]  (.D(per_dout[5]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[5]), .QN());
   AOI222_X1_LVT i_16_10 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[5]), .B1(n_4), 
      .B2(per_dout_val[5]), .C1(n_3), .C2(dmem_dout[5]), .ZN(n_16_5));
   INV_X1_LVT i_16_11 (.A(n_16_5), .ZN(dbg_mem_din[5]));
   DFFR_X1_LVT \per_dout_val_reg[4]  (.D(per_dout[4]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[4]), .QN());
   AOI222_X1_LVT i_16_8 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[4]), .B1(n_4), 
      .B2(per_dout_val[4]), .C1(n_3), .C2(dmem_dout[4]), .ZN(n_16_4));
   INV_X1_LVT i_16_9 (.A(n_16_4), .ZN(dbg_mem_din[4]));
   DFFR_X1_LVT \per_dout_val_reg[3]  (.D(per_dout[3]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[3]), .QN());
   AOI222_X1_LVT i_16_6 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[3]), .B1(n_4), 
      .B2(per_dout_val[3]), .C1(n_3), .C2(dmem_dout[3]), .ZN(n_16_3));
   INV_X1_LVT i_16_7 (.A(n_16_3), .ZN(dbg_mem_din[3]));
   DFFR_X1_LVT \per_dout_val_reg[2]  (.D(per_dout[2]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[2]), .QN());
   AOI222_X1_LVT i_16_4 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[2]), .B1(n_4), 
      .B2(per_dout_val[2]), .C1(n_3), .C2(dmem_dout[2]), .ZN(n_16_2));
   INV_X1_LVT i_16_5 (.A(n_16_2), .ZN(dbg_mem_din[2]));
   DFFR_X1_LVT \per_dout_val_reg[1]  (.D(per_dout[1]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[1]), .QN());
   AOI222_X1_LVT i_16_2 (.A1(ext_mem_din_sel[1]), .A2(pmem_dout[1]), .B1(n_4), 
      .B2(per_dout_val[1]), .C1(n_3), .C2(dmem_dout[1]), .ZN(n_16_1));
   INV_X1_LVT i_16_3 (.A(n_16_1), .ZN(dbg_mem_din[1]));
   DFFR_X1_LVT \per_dout_val_reg[0]  (.D(per_dout[0]), .RN(n_2), .CK(mclk), 
      .Q(per_dout_val[0]), .QN());
   AOI222_X1_LVT i_16_0 (.A1(pmem_dout[0]), .A2(ext_mem_din_sel[1]), .B1(
      per_dout_val[0]), .B2(n_4), .C1(dmem_dout[0]), .C2(n_3), .ZN(n_16_0));
   INV_X1_LVT i_16_1 (.A(n_16_0), .ZN(dbg_mem_din[0]));
   INV_X1_LVT i_19_0 (.A(ext_mem_addr[12]), .ZN(n_19_0));
   INV_X1_LVT i_19_1 (.A(ext_mem_addr[13]), .ZN(n_19_1));
   INV_X1_LVT i_19_2 (.A(ext_mem_addr[14]), .ZN(n_19_2));
   INV_X1_LVT i_19_3 (.A(ext_mem_addr[15]), .ZN(n_19_3));
   NAND4_X1_LVT i_19_4 (.A1(n_19_0), .A2(n_19_1), .A3(n_19_2), .A4(n_19_3), 
      .ZN(n_19_4));
   NOR4_X1_LVT i_19_5 (.A1(n_19_4), .A2(ext_mem_addr[9]), .A3(ext_mem_addr[10]), 
      .A4(ext_mem_addr[11]), .ZN(n_19_5));
   AND2_X1_LVT i_19_6 (.A1(ext_mem_addr[9]), .A2(ext_mem_addr[10]), .ZN(n_19_6));
   NOR4_X1_LVT i_19_7 (.A1(n_19_4), .A2(n_19_5), .A3(n_19_6), .A4(
      ext_mem_addr[11]), .ZN(ext_dmem_sel));
   NAND2_X1_LVT i_21_0 (.A1(ext_mem_en), .A2(ext_dmem_sel), .ZN(n_21_0));
   OR4_X1_LVT i_20_0 (.A1(eu_mab[11]), .A2(eu_mab[12]), .A3(eu_mab[13]), 
      .A4(eu_mab[14]), .ZN(n_20_0));
   NOR4_X1_LVT i_20_1 (.A1(n_20_0), .A2(eu_mab[8]), .A3(eu_mab[9]), .A4(
      eu_mab[10]), .ZN(n_20_1));
   AND2_X1_LVT i_20_2 (.A1(eu_mab[8]), .A2(eu_mab[9]), .ZN(n_20_2));
   NOR4_X1_LVT i_20_3 (.A1(n_20_1), .A2(n_20_2), .A3(eu_mab[10]), .A4(eu_mab[11]), 
      .ZN(n_20_3));
   INV_X1_LVT i_20_4 (.A(eu_mb_en), .ZN(n_20_4));
   NOR4_X1_LVT i_20_5 (.A1(n_20_4), .A2(eu_mab[12]), .A3(eu_mab[13]), .A4(
      eu_mab[14]), .ZN(n_20_5));
   AND2_X1_LVT i_20_6 (.A1(n_20_3), .A2(n_20_5), .ZN(eu_dmem_en));
   NOR2_X1_LVT i_21_1 (.A1(n_21_0), .A2(eu_dmem_en), .ZN(ext_dmem_en));
   INV_X1_LVT i_22_0 (.A(ext_dmem_en), .ZN(n_22_0));
   INV_X1_LVT i_17_0 (.A(eu_mab[8]), .ZN(n_5));
   INV_X1_LVT i_18_0 (.A(ext_mem_addr[9]), .ZN(n_6));
   AOI22_X1_LVT i_22_17 (.A1(n_22_0), .A2(n_5), .B1(ext_dmem_en), .B2(n_6), 
      .ZN(n_22_9));
   INV_X1_LVT i_22_18 (.A(n_22_9), .ZN(dmem_addr[8]));
   AOI22_X1_LVT i_2_15 (.A1(n_2_0), .A2(dma_addr[8]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[8]), .ZN(n_2_8));
   INV_X1_LVT i_2_16 (.A(n_2_8), .ZN(ext_mem_addr[8]));
   AOI22_X1_LVT i_22_15 (.A1(n_22_0), .A2(eu_mab[7]), .B1(ext_dmem_en), .B2(
      ext_mem_addr[8]), .ZN(n_22_8));
   INV_X1_LVT i_22_16 (.A(n_22_8), .ZN(dmem_addr[7]));
   AOI22_X1_LVT i_2_13 (.A1(n_2_0), .A2(dma_addr[7]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[7]), .ZN(n_2_7));
   INV_X1_LVT i_2_14 (.A(n_2_7), .ZN(ext_mem_addr[7]));
   AOI22_X1_LVT i_22_13 (.A1(n_22_0), .A2(eu_mab[6]), .B1(ext_dmem_en), .B2(
      ext_mem_addr[7]), .ZN(n_22_7));
   INV_X1_LVT i_22_14 (.A(n_22_7), .ZN(dmem_addr[6]));
   AOI22_X1_LVT i_2_11 (.A1(n_2_0), .A2(dma_addr[6]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[6]), .ZN(n_2_6));
   INV_X1_LVT i_2_12 (.A(n_2_6), .ZN(ext_mem_addr[6]));
   AOI22_X1_LVT i_22_11 (.A1(n_22_0), .A2(eu_mab[5]), .B1(ext_dmem_en), .B2(
      ext_mem_addr[6]), .ZN(n_22_6));
   INV_X1_LVT i_22_12 (.A(n_22_6), .ZN(dmem_addr[5]));
   AOI22_X1_LVT i_2_9 (.A1(n_2_0), .A2(dma_addr[5]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[5]), .ZN(n_2_5));
   INV_X1_LVT i_2_10 (.A(n_2_5), .ZN(ext_mem_addr[5]));
   AOI22_X1_LVT i_22_9 (.A1(n_22_0), .A2(eu_mab[4]), .B1(ext_dmem_en), .B2(
      ext_mem_addr[5]), .ZN(n_22_5));
   INV_X1_LVT i_22_10 (.A(n_22_5), .ZN(dmem_addr[4]));
   AOI22_X1_LVT i_2_7 (.A1(n_2_0), .A2(dma_addr[4]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[4]), .ZN(n_2_4));
   INV_X1_LVT i_2_8 (.A(n_2_4), .ZN(ext_mem_addr[4]));
   AOI22_X1_LVT i_22_7 (.A1(n_22_0), .A2(eu_mab[3]), .B1(ext_dmem_en), .B2(
      ext_mem_addr[4]), .ZN(n_22_4));
   INV_X1_LVT i_22_8 (.A(n_22_4), .ZN(dmem_addr[3]));
   AOI22_X1_LVT i_2_5 (.A1(n_2_0), .A2(dma_addr[3]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[3]), .ZN(n_2_3));
   INV_X1_LVT i_2_6 (.A(n_2_3), .ZN(ext_mem_addr[3]));
   AOI22_X1_LVT i_22_5 (.A1(n_22_0), .A2(eu_mab[2]), .B1(ext_dmem_en), .B2(
      ext_mem_addr[3]), .ZN(n_22_3));
   INV_X1_LVT i_22_6 (.A(n_22_3), .ZN(dmem_addr[2]));
   AOI22_X1_LVT i_2_3 (.A1(n_2_0), .A2(dma_addr[2]), .B1(dbg_mem_en), .B2(
      dbg_mem_addr[2]), .ZN(n_2_2));
   INV_X1_LVT i_2_4 (.A(n_2_2), .ZN(ext_mem_addr[2]));
   AOI22_X1_LVT i_22_3 (.A1(n_22_0), .A2(eu_mab[1]), .B1(ext_dmem_en), .B2(
      ext_mem_addr[2]), .ZN(n_22_2));
   INV_X1_LVT i_22_4 (.A(n_22_2), .ZN(dmem_addr[1]));
   AOI22_X1_LVT i_2_1 (.A1(n_2_0), .A2(dma_addr[1]), .B1(dbg_mem_addr[1]), 
      .B2(dbg_mem_en), .ZN(n_2_1));
   INV_X1_LVT i_2_2 (.A(n_2_1), .ZN(ext_mem_addr[1]));
   AOI22_X1_LVT i_22_1 (.A1(n_22_0), .A2(eu_mab[0]), .B1(ext_mem_addr[1]), 
      .B2(ext_dmem_en), .ZN(n_22_1));
   INV_X1_LVT i_22_2 (.A(n_22_1), .ZN(dmem_addr[0]));
   NOR2_X1_LVT i_23_0 (.A1(ext_dmem_en), .A2(eu_dmem_en), .ZN(dmem_cen));
   INV_X1_LVT i_25_0 (.A(ext_dmem_en), .ZN(n_25_0));
   INV_X1_LVT i_24_0 (.A(dbg_mem_en), .ZN(n_24_0));
   AOI22_X1_LVT i_24_31 (.A1(n_24_0), .A2(dma_din[15]), .B1(dbg_mem_en), 
      .B2(dbg_mem_dout[15]), .ZN(n_24_16));
   INV_X1_LVT i_24_32 (.A(n_24_16), .ZN(pmem_din[15]));
   AOI22_X1_LVT i_25_31 (.A1(n_25_0), .A2(eu_mdb_out[15]), .B1(ext_dmem_en), 
      .B2(pmem_din[15]), .ZN(n_25_16));
   INV_X1_LVT i_25_32 (.A(n_25_16), .ZN(dmem_din[15]));
   AOI22_X1_LVT i_24_29 (.A1(n_24_0), .A2(dma_din[14]), .B1(dbg_mem_en), 
      .B2(dbg_mem_dout[14]), .ZN(n_24_15));
   INV_X1_LVT i_24_30 (.A(n_24_15), .ZN(pmem_din[14]));
   AOI22_X1_LVT i_25_29 (.A1(n_25_0), .A2(eu_mdb_out[14]), .B1(ext_dmem_en), 
      .B2(pmem_din[14]), .ZN(n_25_15));
   INV_X1_LVT i_25_30 (.A(n_25_15), .ZN(dmem_din[14]));
   AOI22_X1_LVT i_24_27 (.A1(n_24_0), .A2(dma_din[13]), .B1(dbg_mem_en), 
      .B2(dbg_mem_dout[13]), .ZN(n_24_14));
   INV_X1_LVT i_24_28 (.A(n_24_14), .ZN(pmem_din[13]));
   AOI22_X1_LVT i_25_27 (.A1(n_25_0), .A2(eu_mdb_out[13]), .B1(ext_dmem_en), 
      .B2(pmem_din[13]), .ZN(n_25_14));
   INV_X1_LVT i_25_28 (.A(n_25_14), .ZN(dmem_din[13]));
   AOI22_X1_LVT i_24_25 (.A1(n_24_0), .A2(dma_din[12]), .B1(dbg_mem_en), 
      .B2(dbg_mem_dout[12]), .ZN(n_24_13));
   INV_X1_LVT i_24_26 (.A(n_24_13), .ZN(pmem_din[12]));
   AOI22_X1_LVT i_25_25 (.A1(n_25_0), .A2(eu_mdb_out[12]), .B1(ext_dmem_en), 
      .B2(pmem_din[12]), .ZN(n_25_13));
   INV_X1_LVT i_25_26 (.A(n_25_13), .ZN(dmem_din[12]));
   AOI22_X1_LVT i_24_23 (.A1(n_24_0), .A2(dma_din[11]), .B1(dbg_mem_en), 
      .B2(dbg_mem_dout[11]), .ZN(n_24_12));
   INV_X1_LVT i_24_24 (.A(n_24_12), .ZN(pmem_din[11]));
   AOI22_X1_LVT i_25_23 (.A1(n_25_0), .A2(eu_mdb_out[11]), .B1(ext_dmem_en), 
      .B2(pmem_din[11]), .ZN(n_25_12));
   INV_X1_LVT i_25_24 (.A(n_25_12), .ZN(dmem_din[11]));
   AOI22_X1_LVT i_24_21 (.A1(n_24_0), .A2(dma_din[10]), .B1(dbg_mem_en), 
      .B2(dbg_mem_dout[10]), .ZN(n_24_11));
   INV_X1_LVT i_24_22 (.A(n_24_11), .ZN(pmem_din[10]));
   AOI22_X1_LVT i_25_21 (.A1(n_25_0), .A2(eu_mdb_out[10]), .B1(ext_dmem_en), 
      .B2(pmem_din[10]), .ZN(n_25_11));
   INV_X1_LVT i_25_22 (.A(n_25_11), .ZN(dmem_din[10]));
   AOI22_X1_LVT i_24_19 (.A1(n_24_0), .A2(dma_din[9]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[9]), .ZN(n_24_10));
   INV_X1_LVT i_24_20 (.A(n_24_10), .ZN(pmem_din[9]));
   AOI22_X1_LVT i_25_19 (.A1(n_25_0), .A2(eu_mdb_out[9]), .B1(ext_dmem_en), 
      .B2(pmem_din[9]), .ZN(n_25_10));
   INV_X1_LVT i_25_20 (.A(n_25_10), .ZN(dmem_din[9]));
   AOI22_X1_LVT i_24_17 (.A1(n_24_0), .A2(dma_din[8]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[8]), .ZN(n_24_9));
   INV_X1_LVT i_24_18 (.A(n_24_9), .ZN(pmem_din[8]));
   AOI22_X1_LVT i_25_17 (.A1(n_25_0), .A2(eu_mdb_out[8]), .B1(ext_dmem_en), 
      .B2(pmem_din[8]), .ZN(n_25_9));
   INV_X1_LVT i_25_18 (.A(n_25_9), .ZN(dmem_din[8]));
   AOI22_X1_LVT i_24_15 (.A1(n_24_0), .A2(dma_din[7]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[7]), .ZN(n_24_8));
   INV_X1_LVT i_24_16 (.A(n_24_8), .ZN(pmem_din[7]));
   AOI22_X1_LVT i_25_15 (.A1(n_25_0), .A2(eu_mdb_out[7]), .B1(ext_dmem_en), 
      .B2(pmem_din[7]), .ZN(n_25_8));
   INV_X1_LVT i_25_16 (.A(n_25_8), .ZN(dmem_din[7]));
   AOI22_X1_LVT i_24_13 (.A1(n_24_0), .A2(dma_din[6]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[6]), .ZN(n_24_7));
   INV_X1_LVT i_24_14 (.A(n_24_7), .ZN(pmem_din[6]));
   AOI22_X1_LVT i_25_13 (.A1(n_25_0), .A2(eu_mdb_out[6]), .B1(ext_dmem_en), 
      .B2(pmem_din[6]), .ZN(n_25_7));
   INV_X1_LVT i_25_14 (.A(n_25_7), .ZN(dmem_din[6]));
   AOI22_X1_LVT i_24_11 (.A1(n_24_0), .A2(dma_din[5]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[5]), .ZN(n_24_6));
   INV_X1_LVT i_24_12 (.A(n_24_6), .ZN(pmem_din[5]));
   AOI22_X1_LVT i_25_11 (.A1(n_25_0), .A2(eu_mdb_out[5]), .B1(ext_dmem_en), 
      .B2(pmem_din[5]), .ZN(n_25_6));
   INV_X1_LVT i_25_12 (.A(n_25_6), .ZN(dmem_din[5]));
   AOI22_X1_LVT i_24_9 (.A1(n_24_0), .A2(dma_din[4]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[4]), .ZN(n_24_5));
   INV_X1_LVT i_24_10 (.A(n_24_5), .ZN(pmem_din[4]));
   AOI22_X1_LVT i_25_9 (.A1(n_25_0), .A2(eu_mdb_out[4]), .B1(ext_dmem_en), 
      .B2(pmem_din[4]), .ZN(n_25_5));
   INV_X1_LVT i_25_10 (.A(n_25_5), .ZN(dmem_din[4]));
   AOI22_X1_LVT i_24_7 (.A1(n_24_0), .A2(dma_din[3]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[3]), .ZN(n_24_4));
   INV_X1_LVT i_24_8 (.A(n_24_4), .ZN(pmem_din[3]));
   AOI22_X1_LVT i_25_7 (.A1(n_25_0), .A2(eu_mdb_out[3]), .B1(ext_dmem_en), 
      .B2(pmem_din[3]), .ZN(n_25_4));
   INV_X1_LVT i_25_8 (.A(n_25_4), .ZN(dmem_din[3]));
   AOI22_X1_LVT i_24_5 (.A1(n_24_0), .A2(dma_din[2]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[2]), .ZN(n_24_3));
   INV_X1_LVT i_24_6 (.A(n_24_3), .ZN(pmem_din[2]));
   AOI22_X1_LVT i_25_5 (.A1(n_25_0), .A2(eu_mdb_out[2]), .B1(ext_dmem_en), 
      .B2(pmem_din[2]), .ZN(n_25_3));
   INV_X1_LVT i_25_6 (.A(n_25_3), .ZN(dmem_din[2]));
   AOI22_X1_LVT i_24_3 (.A1(n_24_0), .A2(dma_din[1]), .B1(dbg_mem_en), .B2(
      dbg_mem_dout[1]), .ZN(n_24_2));
   INV_X1_LVT i_24_4 (.A(n_24_2), .ZN(pmem_din[1]));
   AOI22_X1_LVT i_25_3 (.A1(n_25_0), .A2(eu_mdb_out[1]), .B1(ext_dmem_en), 
      .B2(pmem_din[1]), .ZN(n_25_2));
   INV_X1_LVT i_25_4 (.A(n_25_2), .ZN(dmem_din[1]));
   AOI22_X1_LVT i_24_1 (.A1(n_24_0), .A2(dma_din[0]), .B1(dbg_mem_dout[0]), 
      .B2(dbg_mem_en), .ZN(n_24_1));
   INV_X1_LVT i_24_2 (.A(n_24_1), .ZN(pmem_din[0]));
   AOI22_X1_LVT i_25_1 (.A1(n_25_0), .A2(eu_mdb_out[0]), .B1(pmem_din[0]), 
      .B2(ext_dmem_en), .ZN(n_25_1));
   INV_X1_LVT i_25_2 (.A(n_25_1), .ZN(dmem_din[0]));
   INV_X1_LVT i_29_0 (.A(ext_dmem_en), .ZN(n_29_0));
   INV_X1_LVT i_26_1 (.A(eu_mb_wr[1]), .ZN(n_8));
   INV_X1_LVT i_27_0 (.A(dbg_mem_en), .ZN(n_27_0));
   AOI22_X1_LVT i_27_3 (.A1(n_27_0), .A2(dma_we[1]), .B1(dbg_mem_en), .B2(
      dbg_mem_wr[1]), .ZN(n_27_2));
   INV_X1_LVT i_27_4 (.A(n_27_2), .ZN(ext_mem_wr[1]));
   INV_X1_LVT i_28_1 (.A(ext_mem_wr[1]), .ZN(n_10));
   AOI22_X1_LVT i_29_3 (.A1(n_29_0), .A2(n_8), .B1(ext_dmem_en), .B2(n_10), 
      .ZN(n_29_2));
   INV_X1_LVT i_29_4 (.A(n_29_2), .ZN(dmem_wen[1]));
   INV_X1_LVT i_26_0 (.A(eu_mb_wr[0]), .ZN(n_7));
   AOI22_X1_LVT i_27_1 (.A1(n_27_0), .A2(dma_we[0]), .B1(dbg_mem_wr[0]), 
      .B2(dbg_mem_en), .ZN(n_27_1));
   INV_X1_LVT i_27_2 (.A(n_27_1), .ZN(ext_mem_wr[0]));
   INV_X1_LVT i_28_0 (.A(ext_mem_wr[0]), .ZN(n_9));
   AOI22_X1_LVT i_29_1 (.A1(n_29_0), .A2(n_7), .B1(n_9), .B2(ext_dmem_en), 
      .ZN(n_29_1));
   INV_X1_LVT i_29_2 (.A(n_29_1), .ZN(dmem_wen[0]));
   DFFR_X1_LVT \eu_mdb_in_sel_reg[1]  (.D(eu_pmem_en), .RN(n_2), .CK(mclk), 
      .Q(eu_mdb_in_sel[1]), .QN());
   DFFR_X1_LVT \eu_mdb_in_sel_reg[0]  (.D(eu_per_en), .RN(n_2), .CK(mclk), 
      .Q(eu_mdb_in_sel[0]), .QN());
   INV_X1_LVT i_31_1 (.A(eu_mdb_in_sel[0]), .ZN(n_31_0));
   NOR2_X1_LVT i_31_2 (.A1(n_31_0), .A2(eu_mdb_in_sel[1]), .ZN(n_12));
   NOR2_X1_LVT i_31_0 (.A1(eu_mdb_in_sel[0]), .A2(eu_mdb_in_sel[1]), .ZN(n_11));
   AOI222_X1_LVT i_32_30 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[15]), .B1(n_12), 
      .B2(per_dout_val[15]), .C1(n_11), .C2(dmem_dout[15]), .ZN(n_32_15));
   INV_X1_LVT i_32_31 (.A(n_32_15), .ZN(eu_mdb_in[15]));
   AOI222_X1_LVT i_32_28 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[14]), .B1(n_12), 
      .B2(per_dout_val[14]), .C1(n_11), .C2(dmem_dout[14]), .ZN(n_32_14));
   INV_X1_LVT i_32_29 (.A(n_32_14), .ZN(eu_mdb_in[14]));
   AOI222_X1_LVT i_32_26 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[13]), .B1(n_12), 
      .B2(per_dout_val[13]), .C1(n_11), .C2(dmem_dout[13]), .ZN(n_32_13));
   INV_X1_LVT i_32_27 (.A(n_32_13), .ZN(eu_mdb_in[13]));
   AOI222_X1_LVT i_32_24 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[12]), .B1(n_12), 
      .B2(per_dout_val[12]), .C1(n_11), .C2(dmem_dout[12]), .ZN(n_32_12));
   INV_X1_LVT i_32_25 (.A(n_32_12), .ZN(eu_mdb_in[12]));
   AOI222_X1_LVT i_32_22 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[11]), .B1(n_12), 
      .B2(per_dout_val[11]), .C1(n_11), .C2(dmem_dout[11]), .ZN(n_32_11));
   INV_X1_LVT i_32_23 (.A(n_32_11), .ZN(eu_mdb_in[11]));
   AOI222_X1_LVT i_32_20 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[10]), .B1(n_12), 
      .B2(per_dout_val[10]), .C1(n_11), .C2(dmem_dout[10]), .ZN(n_32_10));
   INV_X1_LVT i_32_21 (.A(n_32_10), .ZN(eu_mdb_in[10]));
   AOI222_X1_LVT i_32_18 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[9]), .B1(n_12), 
      .B2(per_dout_val[9]), .C1(n_11), .C2(dmem_dout[9]), .ZN(n_32_9));
   INV_X1_LVT i_32_19 (.A(n_32_9), .ZN(eu_mdb_in[9]));
   AOI222_X1_LVT i_32_16 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[8]), .B1(n_12), 
      .B2(per_dout_val[8]), .C1(n_11), .C2(dmem_dout[8]), .ZN(n_32_8));
   INV_X1_LVT i_32_17 (.A(n_32_8), .ZN(eu_mdb_in[8]));
   AOI222_X1_LVT i_32_14 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[7]), .B1(n_12), 
      .B2(per_dout_val[7]), .C1(n_11), .C2(dmem_dout[7]), .ZN(n_32_7));
   INV_X1_LVT i_32_15 (.A(n_32_7), .ZN(eu_mdb_in[7]));
   AOI222_X1_LVT i_32_12 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[6]), .B1(n_12), 
      .B2(per_dout_val[6]), .C1(n_11), .C2(dmem_dout[6]), .ZN(n_32_6));
   INV_X1_LVT i_32_13 (.A(n_32_6), .ZN(eu_mdb_in[6]));
   AOI222_X1_LVT i_32_10 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[5]), .B1(n_12), 
      .B2(per_dout_val[5]), .C1(n_11), .C2(dmem_dout[5]), .ZN(n_32_5));
   INV_X1_LVT i_32_11 (.A(n_32_5), .ZN(eu_mdb_in[5]));
   AOI222_X1_LVT i_32_8 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[4]), .B1(n_12), 
      .B2(per_dout_val[4]), .C1(n_11), .C2(dmem_dout[4]), .ZN(n_32_4));
   INV_X1_LVT i_32_9 (.A(n_32_4), .ZN(eu_mdb_in[4]));
   AOI222_X1_LVT i_32_6 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[3]), .B1(n_12), 
      .B2(per_dout_val[3]), .C1(n_11), .C2(dmem_dout[3]), .ZN(n_32_3));
   INV_X1_LVT i_32_7 (.A(n_32_3), .ZN(eu_mdb_in[3]));
   AOI222_X1_LVT i_32_4 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[2]), .B1(n_12), 
      .B2(per_dout_val[2]), .C1(n_11), .C2(dmem_dout[2]), .ZN(n_32_2));
   INV_X1_LVT i_32_5 (.A(n_32_2), .ZN(eu_mdb_in[2]));
   AOI222_X1_LVT i_32_2 (.A1(eu_mdb_in_sel[1]), .A2(pmem_dout[1]), .B1(n_12), 
      .B2(per_dout_val[1]), .C1(n_11), .C2(dmem_dout[1]), .ZN(n_32_1));
   INV_X1_LVT i_32_3 (.A(n_32_1), .ZN(eu_mdb_in[1]));
   AOI222_X1_LVT i_32_0 (.A1(pmem_dout[0]), .A2(eu_mdb_in_sel[1]), .B1(
      per_dout_val[0]), .B2(n_12), .C1(dmem_dout[0]), .C2(n_11), .ZN(n_32_0));
   INV_X1_LVT i_32_1 (.A(n_32_0), .ZN(eu_mdb_in[0]));
   DFFR_X1_LVT fe_pmem_en_dly_reg (.D(fe_pmem_en), .RN(n_2), .CK(mclk), .Q(
      fe_pmem_en_dly), .QN());
   NAND2_X1_LVT i_33_0 (.A1(n_0), .A2(fe_pmem_en_dly), .ZN(n_33_0));
   NOR2_X1_LVT i_33_1 (.A1(n_33_0), .A2(cpu_halt_st), .ZN(fe_pmem_save));
   INV_X1_LVT i_35_0 (.A(cpu_halt_st), .ZN(n_35_0));
   INV_X1_LVT i_35_1 (.A(fe_pmem_en), .ZN(n_35_1));
   OAI21_X1_LVT i_35_2 (.A(n_35_0), .B1(n_35_1), .B2(fe_pmem_en_dly), .ZN(
      fe_pmem_restore));
   INV_X1_LVT i_37_1 (.A(fe_pmem_restore), .ZN(n_37_1));
   INV_X1_LVT i_37_0 (.A(fe_pmem_save), .ZN(n_37_0));
   NAND2_X1_LVT i_37_2 (.A1(n_37_1), .A2(n_37_0), .ZN(n_15));
   CLKGATETST_X1_LVT clk_gate_pmem_dout_bckup_sel_reg (.CK(mclk), .E(n_15), 
      .SE(1'b0), .GCK(n_14));
   DFFR_X1_LVT pmem_dout_bckup_sel_reg (.D(fe_pmem_save), .RN(n_2), .CK(n_14), 
      .Q(pmem_dout_bckup_sel), .QN());
   INV_X1_LVT i_39_0 (.A(pmem_dout_bckup_sel), .ZN(n_39_0));
   CLKGATETST_X1_LVT clk_gate_pmem_dout_bckup_reg (.CK(mclk), .E(fe_pmem_save), 
      .SE(1'b0), .GCK(n_13));
   DFFR_X1_LVT \pmem_dout_bckup_reg[15]  (.D(pmem_dout[15]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[15]), .QN());
   AOI22_X1_LVT i_39_31 (.A1(n_39_0), .A2(pmem_dout[15]), .B1(
      pmem_dout_bckup_sel), .B2(pmem_dout_bckup[15]), .ZN(n_39_16));
   INV_X1_LVT i_39_32 (.A(n_39_16), .ZN(fe_mdb_in[15]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[14]  (.D(pmem_dout[14]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[14]), .QN());
   AOI22_X1_LVT i_39_29 (.A1(n_39_0), .A2(pmem_dout[14]), .B1(
      pmem_dout_bckup_sel), .B2(pmem_dout_bckup[14]), .ZN(n_39_15));
   INV_X1_LVT i_39_30 (.A(n_39_15), .ZN(fe_mdb_in[14]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[13]  (.D(pmem_dout[13]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[13]), .QN());
   AOI22_X1_LVT i_39_27 (.A1(n_39_0), .A2(pmem_dout[13]), .B1(
      pmem_dout_bckup_sel), .B2(pmem_dout_bckup[13]), .ZN(n_39_14));
   INV_X1_LVT i_39_28 (.A(n_39_14), .ZN(fe_mdb_in[13]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[12]  (.D(pmem_dout[12]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[12]), .QN());
   AOI22_X1_LVT i_39_25 (.A1(n_39_0), .A2(pmem_dout[12]), .B1(
      pmem_dout_bckup_sel), .B2(pmem_dout_bckup[12]), .ZN(n_39_13));
   INV_X1_LVT i_39_26 (.A(n_39_13), .ZN(fe_mdb_in[12]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[11]  (.D(pmem_dout[11]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[11]), .QN());
   AOI22_X1_LVT i_39_23 (.A1(n_39_0), .A2(pmem_dout[11]), .B1(
      pmem_dout_bckup_sel), .B2(pmem_dout_bckup[11]), .ZN(n_39_12));
   INV_X1_LVT i_39_24 (.A(n_39_12), .ZN(fe_mdb_in[11]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[10]  (.D(pmem_dout[10]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[10]), .QN());
   AOI22_X1_LVT i_39_21 (.A1(n_39_0), .A2(pmem_dout[10]), .B1(
      pmem_dout_bckup_sel), .B2(pmem_dout_bckup[10]), .ZN(n_39_11));
   INV_X1_LVT i_39_22 (.A(n_39_11), .ZN(fe_mdb_in[10]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[9]  (.D(pmem_dout[9]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[9]), .QN());
   AOI22_X1_LVT i_39_19 (.A1(n_39_0), .A2(pmem_dout[9]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[9]), .ZN(n_39_10));
   INV_X1_LVT i_39_20 (.A(n_39_10), .ZN(fe_mdb_in[9]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[8]  (.D(pmem_dout[8]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[8]), .QN());
   AOI22_X1_LVT i_39_17 (.A1(n_39_0), .A2(pmem_dout[8]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[8]), .ZN(n_39_9));
   INV_X1_LVT i_39_18 (.A(n_39_9), .ZN(fe_mdb_in[8]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[7]  (.D(pmem_dout[7]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[7]), .QN());
   AOI22_X1_LVT i_39_15 (.A1(n_39_0), .A2(pmem_dout[7]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[7]), .ZN(n_39_8));
   INV_X1_LVT i_39_16 (.A(n_39_8), .ZN(fe_mdb_in[7]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[6]  (.D(pmem_dout[6]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[6]), .QN());
   AOI22_X1_LVT i_39_13 (.A1(n_39_0), .A2(pmem_dout[6]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[6]), .ZN(n_39_7));
   INV_X1_LVT i_39_14 (.A(n_39_7), .ZN(fe_mdb_in[6]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[5]  (.D(pmem_dout[5]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[5]), .QN());
   AOI22_X1_LVT i_39_11 (.A1(n_39_0), .A2(pmem_dout[5]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[5]), .ZN(n_39_6));
   INV_X1_LVT i_39_12 (.A(n_39_6), .ZN(fe_mdb_in[5]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[4]  (.D(pmem_dout[4]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[4]), .QN());
   AOI22_X1_LVT i_39_9 (.A1(n_39_0), .A2(pmem_dout[4]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[4]), .ZN(n_39_5));
   INV_X1_LVT i_39_10 (.A(n_39_5), .ZN(fe_mdb_in[4]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[3]  (.D(pmem_dout[3]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[3]), .QN());
   AOI22_X1_LVT i_39_7 (.A1(n_39_0), .A2(pmem_dout[3]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[3]), .ZN(n_39_4));
   INV_X1_LVT i_39_8 (.A(n_39_4), .ZN(fe_mdb_in[3]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[2]  (.D(pmem_dout[2]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[2]), .QN());
   AOI22_X1_LVT i_39_5 (.A1(n_39_0), .A2(pmem_dout[2]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[2]), .ZN(n_39_3));
   INV_X1_LVT i_39_6 (.A(n_39_3), .ZN(fe_mdb_in[2]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[1]  (.D(pmem_dout[1]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[1]), .QN());
   AOI22_X1_LVT i_39_3 (.A1(n_39_0), .A2(pmem_dout[1]), .B1(pmem_dout_bckup_sel), 
      .B2(pmem_dout_bckup[1]), .ZN(n_39_2));
   INV_X1_LVT i_39_4 (.A(n_39_2), .ZN(fe_mdb_in[1]));
   DFFR_X1_LVT \pmem_dout_bckup_reg[0]  (.D(pmem_dout[0]), .RN(n_2), .CK(n_13), 
      .Q(pmem_dout_bckup[0]), .QN());
   AOI22_X1_LVT i_39_1 (.A1(n_39_0), .A2(pmem_dout[0]), .B1(pmem_dout_bckup[0]), 
      .B2(pmem_dout_bckup_sel), .ZN(n_39_1));
   INV_X1_LVT i_39_2 (.A(n_39_1), .ZN(fe_mdb_in[0]));
   AND2_X1_LVT i_40_0 (.A1(fe_pmem_en), .A2(eu_pmem_en), .ZN(fe_pmem_wait));
   INV_X1_LVT i_41_0 (.A(dbg_mem_en), .ZN(n_16));
   NAND2_X1_LVT i_42_0 (.A1(n_16), .A2(dma_en), .ZN(n_42_0));
   NOR4_X1_LVT i_42_1 (.A1(n_42_0), .A2(ext_dmem_sel), .A3(ext_per_sel), 
      .A4(ext_pmem_sel), .ZN(dma_resp));
   OR4_X1_LVT i_43_0 (.A1(ext_dmem_en), .A2(dma_resp), .A3(ext_per_en), .A4(
      ext_pmem_en), .ZN(n_43_0));
   AND2_X1_LVT i_43_1 (.A1(n_43_0), .A2(n_16), .ZN(dma_ready));
   DFFR_X1_LVT dma_ready_dly_reg (.D(dma_ready), .RN(n_2), .CK(mclk), .Q(
      dma_ready_dly), .QN());
   AND2_X1_LVT i_44_15 (.A1(dma_ready_dly), .A2(dbg_mem_din[15]), .ZN(
      dma_dout[15]));
   AND2_X1_LVT i_44_14 (.A1(dma_ready_dly), .A2(dbg_mem_din[14]), .ZN(
      dma_dout[14]));
   AND2_X1_LVT i_44_13 (.A1(dma_ready_dly), .A2(dbg_mem_din[13]), .ZN(
      dma_dout[13]));
   AND2_X1_LVT i_44_12 (.A1(dma_ready_dly), .A2(dbg_mem_din[12]), .ZN(
      dma_dout[12]));
   AND2_X1_LVT i_44_11 (.A1(dma_ready_dly), .A2(dbg_mem_din[11]), .ZN(
      dma_dout[11]));
   AND2_X1_LVT i_44_10 (.A1(dma_ready_dly), .A2(dbg_mem_din[10]), .ZN(
      dma_dout[10]));
   AND2_X1_LVT i_44_9 (.A1(dma_ready_dly), .A2(dbg_mem_din[9]), .ZN(dma_dout[9]));
   AND2_X1_LVT i_44_8 (.A1(dma_ready_dly), .A2(dbg_mem_din[8]), .ZN(dma_dout[8]));
   AND2_X1_LVT i_44_7 (.A1(dma_ready_dly), .A2(dbg_mem_din[7]), .ZN(dma_dout[7]));
   AND2_X1_LVT i_44_6 (.A1(dma_ready_dly), .A2(dbg_mem_din[6]), .ZN(dma_dout[6]));
   AND2_X1_LVT i_44_5 (.A1(dma_ready_dly), .A2(dbg_mem_din[5]), .ZN(dma_dout[5]));
   AND2_X1_LVT i_44_4 (.A1(dma_ready_dly), .A2(dbg_mem_din[4]), .ZN(dma_dout[4]));
   AND2_X1_LVT i_44_3 (.A1(dma_ready_dly), .A2(dbg_mem_din[3]), .ZN(dma_dout[3]));
   AND2_X1_LVT i_44_2 (.A1(dma_ready_dly), .A2(dbg_mem_din[2]), .ZN(dma_dout[2]));
   AND2_X1_LVT i_44_1 (.A1(dma_ready_dly), .A2(dbg_mem_din[1]), .ZN(dma_dout[1]));
   AND2_X1_LVT i_44_0 (.A1(dbg_mem_din[0]), .A2(dma_ready_dly), .ZN(dma_dout[0]));
   INV_X1_LVT i_45_0 (.A(ext_per_en), .ZN(n_45_0));
   AOI22_X1_LVT i_45_15 (.A1(n_45_0), .A2(eu_mab[7]), .B1(ext_per_en), .B2(
      ext_mem_addr[8]), .ZN(n_45_8));
   INV_X1_LVT i_45_16 (.A(n_45_8), .ZN(per_addr[7]));
   AOI22_X1_LVT i_45_13 (.A1(n_45_0), .A2(eu_mab[6]), .B1(ext_per_en), .B2(
      ext_mem_addr[7]), .ZN(n_45_7));
   INV_X1_LVT i_45_14 (.A(n_45_7), .ZN(per_addr[6]));
   AOI22_X1_LVT i_45_11 (.A1(n_45_0), .A2(eu_mab[5]), .B1(ext_per_en), .B2(
      ext_mem_addr[6]), .ZN(n_45_6));
   INV_X1_LVT i_45_12 (.A(n_45_6), .ZN(per_addr[5]));
   AOI22_X1_LVT i_45_9 (.A1(n_45_0), .A2(eu_mab[4]), .B1(ext_per_en), .B2(
      ext_mem_addr[5]), .ZN(n_45_5));
   INV_X1_LVT i_45_10 (.A(n_45_5), .ZN(per_addr[4]));
   AOI22_X1_LVT i_45_7 (.A1(n_45_0), .A2(eu_mab[3]), .B1(ext_per_en), .B2(
      ext_mem_addr[4]), .ZN(n_45_4));
   INV_X1_LVT i_45_8 (.A(n_45_4), .ZN(per_addr[3]));
   AOI22_X1_LVT i_45_5 (.A1(n_45_0), .A2(eu_mab[2]), .B1(ext_per_en), .B2(
      ext_mem_addr[3]), .ZN(n_45_3));
   INV_X1_LVT i_45_6 (.A(n_45_3), .ZN(per_addr[2]));
   AOI22_X1_LVT i_45_3 (.A1(n_45_0), .A2(eu_mab[1]), .B1(ext_per_en), .B2(
      ext_mem_addr[2]), .ZN(n_45_2));
   INV_X1_LVT i_45_4 (.A(n_45_2), .ZN(per_addr[1]));
   AOI22_X1_LVT i_45_1 (.A1(n_45_0), .A2(eu_mab[0]), .B1(ext_mem_addr[1]), 
      .B2(ext_per_en), .ZN(n_45_1));
   INV_X1_LVT i_45_2 (.A(n_45_1), .ZN(per_addr[0]));
   INV_X1_LVT i_46_0 (.A(ext_per_en), .ZN(n_46_0));
   AOI22_X1_LVT i_46_31 (.A1(n_46_0), .A2(eu_mdb_out[15]), .B1(ext_per_en), 
      .B2(pmem_din[15]), .ZN(n_46_16));
   INV_X1_LVT i_46_32 (.A(n_46_16), .ZN(per_din[15]));
   AOI22_X1_LVT i_46_29 (.A1(n_46_0), .A2(eu_mdb_out[14]), .B1(ext_per_en), 
      .B2(pmem_din[14]), .ZN(n_46_15));
   INV_X1_LVT i_46_30 (.A(n_46_15), .ZN(per_din[14]));
   AOI22_X1_LVT i_46_27 (.A1(n_46_0), .A2(eu_mdb_out[13]), .B1(ext_per_en), 
      .B2(pmem_din[13]), .ZN(n_46_14));
   INV_X1_LVT i_46_28 (.A(n_46_14), .ZN(per_din[13]));
   AOI22_X1_LVT i_46_25 (.A1(n_46_0), .A2(eu_mdb_out[12]), .B1(ext_per_en), 
      .B2(pmem_din[12]), .ZN(n_46_13));
   INV_X1_LVT i_46_26 (.A(n_46_13), .ZN(per_din[12]));
   AOI22_X1_LVT i_46_23 (.A1(n_46_0), .A2(eu_mdb_out[11]), .B1(ext_per_en), 
      .B2(pmem_din[11]), .ZN(n_46_12));
   INV_X1_LVT i_46_24 (.A(n_46_12), .ZN(per_din[11]));
   AOI22_X1_LVT i_46_21 (.A1(n_46_0), .A2(eu_mdb_out[10]), .B1(ext_per_en), 
      .B2(pmem_din[10]), .ZN(n_46_11));
   INV_X1_LVT i_46_22 (.A(n_46_11), .ZN(per_din[10]));
   AOI22_X1_LVT i_46_19 (.A1(n_46_0), .A2(eu_mdb_out[9]), .B1(ext_per_en), 
      .B2(pmem_din[9]), .ZN(n_46_10));
   INV_X1_LVT i_46_20 (.A(n_46_10), .ZN(per_din[9]));
   AOI22_X1_LVT i_46_17 (.A1(n_46_0), .A2(eu_mdb_out[8]), .B1(ext_per_en), 
      .B2(pmem_din[8]), .ZN(n_46_9));
   INV_X1_LVT i_46_18 (.A(n_46_9), .ZN(per_din[8]));
   AOI22_X1_LVT i_46_15 (.A1(n_46_0), .A2(eu_mdb_out[7]), .B1(ext_per_en), 
      .B2(pmem_din[7]), .ZN(n_46_8));
   INV_X1_LVT i_46_16 (.A(n_46_8), .ZN(per_din[7]));
   AOI22_X1_LVT i_46_13 (.A1(n_46_0), .A2(eu_mdb_out[6]), .B1(ext_per_en), 
      .B2(pmem_din[6]), .ZN(n_46_7));
   INV_X1_LVT i_46_14 (.A(n_46_7), .ZN(per_din[6]));
   AOI22_X1_LVT i_46_11 (.A1(n_46_0), .A2(eu_mdb_out[5]), .B1(ext_per_en), 
      .B2(pmem_din[5]), .ZN(n_46_6));
   INV_X1_LVT i_46_12 (.A(n_46_6), .ZN(per_din[5]));
   AOI22_X1_LVT i_46_9 (.A1(n_46_0), .A2(eu_mdb_out[4]), .B1(ext_per_en), 
      .B2(pmem_din[4]), .ZN(n_46_5));
   INV_X1_LVT i_46_10 (.A(n_46_5), .ZN(per_din[4]));
   AOI22_X1_LVT i_46_7 (.A1(n_46_0), .A2(eu_mdb_out[3]), .B1(ext_per_en), 
      .B2(pmem_din[3]), .ZN(n_46_4));
   INV_X1_LVT i_46_8 (.A(n_46_4), .ZN(per_din[3]));
   AOI22_X1_LVT i_46_5 (.A1(n_46_0), .A2(eu_mdb_out[2]), .B1(ext_per_en), 
      .B2(pmem_din[2]), .ZN(n_46_3));
   INV_X1_LVT i_46_6 (.A(n_46_3), .ZN(per_din[2]));
   AOI22_X1_LVT i_46_3 (.A1(n_46_0), .A2(eu_mdb_out[1]), .B1(ext_per_en), 
      .B2(pmem_din[1]), .ZN(n_46_2));
   INV_X1_LVT i_46_4 (.A(n_46_2), .ZN(per_din[1]));
   AOI22_X1_LVT i_46_1 (.A1(n_46_0), .A2(eu_mdb_out[0]), .B1(pmem_din[0]), 
      .B2(ext_per_en), .ZN(n_46_1));
   INV_X1_LVT i_46_2 (.A(n_46_1), .ZN(per_din[0]));
   INV_X1_LVT i_47_0 (.A(ext_per_en), .ZN(n_47_0));
   AOI22_X1_LVT i_47_3 (.A1(n_47_0), .A2(eu_mb_wr[1]), .B1(ext_per_en), .B2(
      ext_mem_wr[1]), .ZN(n_47_2));
   INV_X1_LVT i_47_4 (.A(n_47_2), .ZN(per_we[1]));
   AOI22_X1_LVT i_47_1 (.A1(n_47_0), .A2(eu_mb_wr[0]), .B1(ext_mem_wr[0]), 
      .B2(ext_per_en), .ZN(n_47_1));
   INV_X1_LVT i_47_2 (.A(n_47_1), .ZN(per_we[0]));
   OR2_X1_LVT i_48_0 (.A1(ext_per_en), .A2(eu_per_en), .ZN(per_en));
   NOR2_X1_LVT i_49_0 (.A1(eu_pmem_en), .A2(ext_pmem_en), .ZN(n_49_0));
   AOI222_X1_LVT i_49_21 (.A1(n_49_0), .A2(fe_mab[10]), .B1(ext_pmem_en), 
      .B2(ext_mem_addr[11]), .C1(eu_pmem_en), .C2(eu_mab[10]), .ZN(n_49_11));
   INV_X1_LVT i_49_22 (.A(n_49_11), .ZN(pmem_addr[10]));
   AOI222_X1_LVT i_49_19 (.A1(n_49_0), .A2(fe_mab[9]), .B1(ext_pmem_en), 
      .B2(ext_mem_addr[10]), .C1(eu_pmem_en), .C2(eu_mab[9]), .ZN(n_49_10));
   INV_X1_LVT i_49_20 (.A(n_49_10), .ZN(pmem_addr[9]));
   AOI222_X1_LVT i_49_17 (.A1(n_49_0), .A2(fe_mab[8]), .B1(ext_pmem_en), 
      .B2(ext_mem_addr[9]), .C1(eu_pmem_en), .C2(eu_mab[8]), .ZN(n_49_9));
   INV_X1_LVT i_49_18 (.A(n_49_9), .ZN(pmem_addr[8]));
   AOI222_X1_LVT i_49_15 (.A1(n_49_0), .A2(fe_mab[7]), .B1(ext_pmem_en), 
      .B2(ext_mem_addr[8]), .C1(eu_pmem_en), .C2(eu_mab[7]), .ZN(n_49_8));
   INV_X1_LVT i_49_16 (.A(n_49_8), .ZN(pmem_addr[7]));
   AOI222_X1_LVT i_49_13 (.A1(n_49_0), .A2(fe_mab[6]), .B1(ext_pmem_en), 
      .B2(ext_mem_addr[7]), .C1(eu_pmem_en), .C2(eu_mab[6]), .ZN(n_49_7));
   INV_X1_LVT i_49_14 (.A(n_49_7), .ZN(pmem_addr[6]));
   AOI222_X1_LVT i_49_11 (.A1(n_49_0), .A2(fe_mab[5]), .B1(ext_pmem_en), 
      .B2(ext_mem_addr[6]), .C1(eu_pmem_en), .C2(eu_mab[5]), .ZN(n_49_6));
   INV_X1_LVT i_49_12 (.A(n_49_6), .ZN(pmem_addr[5]));
   AOI222_X1_LVT i_49_9 (.A1(n_49_0), .A2(fe_mab[4]), .B1(ext_pmem_en), .B2(
      ext_mem_addr[5]), .C1(eu_pmem_en), .C2(eu_mab[4]), .ZN(n_49_5));
   INV_X1_LVT i_49_10 (.A(n_49_5), .ZN(pmem_addr[4]));
   AOI222_X1_LVT i_49_7 (.A1(n_49_0), .A2(fe_mab[3]), .B1(ext_pmem_en), .B2(
      ext_mem_addr[4]), .C1(eu_pmem_en), .C2(eu_mab[3]), .ZN(n_49_4));
   INV_X1_LVT i_49_8 (.A(n_49_4), .ZN(pmem_addr[3]));
   AOI222_X1_LVT i_49_5 (.A1(n_49_0), .A2(fe_mab[2]), .B1(ext_pmem_en), .B2(
      ext_mem_addr[3]), .C1(eu_pmem_en), .C2(eu_mab[2]), .ZN(n_49_3));
   INV_X1_LVT i_49_6 (.A(n_49_3), .ZN(pmem_addr[2]));
   AOI222_X1_LVT i_49_3 (.A1(n_49_0), .A2(fe_mab[1]), .B1(ext_pmem_en), .B2(
      ext_mem_addr[2]), .C1(eu_pmem_en), .C2(eu_mab[1]), .ZN(n_49_2));
   INV_X1_LVT i_49_4 (.A(n_49_2), .ZN(pmem_addr[1]));
   AOI222_X1_LVT i_49_1 (.A1(n_49_0), .A2(fe_mab[0]), .B1(ext_mem_addr[1]), 
      .B2(ext_pmem_en), .C1(eu_mab[0]), .C2(eu_pmem_en), .ZN(n_49_1));
   INV_X1_LVT i_49_2 (.A(n_49_1), .ZN(pmem_addr[0]));
   NOR3_X1_LVT i_50_0 (.A1(fe_pmem_en), .A2(ext_pmem_en), .A3(eu_pmem_en), 
      .ZN(pmem_cen));
   NAND2_X1_LVT i_51_2 (.A1(ext_pmem_en), .A2(n_10), .ZN(n_51_1));
   NAND2_X1_LVT i_51_3 (.A1(n_51_1), .A2(ext_pmem_en), .ZN(pmem_wen[1]));
   NAND2_X1_LVT i_51_0 (.A1(n_9), .A2(ext_pmem_en), .ZN(n_51_0));
   NAND2_X1_LVT i_51_1 (.A1(n_51_0), .A2(ext_pmem_en), .ZN(pmem_wen[0]));
endmodule

module omsp_and_gate__1_1(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__1_3(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__1_5(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_frontend(cpu_halt_st, decode_noirq, e_state, exec_done, inst_ad, 
      inst_as, inst_alu, inst_bw, inst_dest, inst_dext, inst_irq_rst, inst_jmp, 
      inst_mov, inst_sext, inst_so, inst_src, inst_type, irq_acc, mab, mb_en, 
      mclk_dma_enable, mclk_dma_wkup, mclk_enable, mclk_wkup, nmi_acc, pc, 
      pc_nxt, cpu_en_s, cpu_halt_cmd, cpuoff, dbg_reg_sel, dma_en, dma_wkup, 
      fe_pmem_wait, gie, irq, mclk, mdb_in, nmi_pnd, nmi_wkup, pc_sw, pc_sw_wr, 
      puc_rst, scan_enable, wdt_irq, wdt_wkup, wkup);
   output cpu_halt_st;
   output decode_noirq;
   output [3:0]e_state;
   output exec_done;
   output [7:0]inst_ad;
   output [7:0]inst_as;
   output [11:0]inst_alu;
   output inst_bw;
   output [15:0]inst_dest;
   output [15:0]inst_dext;
   output inst_irq_rst;
   output [7:0]inst_jmp;
   output inst_mov;
   output [15:0]inst_sext;
   output [7:0]inst_so;
   output [15:0]inst_src;
   output [2:0]inst_type;
   output [13:0]irq_acc;
   output [15:0]mab;
   output mb_en;
   output mclk_dma_enable;
   output mclk_dma_wkup;
   output mclk_enable;
   output mclk_wkup;
   output nmi_acc;
   output [15:0]pc;
   output [15:0]pc_nxt;
   input cpu_en_s;
   input cpu_halt_cmd;
   input cpuoff;
   input [3:0]dbg_reg_sel;
   input dma_en;
   input dma_wkup;
   input fe_pmem_wait;
   input gie;
   input [13:0]irq;
   input mclk;
   input [15:0]mdb_in;
   input nmi_pnd;
   input nmi_wkup;
   input [15:0]pc_sw;
   input pc_sw_wr;
   input puc_rst;
   input scan_enable;
   input wdt_irq;
   input wdt_wkup;
   input wkup;

   wire mirq_wkup;
   wire n_0_0;
   wire cpu_halt_req;
   wire n_3_0;
   wire n_3_1;
   wire n_3_2;
   wire n_3_3;
   wire n_4_0;
   wire n_4_1;
   wire n_4_2;
   wire [2:0]i_state;
   wire n_6_0;
   wire n_6_1;
   wire n_6_2;
   wire n_10_0;
   wire n_10_1;
   wire [3:0]src_reg;
   wire n_10_2;
   wire n_10_3;
   wire n_10_4;
   wire n_11_0;
   wire inst_type_nxt;
   wire n_12_0;
   wire n_12_1;
   wire n_12_2;
   wire n_12_3;
   wire n_12_4;
   wire n_12_5;
   wire n_12_6;
   wire n_12_7;
   wire n_12_8;
   wire n_12_9;
   wire [12:0]inst_as_nxt;
   wire n_12_10;
   wire n_12_11;
   wire n_12_12;
   wire n_12_13;
   wire n_12_14;
   wire n_13_0;
   wire n_13_1;
   wire is_const;
   wire is_sext;
   wire n_16_0;
   wire inst_dext_rdy;
   wire exec_dext_rdy;
   wire n_19_0;
   wire n_19_1;
   wire n_20_0;
   wire n_20_1;
   wire n_20_2;
   wire n_20_3;
   wire n_22_0;
   wire n_23_0;
   wire n_23_1;
   wire n_23_2;
   wire n_23_3;
   wire n_23_4;
   wire n_23_5;
   wire n_23_6;
   wire n_23_7;
   wire n_23_8;
   wire n_23_9;
   wire n_23_10;
   wire n_23_11;
   wire n_23_12;
   wire n_23_13;
   wire n_23_14;
   wire n_23_15;
   wire n_23_16;
   wire n_23_17;
   wire inst_ad_nxt;
   wire n_25_0;
   wire n_25_1;
   wire n_25_2;
   wire n_25_3;
   wire n_25_4;
   wire n_25_5;
   wire n_25_6;
   wire n_27_0;
   wire [7:0]inst_so_nxt;
   wire n_27_1;
   wire inst_sext_rdy;
   wire exec_dst_wr;
   wire n_32_0;
   wire n_33_0;
   wire n_33_1;
   wire n_33_2;
   wire n_33_3;
   wire n_33_4;
   wire exec_src_wr;
   wire n_39_0;
   wire n_39_1;
   wire exec_jmp;
   wire n_44_0;
   wire n_44_1;
   wire n_45_0;
   wire n_45_1;
   wire n_45_2;
   wire dst_acalc_pre;
   wire src_acalc_pre;
   wire n_50_0;
   wire n_50_1;
   wire n_50_2;
   wire n_50_3;
   wire n_50_4;
   wire n_50_5;
   wire n_50_6;
   wire n_50_7;
   wire n_50_8;
   wire n_50_9;
   wire n_50_10;
   wire n_50_11;
   wire n_50_12;
   wire n_50_13;
   wire n_50_14;
   wire n_50_15;
   wire n_50_16;
   wire n_50_17;
   wire n_50_18;
   wire n_50_19;
   wire n_53_0;
   wire n_53_1;
   wire n_55_0;
   wire n_55_1;
   wire n_55_2;
   wire n_55_3;
   wire n_55_4;
   wire n_55_5;
   wire n_55_6;
   wire n_55_7;
   wire n_55_8;
   wire n_55_9;
   wire n_55_10;
   wire n_55_11;
   wire n_55_12;
   wire n_55_13;
   wire n_55_14;
   wire n_55_15;
   wire n_55_16;
   wire n_55_17;
   wire n_55_18;
   wire n_55_19;
   wire n_55_20;
   wire n_55_21;
   wire n_55_22;
   wire n_55_23;
   wire n_55_24;
   wire n_55_25;
   wire n_55_26;
   wire n_55_27;
   wire n_55_28;
   wire n_55_29;
   wire n_55_30;
   wire n_55_31;
   wire n_55_32;
   wire n_55_33;
   wire n_55_34;
   wire [3:0]e_state_nxt_reg;
   wire n_55_35;
   wire n_55_36;
   wire n_55_37;
   wire n_55_38;
   wire n_55_39;
   wire n_55_40;
   wire n_55_41;
   wire n_55_42;
   wire n_55_43;
   wire n_55_44;
   wire n_55_45;
   wire n_55_46;
   wire n_55_47;
   wire n_55_48;
   wire n_55_49;
   wire n_55_50;
   wire n_55_51;
   wire n_55_52;
   wire n_55_53;
   wire n_55_54;
   wire n_55_55;
   wire n_55_56;
   wire n_55_57;
   wire n_55_58;
   wire n_55_59;
   wire n_55_60;
   wire n_55_61;
   wire n_55_62;
   wire n_55_63;
   wire n_55_64;
   wire n_55_65;
   wire n_55_66;
   wire n_55_67;
   wire n_55_68;
   wire n_58_0;
   wire n_58_1;
   wire n_58_2;
   wire n_58_3;
   wire n_59_0;
   wire n_59_1;
   wire n_59_2;
   wire n_59_3;
   wire n_59_4;
   wire n_59_5;
   wire n_59_6;
   wire n_60_0;
   wire irq_detect;
   wire decode;
   wire n_64_0;
   wire [1:0]inst_sz_nxt;
   wire [1:0]inst_sz;
   wire n_70_0;
   wire n_71_0;
   wire n_72_0;
   wire n_73_0;
   wire n_73_1;
   wire n_73_2;
   wire n_73_3;
   wire n_74_0;
   wire n_75_0;
   wire n_76_0;
   wire n_76_1;
   wire n_76_2;
   wire n_76_3;
   wire n_76_4;
   wire n_76_5;
   wire n_76_6;
   wire n_76_7;
   wire [2:0]i_state_nxt_reg;
   wire n_76_8;
   wire n_76_9;
   wire n_76_10;
   wire n_76_11;
   wire n_76_12;
   wire n_76_13;
   wire n_76_14;
   wire n_80_0;
   wire n_82_0;
   wire n_82_1;
   wire n_82_2;
   wire n_82_3;
   wire n_82_4;
   wire n_82_5;
   wire n_82_6;
   wire n_82_7;
   wire n_82_8;
   wire n_82_9;
   wire n_82_10;
   wire [11:0]inst_to_nxt;
   wire alu_inc;
   wire [11:0]inst_alu_nxt;
   wire n_88_0;
   wire n_88_1;
   wire n_91_0;
   wire [3:0]inst_dest_bin;
   wire n_94_0;
   wire n_94_1;
   wire n_94_2;
   wire n_94_3;
   wire n_94_4;
   wire n_94_5;
   wire n_94_6;
   wire n_94_7;
   wire n_94_8;
   wire n_94_9;
   wire n_94_10;
   wire n_94_11;
   wire n_95_0;
   wire n_95_1;
   wire n_95_2;
   wire n_95_3;
   wire n_95_4;
   wire n_95_5;
   wire n_95_6;
   wire n_95_7;
   wire n_95_8;
   wire n_95_9;
   wire n_95_10;
   wire n_95_11;
   wire n_97_0;
   wire n_97_1;
   wire n_97_2;
   wire n_97_3;
   wire n_97_4;
   wire n_97_5;
   wire n_97_6;
   wire n_97_7;
   wire n_97_8;
   wire n_97_9;
   wire n_97_10;
   wire n_97_11;
   wire n_97_12;
   wire n_97_13;
   wire n_97_14;
   wire n_97_15;
   wire n_97_16;
   wire n_97_17;
   wire n_97_18;
   wire n_97_19;
   wire n_98_0;
   wire n_98_1;
   wire n_98_2;
   wire n_98_3;
   wire n_98_4;
   wire n_99_0;
   wire [15:0]ext_nxt;
   wire n_99_1;
   wire n_99_2;
   wire n_99_3;
   wire n_99_4;
   wire n_99_5;
   wire n_99_6;
   wire n_99_7;
   wire n_99_8;
   wire n_99_9;
   wire n_99_10;
   wire n_99_11;
   wire n_99_12;
   wire n_99_13;
   wire n_99_14;
   wire n_99_15;
   wire n_99_16;
   wire n_99_17;
   wire n_101_0;
   wire n_101_1;
   wire [2:0]inst_jmp_bin;
   wire n_105_0;
   wire n_105_1;
   wire n_105_2;
   wire n_105_3;
   wire n_105_4;
   wire n_105_5;
   wire n_105_6;
   wire n_110_0;
   wire n_110_1;
   wire n_110_2;
   wire n_110_3;
   wire n_110_4;
   wire n_110_5;
   wire n_110_6;
   wire n_110_7;
   wire n_110_8;
   wire n_110_9;
   wire n_110_10;
   wire n_110_11;
   wire n_110_12;
   wire n_110_13;
   wire n_110_14;
   wire n_110_15;
   wire n_110_16;
   wire n_110_17;
   wire n_110_18;
   wire n_110_19;
   wire n_110_20;
   wire n_110_21;
   wire n_110_22;
   wire n_110_23;
   wire n_110_24;
   wire n_110_25;
   wire n_110_26;
   wire n_110_27;
   wire n_110_28;
   wire n_110_29;
   wire n_110_30;
   wire n_110_31;
   wire n_110_32;
   wire n_110_33;
   wire n_110_34;
   wire n_110_35;
   wire n_111_0;
   wire n_111_1;
   wire n_111_2;
   wire n_111_3;
   wire n_111_4;
   wire [3:0]inst_src_bin;
   wire n_114_0;
   wire n_114_1;
   wire n_114_2;
   wire n_114_3;
   wire n_114_4;
   wire n_114_5;
   wire n_114_6;
   wire n_114_7;
   wire n_114_8;
   wire n_114_9;
   wire n_114_10;
   wire n_114_11;
   wire n_115_0;
   wire n_115_1;
   wire n_115_2;
   wire n_115_3;
   wire n_115_4;
   wire n_115_5;
   wire n_115_6;
   wire n_115_7;
   wire n_115_8;
   wire n_115_9;
   wire n_115_10;
   wire n_115_11;
   wire n_115_12;
   wire n_115_13;
   wire n_115_14;
   wire n_115_15;
   wire n_115_16;
   wire n_115_17;
   wire n_115_18;
   wire n_115_19;
   wire [5:0]irq_num;
   wire n_118_0;
   wire n_118_1;
   wire n_118_2;
   wire n_118_3;
   wire n_118_4;
   wire n_118_5;
   wire n_118_6;
   wire n_118_7;
   wire n_118_8;
   wire n_118_9;
   wire n_118_10;
   wire n_118_11;
   wire n_118_12;
   wire n_118_13;
   wire n_118_14;
   wire n_118_15;
   wire n_118_16;
   wire n_118_17;
   wire n_118_18;
   wire n_118_19;
   wire n_118_20;
   wire n_118_21;
   wire n_118_22;
   wire n_118_23;
   wire n_118_24;
   wire n_118_25;
   wire n_118_26;
   wire n_118_27;
   wire n_118_28;
   wire n_118_29;
   wire n_118_30;
   wire n_118_31;
   wire n_118_32;
   wire n_118_33;
   wire n_118_34;
   wire n_118_35;
   wire n_118_36;
   wire n_118_37;
   wire n_118_38;
   wire n_118_39;
   wire n_118_40;
   wire n_118_41;
   wire n_118_42;
   wire n_118_43;
   wire n_118_44;
   wire n_118_45;
   wire n_118_46;
   wire n_118_47;
   wire n_118_48;
   wire n_118_49;
   wire n_118_50;
   wire n_118_51;
   wire n_118_52;
   wire n_118_53;
   wire n_118_54;
   wire n_118_55;
   wire n_118_56;
   wire n_120_0;
   wire n_120_1;
   wire n_120_2;
   wire n_120_3;
   wire n_120_4;
   wire n_120_5;
   wire n_120_6;
   wire n_120_7;
   wire n_120_8;
   wire n_120_9;
   wire n_120_10;
   wire n_120_11;
   wire n_120_12;
   wire n_120_13;
   wire n_120_14;
   wire n_120_15;
   wire n_120_16;
   wire n_120_17;
   wire n_120_18;
   wire n_120_19;
   wire n_120_20;
   wire n_122_0;
   wire n_122_1;
   wire n_122_2;
   wire fetch;
   wire [15:0]pc_incr;
   wire n_124_0;
   wire n_124_1;
   wire n_124_2;
   wire n_124_3;
   wire n_124_4;
   wire n_124_5;
   wire n_124_6;
   wire n_124_7;
   wire n_124_8;
   wire n_124_9;
   wire n_124_10;
   wire n_124_11;
   wire n_124_12;
   wire n_124_13;
   wire n_124_14;
   wire n_125_0;
   wire n_126_0;
   wire n_126_1;
   wire n_126_2;
   wire n_126_3;
   wire n_126_4;
   wire n_126_5;
   wire n_126_6;
   wire n_126_7;
   wire n_126_8;
   wire n_126_9;
   wire n_126_10;
   wire n_126_11;
   wire n_126_12;
   wire n_126_13;
   wire n_126_14;
   wire n_126_15;
   wire n_127_0;
   wire n_127_1;
   wire n_127_2;
   wire n_127_3;
   wire n_127_4;
   wire n_127_5;
   wire n_127_6;
   wire n_127_7;
   wire n_127_8;
   wire n_127_9;
   wire n_127_10;
   wire n_127_11;
   wire n_127_12;
   wire n_127_13;
   wire n_127_14;
   wire n_127_15;
   wire n_127_16;
   wire pmem_busy;
   wire n_128_0;
   wire n_128_1;
   wire n_130_0;
   wire n_130_1;
   wire n_130_2;
   wire n_130_3;

   assign mab[15] = pc_nxt[15];
   assign mab[14] = pc_nxt[14];
   assign mab[13] = pc_nxt[13];
   assign mab[12] = pc_nxt[12];
   assign mab[11] = pc_nxt[11];
   assign mab[10] = pc_nxt[10];
   assign mab[9] = pc_nxt[9];
   assign mab[8] = pc_nxt[8];
   assign mab[7] = pc_nxt[7];
   assign mab[6] = pc_nxt[6];
   assign mab[5] = pc_nxt[5];
   assign mab[4] = pc_nxt[4];
   assign mab[3] = pc_nxt[3];
   assign mab[2] = pc_nxt[2];
   assign mab[1] = pc_nxt[1];
   assign mab[0] = pc_nxt[0];

   INV_X1_LVT i_78_0 (.A(puc_rst), .ZN(n_91));
   DFFR_X1_LVT \i_state_reg[0]  (.D(i_state_nxt_reg[0]), .RN(n_91), .CK(mclk), 
      .Q(i_state[0]), .QN());
   INV_X1_LVT i_76_2 (.A(i_state[0]), .ZN(n_76_2));
   INV_X1_LVT i_76_1 (.A(i_state[2]), .ZN(n_76_1));
   NOR3_X1_LVT i_76_3 (.A1(n_76_1), .A2(n_76_2), .A3(i_state[1]), .ZN(n_76_3));
   INV_X1_LVT i_0_0 (.A(cpu_halt_cmd), .ZN(n_0_0));
   NAND2_X1_LVT i_0_1 (.A1(n_0_0), .A2(cpu_en_s), .ZN(cpu_halt_req));
   INV_X1_LVT i_1_0 (.A(cpu_halt_req), .ZN(n_0));
   INV_X1_LVT i_74_0 (.A(n_0), .ZN(n_74_0));
   NOR2_X1_LVT i_74_1 (.A1(n_74_0), .A2(cpuoff), .ZN(n_87));
   INV_X1_LVT i_2_0 (.A(cpu_halt_st), .ZN(n_1));
   NAND2_X1_LVT i_4_0 (.A1(n_1), .A2(n_0), .ZN(n_4_0));
   NOR4_X1_LVT i_3_0 (.A1(irq[10]), .A2(irq[11]), .A3(irq[12]), .A4(irq[13]), 
      .ZN(n_3_0));
   NOR4_X1_LVT i_3_1 (.A1(irq[2]), .A2(irq[3]), .A3(irq[4]), .A4(irq[5]), 
      .ZN(n_3_1));
   NOR4_X1_LVT i_3_2 (.A1(irq[6]), .A2(irq[7]), .A3(irq[8]), .A4(irq[9]), 
      .ZN(n_3_2));
   NOR2_X1_LVT i_3_3 (.A1(irq[0]), .A2(irq[1]), .ZN(n_3_3));
   NAND4_X1_LVT i_3_4 (.A1(n_3_0), .A2(n_3_1), .A3(n_3_2), .A4(n_3_3), .ZN(n_2));
   OAI21_X1_LVT i_4_1 (.A(gie), .B1(n_2), .B2(wdt_irq), .ZN(n_4_1));
   INV_X1_LVT i_4_2 (.A(nmi_pnd), .ZN(n_4_2));
   AOI21_X1_LVT i_4_3 (.A(n_4_0), .B1(n_4_1), .B2(n_4_2), .ZN(n_3));
   AND2_X1_LVT i_74_2 (.A1(n_0), .A2(n_3), .ZN(n_88));
   NOR2_X1_LVT i_75_0 (.A1(n_87), .A2(n_88), .ZN(n_89));
   AND2_X1_LVT i_76_4 (.A1(n_76_3), .A2(n_89), .ZN(n_76_4));
   INV_X1_LVT i_76_5 (.A(i_state[1]), .ZN(n_76_5));
   NOR3_X1_LVT i_76_6 (.A1(n_76_5), .A2(i_state[0]), .A3(i_state[2]), .ZN(n_76_6));
   INV_X1_LVT i_55_0 (.A(e_state[0]), .ZN(n_55_0));
   INV_X1_LVT i_6_2 (.A(i_state[2]), .ZN(n_6_1));
   INV_X1_LVT i_6_3 (.A(i_state[0]), .ZN(n_6_2));
   NOR3_X1_LVT i_6_4 (.A1(n_6_1), .A2(n_6_2), .A3(i_state[1]), .ZN(n_5));
   OR2_X1_LVT i_49_2 (.A1(n_5), .A2(cpu_halt_req), .ZN(n_55));
   NOR3_X1_LVT i_8_0 (.A1(mdb_in[13]), .A2(mdb_in[14]), .A3(mdb_in[15]), 
      .ZN(n_10));
   NAND2_X1_LVT i_25_5 (.A1(mdb_in[7]), .A2(mdb_in[8]), .ZN(n_25_5));
   INV_X1_LVT i_25_6 (.A(mdb_in[9]), .ZN(n_25_6));
   NOR2_X1_LVT i_25_14 (.A1(n_25_5), .A2(n_25_6), .ZN(n_29));
   AND2_X1_LVT i_26_7 (.A1(n_10), .A2(n_29), .ZN(n_37));
   INV_X1_LVT i_27_8 (.A(n_37), .ZN(n_27_1));
   INV_X1_LVT i_25_0 (.A(mdb_in[7]), .ZN(n_25_0));
   NAND2_X1_LVT i_25_4 (.A1(n_25_0), .A2(mdb_in[8]), .ZN(n_25_4));
   NOR2_X1_LVT i_25_13 (.A1(n_25_4), .A2(n_25_6), .ZN(n_28));
   AND2_X1_LVT i_26_6 (.A1(n_10), .A2(n_28), .ZN(n_36));
   AND2_X1_LVT i_27_7 (.A1(n_27_0), .A2(n_36), .ZN(inst_so_nxt[6]));
   INV_X1_LVT i_7_0 (.A(irq_detect), .ZN(n_9));
   NAND2_X1_LVT i_11_0 (.A1(mdb_in[13]), .A2(n_9), .ZN(n_11_0));
   NOR3_X1_LVT i_11_1 (.A1(n_11_0), .A2(mdb_in[14]), .A3(mdb_in[15]), .ZN(
      inst_type_nxt));
   OR2_X1_LVT i_42_0 (.A1(inst_so_nxt[6]), .A2(inst_type_nxt), .ZN(n_49));
   INV_X1_LVT i_23_0 (.A(mdb_in[7]), .ZN(n_23_0));
   NOR4_X1_LVT i_23_1 (.A1(n_23_0), .A2(mdb_in[1]), .A3(mdb_in[2]), .A4(
      mdb_in[3]), .ZN(n_23_1));
   INV_X1_LVT i_23_2 (.A(mdb_in[0]), .ZN(n_23_2));
   NAND2_X1_LVT i_23_3 (.A1(n_23_1), .A2(n_23_2), .ZN(n_23_3));
   NOR4_X1_LVT i_23_4 (.A1(mdb_in[0]), .A2(mdb_in[1]), .A3(mdb_in[2]), .A4(
      mdb_in[3]), .ZN(n_23_4));
   INV_X1_LVT i_23_5 (.A(n_23_4), .ZN(n_23_5));
   NAND2_X1_LVT i_23_6 (.A1(n_23_3), .A2(n_23_5), .ZN(n_23_6));
   INV_X1_LVT i_23_7 (.A(n_23_6), .ZN(n_23_7));
   AOI22_X1_LVT i_23_8 (.A1(n_23_3), .A2(n_23_4), .B1(n_23_7), .B2(n_23_0), 
      .ZN(n_23_8));
   INV_X1_LVT i_23_9 (.A(mdb_in[2]), .ZN(n_23_9));
   INV_X1_LVT i_23_10 (.A(mdb_in[3]), .ZN(n_23_10));
   NAND4_X1_LVT i_23_11 (.A1(n_23_9), .A2(n_23_10), .A3(mdb_in[7]), .A4(
      mdb_in[1]), .ZN(n_23_11));
   OR2_X1_LVT i_23_12 (.A1(n_23_11), .A2(mdb_in[0]), .ZN(n_23_12));
   OAI21_X1_LVT i_22_0 (.A(n_9), .B1(mdb_in[14]), .B2(mdb_in[15]), .ZN(n_22_0));
   INV_X1_LVT i_22_1 (.A(n_22_0), .ZN(n_17));
   NAND2_X1_LVT i_23_13 (.A1(n_23_12), .A2(n_17), .ZN(n_23_13));
   INV_X1_LVT i_23_14 (.A(n_23_13), .ZN(n_23_14));
   NAND4_X1_LVT i_23_15 (.A1(n_23_2), .A2(n_23_9), .A3(n_23_10), .A4(mdb_in[1]), 
      .ZN(n_23_15));
   NAND2_X1_LVT i_23_16 (.A1(n_23_14), .A2(n_23_15), .ZN(n_23_16));
   OAI22_X1_LVT i_23_17 (.A1(n_23_8), .A2(n_23_16), .B1(n_23_15), .B2(n_23_13), 
      .ZN(n_18));
   NOR4_X1_LVT i_41_0 (.A1(mdb_in[0]), .A2(mdb_in[1]), .A3(mdb_in[2]), .A4(
      mdb_in[3]), .ZN(n_48));
   AOI21_X1_LVT i_44_0 (.A(n_49), .B1(n_18), .B2(n_48), .ZN(n_44_0));
   INV_X1_LVT i_6_0 (.A(i_state[1]), .ZN(n_6_0));
   NOR3_X1_LVT i_6_1 (.A1(n_6_0), .A2(i_state[0]), .A3(i_state[2]), .ZN(n_4));
   OR2_X1_LVT i_61_0 (.A1(n_67), .A2(exec_done), .ZN(n_73));
   AND2_X1_LVT i_62_0 (.A1(n_4), .A2(n_73), .ZN(decode_noirq));
   OR2_X1_LVT i_63_0 (.A1(decode_noirq), .A2(irq_detect), .ZN(decode));
   INV_X1_LVT i_44_1 (.A(decode), .ZN(n_44_1));
   NOR2_X1_LVT i_44_2 (.A1(n_44_0), .A2(n_44_1), .ZN(n_51));
   INV_X1_LVT i_45_0 (.A(n_51), .ZN(n_45_0));
   NAND3_X1_LVT i_45_1 (.A1(n_45_0), .A2(e_state[2]), .A3(e_state[3]), .ZN(
      n_45_1));
   NOR3_X1_LVT i_45_2 (.A1(n_45_1), .A2(e_state[0]), .A3(e_state[1]), .ZN(n_45_2));
   OR2_X1_LVT i_45_3 (.A1(n_45_2), .A2(n_51), .ZN(n_52));
   CLKGATETST_X1_LVT clk_gate_exec_jmp_reg (.CK(mclk), .E(n_52), .SE(1'b0), 
      .GCK(n_50));
   DFFR_X1_LVT exec_jmp_reg (.D(n_51), .RN(n_91), .CK(n_50), .Q(exec_jmp), .QN());
   NOR2_X1_LVT i_59_0 (.A1(exec_dst_wr), .A2(exec_jmp), .ZN(n_59_0));
   AND2_X1_LVT i_9_0 (.A1(n_10), .A2(n_9), .ZN(n_11));
   CLKGATETST_X1_LVT clk_gate_inst_type_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_43));
   DFFR_X1_LVT \inst_type_reg[0]  (.D(n_11), .RN(n_91), .CK(n_43), .Q(
      inst_type[0]), .QN());
   INV_X1_LVT i_58_4 (.A(e_state[1]), .ZN(n_58_3));
   INV_X1_LVT i_58_2 (.A(e_state[2]), .ZN(n_58_2));
   NOR4_X1_LVT i_58_5 (.A1(n_58_3), .A2(n_58_2), .A3(e_state[0]), .A4(e_state[3]), 
      .ZN(n_68));
   AND2_X1_LVT i_37_0 (.A1(inst_type[0]), .A2(n_68), .ZN(n_45));
   INV_X1_LVT i_58_1 (.A(e_state[0]), .ZN(n_58_1));
   NOR4_X1_LVT i_58_6 (.A1(n_58_2), .A2(n_58_1), .A3(n_58_3), .A4(e_state[3]), 
      .ZN(n_69));
   NOR4_X1_LVT i_58_7 (.A1(n_58_3), .A2(n_58_0), .A3(e_state[0]), .A4(e_state[2]), 
      .ZN(n_70));
   OR2_X1_LVT i_38_0 (.A1(n_69), .A2(n_70), .ZN(n_46));
   INV_X1_LVT i_39_1 (.A(n_46), .ZN(n_39_1));
   INV_X1_LVT i_39_0 (.A(n_45), .ZN(n_39_0));
   NAND2_X1_LVT i_39_2 (.A1(n_39_1), .A2(n_39_0), .ZN(n_47));
   CLKGATETST_X1_LVT clk_gate_exec_src_wr_reg (.CK(mclk), .E(n_47), .SE(1'b0), 
      .GCK(n_44));
   DFFR_X1_LVT exec_src_wr_reg (.D(n_45), .RN(n_91), .CK(n_44), .Q(exec_src_wr), 
      .QN());
   NAND3_X1_LVT i_59_1 (.A1(n_59_0), .A2(exec_src_wr), .A3(n_69), .ZN(n_59_1));
   INV_X1_LVT i_59_2 (.A(exec_src_wr), .ZN(n_59_2));
   NOR4_X1_LVT i_58_9 (.A1(n_58_0), .A2(n_58_1), .A3(n_58_3), .A4(e_state[2]), 
      .ZN(n_72));
   NAND3_X1_LVT i_59_3 (.A1(n_59_0), .A2(n_59_2), .A3(n_72), .ZN(n_59_3));
   INV_X1_LVT i_59_4 (.A(exec_jmp), .ZN(n_59_4));
   NAND3_X1_LVT i_59_5 (.A1(n_59_4), .A2(exec_dst_wr), .A3(n_70), .ZN(n_59_5));
   NOR4_X1_LVT i_58_8 (.A1(n_58_2), .A2(n_58_0), .A3(e_state[0]), .A4(e_state[1]), 
      .ZN(n_71));
   NAND2_X1_LVT i_59_6 (.A1(n_71), .A2(exec_jmp), .ZN(n_59_6));
   NAND4_X1_LVT i_59_7 (.A1(n_59_1), .A2(n_59_3), .A3(n_59_5), .A4(n_59_6), 
      .ZN(exec_done));
   OAI21_X1_LVT i_60_0 (.A(n_3), .B1(n_5), .B2(exec_done), .ZN(n_60_0));
   INV_X1_LVT i_60_1 (.A(n_60_0), .ZN(irq_detect));
   INV_X1_LVT i_27_0 (.A(irq_detect), .ZN(n_27_0));
   NAND2_X1_LVT i_27_9 (.A1(n_27_1), .A2(n_27_0), .ZN(inst_so_nxt[7]));
   AND2_X1_LVT i_49_3 (.A1(n_1), .A2(inst_so_nxt[7]), .ZN(n_56));
   NOR2_X1_LVT i_50_0 (.A1(n_55), .A2(n_56), .ZN(n_50_0));
   INV_X1_LVT i_50_1 (.A(n_50_0), .ZN(n_50_1));
   NOR2_X1_LVT i_50_2 (.A1(n_50_1), .A2(cpuoff), .ZN(n_50_2));
   INV_X1_LVT i_50_3 (.A(n_50_2), .ZN(n_50_3));
   INV_X1_LVT i_10_0 (.A(n_11), .ZN(n_10_0));
   AOI22_X1_LVT i_10_1 (.A1(n_10_0), .A2(mdb_in[8]), .B1(mdb_in[0]), .B2(n_11), 
      .ZN(n_10_1));
   INV_X1_LVT i_10_2 (.A(n_10_1), .ZN(src_reg[0]));
   AOI22_X1_LVT i_10_3 (.A1(n_10_0), .A2(mdb_in[9]), .B1(n_11), .B2(mdb_in[1]), 
      .ZN(n_10_2));
   INV_X1_LVT i_10_4 (.A(n_10_2), .ZN(src_reg[1]));
   AOI22_X1_LVT i_10_5 (.A1(n_10_0), .A2(mdb_in[10]), .B1(n_11), .B2(mdb_in[2]), 
      .ZN(n_10_3));
   INV_X1_LVT i_10_6 (.A(n_10_3), .ZN(src_reg[2]));
   AOI22_X1_LVT i_10_7 (.A1(n_10_0), .A2(mdb_in[11]), .B1(n_11), .B2(mdb_in[3]), 
      .ZN(n_10_4));
   INV_X1_LVT i_10_8 (.A(n_10_4), .ZN(src_reg[3]));
   NOR4_X1_LVT i_12_12 (.A1(src_reg[0]), .A2(src_reg[1]), .A3(src_reg[2]), 
      .A4(src_reg[3]), .ZN(n_12_11));
   INV_X1_LVT i_12_16 (.A(n_12_11), .ZN(n_12_12));
   INV_X1_LVT i_12_6 (.A(src_reg[0]), .ZN(n_12_6));
   INV_X1_LVT i_12_7 (.A(src_reg[1]), .ZN(n_12_7));
   NOR4_X1_LVT i_12_8 (.A1(n_12_6), .A2(n_12_7), .A3(src_reg[2]), .A4(src_reg[3]), 
      .ZN(n_12_8));
   OR2_X1_LVT i_12_9 (.A1(n_12_8), .A2(inst_type_nxt), .ZN(n_12_9));
   NOR4_X1_LVT i_12_11 (.A1(n_12_7), .A2(src_reg[0]), .A3(src_reg[2]), .A4(
      src_reg[3]), .ZN(n_12_10));
   INV_X1_LVT i_12_1 (.A(mdb_in[5]), .ZN(n_12_1));
   NAND2_X1_LVT i_12_3 (.A1(n_12_1), .A2(mdb_in[4]), .ZN(n_12_3));
   NOR4_X1_LVT i_12_17 (.A1(n_12_12), .A2(n_12_9), .A3(n_12_10), .A4(n_12_3), 
      .ZN(inst_as_nxt[4]));
   INV_X1_LVT i_12_19 (.A(n_12_10), .ZN(n_12_13));
   NOR3_X1_LVT i_12_20 (.A1(n_12_13), .A2(n_12_9), .A3(n_12_3), .ZN(
      inst_as_nxt[6]));
   NOR4_X1_LVT i_12_13 (.A1(n_12_9), .A2(n_12_10), .A3(n_12_3), .A4(n_12_11), 
      .ZN(inst_as_nxt[1]));
   OR3_X1_LVT i_48_0 (.A1(inst_as_nxt[4]), .A2(inst_as_nxt[6]), .A3(
      inst_as_nxt[1]), .ZN(src_acalc_pre));
   NOR2_X1_LVT i_50_4 (.A1(n_50_3), .A2(src_acalc_pre), .ZN(n_50_4));
   OR2_X1_LVT i_12_2 (.A1(n_12_1), .A2(mdb_in[4]), .ZN(n_12_2));
   NOR3_X1_LVT i_12_14 (.A1(n_12_9), .A2(n_12_10), .A3(n_12_2), .ZN(
      inst_as_nxt[2]));
   NAND2_X1_LVT i_12_4 (.A1(mdb_in[4]), .A2(mdb_in[5]), .ZN(n_12_4));
   NOR4_X1_LVT i_12_15 (.A1(n_12_9), .A2(n_12_10), .A3(n_12_11), .A4(n_12_4), 
      .ZN(inst_as_nxt[3]));
   NOR4_X1_LVT i_12_18 (.A1(n_12_12), .A2(n_12_9), .A3(n_12_10), .A4(n_12_4), 
      .ZN(inst_as_nxt[5]));
   OR4_X1_LVT i_49_1 (.A1(inst_as_nxt[2]), .A2(inst_as_nxt[3]), .A3(
      inst_as_nxt[5]), .A4(inst_so_nxt[6]), .ZN(n_54));
   INV_X1_LVT i_50_5 (.A(n_54), .ZN(n_50_5));
   NAND2_X1_LVT i_50_6 (.A1(n_50_4), .A2(n_50_5), .ZN(n_50_6));
   NOR2_X1_LVT i_23_19 (.A1(n_23_3), .A2(n_23_16), .ZN(n_20));
   NOR3_X1_LVT i_23_18 (.A1(n_23_16), .A2(n_23_6), .A3(n_23_0), .ZN(n_19));
   INV_X1_LVT i_23_20 (.A(n_17), .ZN(n_23_17));
   NOR2_X1_LVT i_23_21 (.A1(n_23_12), .A2(n_23_17), .ZN(inst_ad_nxt));
   OR3_X1_LVT i_47_0 (.A1(n_20), .A2(n_19), .A3(inst_ad_nxt), .ZN(dst_acalc_pre));
   NOR2_X1_LVT i_50_7 (.A1(n_50_6), .A2(dst_acalc_pre), .ZN(n_50_7));
   INV_X1_LVT i_25_1 (.A(mdb_in[8]), .ZN(n_25_1));
   NAND2_X1_LVT i_25_2 (.A1(n_25_0), .A2(n_25_1), .ZN(n_25_2));
   NOR2_X1_LVT i_25_11 (.A1(n_25_2), .A2(n_25_6), .ZN(n_26));
   AND2_X1_LVT i_26_4 (.A1(n_10), .A2(n_26), .ZN(n_34));
   AND2_X1_LVT i_27_5 (.A1(n_27_0), .A2(n_34), .ZN(inst_so_nxt[4]));
   NAND2_X1_LVT i_25_3 (.A1(mdb_in[7]), .A2(n_25_1), .ZN(n_25_3));
   NOR2_X1_LVT i_25_12 (.A1(n_25_3), .A2(n_25_6), .ZN(n_27));
   AND2_X1_LVT i_26_5 (.A1(n_10), .A2(n_27), .ZN(n_35));
   AND2_X1_LVT i_27_6 (.A1(n_27_0), .A2(n_35), .ZN(inst_so_nxt[5]));
   OR2_X1_LVT i_49_0 (.A1(inst_so_nxt[4]), .A2(inst_so_nxt[5]), .ZN(n_53));
   INV_X1_LVT i_50_8 (.A(n_53), .ZN(n_50_8));
   NAND2_X1_LVT i_50_9 (.A1(n_50_7), .A2(n_50_8), .ZN(n_50_9));
   NAND2_X1_LVT i_50_17 (.A1(n_50_4), .A2(n_54), .ZN(n_50_16));
   INV_X1_LVT i_50_12 (.A(n_56), .ZN(n_50_12));
   NAND3_X1_LVT i_50_18 (.A1(n_50_9), .A2(n_50_16), .A3(n_50_12), .ZN(n_58));
   AND2_X1_LVT i_55_36 (.A1(n_55_6), .A2(n_58), .ZN(n_55_35));
   NOR4_X1_LVT i_55_18 (.A1(e_state[0]), .A2(e_state[1]), .A3(e_state[2]), 
      .A4(e_state[3]), .ZN(n_55_18));
   NAND4_X1_LVT i_55_23 (.A1(n_55_1), .A2(n_55_10), .A3(e_state[0]), .A4(
      e_state[3]), .ZN(n_55_23));
   INV_X1_LVT i_55_37 (.A(n_55_23), .ZN(n_55_36));
   NOR4_X1_LVT i_55_38 (.A1(n_55_35), .A2(n_55_18), .A3(n_55_21), .A4(n_55_36), 
      .ZN(n_55_37));
   NOR4_X1_LVT i_55_30 (.A1(n_55_0), .A2(n_55_10), .A3(e_state[1]), .A4(
      e_state[3]), .ZN(n_55_30));
   NOR3_X1_LVT i_6_5 (.A1(n_6_0), .A2(n_6_2), .A3(i_state[2]), .ZN(n_6));
   CLKGATETST_X1_LVT clk_gate_inst_as_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_12));
   DFFR_X1_LVT \inst_as_reg[6]  (.D(inst_as_nxt[6]), .RN(n_91), .CK(n_12), 
      .Q(inst_as[6]), .QN());
   DFFR_X1_LVT \inst_as_reg[1]  (.D(inst_as_nxt[1]), .RN(n_91), .CK(n_12), 
      .Q(inst_as[1]), .QN());
   DFFR_X1_LVT \inst_as_reg[5]  (.D(inst_as_nxt[5]), .RN(n_91), .CK(n_12), 
      .Q(inst_as[5]), .QN());
   DFFR_X1_LVT \inst_as_reg[4]  (.D(inst_as_nxt[4]), .RN(n_91), .CK(n_12), 
      .Q(inst_as[4]), .QN());
   OR4_X1_LVT i_15_0 (.A1(inst_as[6]), .A2(inst_as[1]), .A3(inst_as[5]), 
      .A4(inst_as[4]), .ZN(is_sext));
   AND2_X1_LVT i_30_0 (.A1(n_6), .A2(is_sext), .ZN(inst_sext_rdy));
   NAND2_X1_LVT i_55_39 (.A1(n_55_30), .A2(inst_sext_rdy), .ZN(n_55_38));
   INV_X1_LVT i_55_4 (.A(e_state[3]), .ZN(n_55_4));
   NAND4_X1_LVT i_55_32 (.A1(n_55_0), .A2(n_55_4), .A3(e_state[1]), .A4(
      e_state[2]), .ZN(n_55_32));
   INV_X1_LVT i_55_33 (.A(n_55_32), .ZN(n_55_33));
   CLKGATETST_X1_LVT clk_gate_inst_so_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_38));
   DFFR_X1_LVT \inst_so_reg[6]  (.D(inst_so_nxt[6]), .RN(n_91), .CK(n_38), 
      .Q(inst_so[6]), .QN());
   DFFR_X1_LVT \inst_so_reg[4]  (.D(inst_so_nxt[4]), .RN(n_91), .CK(n_38), 
      .Q(inst_so[4]), .QN());
   DFFR_X1_LVT \inst_so_reg[5]  (.D(inst_so_nxt[5]), .RN(n_91), .CK(n_38), 
      .Q(inst_so[5]), .QN());
   OR2_X1_LVT i_29_0 (.A1(inst_so[4]), .A2(inst_so[5]), .ZN(n_39));
   OR2_X1_LVT i_52_0 (.A1(inst_so[6]), .A2(n_39), .ZN(n_62));
   CLKGATETST_X1_LVT clk_gate_inst_ad_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_21));
   DFFR_X1_LVT \inst_ad_reg[4]  (.D(n_20), .RN(n_91), .CK(n_21), .Q(inst_ad[4]), 
      .QN());
   DFFR_X1_LVT \inst_ad_reg[1]  (.D(n_19), .RN(n_91), .CK(n_21), .Q(inst_ad[1]), 
      .QN());
   DFFR_X1_LVT \inst_ad_reg[6]  (.D(inst_ad_nxt), .RN(n_91), .CK(n_21), .Q(
      inst_ad[6]), .QN());
   OR3_X1_LVT i_52_1 (.A1(inst_ad[4]), .A2(inst_ad[1]), .A3(inst_ad[6]), 
      .ZN(n_63));
   NOR2_X1_LVT i_53_0 (.A1(n_62), .A2(n_63), .ZN(n_64));
   NAND2_X1_LVT i_55_40 (.A1(n_55_33), .A2(n_64), .ZN(n_55_39));
   NAND4_X1_LVT i_55_11 (.A1(n_55_10), .A2(e_state[0]), .A3(e_state[1]), 
      .A4(e_state[3]), .ZN(n_55_11));
   INV_X1_LVT i_55_41 (.A(n_55_11), .ZN(n_55_40));
   NOR2_X1_LVT i_55_12 (.A1(exec_jmp), .A2(exec_dst_wr), .ZN(n_55_12));
   NAND2_X1_LVT i_55_16 (.A1(n_55_12), .A2(exec_src_wr), .ZN(n_55_16));
   INV_X1_LVT i_55_13 (.A(n_55_12), .ZN(n_55_13));
   NOR2_X1_LVT i_55_14 (.A1(n_55_13), .A2(exec_src_wr), .ZN(n_55_14));
   INV_X1_LVT i_55_43 (.A(n_55_14), .ZN(n_55_42));
   INV_X1_LVT i_55_44 (.A(n_58), .ZN(n_55_43));
   OAI211_X1_LVT i_55_45 (.A(n_55_16), .B(n_55_41), .C1(n_55_42), .C2(n_55_43), 
      .ZN(n_55_44));
   NAND2_X1_LVT i_55_46 (.A1(n_55_40), .A2(n_55_44), .ZN(n_55_45));
   AND4_X1_LVT i_55_47 (.A1(n_55_37), .A2(n_55_38), .A3(n_55_39), .A4(n_55_45), 
      .ZN(n_55_46));
   NAND4_X1_LVT i_55_26 (.A1(n_55_0), .A2(n_55_10), .A3(e_state[1]), .A4(
      e_state[3]), .ZN(n_55_26));
   INV_X1_LVT i_55_27 (.A(n_55_26), .ZN(n_55_27));
   INV_X1_LVT i_55_28 (.A(exec_jmp), .ZN(n_55_28));
   NAND3_X1_LVT i_55_48 (.A1(n_55_27), .A2(n_55_28), .A3(n_58), .ZN(n_55_47));
   NAND4_X1_LVT i_55_3 (.A1(n_55_1), .A2(e_state[0]), .A3(e_state[2]), .A4(
      e_state[3]), .ZN(n_55_3));
   NAND4_X1_LVT i_55_5 (.A1(n_55_4), .A2(e_state[0]), .A3(e_state[1]), .A4(
      e_state[2]), .ZN(n_55_5));
   AND4_X1_LVT i_55_49 (.A1(n_55_26), .A2(n_55_3), .A3(n_55_11), .A4(n_55_5), 
      .ZN(n_55_48));
   NAND4_X1_LVT i_55_50 (.A1(n_55_48), .A2(n_55_32), .A3(n_55_23), .A4(n_55_2), 
      .ZN(n_55_49));
   NOR4_X1_LVT i_55_8 (.A1(n_55_4), .A2(e_state[0]), .A3(e_state[1]), .A4(
      e_state[2]), .ZN(n_55_8));
   NOR4_X1_LVT i_55_51 (.A1(n_55_0), .A2(n_55_1), .A3(e_state[2]), .A4(
      e_state[3]), .ZN(n_55_50));
   NOR4_X1_LVT i_55_52 (.A1(n_55_49), .A2(n_55_8), .A3(n_55_50), .A4(n_55_30), 
      .ZN(n_55_51));
   NAND4_X1_LVT i_55_20 (.A1(n_55_0), .A2(n_55_10), .A3(n_55_4), .A4(e_state[1]), 
      .ZN(n_55_20));
   NAND4_X1_LVT i_55_53 (.A1(n_55_1), .A2(n_55_10), .A3(n_55_4), .A4(e_state[0]), 
      .ZN(n_55_52));
   INV_X1_LVT i_55_22 (.A(n_55_21), .ZN(n_55_22));
   NAND4_X1_LVT i_55_54 (.A1(n_55_51), .A2(n_55_20), .A3(n_55_52), .A4(n_55_22), 
      .ZN(n_55_53));
   OAI211_X1_LVT i_55_55 (.A(n_55_46), .B(n_55_47), .C1(n_55_53), .C2(n_55_18), 
      .ZN(e_state_nxt_reg[1]));
   DFFR_X1_LVT \e_state_reg[1]  (.D(e_state_nxt_reg[1]), .RN(n_91), .CK(mclk), 
      .Q(e_state[1]), .QN());
   INV_X1_LVT i_55_1 (.A(e_state[1]), .ZN(n_55_1));
   NAND4_X1_LVT i_55_2 (.A1(n_55_0), .A2(n_55_1), .A3(e_state[2]), .A4(
      e_state[3]), .ZN(n_55_2));
   NAND3_X1_LVT i_55_6 (.A1(n_55_2), .A2(n_55_3), .A3(n_55_5), .ZN(n_55_6));
   NAND2_X1_LVT i_50_10 (.A1(n_50_2), .A2(src_acalc_pre), .ZN(n_50_10));
   NAND2_X1_LVT i_50_11 (.A1(n_50_0), .A2(cpuoff), .ZN(n_50_11));
   NAND2_X1_LVT i_50_13 (.A1(n_50_12), .A2(n_55), .ZN(n_50_13));
   AND4_X1_LVT i_50_14 (.A1(n_50_9), .A2(n_50_10), .A3(n_50_11), .A4(n_50_13), 
      .ZN(n_50_14));
   NAND2_X1_LVT i_50_15 (.A1(n_50_7), .A2(n_53), .ZN(n_50_15));
   NAND2_X1_LVT i_50_16 (.A1(n_50_14), .A2(n_50_15), .ZN(n_57));
   AND2_X1_LVT i_55_7 (.A1(n_55_6), .A2(n_57), .ZN(n_55_7));
   INV_X1_LVT i_16_0 (.A(n_6), .ZN(n_16_0));
   NOR2_X1_LVT i_16_1 (.A1(n_16_0), .A2(is_sext), .ZN(n_13));
   NOR3_X1_LVT i_6_6 (.A1(n_6_1), .A2(i_state[0]), .A3(i_state[1]), .ZN(n_7));
   OR2_X1_LVT i_17_0 (.A1(n_13), .A2(n_7), .ZN(inst_dext_rdy));
   NAND2_X1_LVT i_19_0 (.A1(e_state[0]), .A2(e_state[3]), .ZN(n_19_0));
   OR3_X1_LVT i_19_1 (.A1(n_19_0), .A2(e_state[1]), .A3(e_state[2]), .ZN(n_19_1));
   AND2_X1_LVT i_19_2 (.A1(n_19_1), .A2(inst_dext_rdy), .ZN(n_15));
   INV_X1_LVT i_20_3 (.A(inst_dext_rdy), .ZN(n_20_3));
   NAND2_X1_LVT i_20_0 (.A1(e_state[0]), .A2(e_state[3]), .ZN(n_20_0));
   NOR3_X1_LVT i_20_1 (.A1(n_20_0), .A2(e_state[1]), .A3(e_state[2]), .ZN(n_20_1));
   INV_X1_LVT i_20_2 (.A(n_20_1), .ZN(n_20_2));
   NAND2_X1_LVT i_20_4 (.A1(n_20_3), .A2(n_20_2), .ZN(n_16));
   CLKGATETST_X1_LVT clk_gate_exec_dext_rdy_reg (.CK(mclk), .E(n_16), .SE(1'b0), 
      .GCK(n_14));
   DFFR_X1_LVT exec_dext_rdy_reg (.D(n_15), .RN(n_91), .CK(n_14), .Q(
      exec_dext_rdy), .QN());
   OR2_X1_LVT i_51_0 (.A1(inst_dext_rdy), .A2(exec_dext_rdy), .ZN(n_61));
   AND2_X1_LVT i_55_9 (.A1(n_55_8), .A2(n_61), .ZN(n_55_9));
   NAND2_X1_LVT i_55_15 (.A1(n_55_14), .A2(n_57), .ZN(n_55_15));
   AOI21_X1_LVT i_55_17 (.A(n_55_11), .B1(n_55_15), .B2(n_55_16), .ZN(n_55_17));
   INV_X1_LVT i_55_19 (.A(n_55_18), .ZN(n_55_19));
   NAND4_X1_LVT i_55_24 (.A1(n_55_19), .A2(n_55_20), .A3(n_55_22), .A4(n_55_23), 
      .ZN(n_55_24));
   NOR4_X1_LVT i_55_25 (.A1(n_55_7), .A2(n_55_9), .A3(n_55_17), .A4(n_55_24), 
      .ZN(n_55_25));
   NAND3_X1_LVT i_55_29 (.A1(n_55_27), .A2(n_55_28), .A3(n_57), .ZN(n_55_29));
   INV_X1_LVT i_54_0 (.A(inst_sext_rdy), .ZN(n_66));
   NAND2_X1_LVT i_55_31 (.A1(n_55_30), .A2(n_66), .ZN(n_55_31));
   INV_X1_LVT i_53_1 (.A(n_64), .ZN(n_53_0));
   INV_X1_LVT i_53_2 (.A(n_62), .ZN(n_53_1));
   OAI21_X1_LVT i_53_3 (.A(n_53_0), .B1(n_53_1), .B2(n_63), .ZN(n_65));
   NAND2_X1_LVT i_55_34 (.A1(n_55_33), .A2(n_65), .ZN(n_55_34));
   NAND4_X1_LVT i_55_35 (.A1(n_55_25), .A2(n_55_29), .A3(n_55_31), .A4(n_55_34), 
      .ZN(e_state_nxt_reg[0]));
   DFFS_X1_LVT \e_state_reg[0]  (.D(e_state_nxt_reg[0]), .SN(n_91), .CK(mclk), 
      .Q(e_state[0]), .QN());
   NAND2_X1_LVT i_32_0 (.A1(e_state[0]), .A2(e_state[3]), .ZN(n_32_0));
   NOR3_X1_LVT i_32_1 (.A1(n_32_0), .A2(e_state[1]), .A3(e_state[2]), .ZN(n_41));
   INV_X1_LVT i_33_0 (.A(e_state[1]), .ZN(n_33_0));
   INV_X1_LVT i_33_1 (.A(e_state[2]), .ZN(n_33_1));
   NAND4_X1_LVT i_33_2 (.A1(n_33_0), .A2(n_33_1), .A3(e_state[0]), .A4(
      e_state[3]), .ZN(n_33_2));
   INV_X1_LVT i_33_3 (.A(e_state[0]), .ZN(n_33_3));
   NAND4_X1_LVT i_33_4 (.A1(n_33_3), .A2(n_33_1), .A3(e_state[1]), .A4(
      e_state[3]), .ZN(n_33_4));
   NAND2_X1_LVT i_33_5 (.A1(n_33_2), .A2(n_33_4), .ZN(n_42));
   CLKGATETST_X1_LVT clk_gate_exec_dst_wr_reg (.CK(mclk), .E(n_42), .SE(1'b0), 
      .GCK(n_40));
   DFFR_X1_LVT exec_dst_wr_reg (.D(n_41), .RN(n_91), .CK(n_40), .Q(exec_dst_wr), 
      .QN());
   INV_X1_LVT i_55_42 (.A(exec_dst_wr), .ZN(n_55_41));
   NAND2_X1_LVT i_55_56 (.A1(n_55_41), .A2(exec_jmp), .ZN(n_55_54));
   INV_X1_LVT i_55_57 (.A(n_55_54), .ZN(n_55_55));
   INV_X1_LVT i_55_58 (.A(n_55_16), .ZN(n_55_56));
   NAND4_X1_LVT i_50_19 (.A1(n_50_16), .A2(n_50_10), .A3(n_50_11), .A4(n_50_13), 
      .ZN(n_59));
   AOI211_X1_LVT i_55_59 (.A(n_55_55), .B(n_55_56), .C1(n_55_14), .C2(n_59), 
      .ZN(n_55_57));
   NOR2_X1_LVT i_55_60 (.A1(n_55_57), .A2(n_55_11), .ZN(n_55_58));
   AND2_X1_LVT i_55_61 (.A1(n_55_6), .A2(n_59), .ZN(n_55_59));
   NOR4_X1_LVT i_55_62 (.A1(n_55_58), .A2(n_55_59), .A3(n_55_50), .A4(n_55_30), 
      .ZN(n_55_60));
   NOR2_X1_LVT i_55_72 (.A1(n_59), .A2(exec_jmp), .ZN(n_55_68));
   OAI21_X1_LVT i_55_63 (.A(n_55_60), .B1(n_55_26), .B2(n_55_68), .ZN(
      e_state_nxt_reg[2]));
   DFFR_X1_LVT \e_state_reg[2]  (.D(e_state_nxt_reg[2]), .RN(n_91), .CK(mclk), 
      .Q(e_state[2]), .QN());
   INV_X1_LVT i_55_10 (.A(e_state[2]), .ZN(n_55_10));
   NOR4_X1_LVT i_55_21 (.A1(n_55_10), .A2(e_state[0]), .A3(e_state[1]), .A4(
      e_state[3]), .ZN(n_55_21));
   NOR4_X1_LVT i_55_64 (.A1(n_55_21), .A2(n_55_36), .A3(n_55_33), .A4(n_55_8), 
      .ZN(n_55_61));
   INV_X1_LVT i_50_20 (.A(n_50_6), .ZN(n_50_17));
   NAND2_X1_LVT i_50_21 (.A1(n_50_17), .A2(dst_acalc_pre), .ZN(n_50_18));
   AND4_X1_LVT i_50_22 (.A1(n_50_9), .A2(n_50_18), .A3(n_50_11), .A4(n_50_13), 
      .ZN(n_50_19));
   NAND2_X1_LVT i_50_23 (.A1(n_50_19), .A2(n_50_15), .ZN(n_60));
   INV_X1_LVT i_55_65 (.A(n_60), .ZN(n_55_62));
   NOR2_X1_LVT i_55_66 (.A1(n_55_62), .A2(exec_jmp), .ZN(n_55_63));
   OAI21_X1_LVT i_55_67 (.A(n_55_27), .B1(n_55_63), .B2(exec_jmp), .ZN(n_55_64));
   OAI211_X1_LVT i_55_68 (.A(n_55_54), .B(n_55_41), .C1(n_55_42), .C2(n_55_62), 
      .ZN(n_55_65));
   NAND2_X1_LVT i_55_69 (.A1(n_55_40), .A2(n_55_65), .ZN(n_55_66));
   NAND2_X1_LVT i_55_70 (.A1(n_55_6), .A2(n_60), .ZN(n_55_67));
   NAND4_X1_LVT i_55_71 (.A1(n_55_61), .A2(n_55_64), .A3(n_55_66), .A4(n_55_67), 
      .ZN(e_state_nxt_reg[3]));
   DFFR_X1_LVT \e_state_reg[3]  (.D(e_state_nxt_reg[3]), .RN(n_91), .CK(mclk), 
      .Q(e_state[3]), .QN());
   INV_X1_LVT i_58_0 (.A(e_state[3]), .ZN(n_58_0));
   NOR4_X1_LVT i_58_3 (.A1(n_58_0), .A2(n_58_1), .A3(n_58_2), .A4(e_state[1]), 
      .ZN(n_67));
   AND2_X1_LVT i_72_0 (.A1(cpu_halt_req), .A2(n_67), .ZN(n_82));
   OAI21_X1_LVT i_72_1 (.A(exec_done), .B1(cpu_halt_req), .B2(cpuoff), .ZN(
      n_72_0));
   INV_X1_LVT i_72_2 (.A(n_72_0), .ZN(n_83));
   NOR2_X1_LVT i_73_0 (.A1(n_82), .A2(n_83), .ZN(n_73_0));
   NOR2_X1_LVT i_73_6 (.A1(n_73_0), .A2(irq_detect), .ZN(n_86));
   NOR3_X1_LVT i_76_13 (.A1(n_76_5), .A2(n_76_2), .A3(i_state[2]), .ZN(n_76_12));
   INV_X1_LVT i_71_0 (.A(pc_sw_wr), .ZN(n_71_0));
   INV_X1_LVT i_64_0 (.A(dst_acalc_pre), .ZN(n_64_0));
   NOR2_X1_LVT i_64_1 (.A1(n_64_0), .A2(n_11), .ZN(n_74));
   OR2_X1_LVT i_65_0 (.A1(inst_as_nxt[5]), .A2(src_acalc_pre), .ZN(n_75));
   HA_X1_LVT i_66_0 (.A(n_74), .B(n_75), .CO(inst_sz_nxt[1]), .S(inst_sz_nxt[0]));
   CLKGATETST_X1_LVT clk_gate_inst_sz_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_76));
   DFFR_X1_LVT \inst_sz_reg[1]  (.D(inst_sz_nxt[1]), .RN(n_91), .CK(n_76), 
      .Q(inst_sz[1]), .QN());
   INV_X1_LVT i_70_0 (.A(inst_sz[1]), .ZN(n_70_0));
   DFFR_X1_LVT \inst_sz_reg[0]  (.D(inst_sz_nxt[0]), .RN(n_91), .CK(n_76), 
      .Q(inst_sz[0]), .QN());
   NAND2_X1_LVT i_70_1 (.A1(n_70_0), .A2(inst_sz[0]), .ZN(n_79));
   AND2_X1_LVT i_71_1 (.A1(n_71_0), .A2(n_79), .ZN(n_80));
   AOI221_X1_LVT i_76_16 (.A(n_76_4), .B1(n_76_6), .B2(n_86), .C1(n_76_12), 
      .C2(n_80), .ZN(n_76_14));
   INV_X1_LVT i_76_17 (.A(n_76_14), .ZN(i_state_nxt_reg[2]));
   DFFR_X1_LVT \i_state_reg[2]  (.D(i_state_nxt_reg[2]), .RN(n_91), .CK(mclk), 
      .Q(i_state[2]), .QN());
   OAI33_X1_LVT i_76_9 (.A1(n_76_2), .A2(i_state[1]), .A3(i_state[2]), .B1(
      n_76_1), .B2(i_state[0]), .B3(i_state[1]), .ZN(n_76_8));
   INV_X1_LVT i_76_10 (.A(n_76_8), .ZN(n_76_9));
   INV_X1_LVT i_75_1 (.A(n_87), .ZN(n_75_0));
   NOR2_X1_LVT i_75_2 (.A1(n_75_0), .A2(n_88), .ZN(n_90));
   NAND2_X1_LVT i_76_11 (.A1(n_76_3), .A2(n_90), .ZN(n_76_10));
   INV_X1_LVT i_73_1 (.A(n_73_0), .ZN(n_73_1));
   NOR2_X1_LVT i_73_5 (.A1(n_73_1), .A2(irq_detect), .ZN(n_85));
   NAND2_X1_LVT i_76_12 (.A1(n_76_6), .A2(n_85), .ZN(n_76_11));
   INV_X1_LVT i_71_2 (.A(n_80), .ZN(n_81));
   NAND2_X1_LVT i_76_14 (.A1(n_76_12), .A2(n_81), .ZN(n_76_13));
   NAND4_X1_LVT i_76_15 (.A1(n_76_9), .A2(n_76_10), .A3(n_76_11), .A4(n_76_13), 
      .ZN(i_state_nxt_reg[1]));
   DFFR_X1_LVT \i_state_reg[1]  (.D(i_state_nxt_reg[1]), .RN(n_91), .CK(mclk), 
      .Q(i_state[1]), .QN());
   NOR3_X1_LVT i_76_0 (.A1(i_state[0]), .A2(i_state[1]), .A3(i_state[2]), 
      .ZN(n_76_0));
   NOR2_X1_LVT i_68_0 (.A1(exec_done), .A2(n_67), .ZN(n_77));
   OR2_X1_LVT i_69_0 (.A1(inst_sz_nxt[0]), .A2(inst_sz_nxt[1]), .ZN(n_78));
   INV_X1_LVT i_73_2 (.A(n_78), .ZN(n_73_2));
   OR4_X1_LVT i_73_3 (.A1(n_73_1), .A2(n_77), .A3(pc_sw_wr), .A4(n_73_2), 
      .ZN(n_73_3));
   AOI21_X1_LVT i_73_4 (.A(irq_detect), .B1(n_73_3), .B2(n_73_0), .ZN(n_84));
   AOI211_X1_LVT i_76_7 (.A(n_76_0), .B(n_76_4), .C1(n_76_6), .C2(n_84), 
      .ZN(n_76_7));
   INV_X1_LVT i_76_8 (.A(n_76_7), .ZN(i_state_nxt_reg[0]));
   NAND3_X1_LVT i_80_0 (.A1(i_state_nxt_reg[0]), .A2(i_state_nxt_reg[2]), 
      .A3(cpu_halt_req), .ZN(n_80_0));
   NOR2_X1_LVT i_80_1 (.A1(n_80_0), .A2(i_state_nxt_reg[1]), .ZN(n_92));
   DFFR_X1_LVT cpu_halt_st_reg (.D(n_92), .RN(n_91), .CK(mclk), .Q(cpu_halt_st), 
      .QN());
   DFFR_X1_LVT \inst_ad_reg[7]  (.D(1'b0), .RN(n_91), .CK(n_21), .Q(inst_ad[7]), 
      .QN());
   DFFR_X1_LVT \inst_ad_reg[5]  (.D(1'b0), .RN(n_91), .CK(n_21), .Q(inst_ad[5]), 
      .QN());
   DFFR_X1_LVT \inst_ad_reg[3]  (.D(1'b0), .RN(n_91), .CK(n_21), .Q(inst_ad[3]), 
      .QN());
   DFFR_X1_LVT \inst_ad_reg[2]  (.D(1'b0), .RN(n_91), .CK(n_21), .Q(inst_ad[2]), 
      .QN());
   DFFR_X1_LVT \inst_ad_reg[0]  (.D(n_18), .RN(n_91), .CK(n_21), .Q(inst_ad[0]), 
      .QN());
   INV_X1_LVT i_12_0 (.A(inst_type_nxt), .ZN(n_12_0));
   NAND2_X1_LVT i_12_23 (.A1(n_12_8), .A2(n_12_0), .ZN(n_12_14));
   NAND3_X1_LVT i_12_5 (.A1(n_12_2), .A2(n_12_3), .A3(n_12_4), .ZN(n_12_5));
   NOR2_X1_LVT i_12_24 (.A1(n_12_14), .A2(n_12_5), .ZN(inst_as_nxt[9]));
   NOR2_X1_LVT i_12_25 (.A1(n_12_14), .A2(n_12_3), .ZN(inst_as_nxt[10]));
   NOR2_X1_LVT i_12_26 (.A1(n_12_14), .A2(n_12_2), .ZN(inst_as_nxt[11]));
   NOR2_X1_LVT i_12_27 (.A1(n_12_14), .A2(n_12_4), .ZN(inst_as_nxt[12]));
   NOR4_X1_LVT i_13_0 (.A1(inst_as_nxt[9]), .A2(inst_as_nxt[10]), .A3(
      inst_as_nxt[11]), .A4(inst_as_nxt[12]), .ZN(n_13_0));
   NOR3_X1_LVT i_12_21 (.A1(n_12_13), .A2(n_12_9), .A3(n_12_2), .ZN(
      inst_as_nxt[7]));
   NOR3_X1_LVT i_12_22 (.A1(n_12_13), .A2(n_12_9), .A3(n_12_4), .ZN(
      inst_as_nxt[8]));
   NOR2_X1_LVT i_13_1 (.A1(inst_as_nxt[7]), .A2(inst_as_nxt[8]), .ZN(n_13_1));
   NAND2_X1_LVT i_13_2 (.A1(n_13_0), .A2(n_13_1), .ZN(is_const));
   DFFR_X1_LVT \inst_as_reg[7]  (.D(is_const), .RN(n_91), .CK(n_12), .Q(
      inst_as[7]), .QN());
   DFFR_X1_LVT \inst_as_reg[3]  (.D(inst_as_nxt[3]), .RN(n_91), .CK(n_12), 
      .Q(inst_as[3]), .QN());
   DFFR_X1_LVT \inst_as_reg[2]  (.D(inst_as_nxt[2]), .RN(n_91), .CK(n_12), 
      .Q(inst_as[2]), .QN());
   OAI21_X1_LVT i_12_10 (.A(n_12_0), .B1(n_12_5), .B2(n_12_9), .ZN(
      inst_as_nxt[0]));
   DFFR_X1_LVT \inst_as_reg[0]  (.D(inst_as_nxt[0]), .RN(n_91), .CK(n_12), 
      .Q(inst_as[0]), .QN());
   INV_X1_LVT i_82_1 (.A(mdb_in[13]), .ZN(n_82_1));
   NAND2_X1_LVT i_82_3 (.A1(mdb_in[12]), .A2(n_82_1), .ZN(n_82_3));
   INV_X1_LVT i_82_6 (.A(mdb_in[14]), .ZN(n_82_6));
   NAND2_X1_LVT i_82_9 (.A1(n_82_6), .A2(mdb_in[15]), .ZN(n_82_9));
   NOR2_X1_LVT i_82_16 (.A1(n_82_3), .A2(n_82_9), .ZN(n_98));
   AND2_X1_LVT i_83_5 (.A1(n_17), .A2(n_98), .ZN(inst_to_nxt[5]));
   NAND2_X1_LVT i_82_5 (.A1(mdb_in[12]), .A2(mdb_in[13]), .ZN(n_82_5));
   NOR2_X1_LVT i_82_18 (.A1(n_82_5), .A2(n_82_9), .ZN(n_100));
   AND2_X1_LVT i_83_7 (.A1(n_17), .A2(n_100), .ZN(inst_to_nxt[7]));
   OR2_X1_LVT i_88_9 (.A1(inst_to_nxt[5]), .A2(inst_to_nxt[7]), .ZN(
      inst_alu_nxt[11]));
   CLKGATETST_X1_LVT clk_gate_inst_alu_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_108));
   DFFR_X1_LVT \inst_alu_reg[11]  (.D(inst_alu_nxt[11]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[11]), .QN());
   NOR2_X1_LVT i_25_9 (.A1(n_25_4), .A2(mdb_in[9]), .ZN(n_24));
   AND2_X1_LVT i_26_2 (.A1(n_10), .A2(n_24), .ZN(n_32));
   AND2_X1_LVT i_27_3 (.A1(n_27_0), .A2(n_32), .ZN(inst_so_nxt[2]));
   NOR2_X1_LVT i_25_7 (.A1(n_25_2), .A2(mdb_in[9]), .ZN(n_22));
   AND2_X1_LVT i_26_0 (.A1(n_22), .A2(n_10), .ZN(n_30));
   AND2_X1_LVT i_27_1 (.A1(n_27_0), .A2(n_30), .ZN(inst_so_nxt[0]));
   NOR2_X1_LVT i_88_6 (.A1(inst_so_nxt[2]), .A2(inst_so_nxt[0]), .ZN(n_88_1));
   INV_X1_LVT i_88_8 (.A(n_88_1), .ZN(inst_alu_nxt[10]));
   DFFR_X1_LVT \inst_alu_reg[10]  (.D(inst_alu_nxt[10]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[10]), .QN());
   NAND2_X1_LVT i_82_10 (.A1(mdb_in[14]), .A2(mdb_in[15]), .ZN(n_82_10));
   NOR2_X1_LVT i_82_22 (.A1(n_82_5), .A2(n_82_10), .ZN(n_104));
   AND2_X1_LVT i_83_11 (.A1(n_17), .A2(n_104), .ZN(inst_to_nxt[11]));
   OR2_X1_LVT i_87_0 (.A1(inst_to_nxt[7]), .A2(inst_to_nxt[11]), .ZN(n_107));
   NOR2_X1_LVT i_25_10 (.A1(n_25_5), .A2(mdb_in[9]), .ZN(n_25));
   AND2_X1_LVT i_26_3 (.A1(n_10), .A2(n_25), .ZN(n_33));
   AND2_X1_LVT i_27_4 (.A1(n_27_0), .A2(n_33), .ZN(inst_so_nxt[3]));
   OR2_X1_LVT i_88_4 (.A1(n_107), .A2(inst_so_nxt[3]), .ZN(inst_alu_nxt[8]));
   INV_X1_LVT i_82_7 (.A(mdb_in[15]), .ZN(n_82_7));
   NAND2_X1_LVT i_82_8 (.A1(mdb_in[14]), .A2(n_82_7), .ZN(n_82_8));
   NOR2_X1_LVT i_82_12 (.A1(n_82_3), .A2(n_82_8), .ZN(n_94));
   AND2_X1_LVT i_83_1 (.A1(n_17), .A2(n_94), .ZN(inst_to_nxt[1]));
   INV_X1_LVT i_82_0 (.A(mdb_in[12]), .ZN(n_82_0));
   NAND2_X1_LVT i_82_2 (.A1(n_82_0), .A2(n_82_1), .ZN(n_82_2));
   NOR2_X1_LVT i_82_15 (.A1(n_82_2), .A2(n_82_9), .ZN(n_97));
   AND2_X1_LVT i_83_4 (.A1(n_17), .A2(n_97), .ZN(inst_to_nxt[4]));
   OR2_X1_LVT i_84_0 (.A1(inst_to_nxt[5]), .A2(inst_to_nxt[4]), .ZN(alu_inc));
   NOR2_X1_LVT i_82_14 (.A1(n_82_5), .A2(n_82_8), .ZN(n_96));
   AND2_X1_LVT i_83_3 (.A1(n_17), .A2(n_96), .ZN(inst_to_nxt[3]));
   NAND2_X1_LVT i_82_4 (.A1(n_82_0), .A2(mdb_in[13]), .ZN(n_82_4));
   NOR2_X1_LVT i_82_13 (.A1(n_82_4), .A2(n_82_8), .ZN(n_95));
   AND2_X1_LVT i_83_2 (.A1(n_17), .A2(n_95), .ZN(inst_to_nxt[2]));
   OR2_X1_LVT i_85_0 (.A1(inst_to_nxt[3]), .A2(inst_to_nxt[2]), .ZN(n_105));
   OR3_X1_LVT i_86_0 (.A1(inst_to_nxt[1]), .A2(alu_inc), .A3(n_105), .ZN(n_106));
   NOR2_X1_LVT i_82_21 (.A1(n_82_4), .A2(n_82_10), .ZN(n_103));
   AND2_X1_LVT i_83_10 (.A1(n_17), .A2(n_103), .ZN(inst_to_nxt[10]));
   NOR2_X1_LVT i_82_17 (.A1(n_82_4), .A2(n_82_9), .ZN(n_99));
   AND2_X1_LVT i_83_6 (.A1(n_17), .A2(n_99), .ZN(inst_to_nxt[6]));
   NOR4_X1_LVT i_88_5 (.A1(inst_alu_nxt[8]), .A2(n_106), .A3(inst_to_nxt[10]), 
      .A4(inst_to_nxt[6]), .ZN(n_88_0));
   NAND2_X1_LVT i_88_7 (.A1(n_88_0), .A2(n_88_1), .ZN(inst_alu_nxt[9]));
   DFFR_X1_LVT \inst_alu_reg[9]  (.D(inst_alu_nxt[9]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[9]), .QN());
   DFFR_X1_LVT \inst_alu_reg[8]  (.D(inst_alu_nxt[8]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[8]), .QN());
   DFFR_X1_LVT \inst_alu_reg[7]  (.D(inst_to_nxt[6]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[7]), .QN());
   DFFR_X1_LVT \inst_alu_reg[6]  (.D(inst_to_nxt[10]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[6]), .QN());
   NOR2_X1_LVT i_82_20 (.A1(n_82_3), .A2(n_82_10), .ZN(n_102));
   AND2_X1_LVT i_83_9 (.A1(n_17), .A2(n_102), .ZN(inst_to_nxt[9]));
   DFFR_X1_LVT \inst_alu_reg[5]  (.D(inst_to_nxt[9]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[5]), .QN());
   NOR2_X1_LVT i_82_19 (.A1(n_82_2), .A2(n_82_10), .ZN(n_101));
   AND2_X1_LVT i_83_8 (.A1(n_17), .A2(n_101), .ZN(inst_to_nxt[8]));
   OR2_X1_LVT i_88_3 (.A1(inst_to_nxt[8]), .A2(n_107), .ZN(inst_alu_nxt[4]));
   DFFR_X1_LVT \inst_alu_reg[4]  (.D(inst_alu_nxt[4]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[4]), .QN());
   OR2_X1_LVT i_88_2 (.A1(n_49), .A2(n_106), .ZN(inst_alu_nxt[3]));
   DFFR_X1_LVT \inst_alu_reg[3]  (.D(inst_alu_nxt[3]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[3]), .QN());
   OR2_X1_LVT i_88_1 (.A1(inst_to_nxt[6]), .A2(n_105), .ZN(inst_alu_nxt[2]));
   DFFR_X1_LVT \inst_alu_reg[2]  (.D(inst_alu_nxt[2]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[2]), .QN());
   DFFR_X1_LVT \inst_alu_reg[1]  (.D(alu_inc), .RN(n_91), .CK(n_108), .Q(
      inst_alu[1]), .QN());
   OR3_X1_LVT i_88_0 (.A1(inst_to_nxt[3]), .A2(alu_inc), .A3(inst_to_nxt[8]), 
      .ZN(inst_alu_nxt[0]));
   DFFR_X1_LVT \inst_alu_reg[0]  (.D(inst_alu_nxt[0]), .RN(n_91), .CK(n_108), 
      .Q(inst_alu[0]), .QN());
   NAND3_X1_LVT i_91_0 (.A1(mdb_in[6]), .A2(n_0), .A3(n_9), .ZN(n_91_0));
   NOR2_X1_LVT i_91_1 (.A1(n_91_0), .A2(inst_type_nxt), .ZN(n_110));
   CLKGATETST_X1_LVT clk_gate_inst_bw_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_109));
   DFFR_X1_LVT inst_bw_reg (.D(n_110), .RN(n_91), .CK(n_109), .Q(inst_bw), .QN());
   DFFR_X1_LVT \inst_type_reg[1]  (.D(inst_type_nxt), .RN(n_91), .CK(n_43), 
      .Q(inst_type[1]), .QN());
   NOR2_X1_LVT i_97_0 (.A1(inst_type[1]), .A2(cpu_halt_st), .ZN(n_97_0));
   INV_X1_LVT i_97_1 (.A(n_97_0), .ZN(n_97_1));
   DFFR_X1_LVT \inst_so_reg[7]  (.D(inst_so_nxt[7]), .RN(n_91), .CK(n_38), 
      .Q(inst_so[7]), .QN());
   OR2_X1_LVT i_96_0 (.A1(inst_so[7]), .A2(n_39), .ZN(n_144));
   NOR2_X1_LVT i_97_2 (.A1(n_97_1), .A2(n_144), .ZN(n_97_2));
   CLKGATETST_X1_LVT clk_gate_inst_dest_bin_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_111));
   DFFR_X1_LVT \inst_dest_bin_reg[0]  (.D(mdb_in[0]), .RN(n_91), .CK(n_111), 
      .Q(inst_dest_bin[0]), .QN());
   DFFR_X1_LVT \inst_dest_bin_reg[1]  (.D(mdb_in[1]), .RN(n_91), .CK(n_111), 
      .Q(inst_dest_bin[1]), .QN());
   NAND2_X1_LVT i_94_5 (.A1(inst_dest_bin[0]), .A2(inst_dest_bin[1]), .ZN(n_94_5));
   DFFR_X1_LVT \inst_dest_bin_reg[2]  (.D(mdb_in[2]), .RN(n_91), .CK(n_111), 
      .Q(inst_dest_bin[2]), .QN());
   DFFR_X1_LVT \inst_dest_bin_reg[3]  (.D(mdb_in[3]), .RN(n_91), .CK(n_111), 
      .Q(inst_dest_bin[3]), .QN());
   NAND2_X1_LVT i_94_11 (.A1(inst_dest_bin[2]), .A2(inst_dest_bin[3]), .ZN(
      n_94_11));
   NOR2_X1_LVT i_94_27 (.A1(n_94_5), .A2(n_94_11), .ZN(n_127));
   NAND2_X1_LVT i_95_5 (.A1(dbg_reg_sel[0]), .A2(dbg_reg_sel[1]), .ZN(n_95_5));
   NAND2_X1_LVT i_95_11 (.A1(dbg_reg_sel[2]), .A2(dbg_reg_sel[3]), .ZN(n_95_11));
   NOR2_X1_LVT i_95_27 (.A1(n_95_5), .A2(n_95_11), .ZN(n_143));
   AOI22_X1_LVT i_97_34 (.A1(n_97_2), .A2(n_127), .B1(cpu_halt_st), .B2(n_143), 
      .ZN(n_97_19));
   INV_X1_LVT i_97_35 (.A(n_97_19), .ZN(inst_dest[15]));
   INV_X1_LVT i_94_0 (.A(inst_dest_bin[0]), .ZN(n_94_0));
   NAND2_X1_LVT i_94_4 (.A1(n_94_0), .A2(inst_dest_bin[1]), .ZN(n_94_4));
   NOR2_X1_LVT i_94_26 (.A1(n_94_4), .A2(n_94_11), .ZN(n_126));
   INV_X1_LVT i_95_0 (.A(dbg_reg_sel[0]), .ZN(n_95_0));
   NAND2_X1_LVT i_95_4 (.A1(n_95_0), .A2(dbg_reg_sel[1]), .ZN(n_95_4));
   NOR2_X1_LVT i_95_26 (.A1(n_95_4), .A2(n_95_11), .ZN(n_142));
   AOI22_X1_LVT i_97_32 (.A1(n_97_2), .A2(n_126), .B1(cpu_halt_st), .B2(n_142), 
      .ZN(n_97_18));
   INV_X1_LVT i_97_33 (.A(n_97_18), .ZN(inst_dest[14]));
   INV_X1_LVT i_94_1 (.A(inst_dest_bin[1]), .ZN(n_94_1));
   NAND2_X1_LVT i_94_3 (.A1(inst_dest_bin[0]), .A2(n_94_1), .ZN(n_94_3));
   NOR2_X1_LVT i_94_25 (.A1(n_94_3), .A2(n_94_11), .ZN(n_125));
   INV_X1_LVT i_95_1 (.A(dbg_reg_sel[1]), .ZN(n_95_1));
   NAND2_X1_LVT i_95_3 (.A1(dbg_reg_sel[0]), .A2(n_95_1), .ZN(n_95_3));
   NOR2_X1_LVT i_95_25 (.A1(n_95_3), .A2(n_95_11), .ZN(n_141));
   AOI22_X1_LVT i_97_30 (.A1(n_97_2), .A2(n_125), .B1(cpu_halt_st), .B2(n_141), 
      .ZN(n_97_17));
   INV_X1_LVT i_97_31 (.A(n_97_17), .ZN(inst_dest[13]));
   NAND2_X1_LVT i_94_2 (.A1(n_94_0), .A2(n_94_1), .ZN(n_94_2));
   NOR2_X1_LVT i_94_24 (.A1(n_94_2), .A2(n_94_11), .ZN(n_124));
   NAND2_X1_LVT i_95_2 (.A1(n_95_0), .A2(n_95_1), .ZN(n_95_2));
   NOR2_X1_LVT i_95_24 (.A1(n_95_2), .A2(n_95_11), .ZN(n_140));
   AOI22_X1_LVT i_97_28 (.A1(n_97_2), .A2(n_124), .B1(cpu_halt_st), .B2(n_140), 
      .ZN(n_97_16));
   INV_X1_LVT i_97_29 (.A(n_97_16), .ZN(inst_dest[12]));
   INV_X1_LVT i_94_6 (.A(inst_dest_bin[2]), .ZN(n_94_6));
   NAND2_X1_LVT i_94_10 (.A1(n_94_6), .A2(inst_dest_bin[3]), .ZN(n_94_10));
   NOR2_X1_LVT i_94_23 (.A1(n_94_5), .A2(n_94_10), .ZN(n_123));
   INV_X1_LVT i_95_6 (.A(dbg_reg_sel[2]), .ZN(n_95_6));
   NAND2_X1_LVT i_95_10 (.A1(n_95_6), .A2(dbg_reg_sel[3]), .ZN(n_95_10));
   NOR2_X1_LVT i_95_23 (.A1(n_95_5), .A2(n_95_10), .ZN(n_139));
   AOI22_X1_LVT i_97_26 (.A1(n_97_2), .A2(n_123), .B1(cpu_halt_st), .B2(n_139), 
      .ZN(n_97_15));
   INV_X1_LVT i_97_27 (.A(n_97_15), .ZN(inst_dest[11]));
   NOR2_X1_LVT i_94_22 (.A1(n_94_4), .A2(n_94_10), .ZN(n_122));
   NOR2_X1_LVT i_95_22 (.A1(n_95_4), .A2(n_95_10), .ZN(n_138));
   AOI22_X1_LVT i_97_24 (.A1(n_97_2), .A2(n_122), .B1(cpu_halt_st), .B2(n_138), 
      .ZN(n_97_14));
   INV_X1_LVT i_97_25 (.A(n_97_14), .ZN(inst_dest[10]));
   NOR2_X1_LVT i_94_21 (.A1(n_94_3), .A2(n_94_10), .ZN(n_121));
   NOR2_X1_LVT i_95_21 (.A1(n_95_3), .A2(n_95_10), .ZN(n_137));
   AOI22_X1_LVT i_97_22 (.A1(n_97_2), .A2(n_121), .B1(cpu_halt_st), .B2(n_137), 
      .ZN(n_97_13));
   INV_X1_LVT i_97_23 (.A(n_97_13), .ZN(inst_dest[9]));
   NOR2_X1_LVT i_94_20 (.A1(n_94_2), .A2(n_94_10), .ZN(n_120));
   NOR2_X1_LVT i_95_20 (.A1(n_95_2), .A2(n_95_10), .ZN(n_136));
   AOI22_X1_LVT i_97_20 (.A1(n_97_2), .A2(n_120), .B1(cpu_halt_st), .B2(n_136), 
      .ZN(n_97_12));
   INV_X1_LVT i_97_21 (.A(n_97_12), .ZN(inst_dest[8]));
   INV_X1_LVT i_94_7 (.A(inst_dest_bin[3]), .ZN(n_94_7));
   NAND2_X1_LVT i_94_9 (.A1(inst_dest_bin[2]), .A2(n_94_7), .ZN(n_94_9));
   NOR2_X1_LVT i_94_19 (.A1(n_94_5), .A2(n_94_9), .ZN(n_119));
   INV_X1_LVT i_95_7 (.A(dbg_reg_sel[3]), .ZN(n_95_7));
   NAND2_X1_LVT i_95_9 (.A1(dbg_reg_sel[2]), .A2(n_95_7), .ZN(n_95_9));
   NOR2_X1_LVT i_95_19 (.A1(n_95_5), .A2(n_95_9), .ZN(n_135));
   AOI22_X1_LVT i_97_18 (.A1(n_97_2), .A2(n_119), .B1(cpu_halt_st), .B2(n_135), 
      .ZN(n_97_11));
   INV_X1_LVT i_97_19 (.A(n_97_11), .ZN(inst_dest[7]));
   NOR2_X1_LVT i_94_18 (.A1(n_94_4), .A2(n_94_9), .ZN(n_118));
   NOR2_X1_LVT i_95_18 (.A1(n_95_4), .A2(n_95_9), .ZN(n_134));
   AOI22_X1_LVT i_97_16 (.A1(n_97_2), .A2(n_118), .B1(cpu_halt_st), .B2(n_134), 
      .ZN(n_97_10));
   INV_X1_LVT i_97_17 (.A(n_97_10), .ZN(inst_dest[6]));
   NOR2_X1_LVT i_94_17 (.A1(n_94_3), .A2(n_94_9), .ZN(n_117));
   NOR2_X1_LVT i_95_17 (.A1(n_95_3), .A2(n_95_9), .ZN(n_133));
   AOI22_X1_LVT i_97_14 (.A1(n_97_2), .A2(n_117), .B1(cpu_halt_st), .B2(n_133), 
      .ZN(n_97_9));
   INV_X1_LVT i_97_15 (.A(n_97_9), .ZN(inst_dest[5]));
   NOR2_X1_LVT i_94_16 (.A1(n_94_2), .A2(n_94_9), .ZN(n_116));
   NOR2_X1_LVT i_95_16 (.A1(n_95_2), .A2(n_95_9), .ZN(n_132));
   AOI22_X1_LVT i_97_12 (.A1(n_97_2), .A2(n_116), .B1(cpu_halt_st), .B2(n_132), 
      .ZN(n_97_8));
   INV_X1_LVT i_97_13 (.A(n_97_8), .ZN(inst_dest[4]));
   NAND2_X1_LVT i_94_8 (.A1(n_94_6), .A2(n_94_7), .ZN(n_94_8));
   NOR2_X1_LVT i_94_15 (.A1(n_94_5), .A2(n_94_8), .ZN(n_115));
   NAND2_X1_LVT i_95_8 (.A1(n_95_6), .A2(n_95_7), .ZN(n_95_8));
   NOR2_X1_LVT i_95_15 (.A1(n_95_5), .A2(n_95_8), .ZN(n_131));
   AOI22_X1_LVT i_97_10 (.A1(n_97_2), .A2(n_115), .B1(cpu_halt_st), .B2(n_131), 
      .ZN(n_97_7));
   INV_X1_LVT i_97_11 (.A(n_97_7), .ZN(inst_dest[3]));
   NOR2_X1_LVT i_94_14 (.A1(n_94_4), .A2(n_94_8), .ZN(n_114));
   NOR2_X1_LVT i_95_14 (.A1(n_95_4), .A2(n_95_8), .ZN(n_130));
   AOI22_X1_LVT i_97_8 (.A1(n_97_2), .A2(n_114), .B1(cpu_halt_st), .B2(n_130), 
      .ZN(n_97_6));
   INV_X1_LVT i_97_9 (.A(n_97_6), .ZN(inst_dest[2]));
   NOR2_X1_LVT i_94_13 (.A1(n_94_3), .A2(n_94_8), .ZN(n_113));
   NOR2_X1_LVT i_95_13 (.A1(n_95_3), .A2(n_95_8), .ZN(n_129));
   AOI222_X1_LVT i_97_6 (.A1(n_97_2), .A2(n_113), .B1(n_97_0), .B2(n_144), 
      .C1(cpu_halt_st), .C2(n_129), .ZN(n_97_5));
   INV_X1_LVT i_97_7 (.A(n_97_5), .ZN(inst_dest[1]));
   NOR2_X1_LVT i_94_12 (.A1(n_94_2), .A2(n_94_8), .ZN(n_112));
   INV_X1_LVT i_97_3 (.A(cpu_halt_st), .ZN(n_97_3));
   NOR2_X1_LVT i_95_12 (.A1(n_95_2), .A2(n_95_8), .ZN(n_128));
   AOI222_X1_LVT i_97_4 (.A1(n_97_2), .A2(n_112), .B1(n_97_3), .B2(inst_type[1]), 
      .C1(n_128), .C2(cpu_halt_st), .ZN(n_97_4));
   INV_X1_LVT i_97_5 (.A(n_97_4), .ZN(inst_dest[0]));
   INV_X1_LVT i_99_6 (.A(mdb_in[3]), .ZN(n_99_4));
   XNOR2_X1_LVT i_99_19 (.A(mdb_in[15]), .B(n_99_4), .ZN(n_99_17));
   INV_X1_LVT i_98_0 (.A(i_state_nxt_reg[2]), .ZN(n_98_0));
   OR3_X1_LVT i_98_1 (.A1(n_98_0), .A2(i_state_nxt_reg[0]), .A3(
      i_state_nxt_reg[1]), .ZN(n_98_1));
   INV_X1_LVT i_98_2 (.A(inst_as[4]), .ZN(n_98_2));
   AND4_X1_LVT i_98_3 (.A1(n_98_1), .A2(n_98_2), .A3(n_6), .A4(inst_ad[4]), 
      .ZN(n_98_3));
   AOI221_X1_LVT i_98_4 (.A(n_98_3), .B1(n_6), .B2(inst_as[4]), .C1(n_7), 
      .C2(inst_ad[4]), .ZN(n_98_4));
   INV_X1_LVT i_98_5 (.A(n_98_4), .ZN(n_145));
   INV_X1_LVT i_99_3 (.A(mdb_in[1]), .ZN(n_99_2));
   NAND2_X1_LVT i_99_2 (.A1(n_145), .A2(n_99_2), .ZN(n_99_1));
   OR2_X1_LVT i_99_5 (.A1(mdb_in[2]), .A2(n_99_1), .ZN(n_99_3));
   HA_X1_LVT i_99_7 (.A(n_99_4), .B(n_99_3), .CO(n_99_5), .S(ext_nxt[3]));
   FA_X1_LVT i_99_8 (.A(mdb_in[4]), .B(n_99_4), .CI(n_99_5), .CO(n_99_6), 
      .S(ext_nxt[4]));
   FA_X1_LVT i_99_9 (.A(mdb_in[5]), .B(n_99_4), .CI(n_99_6), .CO(n_99_7), 
      .S(ext_nxt[5]));
   FA_X1_LVT i_99_10 (.A(mdb_in[6]), .B(n_99_4), .CI(n_99_7), .CO(n_99_8), 
      .S(ext_nxt[6]));
   FA_X1_LVT i_99_11 (.A(mdb_in[7]), .B(n_99_4), .CI(n_99_8), .CO(n_99_9), 
      .S(ext_nxt[7]));
   FA_X1_LVT i_99_12 (.A(mdb_in[8]), .B(n_99_4), .CI(n_99_9), .CO(n_99_10), 
      .S(ext_nxt[8]));
   FA_X1_LVT i_99_13 (.A(mdb_in[9]), .B(n_99_4), .CI(n_99_10), .CO(n_99_11), 
      .S(ext_nxt[9]));
   FA_X1_LVT i_99_14 (.A(mdb_in[10]), .B(n_99_4), .CI(n_99_11), .CO(n_99_12), 
      .S(ext_nxt[10]));
   FA_X1_LVT i_99_15 (.A(mdb_in[11]), .B(n_99_4), .CI(n_99_12), .CO(n_99_13), 
      .S(ext_nxt[11]));
   FA_X1_LVT i_99_16 (.A(mdb_in[12]), .B(n_99_4), .CI(n_99_13), .CO(n_99_14), 
      .S(ext_nxt[12]));
   FA_X1_LVT i_99_17 (.A(mdb_in[13]), .B(n_99_4), .CI(n_99_14), .CO(n_99_15), 
      .S(ext_nxt[13]));
   FA_X1_LVT i_99_18 (.A(mdb_in[14]), .B(n_99_4), .CI(n_99_15), .CO(n_99_16), 
      .S(ext_nxt[14]));
   XNOR2_X1_LVT i_99_20 (.A(n_99_17), .B(n_99_16), .ZN(ext_nxt[15]));
   INV_X1_LVT i_101_0 (.A(i_state[2]), .ZN(n_101_0));
   NOR3_X1_LVT i_101_1 (.A1(n_101_0), .A2(i_state[0]), .A3(i_state[1]), .ZN(
      n_101_1));
   OR2_X1_LVT i_101_2 (.A1(n_101_1), .A2(n_13), .ZN(n_147));
   CLKGATETST_X1_LVT clk_gate_inst_dext_reg (.CK(mclk), .E(n_147), .SE(1'b0), 
      .GCK(n_146));
   DFFR_X1_LVT \inst_dext_reg[15]  (.D(ext_nxt[15]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[15]), .QN());
   DFFR_X1_LVT \inst_dext_reg[14]  (.D(ext_nxt[14]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[14]), .QN());
   DFFR_X1_LVT \inst_dext_reg[13]  (.D(ext_nxt[13]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[13]), .QN());
   DFFR_X1_LVT \inst_dext_reg[12]  (.D(ext_nxt[12]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[12]), .QN());
   DFFR_X1_LVT \inst_dext_reg[11]  (.D(ext_nxt[11]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[11]), .QN());
   DFFR_X1_LVT \inst_dext_reg[10]  (.D(ext_nxt[10]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[10]), .QN());
   DFFR_X1_LVT \inst_dext_reg[9]  (.D(ext_nxt[9]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[9]), .QN());
   DFFR_X1_LVT \inst_dext_reg[8]  (.D(ext_nxt[8]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[8]), .QN());
   DFFR_X1_LVT \inst_dext_reg[7]  (.D(ext_nxt[7]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[7]), .QN());
   DFFR_X1_LVT \inst_dext_reg[6]  (.D(ext_nxt[6]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[6]), .QN());
   DFFR_X1_LVT \inst_dext_reg[5]  (.D(ext_nxt[5]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[5]), .QN());
   DFFR_X1_LVT \inst_dext_reg[4]  (.D(ext_nxt[4]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[4]), .QN());
   DFFR_X1_LVT \inst_dext_reg[3]  (.D(ext_nxt[3]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[3]), .QN());
   XNOR2_X1_LVT i_99_4 (.A(mdb_in[2]), .B(n_99_1), .ZN(ext_nxt[2]));
   DFFR_X1_LVT \inst_dext_reg[2]  (.D(ext_nxt[2]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[2]), .QN());
   XNOR2_X1_LVT i_99_0 (.A(n_145), .B(mdb_in[1]), .ZN(n_99_0));
   INV_X1_LVT i_99_1 (.A(n_99_0), .ZN(ext_nxt[1]));
   DFFR_X1_LVT \inst_dext_reg[1]  (.D(ext_nxt[1]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[1]), .QN());
   DFFR_X1_LVT \inst_dext_reg[0]  (.D(mdb_in[0]), .RN(n_91), .CK(n_146), 
      .Q(inst_dext[0]), .QN());
   CLKGATETST_X1_LVT clk_gate_inst_irq_rst_reg (.CK(mclk), .E(exec_done), 
      .SE(1'b0), .GCK(n_148));
   DFFS_X1_LVT inst_irq_rst_reg (.D(1'b0), .SN(n_91), .CK(n_148), .Q(
      inst_irq_rst), .QN());
   CLKGATETST_X1_LVT clk_gate_inst_jmp_bin_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_149));
   DFFR_X1_LVT \inst_jmp_bin_reg[0]  (.D(mdb_in[10]), .RN(n_91), .CK(n_149), 
      .Q(inst_jmp_bin[0]), .QN());
   DFFR_X1_LVT \inst_jmp_bin_reg[1]  (.D(mdb_in[11]), .RN(n_91), .CK(n_149), 
      .Q(inst_jmp_bin[1]), .QN());
   NAND2_X1_LVT i_105_5 (.A1(inst_jmp_bin[0]), .A2(inst_jmp_bin[1]), .ZN(n_105_5));
   DFFR_X1_LVT \inst_jmp_bin_reg[2]  (.D(mdb_in[12]), .RN(n_91), .CK(n_149), 
      .Q(inst_jmp_bin[2]), .QN());
   INV_X1_LVT i_105_6 (.A(inst_jmp_bin[2]), .ZN(n_105_6));
   NOR2_X1_LVT i_105_14 (.A1(n_105_5), .A2(n_105_6), .ZN(n_157));
   AND2_X1_LVT i_106_7 (.A1(inst_type[1]), .A2(n_157), .ZN(inst_jmp[7]));
   INV_X1_LVT i_105_0 (.A(inst_jmp_bin[0]), .ZN(n_105_0));
   NAND2_X1_LVT i_105_4 (.A1(n_105_0), .A2(inst_jmp_bin[1]), .ZN(n_105_4));
   NOR2_X1_LVT i_105_13 (.A1(n_105_4), .A2(n_105_6), .ZN(n_156));
   AND2_X1_LVT i_106_6 (.A1(inst_type[1]), .A2(n_156), .ZN(inst_jmp[6]));
   INV_X1_LVT i_105_1 (.A(inst_jmp_bin[1]), .ZN(n_105_1));
   NAND2_X1_LVT i_105_3 (.A1(inst_jmp_bin[0]), .A2(n_105_1), .ZN(n_105_3));
   NOR2_X1_LVT i_105_12 (.A1(n_105_3), .A2(n_105_6), .ZN(n_155));
   AND2_X1_LVT i_106_5 (.A1(inst_type[1]), .A2(n_155), .ZN(inst_jmp[5]));
   NAND2_X1_LVT i_105_2 (.A1(n_105_0), .A2(n_105_1), .ZN(n_105_2));
   NOR2_X1_LVT i_105_11 (.A1(n_105_2), .A2(n_105_6), .ZN(n_154));
   AND2_X1_LVT i_106_4 (.A1(inst_type[1]), .A2(n_154), .ZN(inst_jmp[4]));
   NOR2_X1_LVT i_105_10 (.A1(n_105_5), .A2(inst_jmp_bin[2]), .ZN(n_153));
   AND2_X1_LVT i_106_3 (.A1(inst_type[1]), .A2(n_153), .ZN(inst_jmp[3]));
   NOR2_X1_LVT i_105_9 (.A1(n_105_4), .A2(inst_jmp_bin[2]), .ZN(n_152));
   AND2_X1_LVT i_106_2 (.A1(inst_type[1]), .A2(n_152), .ZN(inst_jmp[2]));
   NOR2_X1_LVT i_105_8 (.A1(n_105_3), .A2(inst_jmp_bin[2]), .ZN(n_151));
   AND2_X1_LVT i_106_1 (.A1(inst_type[1]), .A2(n_151), .ZN(inst_jmp[1]));
   NOR2_X1_LVT i_105_7 (.A1(n_105_2), .A2(inst_jmp_bin[2]), .ZN(n_150));
   AND2_X1_LVT i_106_0 (.A1(n_150), .A2(inst_type[1]), .ZN(inst_jmp[0]));
   NOR2_X1_LVT i_82_11 (.A1(n_82_2), .A2(n_82_8), .ZN(n_93));
   AND2_X1_LVT i_83_0 (.A1(n_17), .A2(n_93), .ZN(inst_to_nxt[0]));
   CLKGATETST_X1_LVT clk_gate_inst_mov_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_158));
   DFFR_X1_LVT inst_mov_reg (.D(inst_to_nxt[0]), .RN(n_91), .CK(n_158), .Q(
      inst_mov), .QN());
   AND2_X1_LVT i_110_33 (.A1(inst_type_nxt), .A2(mdb_in[9]), .ZN(n_110_23));
   AND2_X1_LVT i_110_14 (.A1(is_const), .A2(inst_as_nxt[12]), .ZN(n_110_10));
   NOR2_X1_LVT i_110_0 (.A1(inst_type_nxt), .A2(is_const), .ZN(n_110_0));
   AOI211_X1_LVT i_110_49 (.A(n_110_23), .B(n_110_10), .C1(n_110_0), .C2(
      ext_nxt[15]), .ZN(n_110_34));
   INV_X1_LVT i_110_2 (.A(decode), .ZN(n_110_2));
   INV_X1_LVT i_110_50 (.A(ext_nxt[15]), .ZN(n_110_35));
   OAI22_X1_LVT i_110_51 (.A1(n_110_34), .A2(n_110_2), .B1(decode), .B2(n_110_35), 
      .ZN(n_179));
   NOR2_X1_LVT i_111_0 (.A1(inst_type_nxt), .A2(is_const), .ZN(n_111_0));
   INV_X1_LVT i_111_4 (.A(n_111_0), .ZN(n_111_3));
   NOR2_X1_LVT i_111_5 (.A1(inst_sext_rdy), .A2(n_111_3), .ZN(n_111_4));
   INV_X1_LVT i_111_1 (.A(decode), .ZN(n_111_1));
   INV_X1_LVT i_111_2 (.A(inst_sext_rdy), .ZN(n_111_2));
   OAI22_X1_LVT i_111_3 (.A1(n_111_4), .A2(n_111_1), .B1(decode), .B2(n_111_2), 
      .ZN(n_180));
   CLKGATETST_X1_LVT clk_gate_inst_sext_reg (.CK(mclk), .E(n_180), .SE(1'b0), 
      .GCK(n_163));
   DFFR_X1_LVT \inst_sext_reg[15]  (.D(n_179), .RN(n_91), .CK(n_163), .Q(
      inst_sext[15]), .QN());
   AOI211_X1_LVT i_110_46 (.A(n_110_23), .B(n_110_10), .C1(n_110_0), .C2(
      ext_nxt[14]), .ZN(n_110_32));
   INV_X1_LVT i_110_47 (.A(ext_nxt[14]), .ZN(n_110_33));
   OAI22_X1_LVT i_110_48 (.A1(n_110_32), .A2(n_110_2), .B1(decode), .B2(n_110_33), 
      .ZN(n_178));
   DFFR_X1_LVT \inst_sext_reg[14]  (.D(n_178), .RN(n_91), .CK(n_163), .Q(
      inst_sext[14]), .QN());
   AOI211_X1_LVT i_110_43 (.A(n_110_23), .B(n_110_10), .C1(n_110_0), .C2(
      ext_nxt[13]), .ZN(n_110_30));
   INV_X1_LVT i_110_44 (.A(ext_nxt[13]), .ZN(n_110_31));
   OAI22_X1_LVT i_110_45 (.A1(n_110_30), .A2(n_110_2), .B1(decode), .B2(n_110_31), 
      .ZN(n_177));
   DFFR_X1_LVT \inst_sext_reg[13]  (.D(n_177), .RN(n_91), .CK(n_163), .Q(
      inst_sext[13]), .QN());
   AOI211_X1_LVT i_110_40 (.A(n_110_23), .B(n_110_10), .C1(n_110_0), .C2(
      ext_nxt[12]), .ZN(n_110_28));
   INV_X1_LVT i_110_41 (.A(ext_nxt[12]), .ZN(n_110_29));
   OAI22_X1_LVT i_110_42 (.A1(n_110_28), .A2(n_110_2), .B1(decode), .B2(n_110_29), 
      .ZN(n_176));
   DFFR_X1_LVT \inst_sext_reg[12]  (.D(n_176), .RN(n_91), .CK(n_163), .Q(
      inst_sext[12]), .QN());
   AOI211_X1_LVT i_110_37 (.A(n_110_23), .B(n_110_10), .C1(n_110_0), .C2(
      ext_nxt[11]), .ZN(n_110_26));
   INV_X1_LVT i_110_38 (.A(ext_nxt[11]), .ZN(n_110_27));
   OAI22_X1_LVT i_110_39 (.A1(n_110_26), .A2(n_110_2), .B1(decode), .B2(n_110_27), 
      .ZN(n_175));
   DFFR_X1_LVT \inst_sext_reg[11]  (.D(n_175), .RN(n_91), .CK(n_163), .Q(
      inst_sext[11]), .QN());
   AOI211_X1_LVT i_110_34 (.A(n_110_23), .B(n_110_10), .C1(n_110_0), .C2(
      ext_nxt[10]), .ZN(n_110_24));
   INV_X1_LVT i_110_35 (.A(ext_nxt[10]), .ZN(n_110_25));
   OAI22_X1_LVT i_110_36 (.A1(n_110_24), .A2(n_110_2), .B1(decode), .B2(n_110_25), 
      .ZN(n_174));
   DFFR_X1_LVT \inst_sext_reg[10]  (.D(n_174), .RN(n_91), .CK(n_163), .Q(
      inst_sext[10]), .QN());
   AOI221_X1_LVT i_110_30 (.A(n_110_10), .B1(inst_type_nxt), .B2(mdb_in[8]), 
      .C1(n_110_0), .C2(ext_nxt[9]), .ZN(n_110_21));
   INV_X1_LVT i_110_31 (.A(ext_nxt[9]), .ZN(n_110_22));
   OAI22_X1_LVT i_110_32 (.A1(n_110_21), .A2(n_110_2), .B1(decode), .B2(n_110_22), 
      .ZN(n_173));
   DFFR_X1_LVT \inst_sext_reg[9]  (.D(n_173), .RN(n_91), .CK(n_163), .Q(
      inst_sext[9]), .QN());
   AOI221_X1_LVT i_110_27 (.A(n_110_10), .B1(inst_type_nxt), .B2(mdb_in[7]), 
      .C1(n_110_0), .C2(ext_nxt[8]), .ZN(n_110_19));
   INV_X1_LVT i_110_28 (.A(ext_nxt[8]), .ZN(n_110_20));
   OAI22_X1_LVT i_110_29 (.A1(n_110_19), .A2(n_110_2), .B1(decode), .B2(n_110_20), 
      .ZN(n_172));
   DFFR_X1_LVT \inst_sext_reg[8]  (.D(n_172), .RN(n_91), .CK(n_163), .Q(
      inst_sext[8]), .QN());
   AOI221_X1_LVT i_110_24 (.A(n_110_10), .B1(inst_type_nxt), .B2(mdb_in[6]), 
      .C1(n_110_0), .C2(ext_nxt[7]), .ZN(n_110_17));
   INV_X1_LVT i_110_25 (.A(ext_nxt[7]), .ZN(n_110_18));
   OAI22_X1_LVT i_110_26 (.A1(n_110_17), .A2(n_110_2), .B1(decode), .B2(n_110_18), 
      .ZN(n_171));
   DFFR_X1_LVT \inst_sext_reg[7]  (.D(n_171), .RN(n_91), .CK(n_163), .Q(
      inst_sext[7]), .QN());
   AOI221_X1_LVT i_110_21 (.A(n_110_10), .B1(inst_type_nxt), .B2(mdb_in[5]), 
      .C1(n_110_0), .C2(ext_nxt[6]), .ZN(n_110_15));
   INV_X1_LVT i_110_22 (.A(ext_nxt[6]), .ZN(n_110_16));
   OAI22_X1_LVT i_110_23 (.A1(n_110_15), .A2(n_110_2), .B1(decode), .B2(n_110_16), 
      .ZN(n_170));
   DFFR_X1_LVT \inst_sext_reg[6]  (.D(n_170), .RN(n_91), .CK(n_163), .Q(
      inst_sext[6]), .QN());
   AOI221_X1_LVT i_110_18 (.A(n_110_10), .B1(inst_type_nxt), .B2(mdb_in[4]), 
      .C1(n_110_0), .C2(ext_nxt[5]), .ZN(n_110_13));
   INV_X1_LVT i_110_19 (.A(ext_nxt[5]), .ZN(n_110_14));
   OAI22_X1_LVT i_110_20 (.A1(n_110_13), .A2(n_110_2), .B1(decode), .B2(n_110_14), 
      .ZN(n_169));
   DFFR_X1_LVT \inst_sext_reg[5]  (.D(n_169), .RN(n_91), .CK(n_163), .Q(
      inst_sext[5]), .QN());
   AOI221_X1_LVT i_110_15 (.A(n_110_10), .B1(inst_type_nxt), .B2(mdb_in[3]), 
      .C1(n_110_0), .C2(ext_nxt[4]), .ZN(n_110_11));
   INV_X1_LVT i_110_16 (.A(ext_nxt[4]), .ZN(n_110_12));
   OAI22_X1_LVT i_110_17 (.A1(n_110_11), .A2(n_110_2), .B1(decode), .B2(n_110_12), 
      .ZN(n_168));
   DFFR_X1_LVT \inst_sext_reg[4]  (.D(n_168), .RN(n_91), .CK(n_163), .Q(
      inst_sext[4]), .QN());
   OR2_X1_LVT i_108_3 (.A1(inst_as_nxt[12]), .A2(inst_as_nxt[8]), .ZN(n_162));
   AOI222_X1_LVT i_110_11 (.A1(n_110_0), .A2(ext_nxt[3]), .B1(is_const), 
      .B2(n_162), .C1(inst_type_nxt), .C2(mdb_in[2]), .ZN(n_110_8));
   INV_X1_LVT i_110_12 (.A(ext_nxt[3]), .ZN(n_110_9));
   OAI22_X1_LVT i_110_13 (.A1(n_110_8), .A2(n_110_2), .B1(decode), .B2(n_110_9), 
      .ZN(n_167));
   DFFR_X1_LVT \inst_sext_reg[3]  (.D(n_167), .RN(n_91), .CK(n_163), .Q(
      inst_sext[3]), .QN());
   OR2_X1_LVT i_108_2 (.A1(inst_as_nxt[12]), .A2(inst_as_nxt[7]), .ZN(n_161));
   AOI222_X1_LVT i_110_8 (.A1(n_110_0), .A2(ext_nxt[2]), .B1(is_const), .B2(
      n_161), .C1(inst_type_nxt), .C2(mdb_in[1]), .ZN(n_110_6));
   INV_X1_LVT i_110_9 (.A(ext_nxt[2]), .ZN(n_110_7));
   OAI22_X1_LVT i_110_10 (.A1(n_110_6), .A2(n_110_2), .B1(decode), .B2(n_110_7), 
      .ZN(n_166));
   DFFR_X1_LVT \inst_sext_reg[2]  (.D(n_166), .RN(n_91), .CK(n_163), .Q(
      inst_sext[2]), .QN());
   OR2_X1_LVT i_108_1 (.A1(inst_as_nxt[12]), .A2(inst_as_nxt[11]), .ZN(n_160));
   AOI222_X1_LVT i_110_5 (.A1(n_110_0), .A2(ext_nxt[1]), .B1(is_const), .B2(
      n_160), .C1(inst_type_nxt), .C2(mdb_in[0]), .ZN(n_110_4));
   INV_X1_LVT i_110_6 (.A(ext_nxt[1]), .ZN(n_110_5));
   OAI22_X1_LVT i_110_7 (.A1(n_110_4), .A2(n_110_2), .B1(decode), .B2(n_110_5), 
      .ZN(n_165));
   DFFR_X1_LVT \inst_sext_reg[1]  (.D(n_165), .RN(n_91), .CK(n_163), .Q(
      inst_sext[1]), .QN());
   OR2_X1_LVT i_108_0 (.A1(inst_as_nxt[12]), .A2(inst_as_nxt[10]), .ZN(n_159));
   AOI22_X1_LVT i_110_1 (.A1(n_110_0), .A2(mdb_in[0]), .B1(n_159), .B2(is_const), 
      .ZN(n_110_1));
   INV_X1_LVT i_110_3 (.A(mdb_in[0]), .ZN(n_110_3));
   OAI22_X1_LVT i_110_4 (.A1(n_110_1), .A2(n_110_2), .B1(decode), .B2(n_110_3), 
      .ZN(n_164));
   DFFR_X1_LVT \inst_sext_reg[0]  (.D(n_164), .RN(n_91), .CK(n_163), .Q(
      inst_sext[0]), .QN());
   DFFR_X1_LVT \inst_so_reg[3]  (.D(inst_so_nxt[3]), .RN(n_91), .CK(n_38), 
      .Q(inst_so[3]), .QN());
   DFFR_X1_LVT \inst_so_reg[2]  (.D(inst_so_nxt[2]), .RN(n_91), .CK(n_38), 
      .Q(inst_so[2]), .QN());
   NOR2_X1_LVT i_25_8 (.A1(n_25_3), .A2(mdb_in[9]), .ZN(n_23));
   AND2_X1_LVT i_26_1 (.A1(n_10), .A2(n_23), .ZN(n_31));
   AND2_X1_LVT i_27_2 (.A1(n_27_0), .A2(n_31), .ZN(inst_so_nxt[1]));
   DFFR_X1_LVT \inst_so_reg[1]  (.D(inst_so_nxt[1]), .RN(n_91), .CK(n_38), 
      .Q(inst_so[1]), .QN());
   DFFR_X1_LVT \inst_so_reg[0]  (.D(inst_so_nxt[0]), .RN(n_91), .CK(n_38), 
      .Q(inst_so[0]), .QN());
   DFFR_X1_LVT \inst_type_reg[2]  (.D(n_17), .RN(n_91), .CK(n_43), .Q(
      inst_type[2]), .QN());
   NOR2_X1_LVT i_115_0 (.A1(inst_so[6]), .A2(inst_type[2]), .ZN(n_115_0));
   INV_X1_LVT i_115_1 (.A(inst_so[7]), .ZN(n_115_1));
   AND3_X1_LVT i_115_2 (.A1(n_115_0), .A2(n_115_1), .A3(inst_type[0]), .ZN(
      n_115_2));
   CLKGATETST_X1_LVT clk_gate_inst_src_bin_reg (.CK(mclk), .E(decode), .SE(1'b0), 
      .GCK(n_181));
   DFFR_X1_LVT \inst_src_bin_reg[0]  (.D(mdb_in[8]), .RN(n_91), .CK(n_181), 
      .Q(inst_src_bin[0]), .QN());
   DFFR_X1_LVT \inst_src_bin_reg[1]  (.D(mdb_in[9]), .RN(n_91), .CK(n_181), 
      .Q(inst_src_bin[1]), .QN());
   NAND2_X1_LVT i_114_5 (.A1(inst_src_bin[0]), .A2(inst_src_bin[1]), .ZN(n_114_5));
   DFFR_X1_LVT \inst_src_bin_reg[2]  (.D(mdb_in[10]), .RN(n_91), .CK(n_181), 
      .Q(inst_src_bin[2]), .QN());
   DFFR_X1_LVT \inst_src_bin_reg[3]  (.D(mdb_in[11]), .RN(n_91), .CK(n_181), 
      .Q(inst_src_bin[3]), .QN());
   NAND2_X1_LVT i_114_11 (.A1(inst_src_bin[2]), .A2(inst_src_bin[3]), .ZN(
      n_114_11));
   NOR2_X1_LVT i_114_27 (.A1(n_114_5), .A2(n_114_11), .ZN(n_197));
   AOI22_X1_LVT i_115_34 (.A1(n_115_2), .A2(n_127), .B1(inst_type[2]), .B2(n_197), 
      .ZN(n_115_19));
   INV_X1_LVT i_115_35 (.A(n_115_19), .ZN(inst_src[15]));
   INV_X1_LVT i_114_0 (.A(inst_src_bin[0]), .ZN(n_114_0));
   NAND2_X1_LVT i_114_4 (.A1(n_114_0), .A2(inst_src_bin[1]), .ZN(n_114_4));
   NOR2_X1_LVT i_114_26 (.A1(n_114_4), .A2(n_114_11), .ZN(n_196));
   AOI22_X1_LVT i_115_32 (.A1(n_115_2), .A2(n_126), .B1(inst_type[2]), .B2(n_196), 
      .ZN(n_115_18));
   INV_X1_LVT i_115_33 (.A(n_115_18), .ZN(inst_src[14]));
   INV_X1_LVT i_114_1 (.A(inst_src_bin[1]), .ZN(n_114_1));
   NAND2_X1_LVT i_114_3 (.A1(inst_src_bin[0]), .A2(n_114_1), .ZN(n_114_3));
   NOR2_X1_LVT i_114_25 (.A1(n_114_3), .A2(n_114_11), .ZN(n_195));
   AOI22_X1_LVT i_115_30 (.A1(n_115_2), .A2(n_125), .B1(inst_type[2]), .B2(n_195), 
      .ZN(n_115_17));
   INV_X1_LVT i_115_31 (.A(n_115_17), .ZN(inst_src[13]));
   NAND2_X1_LVT i_114_2 (.A1(n_114_0), .A2(n_114_1), .ZN(n_114_2));
   NOR2_X1_LVT i_114_24 (.A1(n_114_2), .A2(n_114_11), .ZN(n_194));
   AOI22_X1_LVT i_115_28 (.A1(n_115_2), .A2(n_124), .B1(inst_type[2]), .B2(n_194), 
      .ZN(n_115_16));
   INV_X1_LVT i_115_29 (.A(n_115_16), .ZN(inst_src[12]));
   INV_X1_LVT i_114_6 (.A(inst_src_bin[2]), .ZN(n_114_6));
   NAND2_X1_LVT i_114_10 (.A1(n_114_6), .A2(inst_src_bin[3]), .ZN(n_114_10));
   NOR2_X1_LVT i_114_23 (.A1(n_114_5), .A2(n_114_10), .ZN(n_193));
   AOI22_X1_LVT i_115_26 (.A1(n_115_2), .A2(n_123), .B1(inst_type[2]), .B2(n_193), 
      .ZN(n_115_15));
   INV_X1_LVT i_115_27 (.A(n_115_15), .ZN(inst_src[11]));
   NOR2_X1_LVT i_114_22 (.A1(n_114_4), .A2(n_114_10), .ZN(n_192));
   AOI22_X1_LVT i_115_24 (.A1(n_115_2), .A2(n_122), .B1(inst_type[2]), .B2(n_192), 
      .ZN(n_115_14));
   INV_X1_LVT i_115_25 (.A(n_115_14), .ZN(inst_src[10]));
   NOR2_X1_LVT i_114_21 (.A1(n_114_3), .A2(n_114_10), .ZN(n_191));
   AOI22_X1_LVT i_115_22 (.A1(n_115_2), .A2(n_121), .B1(inst_type[2]), .B2(n_191), 
      .ZN(n_115_13));
   INV_X1_LVT i_115_23 (.A(n_115_13), .ZN(inst_src[9]));
   NOR2_X1_LVT i_114_20 (.A1(n_114_2), .A2(n_114_10), .ZN(n_190));
   AOI22_X1_LVT i_115_20 (.A1(n_115_2), .A2(n_120), .B1(inst_type[2]), .B2(n_190), 
      .ZN(n_115_12));
   INV_X1_LVT i_115_21 (.A(n_115_12), .ZN(inst_src[8]));
   INV_X1_LVT i_114_7 (.A(inst_src_bin[3]), .ZN(n_114_7));
   NAND2_X1_LVT i_114_9 (.A1(inst_src_bin[2]), .A2(n_114_7), .ZN(n_114_9));
   NOR2_X1_LVT i_114_19 (.A1(n_114_5), .A2(n_114_9), .ZN(n_189));
   AOI22_X1_LVT i_115_18 (.A1(n_115_2), .A2(n_119), .B1(inst_type[2]), .B2(n_189), 
      .ZN(n_115_11));
   INV_X1_LVT i_115_19 (.A(n_115_11), .ZN(inst_src[7]));
   NOR2_X1_LVT i_114_18 (.A1(n_114_4), .A2(n_114_9), .ZN(n_188));
   AOI22_X1_LVT i_115_16 (.A1(n_115_2), .A2(n_118), .B1(inst_type[2]), .B2(n_188), 
      .ZN(n_115_10));
   INV_X1_LVT i_115_17 (.A(n_115_10), .ZN(inst_src[6]));
   NOR2_X1_LVT i_114_17 (.A1(n_114_3), .A2(n_114_9), .ZN(n_187));
   AOI22_X1_LVT i_115_14 (.A1(n_115_2), .A2(n_117), .B1(inst_type[2]), .B2(n_187), 
      .ZN(n_115_9));
   INV_X1_LVT i_115_15 (.A(n_115_9), .ZN(inst_src[5]));
   NOR2_X1_LVT i_114_16 (.A1(n_114_2), .A2(n_114_9), .ZN(n_186));
   AOI22_X1_LVT i_115_12 (.A1(n_115_2), .A2(n_116), .B1(inst_type[2]), .B2(n_186), 
      .ZN(n_115_8));
   INV_X1_LVT i_115_13 (.A(n_115_8), .ZN(inst_src[4]));
   NAND2_X1_LVT i_114_8 (.A1(n_114_6), .A2(n_114_7), .ZN(n_114_8));
   NOR2_X1_LVT i_114_15 (.A1(n_114_5), .A2(n_114_8), .ZN(n_185));
   AOI22_X1_LVT i_115_10 (.A1(n_115_2), .A2(n_115), .B1(inst_type[2]), .B2(n_185), 
      .ZN(n_115_7));
   INV_X1_LVT i_115_11 (.A(n_115_7), .ZN(inst_src[3]));
   NOR2_X1_LVT i_114_14 (.A1(n_114_4), .A2(n_114_8), .ZN(n_184));
   AOI22_X1_LVT i_115_8 (.A1(n_115_2), .A2(n_114), .B1(inst_type[2]), .B2(n_184), 
      .ZN(n_115_6));
   INV_X1_LVT i_115_9 (.A(n_115_6), .ZN(inst_src[2]));
   INV_X1_LVT i_115_5 (.A(inst_type[2]), .ZN(n_115_4));
   NOR2_X1_LVT i_114_13 (.A1(n_114_3), .A2(n_114_8), .ZN(n_183));
   AOI222_X1_LVT i_115_6 (.A1(n_115_2), .A2(n_113), .B1(n_115_4), .B2(inst_so[6]), 
      .C1(inst_type[2]), .C2(n_183), .ZN(n_115_5));
   INV_X1_LVT i_115_7 (.A(n_115_5), .ZN(inst_src[1]));
   NOR2_X1_LVT i_114_12 (.A1(n_114_2), .A2(n_114_8), .ZN(n_182));
   AOI222_X1_LVT i_115_3 (.A1(n_115_2), .A2(n_112), .B1(n_115_0), .B2(inst_so[7]), 
      .C1(n_182), .C2(inst_type[2]), .ZN(n_115_3));
   INV_X1_LVT i_115_4 (.A(n_115_3), .ZN(inst_src[0]));
   NOR3_X1_LVT i_6_7 (.A1(i_state[0]), .A2(i_state[1]), .A3(i_state[2]), 
      .ZN(n_8));
   NOR2_X1_LVT i_118_0 (.A1(irq[13]), .A2(nmi_pnd), .ZN(n_118_0));
   INV_X1_LVT i_118_1 (.A(n_118_0), .ZN(n_118_1));
   NOR2_X1_LVT i_118_2 (.A1(n_118_1), .A2(irq[12]), .ZN(n_118_2));
   INV_X1_LVT i_118_3 (.A(n_118_2), .ZN(n_118_3));
   NOR2_X1_LVT i_118_4 (.A1(n_118_3), .A2(irq[11]), .ZN(n_118_4));
   INV_X1_LVT i_118_5 (.A(n_118_4), .ZN(n_118_5));
   OR2_X1_LVT i_116_0 (.A1(irq[10]), .A2(wdt_irq), .ZN(n_198));
   NOR2_X1_LVT i_118_6 (.A1(n_118_5), .A2(n_198), .ZN(n_118_6));
   INV_X1_LVT i_118_7 (.A(irq[9]), .ZN(n_118_7));
   NAND2_X1_LVT i_118_8 (.A1(n_118_6), .A2(n_118_7), .ZN(n_118_8));
   NOR2_X1_LVT i_118_9 (.A1(n_118_8), .A2(irq[8]), .ZN(n_118_9));
   INV_X1_LVT i_118_10 (.A(n_118_9), .ZN(n_118_10));
   NOR2_X1_LVT i_118_11 (.A1(n_118_10), .A2(irq[7]), .ZN(n_118_11));
   INV_X1_LVT i_118_12 (.A(n_118_11), .ZN(n_118_12));
   NOR2_X1_LVT i_118_13 (.A1(n_118_12), .A2(irq[6]), .ZN(n_118_13));
   INV_X1_LVT i_118_14 (.A(irq[5]), .ZN(n_118_14));
   NAND2_X1_LVT i_118_15 (.A1(n_118_13), .A2(n_118_14), .ZN(n_118_15));
   NOR2_X1_LVT i_118_16 (.A1(n_118_15), .A2(irq[4]), .ZN(n_118_16));
   INV_X1_LVT i_118_17 (.A(irq[3]), .ZN(n_118_17));
   NAND2_X1_LVT i_118_18 (.A1(n_118_16), .A2(n_118_17), .ZN(n_118_18));
   NOR2_X1_LVT i_118_19 (.A1(n_118_18), .A2(irq[2]), .ZN(n_118_19));
   NAND2_X1_LVT i_118_20 (.A1(n_118_19), .A2(irq[1]), .ZN(n_118_20));
   INV_X1_LVT i_118_21 (.A(n_118_20), .ZN(n_118_21));
   NAND2_X1_LVT i_118_22 (.A1(n_118_9), .A2(irq[7]), .ZN(n_118_22));
   NAND2_X1_LVT i_118_23 (.A1(n_118_6), .A2(irq[9]), .ZN(n_118_23));
   NAND2_X1_LVT i_118_24 (.A1(n_118_2), .A2(irq[11]), .ZN(n_118_24));
   INV_X1_LVT i_118_25 (.A(nmi_pnd), .ZN(n_118_25));
   NAND2_X1_LVT i_118_26 (.A1(n_118_25), .A2(irq[13]), .ZN(n_118_26));
   NAND4_X1_LVT i_118_27 (.A1(n_118_22), .A2(n_118_23), .A3(n_118_24), .A4(
      n_118_26), .ZN(n_118_27));
   AND2_X1_LVT i_118_28 (.A1(n_118_16), .A2(irq[3]), .ZN(n_118_28));
   NAND2_X1_LVT i_118_29 (.A1(n_118_13), .A2(irq[5]), .ZN(n_118_29));
   INV_X1_LVT i_118_30 (.A(n_118_29), .ZN(n_118_30));
   NOR4_X1_LVT i_118_31 (.A1(n_118_21), .A2(n_118_27), .A3(n_118_28), .A4(
      n_118_30), .ZN(n_118_31));
   INV_X1_LVT i_118_32 (.A(n_118_19), .ZN(n_118_32));
   NOR2_X1_LVT i_118_33 (.A1(n_118_32), .A2(irq[1]), .ZN(n_118_33));
   INV_X1_LVT i_118_34 (.A(irq[0]), .ZN(n_118_34));
   NAND2_X1_LVT i_118_35 (.A1(n_118_33), .A2(n_118_34), .ZN(n_118_35));
   NAND2_X1_LVT i_118_36 (.A1(n_118_31), .A2(n_118_35), .ZN(n_200));
   CLKGATETST_X1_LVT clk_gate_irq_num_reg (.CK(mclk), .E(irq_detect), .SE(1'b0), 
      .GCK(n_199));
   DFFS_X1_LVT \irq_num_reg[0]  (.D(n_200), .SN(n_91), .CK(n_199), .Q(irq_num[0]), 
      .QN());
   INV_X1_LVT i_120_0 (.A(irq_num[0]), .ZN(n_120_0));
   INV_X1_LVT i_118_37 (.A(irq[2]), .ZN(n_118_36));
   NOR2_X1_LVT i_118_38 (.A1(n_118_18), .A2(n_118_36), .ZN(n_118_37));
   NAND2_X1_LVT i_118_39 (.A1(n_118_4), .A2(n_198), .ZN(n_118_38));
   NAND4_X1_LVT i_118_40 (.A1(n_118_22), .A2(n_118_38), .A3(n_118_24), .A4(
      n_118_25), .ZN(n_118_39));
   NAND2_X1_LVT i_118_41 (.A1(n_118_11), .A2(irq[6]), .ZN(n_118_40));
   INV_X1_LVT i_118_42 (.A(n_118_40), .ZN(n_118_41));
   NOR4_X1_LVT i_118_43 (.A1(n_118_37), .A2(n_118_39), .A3(n_118_28), .A4(
      n_118_41), .ZN(n_118_42));
   NAND2_X1_LVT i_118_44 (.A1(n_118_42), .A2(n_118_35), .ZN(n_201));
   DFFS_X1_LVT \irq_num_reg[1]  (.D(n_201), .SN(n_91), .CK(n_199), .Q(irq_num[1]), 
      .QN());
   NOR2_X1_LVT i_120_3 (.A1(n_120_0), .A2(irq_num[1]), .ZN(n_120_3));
   NAND2_X1_LVT i_118_45 (.A1(n_118_0), .A2(irq[12]), .ZN(n_118_43));
   NAND4_X1_LVT i_118_46 (.A1(n_118_22), .A2(n_118_43), .A3(n_118_26), .A4(
      n_118_25), .ZN(n_118_44));
   INV_X1_LVT i_118_47 (.A(irq[4]), .ZN(n_118_45));
   NOR2_X1_LVT i_118_48 (.A1(n_118_15), .A2(n_118_45), .ZN(n_118_46));
   NOR4_X1_LVT i_118_49 (.A1(n_118_44), .A2(n_118_46), .A3(n_118_30), .A4(
      n_118_41), .ZN(n_118_47));
   NAND2_X1_LVT i_118_50 (.A1(n_118_47), .A2(n_118_35), .ZN(n_202));
   DFFS_X1_LVT \irq_num_reg[2]  (.D(n_202), .SN(n_91), .CK(n_199), .Q(irq_num[2]), 
      .QN());
   NAND2_X1_LVT i_120_12 (.A1(n_120_3), .A2(irq_num[2]), .ZN(n_120_12));
   NAND4_X1_LVT i_118_51 (.A1(n_118_24), .A2(n_118_43), .A3(n_118_26), .A4(
      n_118_25), .ZN(n_118_48));
   INV_X1_LVT i_118_52 (.A(irq[8]), .ZN(n_118_49));
   NOR2_X1_LVT i_118_53 (.A1(n_118_8), .A2(n_118_49), .ZN(n_118_50));
   INV_X1_LVT i_118_54 (.A(n_118_23), .ZN(n_118_51));
   INV_X1_LVT i_118_55 (.A(n_118_38), .ZN(n_118_52));
   NOR4_X1_LVT i_118_56 (.A1(n_118_48), .A2(n_118_50), .A3(n_118_51), .A4(
      n_118_52), .ZN(n_118_53));
   NAND2_X1_LVT i_118_57 (.A1(n_118_53), .A2(n_118_35), .ZN(n_203));
   DFFS_X1_LVT \irq_num_reg[3]  (.D(n_203), .SN(n_91), .CK(n_199), .Q(irq_num[3]), 
      .QN());
   INV_X1_LVT i_120_15 (.A(irq_num[3]), .ZN(n_120_15));
   NAND4_X1_LVT i_118_58 (.A1(n_118_53), .A2(n_118_29), .A3(n_118_40), .A4(
      n_118_22), .ZN(n_118_54));
   NOR4_X1_LVT i_118_59 (.A1(n_118_54), .A2(n_118_37), .A3(n_118_28), .A4(
      n_118_46), .ZN(n_118_55));
   NAND2_X1_LVT i_118_60 (.A1(n_118_33), .A2(irq[0]), .ZN(n_118_56));
   NAND4_X1_LVT i_118_61 (.A1(n_118_55), .A2(n_118_56), .A3(n_118_35), .A4(
      n_118_20), .ZN(n_204));
   DFFS_X1_LVT \irq_num_reg[4]  (.D(n_204), .SN(n_91), .CK(n_199), .Q(irq_num[4]), 
      .QN());
   INV_X1_LVT i_120_16 (.A(irq_num[4]), .ZN(n_120_16));
   NOR2_X1_LVT i_120_18 (.A1(n_120_15), .A2(n_120_16), .ZN(n_120_18));
   DFFS_X1_LVT \irq_num_reg[5]  (.D(n_204), .SN(n_91), .CK(n_199), .Q(irq_num[5]), 
      .QN());
   NAND2_X1_LVT i_120_20 (.A1(n_120_18), .A2(irq_num[5]), .ZN(n_120_20));
   NOR2_X1_LVT i_120_34 (.A1(n_120_12), .A2(n_120_20), .ZN(n_218));
   AND2_X1_LVT i_121_13 (.A1(n_8), .A2(n_218), .ZN(irq_acc[13]));
   NOR2_X1_LVT i_120_2 (.A1(irq_num[0]), .A2(irq_num[1]), .ZN(n_120_2));
   NAND2_X1_LVT i_120_11 (.A1(n_120_2), .A2(irq_num[2]), .ZN(n_120_11));
   NOR2_X1_LVT i_120_33 (.A1(n_120_11), .A2(n_120_20), .ZN(n_217));
   AND2_X1_LVT i_121_12 (.A1(n_8), .A2(n_217), .ZN(irq_acc[12]));
   INV_X1_LVT i_120_1 (.A(irq_num[1]), .ZN(n_120_1));
   NOR2_X1_LVT i_120_5 (.A1(n_120_0), .A2(n_120_1), .ZN(n_120_5));
   INV_X1_LVT i_120_6 (.A(irq_num[2]), .ZN(n_120_6));
   NAND2_X1_LVT i_120_10 (.A1(n_120_5), .A2(n_120_6), .ZN(n_120_10));
   NOR2_X1_LVT i_120_32 (.A1(n_120_10), .A2(n_120_20), .ZN(n_216));
   AND2_X1_LVT i_121_11 (.A1(n_8), .A2(n_216), .ZN(irq_acc[11]));
   NOR2_X1_LVT i_120_4 (.A1(irq_num[0]), .A2(n_120_1), .ZN(n_120_4));
   NAND2_X1_LVT i_120_9 (.A1(n_120_4), .A2(n_120_6), .ZN(n_120_9));
   NOR2_X1_LVT i_120_31 (.A1(n_120_9), .A2(n_120_20), .ZN(n_215));
   AND2_X1_LVT i_121_10 (.A1(n_8), .A2(n_215), .ZN(irq_acc[10]));
   NAND2_X1_LVT i_120_8 (.A1(n_120_3), .A2(n_120_6), .ZN(n_120_8));
   NOR2_X1_LVT i_120_30 (.A1(n_120_8), .A2(n_120_20), .ZN(n_214));
   AND2_X1_LVT i_121_9 (.A1(n_8), .A2(n_214), .ZN(irq_acc[9]));
   NAND2_X1_LVT i_120_7 (.A1(n_120_2), .A2(n_120_6), .ZN(n_120_7));
   NOR2_X1_LVT i_120_29 (.A1(n_120_7), .A2(n_120_20), .ZN(n_213));
   AND2_X1_LVT i_121_8 (.A1(n_8), .A2(n_213), .ZN(irq_acc[8]));
   NAND2_X1_LVT i_120_14 (.A1(n_120_5), .A2(irq_num[2]), .ZN(n_120_14));
   NOR2_X1_LVT i_120_17 (.A1(irq_num[3]), .A2(n_120_16), .ZN(n_120_17));
   NAND2_X1_LVT i_120_19 (.A1(n_120_17), .A2(irq_num[5]), .ZN(n_120_19));
   NOR2_X1_LVT i_120_28 (.A1(n_120_14), .A2(n_120_19), .ZN(n_212));
   AND2_X1_LVT i_121_7 (.A1(n_8), .A2(n_212), .ZN(irq_acc[7]));
   NAND2_X1_LVT i_120_13 (.A1(n_120_4), .A2(irq_num[2]), .ZN(n_120_13));
   NOR2_X1_LVT i_120_27 (.A1(n_120_13), .A2(n_120_19), .ZN(n_211));
   AND2_X1_LVT i_121_6 (.A1(n_8), .A2(n_211), .ZN(irq_acc[6]));
   NOR2_X1_LVT i_120_26 (.A1(n_120_12), .A2(n_120_19), .ZN(n_210));
   AND2_X1_LVT i_121_5 (.A1(n_8), .A2(n_210), .ZN(irq_acc[5]));
   NOR2_X1_LVT i_120_25 (.A1(n_120_11), .A2(n_120_19), .ZN(n_209));
   AND2_X1_LVT i_121_4 (.A1(n_8), .A2(n_209), .ZN(irq_acc[4]));
   NOR2_X1_LVT i_120_24 (.A1(n_120_10), .A2(n_120_19), .ZN(n_208));
   AND2_X1_LVT i_121_3 (.A1(n_8), .A2(n_208), .ZN(irq_acc[3]));
   NOR2_X1_LVT i_120_23 (.A1(n_120_9), .A2(n_120_19), .ZN(n_207));
   AND2_X1_LVT i_121_2 (.A1(n_8), .A2(n_207), .ZN(irq_acc[2]));
   NOR2_X1_LVT i_120_22 (.A1(n_120_8), .A2(n_120_19), .ZN(n_206));
   AND2_X1_LVT i_121_1 (.A1(n_8), .A2(n_206), .ZN(irq_acc[1]));
   NOR2_X1_LVT i_120_21 (.A1(n_120_7), .A2(n_120_19), .ZN(n_205));
   AND2_X1_LVT i_121_0 (.A1(n_8), .A2(n_205), .ZN(irq_acc[0]));
   INV_X1_LVT i_127_0 (.A(pc_sw_wr), .ZN(n_127_0));
   NOR3_X1_LVT i_125_2 (.A1(i_state[0]), .A2(i_state[1]), .A3(i_state[2]), 
      .ZN(n_221));
   INV_X1_LVT i_125_0 (.A(i_state[0]), .ZN(n_125_0));
   NOR3_X1_LVT i_125_1 (.A1(n_125_0), .A2(i_state[1]), .A3(i_state[2]), .ZN(
      n_220));
   NOR2_X1_LVT i_125_3 (.A1(n_220), .A2(n_221), .ZN(n_222));
   DFFR_X1_LVT \pc_reg[15]  (.D(pc_nxt[15]), .RN(n_91), .CK(mclk), .Q(pc[15]), 
      .QN());
   AOI221_X1_LVT i_126_28 (.A(n_221), .B1(n_220), .B2(mdb_in[14]), .C1(n_222), 
      .C2(pc_incr[14]), .ZN(n_126_14));
   INV_X1_LVT i_126_29 (.A(n_126_14), .ZN(n_237));
   AOI22_X1_LVT i_127_29 (.A1(n_127_0), .A2(n_237), .B1(pc_sw_wr), .B2(pc_sw[14]), 
      .ZN(n_127_15));
   INV_X1_LVT i_127_30 (.A(n_127_15), .ZN(pc_nxt[14]));
   DFFR_X1_LVT \pc_reg[14]  (.D(pc_nxt[14]), .RN(n_91), .CK(mclk), .Q(pc[14]), 
      .QN());
   AOI221_X1_LVT i_126_26 (.A(n_221), .B1(n_220), .B2(mdb_in[13]), .C1(n_222), 
      .C2(pc_incr[13]), .ZN(n_126_13));
   INV_X1_LVT i_126_27 (.A(n_126_13), .ZN(n_236));
   AOI22_X1_LVT i_127_27 (.A1(n_127_0), .A2(n_236), .B1(pc_sw_wr), .B2(pc_sw[13]), 
      .ZN(n_127_14));
   INV_X1_LVT i_127_28 (.A(n_127_14), .ZN(pc_nxt[13]));
   DFFR_X1_LVT \pc_reg[13]  (.D(pc_nxt[13]), .RN(n_91), .CK(mclk), .Q(pc[13]), 
      .QN());
   AOI221_X1_LVT i_126_24 (.A(n_221), .B1(n_220), .B2(mdb_in[12]), .C1(n_222), 
      .C2(pc_incr[12]), .ZN(n_126_12));
   INV_X1_LVT i_126_25 (.A(n_126_12), .ZN(n_235));
   AOI22_X1_LVT i_127_25 (.A1(n_127_0), .A2(n_235), .B1(pc_sw_wr), .B2(pc_sw[12]), 
      .ZN(n_127_13));
   INV_X1_LVT i_127_26 (.A(n_127_13), .ZN(pc_nxt[12]));
   DFFR_X1_LVT \pc_reg[12]  (.D(pc_nxt[12]), .RN(n_91), .CK(mclk), .Q(pc[12]), 
      .QN());
   AOI221_X1_LVT i_126_22 (.A(n_221), .B1(n_220), .B2(mdb_in[11]), .C1(n_222), 
      .C2(pc_incr[11]), .ZN(n_126_11));
   INV_X1_LVT i_126_23 (.A(n_126_11), .ZN(n_234));
   AOI22_X1_LVT i_127_23 (.A1(n_127_0), .A2(n_234), .B1(pc_sw_wr), .B2(pc_sw[11]), 
      .ZN(n_127_12));
   INV_X1_LVT i_127_24 (.A(n_127_12), .ZN(pc_nxt[11]));
   DFFR_X1_LVT \pc_reg[11]  (.D(pc_nxt[11]), .RN(n_91), .CK(mclk), .Q(pc[11]), 
      .QN());
   AOI221_X1_LVT i_126_20 (.A(n_221), .B1(n_220), .B2(mdb_in[10]), .C1(n_222), 
      .C2(pc_incr[10]), .ZN(n_126_10));
   INV_X1_LVT i_126_21 (.A(n_126_10), .ZN(n_233));
   AOI22_X1_LVT i_127_21 (.A1(n_127_0), .A2(n_233), .B1(pc_sw_wr), .B2(pc_sw[10]), 
      .ZN(n_127_11));
   INV_X1_LVT i_127_22 (.A(n_127_11), .ZN(pc_nxt[10]));
   DFFR_X1_LVT \pc_reg[10]  (.D(pc_nxt[10]), .RN(n_91), .CK(mclk), .Q(pc[10]), 
      .QN());
   AOI221_X1_LVT i_126_18 (.A(n_221), .B1(n_220), .B2(mdb_in[9]), .C1(n_222), 
      .C2(pc_incr[9]), .ZN(n_126_9));
   INV_X1_LVT i_126_19 (.A(n_126_9), .ZN(n_232));
   AOI22_X1_LVT i_127_19 (.A1(n_127_0), .A2(n_232), .B1(pc_sw_wr), .B2(pc_sw[9]), 
      .ZN(n_127_10));
   INV_X1_LVT i_127_20 (.A(n_127_10), .ZN(pc_nxt[9]));
   DFFR_X1_LVT \pc_reg[9]  (.D(pc_nxt[9]), .RN(n_91), .CK(mclk), .Q(pc[9]), 
      .QN());
   AOI221_X1_LVT i_126_16 (.A(n_221), .B1(n_220), .B2(mdb_in[8]), .C1(n_222), 
      .C2(pc_incr[8]), .ZN(n_126_8));
   INV_X1_LVT i_126_17 (.A(n_126_8), .ZN(n_231));
   AOI22_X1_LVT i_127_17 (.A1(n_127_0), .A2(n_231), .B1(pc_sw_wr), .B2(pc_sw[8]), 
      .ZN(n_127_9));
   INV_X1_LVT i_127_18 (.A(n_127_9), .ZN(pc_nxt[8]));
   DFFR_X1_LVT \pc_reg[8]  (.D(pc_nxt[8]), .RN(n_91), .CK(mclk), .Q(pc[8]), 
      .QN());
   AOI221_X1_LVT i_126_14 (.A(n_221), .B1(n_220), .B2(mdb_in[7]), .C1(n_222), 
      .C2(pc_incr[7]), .ZN(n_126_7));
   INV_X1_LVT i_126_15 (.A(n_126_7), .ZN(n_230));
   AOI22_X1_LVT i_127_15 (.A1(n_127_0), .A2(n_230), .B1(pc_sw_wr), .B2(pc_sw[7]), 
      .ZN(n_127_8));
   INV_X1_LVT i_127_16 (.A(n_127_8), .ZN(pc_nxt[7]));
   DFFR_X1_LVT \pc_reg[7]  (.D(pc_nxt[7]), .RN(n_91), .CK(mclk), .Q(pc[7]), 
      .QN());
   AOI222_X1_LVT i_126_12 (.A1(n_221), .A2(irq_num[5]), .B1(n_220), .B2(
      mdb_in[6]), .C1(n_222), .C2(pc_incr[6]), .ZN(n_126_6));
   INV_X1_LVT i_126_13 (.A(n_126_6), .ZN(n_229));
   AOI22_X1_LVT i_127_13 (.A1(n_127_0), .A2(n_229), .B1(pc_sw_wr), .B2(pc_sw[6]), 
      .ZN(n_127_7));
   INV_X1_LVT i_127_14 (.A(n_127_7), .ZN(pc_nxt[6]));
   DFFR_X1_LVT \pc_reg[6]  (.D(pc_nxt[6]), .RN(n_91), .CK(mclk), .Q(pc[6]), 
      .QN());
   AOI222_X1_LVT i_126_10 (.A1(n_221), .A2(irq_num[4]), .B1(n_220), .B2(
      mdb_in[5]), .C1(n_222), .C2(pc_incr[5]), .ZN(n_126_5));
   INV_X1_LVT i_126_11 (.A(n_126_5), .ZN(n_228));
   AOI22_X1_LVT i_127_11 (.A1(n_127_0), .A2(n_228), .B1(pc_sw_wr), .B2(pc_sw[5]), 
      .ZN(n_127_6));
   INV_X1_LVT i_127_12 (.A(n_127_6), .ZN(pc_nxt[5]));
   DFFR_X1_LVT \pc_reg[5]  (.D(pc_nxt[5]), .RN(n_91), .CK(mclk), .Q(pc[5]), 
      .QN());
   AOI222_X1_LVT i_126_8 (.A1(n_221), .A2(irq_num[3]), .B1(n_220), .B2(mdb_in[4]), 
      .C1(n_222), .C2(pc_incr[4]), .ZN(n_126_4));
   INV_X1_LVT i_126_9 (.A(n_126_4), .ZN(n_227));
   AOI22_X1_LVT i_127_9 (.A1(n_127_0), .A2(n_227), .B1(pc_sw_wr), .B2(pc_sw[4]), 
      .ZN(n_127_5));
   INV_X1_LVT i_127_10 (.A(n_127_5), .ZN(pc_nxt[4]));
   DFFR_X1_LVT \pc_reg[4]  (.D(pc_nxt[4]), .RN(n_91), .CK(mclk), .Q(pc[4]), 
      .QN());
   AOI222_X1_LVT i_126_6 (.A1(n_221), .A2(irq_num[2]), .B1(n_220), .B2(mdb_in[3]), 
      .C1(n_222), .C2(pc_incr[3]), .ZN(n_126_3));
   INV_X1_LVT i_126_7 (.A(n_126_3), .ZN(n_226));
   AOI22_X1_LVT i_127_7 (.A1(n_127_0), .A2(n_226), .B1(pc_sw_wr), .B2(pc_sw[3]), 
      .ZN(n_127_4));
   INV_X1_LVT i_127_8 (.A(n_127_4), .ZN(pc_nxt[3]));
   DFFR_X1_LVT \pc_reg[3]  (.D(pc_nxt[3]), .RN(n_91), .CK(mclk), .Q(pc[3]), 
      .QN());
   AOI222_X1_LVT i_126_4 (.A1(n_221), .A2(irq_num[1]), .B1(n_220), .B2(mdb_in[2]), 
      .C1(n_222), .C2(pc_incr[2]), .ZN(n_126_2));
   INV_X1_LVT i_126_5 (.A(n_126_2), .ZN(n_225));
   AOI22_X1_LVT i_127_5 (.A1(n_127_0), .A2(n_225), .B1(pc_sw_wr), .B2(pc_sw[2]), 
      .ZN(n_127_3));
   INV_X1_LVT i_127_6 (.A(n_127_3), .ZN(pc_nxt[2]));
   DFFR_X1_LVT \pc_reg[2]  (.D(pc_nxt[2]), .RN(n_91), .CK(mclk), .Q(pc[2]), 
      .QN());
   INV_X1_LVT i_122_0 (.A(e_state_nxt_reg[1]), .ZN(n_122_0));
   AND4_X1_LVT i_122_1 (.A1(n_122_0), .A2(e_state_nxt_reg[0]), .A3(
      e_state_nxt_reg[2]), .A4(e_state_nxt_reg[3]), .ZN(n_122_1));
   INV_X1_LVT i_122_2 (.A(n_73), .ZN(n_122_2));
   AOI21_X1_LVT i_122_3 (.A(n_122_1), .B1(n_122_2), .B2(n_4), .ZN(fetch));
   AOI222_X1_LVT i_126_2 (.A1(n_221), .A2(irq_num[0]), .B1(n_220), .B2(mdb_in[1]), 
      .C1(n_222), .C2(pc_incr[1]), .ZN(n_126_1));
   INV_X1_LVT i_126_3 (.A(n_126_1), .ZN(n_224));
   AOI22_X1_LVT i_127_3 (.A1(n_127_0), .A2(n_224), .B1(pc_sw_wr), .B2(pc_sw[1]), 
      .ZN(n_127_2));
   INV_X1_LVT i_127_4 (.A(n_127_2), .ZN(pc_nxt[1]));
   DFFR_X1_LVT \pc_reg[1]  (.D(pc_nxt[1]), .RN(n_91), .CK(mclk), .Q(pc[1]), 
      .QN());
   HA_X1_LVT i_124_0 (.A(fetch), .B(pc[1]), .CO(n_124_0), .S(pc_incr[1]));
   HA_X1_LVT i_124_1 (.A(pc[2]), .B(n_124_0), .CO(n_124_1), .S(pc_incr[2]));
   HA_X1_LVT i_124_2 (.A(pc[3]), .B(n_124_1), .CO(n_124_2), .S(pc_incr[3]));
   HA_X1_LVT i_124_3 (.A(pc[4]), .B(n_124_2), .CO(n_124_3), .S(pc_incr[4]));
   HA_X1_LVT i_124_4 (.A(pc[5]), .B(n_124_3), .CO(n_124_4), .S(pc_incr[5]));
   HA_X1_LVT i_124_5 (.A(pc[6]), .B(n_124_4), .CO(n_124_5), .S(pc_incr[6]));
   HA_X1_LVT i_124_6 (.A(pc[7]), .B(n_124_5), .CO(n_124_6), .S(pc_incr[7]));
   HA_X1_LVT i_124_7 (.A(pc[8]), .B(n_124_6), .CO(n_124_7), .S(pc_incr[8]));
   HA_X1_LVT i_124_8 (.A(pc[9]), .B(n_124_7), .CO(n_124_8), .S(pc_incr[9]));
   HA_X1_LVT i_124_9 (.A(pc[10]), .B(n_124_8), .CO(n_124_9), .S(pc_incr[10]));
   HA_X1_LVT i_124_10 (.A(pc[11]), .B(n_124_9), .CO(n_124_10), .S(pc_incr[11]));
   HA_X1_LVT i_124_11 (.A(pc[12]), .B(n_124_10), .CO(n_124_11), .S(pc_incr[12]));
   HA_X1_LVT i_124_12 (.A(pc[13]), .B(n_124_11), .CO(n_124_12), .S(pc_incr[13]));
   HA_X1_LVT i_124_13 (.A(pc[14]), .B(n_124_12), .CO(n_124_13), .S(pc_incr[14]));
   XNOR2_X1_LVT i_124_14 (.A(pc[15]), .B(n_124_13), .ZN(n_124_14));
   INV_X1_LVT i_124_15 (.A(n_124_14), .ZN(pc_incr[15]));
   AOI221_X1_LVT i_126_30 (.A(n_221), .B1(n_220), .B2(mdb_in[15]), .C1(n_222), 
      .C2(pc_incr[15]), .ZN(n_126_15));
   INV_X1_LVT i_126_31 (.A(n_126_15), .ZN(n_238));
   AOI22_X1_LVT i_127_31 (.A1(n_127_0), .A2(n_238), .B1(pc_sw_wr), .B2(pc_sw[15]), 
      .ZN(n_127_16));
   INV_X1_LVT i_127_32 (.A(n_127_16), .ZN(pc_nxt[15]));
   DFFR_X1_LVT \pc_reg[0]  (.D(pc_nxt[0]), .RN(n_91), .CK(mclk), .Q(pc[0]), 
      .QN());
   AOI22_X1_LVT i_126_0 (.A1(mdb_in[0]), .A2(n_220), .B1(pc[0]), .B2(n_222), 
      .ZN(n_126_0));
   INV_X1_LVT i_126_1 (.A(n_126_0), .ZN(n_223));
   AOI22_X1_LVT i_127_1 (.A1(n_127_0), .A2(n_223), .B1(pc_sw[0]), .B2(pc_sw_wr), 
      .ZN(n_127_1));
   INV_X1_LVT i_127_2 (.A(n_127_1), .ZN(pc_nxt[0]));
   DFFR_X1_LVT pmem_busy_reg (.D(fe_pmem_wait), .RN(n_91), .CK(mclk), .Q(
      pmem_busy), .QN());
   NOR4_X1_LVT i_128_0 (.A1(pc_sw_wr), .A2(fetch), .A3(pmem_busy), .A4(n_8), 
      .ZN(n_128_0));
   NAND2_X1_LVT i_128_1 (.A1(cpu_halt_st), .A2(n_0), .ZN(n_128_1));
   NAND2_X1_LVT i_128_2 (.A1(n_128_0), .A2(n_128_1), .ZN(mb_en));
   AND2_X1_LVT i_129_0 (.A1(dma_en), .A2(cpu_en_s), .ZN(mclk_dma_enable));
   omsp_and_gate__1_1 and_mclk_dma_wkup (.y(mclk_dma_wkup), .a(dma_wkup), 
      .b(cpu_en_s));
   INV_X1_LVT i_130_0 (.A(cpu_en_s), .ZN(n_130_0));
   OAI211_X1_LVT i_130_1 (.A(n_5), .B(n_67), .C1(n_130_0), .C2(cpuoff), .ZN(
      n_130_1));
   INV_X1_LVT i_130_2 (.A(inst_irq_rst), .ZN(n_130_2));
   AOI22_X1_LVT i_130_3 (.A1(n_130_1), .A2(n_130_2), .B1(cpu_en_s), .B2(
      inst_irq_rst), .ZN(n_130_3));
   INV_X1_LVT i_130_4 (.A(n_130_3), .ZN(mclk_enable));
   OR2_X1_LVT i_132_0 (.A1(wkup), .A2(wdt_wkup), .ZN(n_240));
   omsp_and_gate__1_3 and_mirq_wkup (.y(mirq_wkup), .a(n_240), .b(gie));
   OR2_X1_LVT i_131_0 (.A1(nmi_wkup), .A2(mirq_wkup), .ZN(n_239));
   omsp_and_gate__1_5 and_mclk_wkup (.y(mclk_wkup), .a(n_239), .b(cpu_en_s));
   NOR2_X1_LVT i_120_35 (.A1(n_120_13), .A2(n_120_20), .ZN(n_219));
   AND2_X1_LVT i_121_14 (.A1(n_8), .A2(n_219), .ZN(nmi_acc));
endmodule

module omsp_alu(alu_out, alu_out_add, alu_stat, alu_stat_wr, dbg_halt_st, 
      exec_cycle, inst_alu, inst_bw, inst_jmp, inst_so, op_dst, op_src, status);
   output [15:0]alu_out;
   output [15:0]alu_out_add;
   output [3:0]alu_stat;
   output [3:0]alu_stat_wr;
   input dbg_halt_st;
   input exec_cycle;
   input [11:0]inst_alu;
   input inst_bw;
   input [7:0]inst_jmp;
   input [7:0]inst_so;
   input [15:0]op_dst;
   input [15:0]op_src;
   input [3:0]status;

   wire op_bit8_msk;
   wire op_src_inv_cmd;
   wire n_4_0;
   wire n_4_1;
   wire n_4_2;
   wire n_4_3;
   wire n_4_4;
   wire n_4_5;
   wire [3:0]X;
   wire n_4_6;
   wire n_4_7;
   wire n_4_8;
   wire n_5_0;
   wire n_5_1;
   wire n_5_2;
   wire n_5_3;
   wire n_5_4;
   wire n_5_5;
   wire n_6_0;
   wire alu_short_thro;
   wire n_7_0;
   wire n_7_1;
   wire n_7_2;
   wire n_7_3;
   wire n_7_4;
   wire n_7_5;
   wire n_7_6;
   wire n_7_7;
   wire n_7_8;
   wire n_7_9;
   wire n_7_10;
   wire n_7_11;
   wire n_7_12;
   wire n_7_13;
   wire n_7_14;
   wire n_7_15;
   wire n_7_16;
   wire n_7_17;
   wire n_7_18;
   wire n_7_19;
   wire n_7_20;
   wire n_7_21;
   wire n_7_22;
   wire n_7_23;
   wire n_7_24;
   wire n_7_25;
   wire n_7_26;
   wire n_7_27;
   wire n_7_28;
   wire n_7_29;
   wire n_7_30;
   wire n_7_31;
   wire n_7_32;
   wire n_7_33;
   wire n_7_34;
   wire n_7_35;
   wire n_7_36;
   wire n_7_37;
   wire n_7_38;
   wire n_7_39;
   wire n_7_40;
   wire n_7_41;
   wire n_7_42;
   wire n_7_43;
   wire n_7_44;
   wire n_7_45;
   wire n_7_46;
   wire n_7_47;
   wire n_7_48;
   wire n_7_49;
   wire n_7_50;
   wire n_7_51;
   wire n_7_52;
   wire n_7_53;
   wire n_7_54;
   wire n_7_55;
   wire n_7_56;
   wire n_7_57;
   wire n_7_58;
   wire n_7_59;
   wire n_7_60;
   wire n_7_61;
   wire n_7_62;
   wire n_7_63;
   wire n_7_64;
   wire n_7_65;
   wire n_7_66;
   wire n_7_67;
   wire n_7_68;
   wire n_7_69;
   wire n_7_70;
   wire n_7_71;
   wire n_7_72;
   wire n_7_73;
   wire n_7_74;
   wire n_7_75;
   wire n_7_76;
   wire n_7_77;
   wire n_7_78;
   wire n_7_79;
   wire n_7_80;
   wire n_7_81;
   wire n_7_82;
   wire n_7_83;
   wire n_7_84;
   wire n_7_85;
   wire n_7_86;
   wire n_7_87;
   wire n_7_88;
   wire n_7_89;
   wire n_7_90;
   wire n_7_91;
   wire n_7_92;
   wire n_7_93;
   wire n_7_94;
   wire n_7_95;
   wire n_7_96;
   wire n_7_97;
   wire n_7_98;
   wire n_7_99;
   wire n_7_100;
   wire n_7_101;
   wire n_7_102;
   wire n_7_103;
   wire n_7_104;
   wire n_7_105;
   wire n_7_106;
   wire n_7_107;
   wire n_7_108;
   wire n_7_109;
   wire n_7_110;
   wire n_7_111;
   wire n_7_112;
   wire n_7_113;
   wire n_7_114;
   wire n_7_115;
   wire n_7_116;
   wire n_7_117;
   wire n_7_118;
   wire n_7_119;
   wire n_7_120;
   wire n_7_121;
   wire n_7_122;
   wire n_7_123;
   wire n_7_124;
   wire n_7_125;
   wire n_7_126;
   wire n_7_127;
   wire n_7_128;
   wire n_7_129;
   wire n_7_130;
   wire n_7_131;
   wire n_7_132;
   wire n_7_133;
   wire n_7_134;
   wire n_7_135;
   wire n_8_0;
   wire n_9_0;
   wire n_9_1;
   wire n_9_2;
   wire n_9_3;
   wire n_9_4;
   wire n_9_5;
   wire n_9_6;
   wire n_9_7;
   wire n_9_8;
   wire n_9_9;
   wire n_11_0;
   wire n_11_1;
   wire n_11_2;
   wire n_12_0;
   wire [4:0]bcd_add;
   wire n_12_1;
   wire n_12_2;
   wire n_12_3;
   wire n_12_4;
   wire n_12_5;
   wire n_12_6;
   wire n_12_7;
   wire n_12_8;
   wire n_13_0;
   wire n_14_0;
   wire n_14_1;
   wire n_14_2;
   wire n_14_3;
   wire n_14_4;
   wire n_14_5;
   wire n_14_6;
   wire n_14_7;
   wire n_14_8;
   wire n_14_9;
   wire n_16_0;
   wire n_16_1;
   wire n_16_2;
   wire n_17_0;
   wire [4:0]bcd_add0;
   wire n_17_1;
   wire n_17_2;
   wire n_17_3;
   wire n_17_4;
   wire n_17_5;
   wire n_17_6;
   wire n_17_7;
   wire n_17_8;
   wire n_18_0;
   wire n_19_0;
   wire n_19_1;
   wire n_19_2;
   wire n_19_3;
   wire n_19_4;
   wire n_19_5;
   wire n_19_6;
   wire n_19_7;
   wire n_19_8;
   wire n_19_9;
   wire n_21_0;
   wire n_21_1;
   wire n_21_2;
   wire n_22_0;
   wire [4:0]bcd_add1;
   wire n_22_1;
   wire n_22_2;
   wire n_22_3;
   wire n_22_4;
   wire n_22_5;
   wire n_22_6;
   wire n_22_7;
   wire n_22_8;
   wire n_23_0;
   wire n_24_0;
   wire n_24_1;
   wire n_24_2;
   wire n_24_3;
   wire n_24_4;
   wire n_24_5;
   wire n_24_6;
   wire n_24_7;
   wire n_24_8;
   wire n_24_9;
   wire n_26_0;
   wire n_26_1;
   wire n_26_2;
   wire n_27_0;
   wire [4:0]bcd_add2;
   wire n_27_1;
   wire n_27_2;
   wire n_27_3;
   wire n_27_4;
   wire n_27_5;
   wire n_27_6;
   wire n_27_7;
   wire n_27_8;
   wire n_28_0;
   wire n_28_1;
   wire alu_inc;
   wire n_30_0;
   wire n_30_1;
   wire n_30_2;
   wire n_30_3;
   wire n_30_4;
   wire n_30_5;
   wire n_30_6;
   wire n_30_7;
   wire n_30_8;
   wire n_30_9;
   wire n_40_0;
   wire n_40_1;
   wire n_40_2;
   wire n_40_3;
   wire n_40_4;
   wire n_40_5;
   wire n_40_6;
   wire n_40_7;
   wire n_40_8;
   wire n_40_9;
   wire n_40_10;
   wire n_40_11;
   wire n_40_12;
   wire n_40_13;
   wire n_40_14;
   wire [16:0]alu_add;
   wire [16:0]alu_add_inc;
   wire n_41_0;
   wire n_41_1;
   wire n_41_2;
   wire n_41_3;
   wire n_41_4;
   wire n_41_5;
   wire n_41_6;
   wire n_41_7;
   wire n_41_8;
   wire n_41_9;
   wire n_41_10;
   wire n_41_11;
   wire n_41_12;
   wire n_41_13;
   wire n_41_14;
   wire n_41_15;
   wire n_41_16;
   wire n_43_0;
   wire n_44_0;
   wire n_44_1;
   wire n_44_2;
   wire n_44_3;
   wire n_44_4;
   wire n_44_5;
   wire n_44_6;
   wire n_44_7;
   wire n_44_8;
   wire n_44_9;
   wire n_44_10;
   wire n_44_11;
   wire n_44_12;
   wire n_44_13;
   wire n_44_14;
   wire n_44_15;
   wire n_44_16;
   wire n_46_0;
   wire n_46_1;
   wire n_46_2;
   wire n_48_0;
   wire n_48_1;
   wire n_48_2;
   wire n_49_0;
   wire n_49_1;
   wire n_49_2;
   wire n_49_3;
   wire n_49_4;
   wire n_49_5;
   wire n_49_6;
   wire n_49_7;
   wire n_49_8;
   wire n_49_9;
   wire Z;
   wire n_51_0;
   wire n_51_1;
   wire n_51_2;
   wire n_51_3;
   wire n_51_4;
   wire n_51_5;
   wire n_51_6;
   wire n_51_7;
   wire n_51_8;
   wire n_51_9;
   wire n_51_10;
   wire n_51_11;
   wire n_51_12;
   wire n_51_13;
   wire n_51_14;
   wire n_51_15;
   wire n_51_16;
   wire n_51_17;
   wire n_51_18;
   wire n_51_19;
   wire n_51_20;
   wire n_51_21;
   wire n_51_22;

   assign alu_stat_wr[3] = alu_stat_wr[0];
   assign alu_stat_wr[2] = alu_stat_wr[0];
   assign alu_stat_wr[1] = alu_stat_wr[0];

   OR3_X1_LVT i_42_0 (.A1(inst_so[7]), .A2(inst_alu[3]), .A3(dbg_halt_st), 
      .ZN(n_104));
   NAND2_X1_LVT i_0_0 (.A1(exec_cycle), .A2(inst_bw), .ZN(op_bit8_msk));
   AND2_X1_LVT i_1_7 (.A1(op_bit8_msk), .A2(op_dst[15]), .ZN(n_7));
   XOR2_X1_LVT i_29_0 (.A(status[3]), .B(status[2]), .Z(n_86));
   INV_X1_LVT i_30_0 (.A(n_86), .ZN(n_30_0));
   INV_X1_LVT i_30_1 (.A(status[1]), .ZN(n_30_1));
   INV_X1_LVT i_30_2 (.A(status[0]), .ZN(n_30_2));
   AOI222_X1_LVT i_30_3 (.A1(n_30_0), .A2(inst_jmp[6]), .B1(n_30_1), .B2(
      inst_jmp[1]), .C1(n_30_2), .C2(inst_jmp[3]), .ZN(n_30_3));
   INV_X1_LVT i_30_4 (.A(status[2]), .ZN(n_30_4));
   NAND2_X1_LVT i_30_5 (.A1(n_30_4), .A2(inst_jmp[4]), .ZN(n_30_5));
   NAND2_X1_LVT i_30_6 (.A1(inst_jmp[0]), .A2(status[1]), .ZN(n_30_6));
   NAND2_X1_LVT i_30_7 (.A1(inst_jmp[2]), .A2(status[0]), .ZN(n_30_7));
   NAND2_X1_LVT i_30_8 (.A1(n_86), .A2(inst_jmp[5]), .ZN(n_30_8));
   AND4_X1_LVT i_30_9 (.A1(n_30_5), .A2(n_30_6), .A3(n_30_7), .A4(n_30_8), 
      .ZN(n_30_9));
   AND2_X1_LVT i_30_10 (.A1(n_30_3), .A2(n_30_9), .ZN(n_87));
   AND2_X1_LVT i_2_0 (.A1(exec_cycle), .A2(inst_alu[0]), .ZN(op_src_inv_cmd));
   XNOR2_X1_LVT i_4_15 (.A(op_src_inv_cmd), .B(op_src[15]), .ZN(n_4_8));
   INV_X1_LVT i_4_1 (.A(op_bit8_msk), .ZN(n_4_1));
   NOR2_X1_LVT i_4_16 (.A1(n_4_8), .A2(n_4_1), .ZN(X[3]));
   AND2_X1_LVT i_39_7 (.A1(n_87), .A2(X[3]), .ZN(n_103));
   AND2_X1_LVT i_1_6 (.A1(op_bit8_msk), .A2(op_dst[14]), .ZN(n_6));
   XNOR2_X1_LVT i_4_13 (.A(op_src_inv_cmd), .B(op_src[14]), .ZN(n_4_7));
   NOR2_X1_LVT i_4_14 (.A1(n_4_7), .A2(n_4_1), .ZN(X[2]));
   AND2_X1_LVT i_39_6 (.A1(n_87), .A2(X[2]), .ZN(n_102));
   AND2_X1_LVT i_1_5 (.A1(op_bit8_msk), .A2(op_dst[13]), .ZN(n_5));
   XNOR2_X1_LVT i_4_11 (.A(op_src_inv_cmd), .B(op_src[13]), .ZN(n_4_6));
   NOR2_X1_LVT i_4_12 (.A1(n_4_6), .A2(n_4_1), .ZN(X[1]));
   AND2_X1_LVT i_39_5 (.A1(n_87), .A2(X[1]), .ZN(n_101));
   AND2_X1_LVT i_1_4 (.A1(op_bit8_msk), .A2(op_dst[12]), .ZN(n_4));
   XNOR2_X1_LVT i_4_9 (.A(op_src_inv_cmd), .B(op_src[12]), .ZN(n_4_5));
   NOR2_X1_LVT i_4_10 (.A1(n_4_5), .A2(n_4_1), .ZN(X[0]));
   AND2_X1_LVT i_39_4 (.A1(n_87), .A2(X[0]), .ZN(n_100));
   AND2_X1_LVT i_1_3 (.A1(op_bit8_msk), .A2(op_dst[11]), .ZN(n_3));
   XNOR2_X1_LVT i_4_7 (.A(op_src_inv_cmd), .B(op_src[11]), .ZN(n_4_4));
   NOR2_X1_LVT i_4_8 (.A1(n_4_4), .A2(n_4_1), .ZN(n_19));
   AND2_X1_LVT i_39_3 (.A1(n_87), .A2(n_19), .ZN(n_99));
   AND2_X1_LVT i_1_2 (.A1(op_bit8_msk), .A2(op_dst[10]), .ZN(n_2));
   XNOR2_X1_LVT i_4_5 (.A(op_src_inv_cmd), .B(op_src[10]), .ZN(n_4_3));
   NOR2_X1_LVT i_4_6 (.A1(n_4_3), .A2(n_4_1), .ZN(n_18));
   AND2_X1_LVT i_39_2 (.A1(n_87), .A2(n_18), .ZN(n_98));
   AND2_X1_LVT i_1_1 (.A1(op_bit8_msk), .A2(op_dst[9]), .ZN(n_1));
   XNOR2_X1_LVT i_4_3 (.A(op_src_inv_cmd), .B(op_src[9]), .ZN(n_4_2));
   NOR2_X1_LVT i_4_4 (.A1(n_4_2), .A2(n_4_1), .ZN(n_17));
   AND2_X1_LVT i_39_1 (.A1(n_87), .A2(n_17), .ZN(n_97));
   AND2_X1_LVT i_1_0 (.A1(op_dst[8]), .A2(op_bit8_msk), .ZN(n_0));
   XNOR2_X1_LVT i_4_0 (.A(op_src_inv_cmd), .B(op_src[8]), .ZN(n_4_0));
   NOR2_X1_LVT i_4_2 (.A1(n_4_0), .A2(n_4_1), .ZN(n_16));
   AND2_X1_LVT i_39_0 (.A1(n_16), .A2(n_87), .ZN(n_96));
   XOR2_X1_LVT i_3_7 (.A(op_src_inv_cmd), .B(op_src[7]), .Z(n_15));
   AND2_X1_LVT i_38_0 (.A1(n_15), .A2(n_87), .ZN(n_95));
   XOR2_X1_LVT i_3_6 (.A(op_src_inv_cmd), .B(op_src[6]), .Z(n_14));
   AND2_X1_LVT i_37_0 (.A1(n_14), .A2(n_87), .ZN(n_94));
   XOR2_X1_LVT i_3_5 (.A(op_src_inv_cmd), .B(op_src[5]), .Z(n_13));
   AND2_X1_LVT i_36_0 (.A1(n_13), .A2(n_87), .ZN(n_93));
   XOR2_X1_LVT i_3_4 (.A(op_src_inv_cmd), .B(op_src[4]), .Z(n_12));
   AND2_X1_LVT i_35_0 (.A1(n_12), .A2(n_87), .ZN(n_92));
   XOR2_X1_LVT i_3_3 (.A(op_src_inv_cmd), .B(op_src[3]), .Z(n_11));
   AND2_X1_LVT i_34_0 (.A1(n_11), .A2(n_87), .ZN(n_91));
   XOR2_X1_LVT i_3_2 (.A(op_src_inv_cmd), .B(op_src[2]), .Z(n_10));
   AND2_X1_LVT i_33_0 (.A1(n_10), .A2(n_87), .ZN(n_90));
   XOR2_X1_LVT i_3_1 (.A(op_src_inv_cmd), .B(op_src[1]), .Z(n_9));
   AND2_X1_LVT i_32_0 (.A1(n_9), .A2(n_87), .ZN(n_89));
   XOR2_X1_LVT i_3_0 (.A(op_src_inv_cmd), .B(op_src[0]), .Z(n_8));
   AND2_X1_LVT i_31_0 (.A1(n_8), .A2(n_87), .ZN(n_88));
   HA_X1_LVT i_40_0 (.A(op_dst[0]), .B(n_88), .CO(n_40_0), .S(alu_out_add[0]));
   FA_X1_LVT i_40_1 (.A(op_dst[1]), .B(n_89), .CI(n_40_0), .CO(n_40_1), .S(
      alu_out_add[1]));
   FA_X1_LVT i_40_2 (.A(op_dst[2]), .B(n_90), .CI(n_40_1), .CO(n_40_2), .S(
      alu_out_add[2]));
   FA_X1_LVT i_40_3 (.A(op_dst[3]), .B(n_91), .CI(n_40_2), .CO(n_40_3), .S(
      alu_out_add[3]));
   FA_X1_LVT i_40_4 (.A(op_dst[4]), .B(n_92), .CI(n_40_3), .CO(n_40_4), .S(
      alu_out_add[4]));
   FA_X1_LVT i_40_5 (.A(op_dst[5]), .B(n_93), .CI(n_40_4), .CO(n_40_5), .S(
      alu_out_add[5]));
   FA_X1_LVT i_40_6 (.A(op_dst[6]), .B(n_94), .CI(n_40_5), .CO(n_40_6), .S(
      alu_out_add[6]));
   FA_X1_LVT i_40_7 (.A(op_dst[7]), .B(n_95), .CI(n_40_6), .CO(n_40_7), .S(
      alu_out_add[7]));
   FA_X1_LVT i_40_8 (.A(n_0), .B(n_96), .CI(n_40_7), .CO(n_40_8), .S(
      alu_out_add[8]));
   FA_X1_LVT i_40_9 (.A(n_1), .B(n_97), .CI(n_40_8), .CO(n_40_9), .S(
      alu_out_add[9]));
   FA_X1_LVT i_40_10 (.A(n_2), .B(n_98), .CI(n_40_9), .CO(n_40_10), .S(
      alu_out_add[10]));
   FA_X1_LVT i_40_11 (.A(n_3), .B(n_99), .CI(n_40_10), .CO(n_40_11), .S(
      alu_out_add[11]));
   FA_X1_LVT i_40_12 (.A(n_4), .B(n_100), .CI(n_40_11), .CO(n_40_12), .S(
      alu_out_add[12]));
   FA_X1_LVT i_40_13 (.A(n_5), .B(n_101), .CI(n_40_12), .CO(n_40_13), .S(
      alu_out_add[13]));
   FA_X1_LVT i_40_14 (.A(n_6), .B(n_102), .CI(n_40_13), .CO(n_40_14), .S(
      alu_out_add[14]));
   FA_X1_LVT i_40_15 (.A(n_7), .B(n_103), .CI(n_40_14), .CO(alu_add[16]), 
      .S(alu_out_add[15]));
   AOI21_X1_LVT i_28_0 (.A(inst_alu[1]), .B1(inst_alu[2]), .B2(status[0]), 
      .ZN(n_28_0));
   INV_X1_LVT i_28_1 (.A(exec_cycle), .ZN(n_28_1));
   NOR2_X1_LVT i_28_2 (.A1(n_28_0), .A2(n_28_1), .ZN(alu_inc));
   HA_X1_LVT i_41_0 (.A(alu_inc), .B(alu_out_add[0]), .CO(n_41_0), .S(
      alu_add_inc[0]));
   HA_X1_LVT i_41_1 (.A(alu_out_add[1]), .B(n_41_0), .CO(n_41_1), .S(
      alu_add_inc[1]));
   HA_X1_LVT i_41_2 (.A(alu_out_add[2]), .B(n_41_1), .CO(n_41_2), .S(
      alu_add_inc[2]));
   HA_X1_LVT i_41_3 (.A(alu_out_add[3]), .B(n_41_2), .CO(n_41_3), .S(
      alu_add_inc[3]));
   HA_X1_LVT i_41_4 (.A(alu_out_add[4]), .B(n_41_3), .CO(n_41_4), .S(
      alu_add_inc[4]));
   HA_X1_LVT i_41_5 (.A(alu_out_add[5]), .B(n_41_4), .CO(n_41_5), .S(
      alu_add_inc[5]));
   HA_X1_LVT i_41_6 (.A(alu_out_add[6]), .B(n_41_5), .CO(n_41_6), .S(
      alu_add_inc[6]));
   HA_X1_LVT i_41_7 (.A(alu_out_add[7]), .B(n_41_6), .CO(n_41_7), .S(
      alu_add_inc[7]));
   HA_X1_LVT i_41_8 (.A(alu_out_add[8]), .B(n_41_7), .CO(n_41_8), .S(
      alu_add_inc[8]));
   HA_X1_LVT i_41_9 (.A(alu_out_add[9]), .B(n_41_8), .CO(n_41_9), .S(
      alu_add_inc[9]));
   HA_X1_LVT i_41_10 (.A(alu_out_add[10]), .B(n_41_9), .CO(n_41_10), .S(
      alu_add_inc[10]));
   HA_X1_LVT i_41_11 (.A(alu_out_add[11]), .B(n_41_10), .CO(n_41_11), .S(
      alu_add_inc[11]));
   HA_X1_LVT i_41_12 (.A(alu_out_add[12]), .B(n_41_11), .CO(n_41_12), .S(
      alu_add_inc[12]));
   HA_X1_LVT i_41_13 (.A(alu_out_add[13]), .B(n_41_12), .CO(n_41_13), .S(
      alu_add_inc[13]));
   HA_X1_LVT i_41_14 (.A(alu_out_add[14]), .B(n_41_13), .CO(n_41_14), .S(
      alu_add_inc[14]));
   HA_X1_LVT i_41_15 (.A(alu_out_add[15]), .B(n_41_14), .CO(n_41_15), .S(
      alu_add_inc[15]));
   INV_X1_LVT i_43_1 (.A(inst_alu[7]), .ZN(n_43_0));
   NOR2_X1_LVT i_43_2 (.A1(n_43_0), .A2(n_104), .ZN(n_106));
   HA_X1_LVT i_18_3 (.A(n_3), .B(n_19), .CO(n_68), .S(n_67));
   INV_X1_LVT i_19_2 (.A(n_68), .ZN(n_19_3));
   HA_X1_LVT i_18_2 (.A(n_2), .B(n_18), .CO(n_66), .S(n_65));
   HA_X1_LVT i_19_1 (.A(n_67), .B(n_66), .CO(n_19_2), .S(n_19_1));
   HA_X1_LVT i_13_3 (.A(op_dst[7]), .B(n_15), .CO(n_56), .S(n_55));
   INV_X1_LVT i_14_2 (.A(n_56), .ZN(n_14_3));
   HA_X1_LVT i_13_2 (.A(op_dst[6]), .B(n_14), .CO(n_54), .S(n_53));
   HA_X1_LVT i_14_1 (.A(n_55), .B(n_54), .CO(n_14_2), .S(n_14_1));
   HA_X1_LVT i_8_3 (.A(op_dst[3]), .B(n_11), .CO(n_44), .S(n_43));
   INV_X1_LVT i_9_2 (.A(n_44), .ZN(n_9_3));
   HA_X1_LVT i_8_2 (.A(op_dst[2]), .B(n_10), .CO(n_42), .S(n_41));
   HA_X1_LVT i_9_1 (.A(n_43), .B(n_42), .CO(n_9_2), .S(n_9_1));
   FA_X1_LVT i_8_0 (.A(op_dst[0]), .B(status[0]), .CI(n_8), .CO(n_8_0), .S(n_38));
   FA_X1_LVT i_8_1 (.A(op_dst[1]), .B(n_9), .CI(n_8_0), .CO(n_40), .S(n_39));
   INV_X1_LVT i_9_0 (.A(n_40), .ZN(n_9_0));
   FA_X1_LVT i_9_3 (.A(n_41), .B(n_9_0), .CI(n_39), .CO(n_9_4), .S());
   FA_X1_LVT i_9_4 (.A(n_40), .B(n_9_1), .CI(n_9_4), .CO(n_9_5), .S());
   FA_X1_LVT i_9_5 (.A(n_9_2), .B(n_9_3), .CI(n_9_5), .CO(n_9_6), .S());
   HA_X1_LVT i_9_6 (.A(n_9_3), .B(n_9_6), .CO(n_9_7), .S());
   HA_X1_LVT i_9_7 (.A(n_9_3), .B(n_9_7), .CO(n_9_8), .S());
   XNOR2_X1_LVT i_9_8 (.A(n_9_3), .B(n_9_8), .ZN(n_9_9));
   INV_X1_LVT i_9_9 (.A(n_9_9), .ZN(n_45));
   INV_X1_LVT i_10_0 (.A(n_45), .ZN(n_46));
   HA_X1_LVT i_11_0 (.A(n_40), .B(n_41), .CO(n_11_0), .S(n_47));
   FA_X1_LVT i_11_1 (.A(n_43), .B(n_42), .CI(n_11_0), .CO(n_11_1), .S(n_48));
   OR2_X1_LVT i_12_7 (.A1(n_46), .A2(n_48), .ZN(n_12_5));
   HA_X1_LVT i_11_2 (.A(n_44), .B(n_11_1), .CO(n_11_2), .S(n_49));
   INV_X1_LVT i_12_8 (.A(n_49), .ZN(n_12_6));
   XNOR2_X1_LVT i_12_10 (.A(n_12_5), .B(n_12_6), .ZN(n_12_8));
   INV_X1_LVT i_12_3 (.A(n_39), .ZN(n_12_2));
   NAND2_X1_LVT i_12_2 (.A1(n_46), .A2(n_12_2), .ZN(n_12_1));
   OR2_X1_LVT i_12_5 (.A1(n_47), .A2(n_12_1), .ZN(n_12_3));
   XNOR2_X1_LVT i_12_6 (.A(n_46), .B(n_48), .ZN(n_12_4));
   HA_X1_LVT i_12_9 (.A(n_12_3), .B(n_12_4), .CO(n_12_7), .S(bcd_add[3]));
   XNOR2_X1_LVT i_12_11 (.A(n_12_8), .B(n_12_7), .ZN(bcd_add[4]));
   FA_X1_LVT i_13_0 (.A(op_dst[4]), .B(bcd_add[4]), .CI(n_12), .CO(n_13_0), 
      .S(n_50));
   FA_X1_LVT i_13_1 (.A(op_dst[5]), .B(n_13), .CI(n_13_0), .CO(n_52), .S(n_51));
   INV_X1_LVT i_14_0 (.A(n_52), .ZN(n_14_0));
   FA_X1_LVT i_14_3 (.A(n_53), .B(n_14_0), .CI(n_51), .CO(n_14_4), .S());
   FA_X1_LVT i_14_4 (.A(n_52), .B(n_14_1), .CI(n_14_4), .CO(n_14_5), .S());
   FA_X1_LVT i_14_5 (.A(n_14_2), .B(n_14_3), .CI(n_14_5), .CO(n_14_6), .S());
   HA_X1_LVT i_14_6 (.A(n_14_3), .B(n_14_6), .CO(n_14_7), .S());
   HA_X1_LVT i_14_7 (.A(n_14_3), .B(n_14_7), .CO(n_14_8), .S());
   XNOR2_X1_LVT i_14_8 (.A(n_14_3), .B(n_14_8), .ZN(n_14_9));
   INV_X1_LVT i_14_9 (.A(n_14_9), .ZN(n_57));
   INV_X1_LVT i_15_0 (.A(n_57), .ZN(n_58));
   HA_X1_LVT i_16_0 (.A(n_52), .B(n_53), .CO(n_16_0), .S(n_59));
   FA_X1_LVT i_16_1 (.A(n_55), .B(n_54), .CI(n_16_0), .CO(n_16_1), .S(n_60));
   OR2_X1_LVT i_17_7 (.A1(n_58), .A2(n_60), .ZN(n_17_5));
   HA_X1_LVT i_16_2 (.A(n_56), .B(n_16_1), .CO(n_16_2), .S(n_61));
   INV_X1_LVT i_17_8 (.A(n_61), .ZN(n_17_6));
   XNOR2_X1_LVT i_17_10 (.A(n_17_5), .B(n_17_6), .ZN(n_17_8));
   INV_X1_LVT i_17_3 (.A(n_51), .ZN(n_17_2));
   NAND2_X1_LVT i_17_2 (.A1(n_58), .A2(n_17_2), .ZN(n_17_1));
   OR2_X1_LVT i_17_5 (.A1(n_59), .A2(n_17_1), .ZN(n_17_3));
   XNOR2_X1_LVT i_17_6 (.A(n_58), .B(n_60), .ZN(n_17_4));
   HA_X1_LVT i_17_9 (.A(n_17_3), .B(n_17_4), .CO(n_17_7), .S(bcd_add0[3]));
   XNOR2_X1_LVT i_17_11 (.A(n_17_8), .B(n_17_7), .ZN(bcd_add0[4]));
   FA_X1_LVT i_18_0 (.A(n_0), .B(bcd_add0[4]), .CI(n_16), .CO(n_18_0), .S(n_62));
   FA_X1_LVT i_18_1 (.A(n_1), .B(n_17), .CI(n_18_0), .CO(n_64), .S(n_63));
   INV_X1_LVT i_19_0 (.A(n_64), .ZN(n_19_0));
   FA_X1_LVT i_19_3 (.A(n_65), .B(n_19_0), .CI(n_63), .CO(n_19_4), .S());
   FA_X1_LVT i_19_4 (.A(n_64), .B(n_19_1), .CI(n_19_4), .CO(n_19_5), .S());
   FA_X1_LVT i_19_5 (.A(n_19_2), .B(n_19_3), .CI(n_19_5), .CO(n_19_6), .S());
   HA_X1_LVT i_19_6 (.A(n_19_3), .B(n_19_6), .CO(n_19_7), .S());
   HA_X1_LVT i_19_7 (.A(n_19_3), .B(n_19_7), .CO(n_19_8), .S());
   XNOR2_X1_LVT i_19_8 (.A(n_19_3), .B(n_19_8), .ZN(n_19_9));
   INV_X1_LVT i_19_9 (.A(n_19_9), .ZN(n_69));
   INV_X1_LVT i_20_0 (.A(n_69), .ZN(n_70));
   HA_X1_LVT i_21_0 (.A(n_64), .B(n_65), .CO(n_21_0), .S(n_71));
   FA_X1_LVT i_21_1 (.A(n_67), .B(n_66), .CI(n_21_0), .CO(n_21_1), .S(n_72));
   OR2_X1_LVT i_22_7 (.A1(n_70), .A2(n_72), .ZN(n_22_5));
   HA_X1_LVT i_21_2 (.A(n_68), .B(n_21_1), .CO(n_21_2), .S(n_73));
   INV_X1_LVT i_22_8 (.A(n_73), .ZN(n_22_6));
   XNOR2_X1_LVT i_22_10 (.A(n_22_5), .B(n_22_6), .ZN(n_22_8));
   INV_X1_LVT i_22_3 (.A(n_63), .ZN(n_22_2));
   NAND2_X1_LVT i_22_2 (.A1(n_70), .A2(n_22_2), .ZN(n_22_1));
   OR2_X1_LVT i_22_5 (.A1(n_71), .A2(n_22_1), .ZN(n_22_3));
   XNOR2_X1_LVT i_22_6 (.A(n_70), .B(n_72), .ZN(n_22_4));
   HA_X1_LVT i_22_9 (.A(n_22_3), .B(n_22_4), .CO(n_22_7), .S(bcd_add1[3]));
   XNOR2_X1_LVT i_22_11 (.A(n_22_8), .B(n_22_7), .ZN(bcd_add1[4]));
   FA_X1_LVT i_23_0 (.A(n_4), .B(bcd_add1[4]), .CI(X[0]), .CO(n_23_0), .S(n_74));
   FA_X1_LVT i_23_1 (.A(n_5), .B(X[1]), .CI(n_23_0), .CO(n_76), .S(n_75));
   HA_X1_LVT i_23_2 (.A(n_6), .B(X[2]), .CO(n_78), .S(n_77));
   HA_X1_LVT i_26_0 (.A(n_76), .B(n_77), .CO(n_26_0), .S(n_83));
   HA_X1_LVT i_23_3 (.A(n_7), .B(X[3]), .CO(n_80), .S(n_79));
   INV_X1_LVT i_24_2 (.A(n_80), .ZN(n_24_3));
   HA_X1_LVT i_24_1 (.A(n_79), .B(n_78), .CO(n_24_2), .S(n_24_1));
   INV_X1_LVT i_24_0 (.A(n_76), .ZN(n_24_0));
   FA_X1_LVT i_24_3 (.A(n_77), .B(n_24_0), .CI(n_75), .CO(n_24_4), .S());
   FA_X1_LVT i_24_4 (.A(n_76), .B(n_24_1), .CI(n_24_4), .CO(n_24_5), .S());
   FA_X1_LVT i_24_5 (.A(n_24_2), .B(n_24_3), .CI(n_24_5), .CO(n_24_6), .S());
   HA_X1_LVT i_24_6 (.A(n_24_3), .B(n_24_6), .CO(n_24_7), .S());
   HA_X1_LVT i_24_7 (.A(n_24_3), .B(n_24_7), .CO(n_24_8), .S());
   XNOR2_X1_LVT i_24_8 (.A(n_24_3), .B(n_24_8), .ZN(n_24_9));
   INV_X1_LVT i_24_9 (.A(n_24_9), .ZN(n_81));
   INV_X1_LVT i_25_0 (.A(n_81), .ZN(n_82));
   INV_X1_LVT i_27_3 (.A(n_75), .ZN(n_27_2));
   NAND2_X1_LVT i_27_2 (.A1(n_82), .A2(n_27_2), .ZN(n_27_1));
   OR2_X1_LVT i_27_5 (.A1(n_83), .A2(n_27_1), .ZN(n_27_3));
   FA_X1_LVT i_26_1 (.A(n_79), .B(n_78), .CI(n_26_0), .CO(n_26_1), .S(n_84));
   XNOR2_X1_LVT i_27_6 (.A(n_82), .B(n_84), .ZN(n_27_4));
   HA_X1_LVT i_27_9 (.A(n_27_3), .B(n_27_4), .CO(n_27_7), .S(bcd_add2[3]));
   NOR2_X1_LVT i_43_0 (.A1(inst_alu[7]), .A2(n_104), .ZN(n_105));
   OR4_X1_LVT i_6_0 (.A1(inst_so[1]), .A2(inst_alu[10]), .A3(inst_alu[6]), 
      .A4(inst_alu[5]), .ZN(n_6_0));
   NOR3_X1_LVT i_6_1 (.A1(n_6_0), .A2(inst_alu[4]), .A3(inst_so[3]), .ZN(
      alu_short_thro));
   NAND2_X1_LVT i_7_143 (.A1(alu_short_thro), .A2(X[3]), .ZN(n_7_128));
   NAND2_X1_LVT i_7_71 (.A1(inst_so[3]), .A2(op_src[7]), .ZN(n_7_64));
   NAND2_X1_LVT i_7_144 (.A1(inst_so[1]), .A2(op_src[7]), .ZN(n_7_129));
   INV_X1_LVT i_5_0 (.A(inst_bw), .ZN(n_5_0));
   INV_X1_LVT i_5_1 (.A(inst_so[0]), .ZN(n_5_1));
   NAND3_X1_LVT i_5_2 (.A1(n_5_0), .A2(n_5_1), .A3(op_src[15]), .ZN(n_5_2));
   NAND3_X1_LVT i_5_3 (.A1(n_5_1), .A2(inst_bw), .A3(op_src[7]), .ZN(n_5_3));
   NAND2_X1_LVT i_5_4 (.A1(status[0]), .A2(inst_so[0]), .ZN(n_5_4));
   NAND3_X1_LVT i_5_5 (.A1(n_5_2), .A2(n_5_3), .A3(n_5_4), .ZN(n_20));
   NAND2_X1_LVT i_7_145 (.A1(inst_alu[10]), .A2(n_20), .ZN(n_7_130));
   AND4_X1_LVT i_7_146 (.A1(n_7_128), .A2(n_7_64), .A3(n_7_129), .A4(n_7_130), 
      .ZN(n_7_131));
   OAI21_X1_LVT i_7_147 (.A(inst_alu[5]), .B1(X[3]), .B2(n_7), .ZN(n_7_132));
   XOR2_X1_LVT i_7_148 (.A(X[3]), .B(n_7), .Z(n_7_133));
   NAND2_X1_LVT i_7_149 (.A1(n_7_133), .A2(inst_alu[6]), .ZN(n_7_134));
   NAND3_X1_LVT i_7_150 (.A1(inst_alu[4]), .A2(X[3]), .A3(n_7), .ZN(n_7_135));
   NAND4_X1_LVT i_7_151 (.A1(n_7_131), .A2(n_7_132), .A3(n_7_134), .A4(n_7_135), 
      .ZN(n_37));
   AOI222_X1_LVT i_44_30 (.A1(n_104), .A2(alu_add_inc[15]), .B1(n_106), .B2(
      bcd_add2[3]), .C1(n_105), .C2(n_37), .ZN(n_44_15));
   INV_X1_LVT i_44_31 (.A(n_44_15), .ZN(alu_out[15]));
   XNOR2_X1_LVT i_27_4 (.A(n_83), .B(n_27_1), .ZN(bcd_add2[2]));
   NAND2_X1_LVT i_7_134 (.A1(alu_short_thro), .A2(X[2]), .ZN(n_7_120));
   NAND2_X1_LVT i_7_135 (.A1(inst_so[1]), .A2(op_src[6]), .ZN(n_7_121));
   NAND2_X1_LVT i_7_136 (.A1(inst_alu[10]), .A2(op_src[15]), .ZN(n_7_122));
   AND4_X1_LVT i_7_137 (.A1(n_7_120), .A2(n_7_64), .A3(n_7_121), .A4(n_7_122), 
      .ZN(n_7_123));
   OAI21_X1_LVT i_7_138 (.A(inst_alu[5]), .B1(X[2]), .B2(n_6), .ZN(n_7_124));
   XOR2_X1_LVT i_7_139 (.A(X[2]), .B(n_6), .Z(n_7_125));
   NAND2_X1_LVT i_7_140 (.A1(n_7_125), .A2(inst_alu[6]), .ZN(n_7_126));
   NAND3_X1_LVT i_7_141 (.A1(inst_alu[4]), .A2(X[2]), .A3(n_6), .ZN(n_7_127));
   NAND4_X1_LVT i_7_142 (.A1(n_7_123), .A2(n_7_124), .A3(n_7_126), .A4(n_7_127), 
      .ZN(n_36));
   AOI222_X1_LVT i_44_28 (.A1(n_104), .A2(alu_add_inc[14]), .B1(n_106), .B2(
      bcd_add2[2]), .C1(n_105), .C2(n_36), .ZN(n_44_14));
   INV_X1_LVT i_44_29 (.A(n_44_14), .ZN(alu_out[14]));
   XNOR2_X1_LVT i_27_0 (.A(n_82), .B(n_75), .ZN(n_27_0));
   INV_X1_LVT i_27_1 (.A(n_27_0), .ZN(bcd_add2[1]));
   NAND2_X1_LVT i_7_125 (.A1(alu_short_thro), .A2(X[1]), .ZN(n_7_112));
   NAND2_X1_LVT i_7_126 (.A1(inst_so[1]), .A2(op_src[5]), .ZN(n_7_113));
   NAND2_X1_LVT i_7_127 (.A1(inst_alu[10]), .A2(op_src[14]), .ZN(n_7_114));
   AND4_X1_LVT i_7_128 (.A1(n_7_112), .A2(n_7_64), .A3(n_7_113), .A4(n_7_114), 
      .ZN(n_7_115));
   OAI21_X1_LVT i_7_129 (.A(inst_alu[5]), .B1(X[1]), .B2(n_5), .ZN(n_7_116));
   XOR2_X1_LVT i_7_130 (.A(X[1]), .B(n_5), .Z(n_7_117));
   NAND2_X1_LVT i_7_131 (.A1(n_7_117), .A2(inst_alu[6]), .ZN(n_7_118));
   NAND3_X1_LVT i_7_132 (.A1(inst_alu[4]), .A2(X[1]), .A3(n_5), .ZN(n_7_119));
   NAND4_X1_LVT i_7_133 (.A1(n_7_115), .A2(n_7_116), .A3(n_7_118), .A4(n_7_119), 
      .ZN(n_35));
   AOI222_X1_LVT i_44_26 (.A1(n_104), .A2(alu_add_inc[13]), .B1(n_106), .B2(
      bcd_add2[1]), .C1(n_105), .C2(n_35), .ZN(n_44_13));
   INV_X1_LVT i_44_27 (.A(n_44_13), .ZN(alu_out[13]));
   NAND2_X1_LVT i_7_116 (.A1(alu_short_thro), .A2(X[0]), .ZN(n_7_104));
   NAND2_X1_LVT i_7_117 (.A1(inst_so[1]), .A2(op_src[4]), .ZN(n_7_105));
   NAND2_X1_LVT i_7_118 (.A1(inst_alu[10]), .A2(op_src[13]), .ZN(n_7_106));
   AND4_X1_LVT i_7_119 (.A1(n_7_104), .A2(n_7_64), .A3(n_7_105), .A4(n_7_106), 
      .ZN(n_7_107));
   OAI21_X1_LVT i_7_120 (.A(inst_alu[5]), .B1(X[0]), .B2(n_4), .ZN(n_7_108));
   XOR2_X1_LVT i_7_121 (.A(X[0]), .B(n_4), .Z(n_7_109));
   NAND2_X1_LVT i_7_122 (.A1(n_7_109), .A2(inst_alu[6]), .ZN(n_7_110));
   NAND3_X1_LVT i_7_123 (.A1(inst_alu[4]), .A2(X[0]), .A3(n_4), .ZN(n_7_111));
   NAND4_X1_LVT i_7_124 (.A1(n_7_107), .A2(n_7_108), .A3(n_7_110), .A4(n_7_111), 
      .ZN(n_34));
   AOI222_X1_LVT i_44_24 (.A1(n_104), .A2(alu_add_inc[12]), .B1(n_106), .B2(n_74), 
      .C1(n_105), .C2(n_34), .ZN(n_44_12));
   INV_X1_LVT i_44_25 (.A(n_44_12), .ZN(alu_out[12]));
   NAND2_X1_LVT i_7_107 (.A1(alu_short_thro), .A2(n_19), .ZN(n_7_96));
   NAND2_X1_LVT i_7_108 (.A1(inst_so[1]), .A2(op_src[3]), .ZN(n_7_97));
   NAND2_X1_LVT i_7_109 (.A1(inst_alu[10]), .A2(op_src[12]), .ZN(n_7_98));
   AND4_X1_LVT i_7_110 (.A1(n_7_96), .A2(n_7_64), .A3(n_7_97), .A4(n_7_98), 
      .ZN(n_7_99));
   OAI21_X1_LVT i_7_111 (.A(inst_alu[5]), .B1(n_19), .B2(n_3), .ZN(n_7_100));
   XOR2_X1_LVT i_7_112 (.A(n_19), .B(n_3), .Z(n_7_101));
   NAND2_X1_LVT i_7_113 (.A1(n_7_101), .A2(inst_alu[6]), .ZN(n_7_102));
   NAND3_X1_LVT i_7_114 (.A1(inst_alu[4]), .A2(n_19), .A3(n_3), .ZN(n_7_103));
   NAND4_X1_LVT i_7_115 (.A1(n_7_99), .A2(n_7_100), .A3(n_7_102), .A4(n_7_103), 
      .ZN(n_33));
   AOI222_X1_LVT i_44_22 (.A1(n_104), .A2(alu_add_inc[11]), .B1(n_106), .B2(
      bcd_add1[3]), .C1(n_105), .C2(n_33), .ZN(n_44_11));
   INV_X1_LVT i_44_23 (.A(n_44_11), .ZN(alu_out[11]));
   XNOR2_X1_LVT i_22_4 (.A(n_71), .B(n_22_1), .ZN(bcd_add1[2]));
   NAND2_X1_LVT i_7_98 (.A1(alu_short_thro), .A2(n_18), .ZN(n_7_88));
   NAND2_X1_LVT i_7_99 (.A1(inst_so[1]), .A2(op_src[2]), .ZN(n_7_89));
   NAND2_X1_LVT i_7_100 (.A1(inst_alu[10]), .A2(op_src[11]), .ZN(n_7_90));
   AND4_X1_LVT i_7_101 (.A1(n_7_88), .A2(n_7_64), .A3(n_7_89), .A4(n_7_90), 
      .ZN(n_7_91));
   OAI21_X1_LVT i_7_102 (.A(inst_alu[5]), .B1(n_18), .B2(n_2), .ZN(n_7_92));
   XOR2_X1_LVT i_7_103 (.A(n_18), .B(n_2), .Z(n_7_93));
   NAND2_X1_LVT i_7_104 (.A1(n_7_93), .A2(inst_alu[6]), .ZN(n_7_94));
   NAND3_X1_LVT i_7_105 (.A1(inst_alu[4]), .A2(n_18), .A3(n_2), .ZN(n_7_95));
   NAND4_X1_LVT i_7_106 (.A1(n_7_91), .A2(n_7_92), .A3(n_7_94), .A4(n_7_95), 
      .ZN(n_32));
   AOI222_X1_LVT i_44_20 (.A1(n_104), .A2(alu_add_inc[10]), .B1(n_106), .B2(
      bcd_add1[2]), .C1(n_105), .C2(n_32), .ZN(n_44_10));
   INV_X1_LVT i_44_21 (.A(n_44_10), .ZN(alu_out[10]));
   XNOR2_X1_LVT i_22_0 (.A(n_70), .B(n_63), .ZN(n_22_0));
   INV_X1_LVT i_22_1 (.A(n_22_0), .ZN(bcd_add1[1]));
   NAND2_X1_LVT i_7_89 (.A1(alu_short_thro), .A2(n_17), .ZN(n_7_80));
   NAND2_X1_LVT i_7_90 (.A1(inst_so[1]), .A2(op_src[1]), .ZN(n_7_81));
   NAND2_X1_LVT i_7_91 (.A1(inst_alu[10]), .A2(op_src[10]), .ZN(n_7_82));
   AND4_X1_LVT i_7_92 (.A1(n_7_80), .A2(n_7_64), .A3(n_7_81), .A4(n_7_82), 
      .ZN(n_7_83));
   OAI21_X1_LVT i_7_93 (.A(inst_alu[5]), .B1(n_17), .B2(n_1), .ZN(n_7_84));
   XOR2_X1_LVT i_7_94 (.A(n_17), .B(n_1), .Z(n_7_85));
   NAND2_X1_LVT i_7_95 (.A1(n_7_85), .A2(inst_alu[6]), .ZN(n_7_86));
   NAND3_X1_LVT i_7_96 (.A1(inst_alu[4]), .A2(n_17), .A3(n_1), .ZN(n_7_87));
   NAND4_X1_LVT i_7_97 (.A1(n_7_83), .A2(n_7_84), .A3(n_7_86), .A4(n_7_87), 
      .ZN(n_31));
   AOI222_X1_LVT i_44_18 (.A1(n_104), .A2(alu_add_inc[9]), .B1(n_106), .B2(
      bcd_add1[1]), .C1(n_105), .C2(n_31), .ZN(n_44_9));
   INV_X1_LVT i_44_19 (.A(n_44_9), .ZN(alu_out[9]));
   NAND2_X1_LVT i_7_80 (.A1(alu_short_thro), .A2(n_16), .ZN(n_7_72));
   NAND2_X1_LVT i_7_81 (.A1(op_src[0]), .A2(inst_so[1]), .ZN(n_7_73));
   NAND2_X1_LVT i_7_82 (.A1(inst_alu[10]), .A2(op_src[9]), .ZN(n_7_74));
   AND4_X1_LVT i_7_83 (.A1(n_7_72), .A2(n_7_64), .A3(n_7_73), .A4(n_7_74), 
      .ZN(n_7_75));
   OAI21_X1_LVT i_7_84 (.A(inst_alu[5]), .B1(n_16), .B2(n_0), .ZN(n_7_76));
   XOR2_X1_LVT i_7_85 (.A(n_16), .B(n_0), .Z(n_7_77));
   NAND2_X1_LVT i_7_86 (.A1(n_7_77), .A2(inst_alu[6]), .ZN(n_7_78));
   NAND3_X1_LVT i_7_87 (.A1(inst_alu[4]), .A2(n_16), .A3(n_0), .ZN(n_7_79));
   NAND4_X1_LVT i_7_88 (.A1(n_7_75), .A2(n_7_76), .A3(n_7_78), .A4(n_7_79), 
      .ZN(n_30));
   AOI222_X1_LVT i_44_16 (.A1(n_104), .A2(alu_add_inc[8]), .B1(n_106), .B2(n_62), 
      .C1(n_105), .C2(n_30), .ZN(n_44_8));
   INV_X1_LVT i_44_17 (.A(n_44_8), .ZN(alu_out[8]));
   NAND2_X1_LVT i_7_70 (.A1(alu_short_thro), .A2(n_15), .ZN(n_7_63));
   NAND2_X1_LVT i_7_72 (.A1(inst_so[1]), .A2(op_src[15]), .ZN(n_7_65));
   AOI22_X1_LVT i_5_6 (.A1(n_20), .A2(inst_bw), .B1(n_5_0), .B2(op_src[8]), 
      .ZN(n_5_5));
   INV_X1_LVT i_5_7 (.A(n_5_5), .ZN(n_21));
   NAND2_X1_LVT i_7_73 (.A1(inst_alu[10]), .A2(n_21), .ZN(n_7_66));
   AND4_X1_LVT i_7_74 (.A1(n_7_63), .A2(n_7_64), .A3(n_7_65), .A4(n_7_66), 
      .ZN(n_7_67));
   OAI21_X1_LVT i_7_75 (.A(inst_alu[5]), .B1(n_15), .B2(op_dst[7]), .ZN(n_7_68));
   XOR2_X1_LVT i_7_76 (.A(n_15), .B(op_dst[7]), .Z(n_7_69));
   NAND2_X1_LVT i_7_77 (.A1(n_7_69), .A2(inst_alu[6]), .ZN(n_7_70));
   NAND3_X1_LVT i_7_78 (.A1(inst_alu[4]), .A2(n_15), .A3(op_dst[7]), .ZN(n_7_71));
   NAND4_X1_LVT i_7_79 (.A1(n_7_67), .A2(n_7_68), .A3(n_7_70), .A4(n_7_71), 
      .ZN(n_29));
   AOI222_X1_LVT i_44_14 (.A1(n_104), .A2(alu_add_inc[7]), .B1(n_106), .B2(
      bcd_add0[3]), .C1(n_105), .C2(n_29), .ZN(n_44_7));
   INV_X1_LVT i_44_15 (.A(n_44_7), .ZN(alu_out[7]));
   XNOR2_X1_LVT i_17_4 (.A(n_59), .B(n_17_1), .ZN(bcd_add0[2]));
   NAND2_X1_LVT i_7_60 (.A1(alu_short_thro), .A2(n_14), .ZN(n_7_54));
   NAND2_X1_LVT i_7_61 (.A1(inst_so[3]), .A2(op_src[6]), .ZN(n_7_55));
   NAND2_X1_LVT i_7_62 (.A1(inst_so[1]), .A2(op_src[14]), .ZN(n_7_56));
   NAND2_X1_LVT i_7_63 (.A1(inst_alu[10]), .A2(op_src[7]), .ZN(n_7_57));
   AND4_X1_LVT i_7_64 (.A1(n_7_54), .A2(n_7_55), .A3(n_7_56), .A4(n_7_57), 
      .ZN(n_7_58));
   OAI21_X1_LVT i_7_65 (.A(inst_alu[5]), .B1(n_14), .B2(op_dst[6]), .ZN(n_7_59));
   XOR2_X1_LVT i_7_66 (.A(n_14), .B(op_dst[6]), .Z(n_7_60));
   NAND2_X1_LVT i_7_67 (.A1(n_7_60), .A2(inst_alu[6]), .ZN(n_7_61));
   NAND3_X1_LVT i_7_68 (.A1(inst_alu[4]), .A2(n_14), .A3(op_dst[6]), .ZN(n_7_62));
   NAND4_X1_LVT i_7_69 (.A1(n_7_58), .A2(n_7_59), .A3(n_7_61), .A4(n_7_62), 
      .ZN(n_28));
   AOI222_X1_LVT i_44_12 (.A1(n_104), .A2(alu_add_inc[6]), .B1(n_106), .B2(
      bcd_add0[2]), .C1(n_105), .C2(n_28), .ZN(n_44_6));
   INV_X1_LVT i_44_13 (.A(n_44_6), .ZN(alu_out[6]));
   XNOR2_X1_LVT i_17_0 (.A(n_58), .B(n_51), .ZN(n_17_0));
   INV_X1_LVT i_17_1 (.A(n_17_0), .ZN(bcd_add0[1]));
   NAND2_X1_LVT i_7_50 (.A1(alu_short_thro), .A2(n_13), .ZN(n_7_45));
   NAND2_X1_LVT i_7_51 (.A1(inst_so[3]), .A2(op_src[5]), .ZN(n_7_46));
   NAND2_X1_LVT i_7_52 (.A1(inst_so[1]), .A2(op_src[13]), .ZN(n_7_47));
   NAND2_X1_LVT i_7_53 (.A1(inst_alu[10]), .A2(op_src[6]), .ZN(n_7_48));
   AND4_X1_LVT i_7_54 (.A1(n_7_45), .A2(n_7_46), .A3(n_7_47), .A4(n_7_48), 
      .ZN(n_7_49));
   OAI21_X1_LVT i_7_55 (.A(inst_alu[5]), .B1(n_13), .B2(op_dst[5]), .ZN(n_7_50));
   XOR2_X1_LVT i_7_56 (.A(n_13), .B(op_dst[5]), .Z(n_7_51));
   NAND2_X1_LVT i_7_57 (.A1(n_7_51), .A2(inst_alu[6]), .ZN(n_7_52));
   NAND3_X1_LVT i_7_58 (.A1(inst_alu[4]), .A2(n_13), .A3(op_dst[5]), .ZN(n_7_53));
   NAND4_X1_LVT i_7_59 (.A1(n_7_49), .A2(n_7_50), .A3(n_7_52), .A4(n_7_53), 
      .ZN(n_27));
   AOI222_X1_LVT i_44_10 (.A1(n_104), .A2(alu_add_inc[5]), .B1(n_106), .B2(
      bcd_add0[1]), .C1(n_105), .C2(n_27), .ZN(n_44_5));
   INV_X1_LVT i_44_11 (.A(n_44_5), .ZN(alu_out[5]));
   NAND2_X1_LVT i_7_40 (.A1(alu_short_thro), .A2(n_12), .ZN(n_7_36));
   NAND2_X1_LVT i_7_41 (.A1(inst_so[3]), .A2(op_src[4]), .ZN(n_7_37));
   NAND2_X1_LVT i_7_42 (.A1(inst_so[1]), .A2(op_src[12]), .ZN(n_7_38));
   NAND2_X1_LVT i_7_43 (.A1(inst_alu[10]), .A2(op_src[5]), .ZN(n_7_39));
   AND4_X1_LVT i_7_44 (.A1(n_7_36), .A2(n_7_37), .A3(n_7_38), .A4(n_7_39), 
      .ZN(n_7_40));
   OAI21_X1_LVT i_7_45 (.A(inst_alu[5]), .B1(n_12), .B2(op_dst[4]), .ZN(n_7_41));
   XOR2_X1_LVT i_7_46 (.A(n_12), .B(op_dst[4]), .Z(n_7_42));
   NAND2_X1_LVT i_7_47 (.A1(n_7_42), .A2(inst_alu[6]), .ZN(n_7_43));
   NAND3_X1_LVT i_7_48 (.A1(inst_alu[4]), .A2(n_12), .A3(op_dst[4]), .ZN(n_7_44));
   NAND4_X1_LVT i_7_49 (.A1(n_7_40), .A2(n_7_41), .A3(n_7_43), .A4(n_7_44), 
      .ZN(n_26));
   AOI222_X1_LVT i_44_8 (.A1(n_104), .A2(alu_add_inc[4]), .B1(n_106), .B2(n_50), 
      .C1(n_105), .C2(n_26), .ZN(n_44_4));
   INV_X1_LVT i_44_9 (.A(n_44_4), .ZN(alu_out[4]));
   NAND2_X1_LVT i_7_30 (.A1(alu_short_thro), .A2(n_11), .ZN(n_7_27));
   NAND2_X1_LVT i_7_31 (.A1(inst_so[3]), .A2(op_src[3]), .ZN(n_7_28));
   NAND2_X1_LVT i_7_32 (.A1(inst_so[1]), .A2(op_src[11]), .ZN(n_7_29));
   NAND2_X1_LVT i_7_33 (.A1(inst_alu[10]), .A2(op_src[4]), .ZN(n_7_30));
   AND4_X1_LVT i_7_34 (.A1(n_7_27), .A2(n_7_28), .A3(n_7_29), .A4(n_7_30), 
      .ZN(n_7_31));
   OAI21_X1_LVT i_7_35 (.A(inst_alu[5]), .B1(n_11), .B2(op_dst[3]), .ZN(n_7_32));
   XOR2_X1_LVT i_7_36 (.A(n_11), .B(op_dst[3]), .Z(n_7_33));
   NAND2_X1_LVT i_7_37 (.A1(n_7_33), .A2(inst_alu[6]), .ZN(n_7_34));
   NAND3_X1_LVT i_7_38 (.A1(inst_alu[4]), .A2(n_11), .A3(op_dst[3]), .ZN(n_7_35));
   NAND4_X1_LVT i_7_39 (.A1(n_7_31), .A2(n_7_32), .A3(n_7_34), .A4(n_7_35), 
      .ZN(n_25));
   AOI222_X1_LVT i_44_6 (.A1(n_104), .A2(alu_add_inc[3]), .B1(n_106), .B2(
      bcd_add[3]), .C1(n_105), .C2(n_25), .ZN(n_44_3));
   INV_X1_LVT i_44_7 (.A(n_44_3), .ZN(alu_out[3]));
   XNOR2_X1_LVT i_12_4 (.A(n_47), .B(n_12_1), .ZN(bcd_add[2]));
   NAND2_X1_LVT i_7_20 (.A1(alu_short_thro), .A2(n_10), .ZN(n_7_18));
   NAND2_X1_LVT i_7_21 (.A1(inst_so[3]), .A2(op_src[2]), .ZN(n_7_19));
   NAND2_X1_LVT i_7_22 (.A1(inst_so[1]), .A2(op_src[10]), .ZN(n_7_20));
   NAND2_X1_LVT i_7_23 (.A1(inst_alu[10]), .A2(op_src[3]), .ZN(n_7_21));
   AND4_X1_LVT i_7_24 (.A1(n_7_18), .A2(n_7_19), .A3(n_7_20), .A4(n_7_21), 
      .ZN(n_7_22));
   OAI21_X1_LVT i_7_25 (.A(inst_alu[5]), .B1(n_10), .B2(op_dst[2]), .ZN(n_7_23));
   XOR2_X1_LVT i_7_26 (.A(n_10), .B(op_dst[2]), .Z(n_7_24));
   NAND2_X1_LVT i_7_27 (.A1(n_7_24), .A2(inst_alu[6]), .ZN(n_7_25));
   NAND3_X1_LVT i_7_28 (.A1(inst_alu[4]), .A2(n_10), .A3(op_dst[2]), .ZN(n_7_26));
   NAND4_X1_LVT i_7_29 (.A1(n_7_22), .A2(n_7_23), .A3(n_7_25), .A4(n_7_26), 
      .ZN(n_24));
   AOI222_X1_LVT i_44_4 (.A1(n_104), .A2(alu_add_inc[2]), .B1(n_106), .B2(
      bcd_add[2]), .C1(n_105), .C2(n_24), .ZN(n_44_2));
   INV_X1_LVT i_44_5 (.A(n_44_2), .ZN(alu_out[2]));
   XNOR2_X1_LVT i_12_0 (.A(n_46), .B(n_39), .ZN(n_12_0));
   INV_X1_LVT i_12_1 (.A(n_12_0), .ZN(bcd_add[1]));
   NAND2_X1_LVT i_7_10 (.A1(alu_short_thro), .A2(n_9), .ZN(n_7_9));
   NAND2_X1_LVT i_7_11 (.A1(inst_so[3]), .A2(op_src[1]), .ZN(n_7_10));
   NAND2_X1_LVT i_7_12 (.A1(inst_so[1]), .A2(op_src[9]), .ZN(n_7_11));
   NAND2_X1_LVT i_7_13 (.A1(inst_alu[10]), .A2(op_src[2]), .ZN(n_7_12));
   AND4_X1_LVT i_7_14 (.A1(n_7_9), .A2(n_7_10), .A3(n_7_11), .A4(n_7_12), 
      .ZN(n_7_13));
   OAI21_X1_LVT i_7_15 (.A(inst_alu[5]), .B1(n_9), .B2(op_dst[1]), .ZN(n_7_14));
   XOR2_X1_LVT i_7_16 (.A(n_9), .B(op_dst[1]), .Z(n_7_15));
   NAND2_X1_LVT i_7_17 (.A1(n_7_15), .A2(inst_alu[6]), .ZN(n_7_16));
   NAND3_X1_LVT i_7_18 (.A1(inst_alu[4]), .A2(n_9), .A3(op_dst[1]), .ZN(n_7_17));
   NAND4_X1_LVT i_7_19 (.A1(n_7_13), .A2(n_7_14), .A3(n_7_16), .A4(n_7_17), 
      .ZN(n_23));
   AOI222_X1_LVT i_44_2 (.A1(n_104), .A2(alu_add_inc[1]), .B1(n_106), .B2(
      bcd_add[1]), .C1(n_105), .C2(n_23), .ZN(n_44_1));
   INV_X1_LVT i_44_3 (.A(n_44_1), .ZN(alu_out[1]));
   NAND2_X1_LVT i_7_0 (.A1(n_8), .A2(alu_short_thro), .ZN(n_7_0));
   NAND2_X1_LVT i_7_1 (.A1(inst_so[3]), .A2(op_src[0]), .ZN(n_7_1));
   NAND2_X1_LVT i_7_2 (.A1(inst_so[1]), .A2(op_src[8]), .ZN(n_7_2));
   NAND2_X1_LVT i_7_3 (.A1(inst_alu[10]), .A2(op_src[1]), .ZN(n_7_3));
   AND4_X1_LVT i_7_4 (.A1(n_7_0), .A2(n_7_1), .A3(n_7_2), .A4(n_7_3), .ZN(n_7_4));
   OAI21_X1_LVT i_7_5 (.A(inst_alu[5]), .B1(n_8), .B2(op_dst[0]), .ZN(n_7_5));
   XOR2_X1_LVT i_7_6 (.A(n_8), .B(op_dst[0]), .Z(n_7_6));
   NAND2_X1_LVT i_7_7 (.A1(n_7_6), .A2(inst_alu[6]), .ZN(n_7_7));
   NAND3_X1_LVT i_7_8 (.A1(inst_alu[4]), .A2(n_8), .A3(op_dst[0]), .ZN(n_7_8));
   NAND4_X1_LVT i_7_9 (.A1(n_7_4), .A2(n_7_5), .A3(n_7_7), .A4(n_7_8), .ZN(n_22));
   AOI222_X1_LVT i_44_0 (.A1(alu_add_inc[0]), .A2(n_104), .B1(n_38), .B2(n_106), 
      .C1(n_22), .C2(n_105), .ZN(n_44_0));
   INV_X1_LVT i_44_1 (.A(n_44_0), .ZN(alu_out[0]));
   NOR2_X1_LVT i_51_1 (.A1(inst_alu[8]), .A2(inst_alu[10]), .ZN(n_51_1));
   NAND2_X1_LVT i_51_2 (.A1(n_51_1), .A2(inst_alu[6]), .ZN(n_51_2));
   INV_X1_LVT i_51_8 (.A(inst_bw), .ZN(n_51_8));
   AND2_X1_LVT i_45_0 (.A1(X[3]), .A2(n_7), .ZN(n_108));
   AND2_X1_LVT i_47_0 (.A1(n_15), .A2(op_dst[7]), .ZN(n_110));
   AOI22_X1_LVT i_51_24 (.A1(n_51_8), .A2(n_108), .B1(inst_bw), .B2(n_110), 
      .ZN(n_51_21));
   INV_X1_LVT i_51_6 (.A(inst_alu[6]), .ZN(n_51_6));
   NAND2_X1_LVT i_51_7 (.A1(n_51_1), .A2(n_51_6), .ZN(n_51_7));
   INV_X1_LVT i_46_0 (.A(alu_out[15]), .ZN(n_46_0));
   NOR3_X1_LVT i_46_1 (.A1(n_46_0), .A2(X[3]), .A3(n_7), .ZN(n_46_1));
   AOI21_X1_LVT i_46_2 (.A(n_46_1), .B1(n_46_0), .B2(n_108), .ZN(n_46_2));
   INV_X1_LVT i_46_3 (.A(n_46_2), .ZN(n_109));
   INV_X1_LVT i_48_0 (.A(alu_out[7]), .ZN(n_48_0));
   NOR3_X1_LVT i_48_1 (.A1(n_48_0), .A2(n_15), .A3(op_dst[7]), .ZN(n_48_1));
   AOI21_X1_LVT i_48_2 (.A(n_48_1), .B1(n_48_0), .B2(n_110), .ZN(n_48_2));
   INV_X1_LVT i_48_3 (.A(n_48_2), .ZN(n_111));
   AOI22_X1_LVT i_51_25 (.A1(n_51_8), .A2(n_109), .B1(inst_bw), .B2(n_111), 
      .ZN(n_51_22));
   OAI22_X1_LVT i_51_26 (.A1(n_51_2), .A2(n_51_21), .B1(n_51_7), .B2(n_51_22), 
      .ZN(alu_stat[3]));
   INV_X1_LVT i_51_21 (.A(alu_out[7]), .ZN(n_51_19));
   INV_X1_LVT i_51_22 (.A(alu_out[15]), .ZN(n_51_20));
   OAI22_X1_LVT i_51_23 (.A1(n_51_8), .A2(n_51_19), .B1(n_51_20), .B2(inst_bw), 
      .ZN(alu_stat[2]));
   OR4_X1_LVT i_51_11 (.A1(n_51_8), .A2(alu_out[5]), .A3(alu_out[6]), .A4(
      alu_out[7]), .ZN(n_51_10));
   OR4_X1_LVT i_51_12 (.A1(n_51_10), .A2(alu_out[2]), .A3(alu_out[3]), .A4(
      alu_out[4]), .ZN(n_51_11));
   OR3_X1_LVT i_51_13 (.A1(n_51_11), .A2(alu_out[0]), .A3(alu_out[1]), .ZN(
      n_51_12));
   NOR4_X1_LVT i_51_14 (.A1(alu_out[13]), .A2(alu_out[14]), .A3(alu_out[15]), 
      .A4(inst_bw), .ZN(n_51_13));
   NOR4_X1_LVT i_51_15 (.A1(alu_out[4]), .A2(alu_out[5]), .A3(alu_out[6]), 
      .A4(alu_out[7]), .ZN(n_51_14));
   NOR4_X1_LVT i_51_16 (.A1(alu_out[9]), .A2(alu_out[10]), .A3(alu_out[11]), 
      .A4(alu_out[12]), .ZN(n_51_15));
   INV_X1_LVT i_51_17 (.A(alu_out[3]), .ZN(n_51_16));
   NAND4_X1_LVT i_51_18 (.A1(n_51_13), .A2(n_51_14), .A3(n_51_15), .A4(n_51_16), 
      .ZN(n_51_17));
   OR4_X1_LVT i_51_19 (.A1(n_51_17), .A2(alu_out[0]), .A3(alu_out[1]), .A4(
      alu_out[2]), .ZN(n_51_18));
   OAI21_X1_LVT i_51_20 (.A(n_51_12), .B1(n_51_18), .B2(alu_out[8]), .ZN(
      alu_stat[1]));
   NAND2_X1_LVT i_51_0 (.A1(n_8), .A2(inst_alu[10]), .ZN(n_51_0));
   INV_X1_LVT i_51_3 (.A(inst_alu[8]), .ZN(n_51_3));
   OAI21_X1_LVT i_51_4 (.A(n_51_2), .B1(inst_alu[10]), .B2(n_51_3), .ZN(n_51_4));
   INV_X1_LVT i_49_0 (.A(inst_bw), .ZN(n_49_0));
   OR4_X1_LVT i_49_1 (.A1(n_49_0), .A2(alu_out[5]), .A3(alu_out[6]), .A4(
      alu_out[7]), .ZN(n_49_1));
   OR4_X1_LVT i_49_2 (.A1(n_49_1), .A2(alu_out[2]), .A3(alu_out[3]), .A4(
      alu_out[4]), .ZN(n_49_2));
   OR3_X1_LVT i_49_3 (.A1(n_49_2), .A2(alu_out[0]), .A3(alu_out[1]), .ZN(n_49_3));
   NOR4_X1_LVT i_49_4 (.A1(alu_out[13]), .A2(alu_out[14]), .A3(alu_out[15]), 
      .A4(inst_bw), .ZN(n_49_4));
   NOR4_X1_LVT i_49_5 (.A1(alu_out[5]), .A2(alu_out[6]), .A3(alu_out[7]), 
      .A4(alu_out[8]), .ZN(n_49_5));
   NOR4_X1_LVT i_49_6 (.A1(alu_out[9]), .A2(alu_out[10]), .A3(alu_out[11]), 
      .A4(alu_out[12]), .ZN(n_49_6));
   INV_X1_LVT i_49_7 (.A(alu_out[4]), .ZN(n_49_7));
   NAND4_X1_LVT i_49_8 (.A1(n_49_4), .A2(n_49_5), .A3(n_49_6), .A4(n_49_7), 
      .ZN(n_49_8));
   OR4_X1_LVT i_49_9 (.A1(n_49_8), .A2(alu_out[1]), .A3(alu_out[2]), .A4(
      alu_out[3]), .ZN(n_49_9));
   OAI21_X1_LVT i_49_10 (.A(n_49_3), .B1(n_49_9), .B2(alu_out[0]), .ZN(Z));
   INV_X1_LVT i_50_0 (.A(Z), .ZN(n_112));
   NAND2_X1_LVT i_51_5 (.A1(n_51_4), .A2(n_112), .ZN(n_51_5));
   XNOR2_X1_LVT i_41_16 (.A(alu_add[16]), .B(n_41_15), .ZN(n_41_16));
   INV_X1_LVT i_41_17 (.A(n_41_16), .ZN(alu_add_inc[16]));
   OR2_X1_LVT i_27_7 (.A1(n_82), .A2(n_84), .ZN(n_27_5));
   HA_X1_LVT i_26_2 (.A(n_80), .B(n_26_1), .CO(n_26_2), .S(n_85));
   INV_X1_LVT i_27_8 (.A(n_85), .ZN(n_27_6));
   XNOR2_X1_LVT i_27_10 (.A(n_27_5), .B(n_27_6), .ZN(n_27_8));
   XNOR2_X1_LVT i_27_11 (.A(n_27_8), .B(n_27_7), .ZN(bcd_add2[4]));
   AOI22_X1_LVT i_44_32 (.A1(n_104), .A2(alu_add_inc[16]), .B1(n_106), .B2(
      bcd_add2[4]), .ZN(n_44_16));
   INV_X1_LVT i_44_33 (.A(n_44_16), .ZN(n_107));
   AOI22_X1_LVT i_51_9 (.A1(n_51_8), .A2(n_107), .B1(alu_out[8]), .B2(inst_bw), 
      .ZN(n_51_9));
   OAI211_X1_LVT i_51_10 (.A(n_51_0), .B(n_51_5), .C1(n_51_7), .C2(n_51_9), 
      .ZN(alu_stat[0]));
   AND2_X1_LVT i_52_0 (.A1(inst_alu[9]), .A2(exec_cycle), .ZN(alu_stat_wr[0]));
endmodule

module omsp_register_file(cpuoff, gie, oscoff, pc_sw, pc_sw_wr, reg_dest, 
      reg_src, scg0, scg1, status, alu_stat, alu_stat_wr, inst_bw, inst_dest, 
      inst_src, mclk, pc, puc_rst, reg_dest_val, reg_dest_wr, reg_pc_call, 
      reg_sp_val, reg_sp_wr, reg_sr_wr, reg_sr_clr, reg_incr, scan_enable);
   output cpuoff;
   output gie;
   output oscoff;
   output [15:0]pc_sw;
   output pc_sw_wr;
   output [15:0]reg_dest;
   output [15:0]reg_src;
   output scg0;
   output scg1;
   output [3:0]status;
   input [3:0]alu_stat;
   input [3:0]alu_stat_wr;
   input inst_bw;
   input [15:0]inst_dest;
   input [15:0]inst_src;
   input mclk;
   input [15:0]pc;
   input puc_rst;
   input [15:0]reg_dest_val;
   input reg_dest_wr;
   input reg_pc_call;
   input [15:0]reg_sp_val;
   input reg_sp_wr;
   input reg_sr_wr;
   input reg_sr_clr;
   input reg_incr;
   input scan_enable;

   wire n_0_0;
   wire n_1_0;
   wire r2_wr;
   wire n_2_0;
   wire n_2_1;
   wire [7:3]r2_nxt;
   wire n_2_2;
   wire n_2_3;
   wire n_2_4;
   wire n_5_0;
   wire n_5_1;
   wire n_5_2;
   wire n_5_3;
   wire n_5_4;
   wire n_5_5;
   wire n_5_6;
   wire n_5_7;
   wire n_5_8;
   wire n_5_9;
   wire n_5_10;
   wire n_5_11;
   wire n_5_12;
   wire n_5_13;
   wire n_5_14;
   wire n_5_15;
   wire n_5_16;
   wire n_6_0;
   wire n_8_0;
   wire n_9_0;
   wire n_10_0;
   wire inst_src_in;
   wire r1_inc;
   wire r1_wr;
   wire n_13_0;
   wire n_13_1;
   wire n_14_0;
   wire r3_wr;
   wire [15:0]r3;
   wire n_17_0;
   wire r4_inc;
   wire r4_wr;
   wire n_20_0;
   wire [15:0]reg_incr_val;
   wire n_22_0;
   wire n_22_1;
   wire n_22_2;
   wire n_22_3;
   wire n_22_4;
   wire n_22_5;
   wire n_22_6;
   wire n_22_7;
   wire n_22_8;
   wire n_22_9;
   wire n_22_10;
   wire n_22_11;
   wire n_22_12;
   wire n_22_13;
   wire n_22_14;
   wire n_22_15;
   wire [15:0]r4;
   wire n_24_0;
   wire n_24_1;
   wire n_24_2;
   wire n_24_3;
   wire n_24_4;
   wire n_24_5;
   wire n_24_6;
   wire n_24_7;
   wire n_24_8;
   wire n_24_9;
   wire n_24_10;
   wire n_24_11;
   wire n_24_12;
   wire n_24_13;
   wire n_24_14;
   wire n_24_15;
   wire n_24_16;
   wire n_25_0;
   wire n_25_1;
   wire n_27_0;
   wire r5_inc;
   wire r5_wr;
   wire [15:0]r5;
   wire n_31_0;
   wire n_31_1;
   wire n_31_2;
   wire n_31_3;
   wire n_31_4;
   wire n_31_5;
   wire n_31_6;
   wire n_31_7;
   wire n_31_8;
   wire n_31_9;
   wire n_31_10;
   wire n_31_11;
   wire n_31_12;
   wire n_31_13;
   wire n_31_14;
   wire n_31_15;
   wire n_31_16;
   wire n_32_0;
   wire n_32_1;
   wire n_34_0;
   wire r6_inc;
   wire r6_wr;
   wire [15:0]r6;
   wire n_38_0;
   wire n_38_1;
   wire n_38_2;
   wire n_38_3;
   wire n_38_4;
   wire n_38_5;
   wire n_38_6;
   wire n_38_7;
   wire n_38_8;
   wire n_38_9;
   wire n_38_10;
   wire n_38_11;
   wire n_38_12;
   wire n_38_13;
   wire n_38_14;
   wire n_38_15;
   wire n_38_16;
   wire n_39_0;
   wire n_39_1;
   wire n_41_0;
   wire r7_inc;
   wire r7_wr;
   wire [15:0]r7;
   wire n_45_0;
   wire n_45_1;
   wire n_45_2;
   wire n_45_3;
   wire n_45_4;
   wire n_45_5;
   wire n_45_6;
   wire n_45_7;
   wire n_45_8;
   wire n_45_9;
   wire n_45_10;
   wire n_45_11;
   wire n_45_12;
   wire n_45_13;
   wire n_45_14;
   wire n_45_15;
   wire n_45_16;
   wire n_46_0;
   wire n_46_1;
   wire n_48_0;
   wire r8_inc;
   wire r8_wr;
   wire [15:0]r8;
   wire n_52_0;
   wire n_52_1;
   wire n_52_2;
   wire n_52_3;
   wire n_52_4;
   wire n_52_5;
   wire n_52_6;
   wire n_52_7;
   wire n_52_8;
   wire n_52_9;
   wire n_52_10;
   wire n_52_11;
   wire n_52_12;
   wire n_52_13;
   wire n_52_14;
   wire n_52_15;
   wire n_52_16;
   wire n_53_0;
   wire n_53_1;
   wire n_55_0;
   wire r9_inc;
   wire r9_wr;
   wire [15:0]r9;
   wire n_59_0;
   wire n_59_1;
   wire n_59_2;
   wire n_59_3;
   wire n_59_4;
   wire n_59_5;
   wire n_59_6;
   wire n_59_7;
   wire n_59_8;
   wire n_59_9;
   wire n_59_10;
   wire n_59_11;
   wire n_59_12;
   wire n_59_13;
   wire n_59_14;
   wire n_59_15;
   wire n_59_16;
   wire n_60_0;
   wire n_60_1;
   wire n_62_0;
   wire r10_inc;
   wire r10_wr;
   wire [15:0]r10;
   wire n_66_0;
   wire n_66_1;
   wire n_66_2;
   wire n_66_3;
   wire n_66_4;
   wire n_66_5;
   wire n_66_6;
   wire n_66_7;
   wire n_66_8;
   wire n_66_9;
   wire n_66_10;
   wire n_66_11;
   wire n_66_12;
   wire n_66_13;
   wire n_66_14;
   wire n_66_15;
   wire n_66_16;
   wire n_67_0;
   wire n_67_1;
   wire n_69_0;
   wire r11_inc;
   wire r11_wr;
   wire [15:0]r11;
   wire n_73_0;
   wire n_73_1;
   wire n_73_2;
   wire n_73_3;
   wire n_73_4;
   wire n_73_5;
   wire n_73_6;
   wire n_73_7;
   wire n_73_8;
   wire n_73_9;
   wire n_73_10;
   wire n_73_11;
   wire n_73_12;
   wire n_73_13;
   wire n_73_14;
   wire n_73_15;
   wire n_73_16;
   wire n_74_0;
   wire n_74_1;
   wire n_76_0;
   wire r12_inc;
   wire r12_wr;
   wire [15:0]r12;
   wire n_80_0;
   wire n_80_1;
   wire n_80_2;
   wire n_80_3;
   wire n_80_4;
   wire n_80_5;
   wire n_80_6;
   wire n_80_7;
   wire n_80_8;
   wire n_80_9;
   wire n_80_10;
   wire n_80_11;
   wire n_80_12;
   wire n_80_13;
   wire n_80_14;
   wire n_80_15;
   wire n_80_16;
   wire n_81_0;
   wire n_81_1;
   wire n_83_0;
   wire r13_inc;
   wire r13_wr;
   wire [15:0]r13;
   wire n_87_0;
   wire n_87_1;
   wire n_87_2;
   wire n_87_3;
   wire n_87_4;
   wire n_87_5;
   wire n_87_6;
   wire n_87_7;
   wire n_87_8;
   wire n_87_9;
   wire n_87_10;
   wire n_87_11;
   wire n_87_12;
   wire n_87_13;
   wire n_87_14;
   wire n_87_15;
   wire n_87_16;
   wire n_88_0;
   wire n_88_1;
   wire n_90_0;
   wire r14_inc;
   wire r14_wr;
   wire [15:0]r14;
   wire n_94_0;
   wire n_94_1;
   wire n_94_2;
   wire n_94_3;
   wire n_94_4;
   wire n_94_5;
   wire n_94_6;
   wire n_94_7;
   wire n_94_8;
   wire n_94_9;
   wire n_94_10;
   wire n_94_11;
   wire n_94_12;
   wire n_94_13;
   wire n_94_14;
   wire n_94_15;
   wire n_94_16;
   wire n_95_0;
   wire n_95_1;
   wire n_97_0;
   wire r15_inc;
   wire r15_wr;
   wire [15:0]r15;
   wire n_101_0;
   wire n_101_1;
   wire n_101_2;
   wire n_101_3;
   wire n_101_4;
   wire n_101_5;
   wire n_101_6;
   wire n_101_7;
   wire n_101_8;
   wire n_101_9;
   wire n_101_10;
   wire n_101_11;
   wire n_101_12;
   wire n_101_13;
   wire n_101_14;
   wire n_101_15;
   wire n_101_16;
   wire n_102_0;
   wire n_102_1;
   wire n_104_0;
   wire n_105_0;
   wire n_105_1;
   wire n_105_2;
   wire n_105_3;
   wire n_105_4;
   wire n_105_5;
   wire n_105_6;
   wire n_105_7;
   wire n_105_8;
   wire n_105_9;
   wire n_105_10;
   wire n_105_11;
   wire n_105_12;
   wire n_105_13;
   wire n_105_14;
   wire n_105_15;
   wire n_105_16;
   wire n_105_17;
   wire n_105_18;
   wire n_105_19;
   wire n_105_20;
   wire n_105_21;
   wire n_105_22;
   wire n_105_23;
   wire n_105_24;
   wire n_105_25;
   wire n_105_26;
   wire n_105_27;
   wire n_105_28;
   wire n_105_29;
   wire n_105_30;
   wire n_105_31;
   wire n_105_32;
   wire n_105_33;
   wire n_105_34;
   wire n_105_35;
   wire n_105_36;
   wire n_105_37;
   wire n_105_38;
   wire n_105_39;
   wire n_105_40;
   wire n_105_41;
   wire n_105_42;
   wire n_105_43;
   wire n_105_44;
   wire n_105_45;
   wire n_105_46;
   wire n_105_47;
   wire n_105_48;
   wire n_105_49;
   wire n_105_50;
   wire n_105_51;
   wire n_105_52;
   wire n_105_53;
   wire n_105_54;
   wire n_105_55;
   wire n_105_56;
   wire n_105_57;
   wire n_105_58;
   wire n_105_59;
   wire n_105_60;
   wire n_105_61;
   wire n_105_62;
   wire n_105_63;
   wire n_105_64;
   wire n_105_65;
   wire n_105_66;
   wire n_105_67;
   wire n_105_68;
   wire n_105_69;
   wire n_105_70;
   wire n_105_71;
   wire n_105_72;
   wire n_105_73;
   wire n_105_74;
   wire n_105_75;
   wire n_105_76;
   wire n_105_77;
   wire n_105_78;
   wire n_105_79;
   wire n_105_80;
   wire n_105_81;
   wire n_105_82;
   wire n_105_83;
   wire n_105_84;
   wire n_105_85;
   wire n_105_86;
   wire n_105_87;
   wire n_105_88;
   wire n_105_89;
   wire n_105_90;
   wire n_105_91;
   wire n_105_92;
   wire n_105_93;
   wire n_105_94;
   wire n_105_95;
   wire n_105_96;
   wire n_105_97;
   wire n_105_98;
   wire n_105_99;
   wire n_105_100;
   wire n_105_101;
   wire n_105_102;
   wire n_105_103;
   wire n_105_104;
   wire n_105_105;
   wire n_105_106;
   wire n_105_107;
   wire n_105_108;
   wire n_105_109;
   wire n_105_110;
   wire n_105_111;
   wire n_105_112;
   wire n_105_113;
   wire n_105_114;
   wire n_105_115;
   wire n_105_116;
   wire n_105_117;
   wire n_105_118;
   wire n_105_119;
   wire n_105_120;
   wire n_105_121;
   wire n_105_122;
   wire n_105_123;
   wire n_105_124;
   wire n_105_125;
   wire n_105_126;
   wire n_105_127;
   wire n_105_128;
   wire n_105_129;
   wire n_105_130;
   wire n_105_131;
   wire n_105_132;
   wire n_105_133;
   wire n_105_134;
   wire n_105_135;
   wire n_105_136;
   wire n_105_137;
   wire n_105_138;
   wire n_105_139;
   wire n_105_140;
   wire n_105_141;
   wire n_105_142;
   wire n_105_143;
   wire n_105_144;
   wire n_105_145;
   wire n_105_146;
   wire n_105_147;
   wire n_105_148;
   wire n_105_149;
   wire n_105_150;
   wire n_105_151;
   wire n_105_152;
   wire n_105_153;
   wire n_105_154;
   wire n_105_155;
   wire n_105_156;
   wire n_105_157;
   wire n_105_158;
   wire n_105_159;
   wire n_105_160;
   wire n_105_161;
   wire n_105_162;
   wire n_105_163;
   wire n_105_164;
   wire n_105_165;
   wire n_105_166;
   wire n_105_167;
   wire n_105_168;
   wire n_105_169;
   wire n_105_170;
   wire n_105_171;
   wire n_105_172;
   wire n_105_173;
   wire n_105_174;
   wire n_105_175;
   wire n_105_176;
   wire n_105_177;
   wire n_105_178;
   wire n_105_179;
   wire n_105_180;
   wire n_105_181;
   wire n_105_182;
   wire n_105_183;
   wire n_105_184;
   wire n_105_185;
   wire n_105_186;
   wire n_105_187;
   wire n_105_188;
   wire n_105_189;
   wire n_105_190;
   wire n_105_191;
   wire n_105_192;
   wire n_105_193;
   wire n_105_194;
   wire n_105_195;
   wire n_105_196;
   wire n_105_197;
   wire n_105_198;
   wire n_105_199;
   wire n_105_200;
   wire n_105_201;
   wire n_105_202;
   wire n_105_203;
   wire n_105_204;
   wire n_105_205;
   wire n_105_206;
   wire n_105_207;
   wire n_105_208;
   wire n_105_209;
   wire n_105_210;
   wire n_105_211;
   wire n_105_212;
   wire n_105_213;
   wire n_105_214;
   wire n_105_215;
   wire n_105_216;
   wire n_105_217;
   wire n_105_218;
   wire n_105_219;
   wire n_105_220;
   wire n_105_221;
   wire n_105_222;
   wire n_105_223;
   wire n_105_224;
   wire n_105_225;
   wire n_105_226;
   wire n_105_227;
   wire n_105_228;
   wire n_105_229;
   wire n_105_230;
   wire n_105_231;
   wire n_105_232;
   wire n_105_233;
   wire n_105_234;
   wire n_105_235;
   wire n_105_236;
   wire n_105_237;
   wire n_105_238;
   wire n_105_239;
   wire n_105_240;
   wire n_105_241;
   wire n_105_242;
   wire n_105_243;
   wire n_105_244;
   wire n_105_245;
   wire n_105_246;
   wire n_105_247;
   wire n_105_248;
   wire n_105_249;
   wire n_105_250;
   wire n_105_251;
   wire n_105_252;
   wire n_105_253;
   wire n_105_254;
   wire n_105_255;
   wire n_105_256;
   wire n_105_257;
   wire n_105_258;
   wire n_105_259;
   wire n_105_260;
   wire n_105_261;
   wire n_105_262;
   wire n_105_263;
   wire n_105_264;
   wire n_105_265;
   wire n_105_266;
   wire n_105_267;
   wire n_105_268;
   wire n_105_269;
   wire n_105_270;
   wire n_105_271;
   wire n_105_272;
   wire n_105_273;
   wire n_105_274;
   wire n_105_275;
   wire n_105_276;
   wire n_105_277;
   wire n_105_278;
   wire n_105_279;
   wire n_105_280;
   wire n_105_281;
   wire n_105_282;
   wire n_105_283;
   wire n_105_284;
   wire n_105_285;
   wire n_105_286;
   wire n_105_287;
   wire n_105_288;
   wire n_105_289;
   wire n_105_290;
   wire n_105_291;
   wire n_105_292;
   wire n_105_293;
   wire n_105_294;
   wire n_105_295;
   wire n_105_296;
   wire n_105_297;
   wire n_105_298;
   wire n_105_299;
   wire n_105_300;
   wire n_105_301;
   wire n_105_302;
   wire n_105_303;
   wire n_105_304;
   wire n_105_305;
   wire n_105_306;
   wire n_105_307;
   wire n_105_308;
   wire n_105_309;
   wire n_105_310;
   wire n_105_311;
   wire n_105_312;
   wire n_105_313;
   wire n_105_314;
   wire n_105_315;
   wire n_105_316;
   wire n_105_317;
   wire n_105_318;
   wire n_105_319;
   wire n_106_0;
   wire n_106_1;
   wire n_106_2;
   wire n_106_3;
   wire n_106_4;
   wire n_106_5;
   wire n_106_6;
   wire n_106_7;
   wire n_106_8;
   wire n_106_9;
   wire n_106_10;
   wire n_106_11;
   wire n_106_12;
   wire n_106_13;
   wire [15:0]r1;
   wire n_108_0;
   wire n_109_0;
   wire n_109_1;
   wire n_109_2;
   wire n_109_3;
   wire n_109_4;
   wire n_109_5;
   wire n_109_6;
   wire n_109_7;
   wire n_109_8;
   wire n_109_9;
   wire n_109_10;
   wire n_109_11;
   wire n_109_12;
   wire n_109_13;
   wire n_109_14;
   wire n_110_0;
   wire n_110_1;
   wire n_110_2;
   wire n_112_0;
   wire n_112_1;
   wire n_112_2;
   wire n_112_3;
   wire n_112_4;
   wire n_112_5;
   wire n_112_6;
   wire n_112_7;
   wire n_112_8;
   wire n_112_9;
   wire n_112_10;
   wire n_112_11;
   wire n_112_12;
   wire n_112_13;
   wire n_112_14;
   wire n_112_15;
   wire n_112_16;
   wire n_112_17;
   wire n_112_18;
   wire n_112_19;
   wire n_112_20;
   wire n_112_21;
   wire n_112_22;
   wire n_112_23;
   wire n_112_24;
   wire n_112_25;
   wire n_112_26;
   wire n_112_27;
   wire n_112_28;
   wire n_112_29;
   wire n_112_30;
   wire n_112_31;
   wire n_112_32;
   wire n_112_33;
   wire n_112_34;
   wire n_112_35;
   wire n_112_36;
   wire n_112_37;
   wire n_112_38;
   wire n_112_39;
   wire n_112_40;
   wire n_112_41;
   wire n_112_42;
   wire n_112_43;
   wire n_112_44;
   wire n_112_45;
   wire n_112_46;
   wire n_112_47;
   wire n_112_48;
   wire n_112_49;
   wire n_112_50;
   wire n_112_51;
   wire n_112_52;
   wire n_112_53;
   wire n_112_54;
   wire n_112_55;
   wire n_112_56;
   wire n_112_57;
   wire n_112_58;
   wire n_112_59;
   wire n_112_60;
   wire n_112_61;
   wire n_112_62;
   wire n_112_63;
   wire n_112_64;
   wire n_112_65;
   wire n_112_66;
   wire n_112_67;
   wire n_112_68;
   wire n_112_69;
   wire n_112_70;
   wire n_112_71;
   wire n_112_72;
   wire n_112_73;
   wire n_112_74;
   wire n_112_75;
   wire n_112_76;
   wire n_112_77;
   wire n_112_78;
   wire n_112_79;
   wire n_112_80;
   wire n_112_81;
   wire n_112_82;
   wire n_112_83;
   wire n_112_84;
   wire n_112_85;
   wire n_112_86;
   wire n_112_87;
   wire n_112_88;
   wire n_112_89;
   wire n_112_90;
   wire n_112_91;
   wire n_112_92;
   wire n_112_93;
   wire n_112_94;
   wire n_112_95;
   wire n_112_96;
   wire n_112_97;
   wire n_112_98;
   wire n_112_99;
   wire n_112_100;
   wire n_112_101;
   wire n_112_102;
   wire n_112_103;
   wire n_112_104;
   wire n_112_105;
   wire n_112_106;
   wire n_112_107;
   wire n_112_108;
   wire n_112_109;
   wire n_112_110;
   wire n_112_111;
   wire n_112_112;
   wire n_112_113;
   wire n_112_114;
   wire n_112_115;
   wire n_112_116;
   wire n_112_117;
   wire n_112_118;
   wire n_112_119;
   wire n_112_120;
   wire n_112_121;
   wire n_112_122;
   wire n_112_123;
   wire n_112_124;
   wire n_112_125;
   wire n_112_126;
   wire n_112_127;
   wire n_112_128;
   wire n_112_129;
   wire n_112_130;
   wire n_112_131;
   wire n_112_132;
   wire n_112_133;
   wire n_112_134;
   wire n_112_135;
   wire n_112_136;
   wire n_112_137;
   wire n_112_138;
   wire n_112_139;
   wire n_112_140;
   wire n_112_141;
   wire n_112_142;
   wire n_112_143;
   wire n_112_144;
   wire n_112_145;
   wire n_112_146;
   wire n_112_147;
   wire n_112_148;
   wire n_112_149;
   wire n_112_150;
   wire n_112_151;
   wire n_112_152;
   wire n_112_153;
   wire n_112_154;
   wire n_112_155;
   wire n_112_156;
   wire n_112_157;
   wire n_112_158;
   wire n_112_159;
   wire n_112_160;
   wire n_112_161;
   wire n_112_162;
   wire n_112_163;
   wire n_112_164;
   wire n_112_165;
   wire n_112_166;
   wire n_112_167;
   wire n_112_168;
   wire n_112_169;
   wire n_112_170;
   wire n_112_171;
   wire n_112_172;
   wire n_112_173;
   wire n_112_174;
   wire n_112_175;
   wire n_112_176;
   wire n_112_177;
   wire n_112_178;
   wire n_112_179;
   wire n_112_180;
   wire n_112_181;
   wire n_112_182;
   wire n_112_183;
   wire n_112_184;
   wire n_112_185;
   wire n_112_186;
   wire n_112_187;
   wire n_112_188;
   wire n_112_189;
   wire n_112_190;
   wire n_112_191;
   wire n_112_192;
   wire n_112_193;
   wire n_112_194;
   wire n_112_195;
   wire n_112_196;
   wire n_112_197;
   wire n_112_198;
   wire n_112_199;
   wire n_112_200;
   wire n_112_201;
   wire n_112_202;
   wire n_112_203;
   wire n_112_204;
   wire n_112_205;
   wire n_112_206;
   wire n_112_207;
   wire n_112_208;
   wire n_112_209;
   wire n_112_210;
   wire n_112_211;
   wire n_112_212;
   wire n_112_213;
   wire n_112_214;
   wire n_112_215;
   wire n_112_216;
   wire n_112_217;
   wire n_112_218;
   wire n_112_219;
   wire n_112_220;
   wire n_112_221;
   wire n_112_222;
   wire n_112_223;
   wire n_112_224;
   wire n_112_225;
   wire n_112_226;
   wire n_112_227;
   wire n_112_228;
   wire n_112_229;
   wire n_112_230;
   wire n_112_231;
   wire n_112_232;
   wire n_112_233;
   wire n_112_234;
   wire n_112_235;
   wire n_112_236;
   wire n_112_237;
   wire n_112_238;
   wire n_112_239;
   wire n_112_240;
   wire n_112_241;
   wire n_112_242;
   wire n_112_243;
   wire n_112_244;
   wire n_112_245;
   wire n_112_246;
   wire n_112_247;
   wire n_112_248;
   wire n_112_249;
   wire n_112_250;
   wire n_112_251;
   wire n_112_252;
   wire n_112_253;
   wire n_112_254;
   wire n_112_255;
   wire n_112_256;
   wire n_112_257;
   wire n_112_258;
   wire n_112_259;
   wire n_112_260;
   wire n_112_261;
   wire n_112_262;
   wire n_112_263;
   wire n_112_264;
   wire n_112_265;
   wire n_112_266;
   wire n_112_267;
   wire n_112_268;
   wire n_112_269;
   wire n_112_270;
   wire n_112_271;
   wire n_112_272;
   wire n_112_273;
   wire n_112_274;
   wire n_112_275;
   wire n_112_276;
   wire n_112_277;
   wire n_112_278;
   wire n_112_279;
   wire n_112_280;
   wire n_112_281;
   wire n_112_282;
   wire n_112_283;
   wire n_112_284;
   wire n_112_285;
   wire n_112_286;
   wire n_112_287;
   wire n_112_288;
   wire n_112_289;
   wire n_112_290;
   wire n_112_291;
   wire n_112_292;
   wire n_112_293;
   wire n_112_294;
   wire n_112_295;
   wire n_112_296;
   wire n_112_297;
   wire n_112_298;
   wire n_112_299;
   wire n_112_300;
   wire n_112_301;
   wire n_112_302;
   wire n_112_303;
   wire n_112_304;
   wire n_112_305;
   wire n_112_306;
   wire n_112_307;
   wire n_112_308;
   wire n_112_309;
   wire n_112_310;
   wire n_112_311;
   wire n_112_312;
   wire n_112_313;
   wire n_112_314;
   wire n_112_315;
   wire n_112_316;
   wire n_112_317;
   wire n_112_318;
   wire n_112_319;

   assign pc_sw[7] = reg_dest_val[7];
   assign pc_sw[6] = reg_dest_val[6];
   assign pc_sw[5] = reg_dest_val[5];
   assign pc_sw[4] = reg_dest_val[4];
   assign pc_sw[3] = reg_dest_val[3];
   assign pc_sw[2] = reg_dest_val[2];
   assign pc_sw[1] = reg_dest_val[1];
   assign pc_sw[0] = reg_dest_val[0];

   INV_X1_LVT i_6_0 (.A(reg_sr_clr), .ZN(n_6_0));
   AOI21_X1_LVT i_1_0 (.A(reg_sr_wr), .B1(inst_dest[2]), .B2(reg_dest_wr), 
      .ZN(n_1_0));
   INV_X1_LVT i_1_1 (.A(n_1_0), .ZN(r2_wr));
   INV_X1_LVT i_2_0 (.A(r2_wr), .ZN(n_2_0));
   AOI22_X1_LVT i_2_3 (.A1(n_2_0), .A2(n_7), .B1(r2_wr), .B2(reg_dest_val[4]), 
      .ZN(n_2_2));
   INV_X1_LVT i_2_4 (.A(n_2_2), .ZN(r2_nxt[4]));
   AND2_X1_LVT i_6_5 (.A1(n_6_0), .A2(r2_nxt[4]), .ZN(n_17));
   INV_X1_LVT i_3_0 (.A(puc_rst), .ZN(n_8));
   DFFR_X1_LVT \r2_reg[4]  (.D(n_17), .RN(n_8), .CK(mclk), .Q(n_7), .QN());
   AOI21_X1_LVT i_8_0 (.A(n_7), .B1(r2_nxt[4]), .B2(r2_wr), .ZN(n_8_0));
   INV_X1_LVT i_8_1 (.A(n_8_0), .ZN(cpuoff));
   AOI22_X1_LVT i_2_1 (.A1(n_2_0), .A2(gie), .B1(reg_dest_val[3]), .B2(r2_wr), 
      .ZN(n_2_1));
   INV_X1_LVT i_2_2 (.A(n_2_1), .ZN(r2_nxt[3]));
   AND2_X1_LVT i_6_4 (.A1(n_6_0), .A2(r2_nxt[3]), .ZN(n_16));
   DFFR_X1_LVT \r2_reg[3]  (.D(n_16), .RN(n_8), .CK(mclk), .Q(gie), .QN());
   DFFR_X1_LVT \r2_reg[5]  (.D(1'b0), .RN(n_8), .CK(mclk), .Q(oscoff), .QN());
   INV_X1_LVT i_0_0 (.A(inst_bw), .ZN(n_0_0));
   AND2_X1_LVT i_0_8 (.A1(n_0_0), .A2(reg_dest_val[15]), .ZN(pc_sw[15]));
   AND2_X1_LVT i_0_7 (.A1(n_0_0), .A2(reg_dest_val[14]), .ZN(pc_sw[14]));
   AND2_X1_LVT i_0_6 (.A1(n_0_0), .A2(reg_dest_val[13]), .ZN(pc_sw[13]));
   AND2_X1_LVT i_0_5 (.A1(n_0_0), .A2(reg_dest_val[12]), .ZN(pc_sw[12]));
   AND2_X1_LVT i_0_4 (.A1(n_0_0), .A2(reg_dest_val[11]), .ZN(pc_sw[11]));
   AND2_X1_LVT i_0_3 (.A1(n_0_0), .A2(reg_dest_val[10]), .ZN(pc_sw[10]));
   AND2_X1_LVT i_0_2 (.A1(n_0_0), .A2(reg_dest_val[9]), .ZN(pc_sw[9]));
   AND2_X1_LVT i_0_1 (.A1(n_0_0), .A2(reg_dest_val[8]), .ZN(pc_sw[8]));
   AOI21_X1_LVT i_9_0 (.A(reg_pc_call), .B1(inst_dest[0]), .B2(reg_dest_wr), 
      .ZN(n_9_0));
   INV_X1_LVT i_9_1 (.A(n_9_0), .ZN(pc_sw_wr));
   AND2_X1_LVT i_19_0 (.A1(inst_dest[4]), .A2(reg_dest_wr), .ZN(r4_wr));
   INV_X1_LVT i_24_0 (.A(r4_wr), .ZN(n_24_0));
   INV_X1_LVT i_17_0 (.A(inst_src[4]), .ZN(n_17_0));
   NOR2_X1_LVT i_17_1 (.A1(n_17_0), .A2(reg_sr_clr), .ZN(n_24));
   NAND2_X1_LVT i_105_315 (.A1(n_24), .A2(r4[15]), .ZN(n_105_300));
   INV_X1_LVT i_14_0 (.A(inst_src[3]), .ZN(n_14_0));
   NOR2_X1_LVT i_14_1 (.A1(n_14_0), .A2(reg_sr_clr), .ZN(n_22));
   AND2_X1_LVT i_15_0 (.A1(inst_dest[3]), .A2(reg_dest_wr), .ZN(r3_wr));
   CLKGATETST_X1_LVT clk_gate_r3_reg (.CK(mclk), .E(r3_wr), .SE(1'b0), .GCK(n_23));
   DFFR_X1_LVT \r3_reg[15]  (.D(pc_sw[15]), .RN(n_8), .CK(n_23), .Q(r3[15]), 
      .QN());
   NAND2_X1_LVT i_105_316 (.A1(n_22), .A2(r3[15]), .ZN(n_105_301));
   INV_X1_LVT i_13_1 (.A(inst_src[2]), .ZN(n_13_1));
   INV_X1_LVT i_13_0 (.A(reg_sr_clr), .ZN(n_13_0));
   NAND2_X1_LVT i_13_2 (.A1(n_13_1), .A2(n_13_0), .ZN(n_21));
   DFFR_X1_LVT \r2_reg[15]  (.D(1'b0), .RN(n_8), .CK(mclk), .Q(n_0), .QN());
   NAND2_X1_LVT i_105_317 (.A1(n_21), .A2(n_0), .ZN(n_105_302));
   INV_X1_LVT i_10_0 (.A(inst_src[1]), .ZN(n_10_0));
   NOR2_X1_LVT i_10_1 (.A1(n_10_0), .A2(reg_sr_clr), .ZN(inst_src_in));
   AND2_X1_LVT i_12_0 (.A1(inst_dest[1]), .A2(reg_dest_wr), .ZN(r1_wr));
   INV_X1_LVT i_108_1 (.A(reg_sp_wr), .ZN(n_108_0));
   NOR2_X1_LVT i_108_2 (.A1(n_108_0), .A2(r1_wr), .ZN(n_272));
   NOR2_X1_LVT i_108_0 (.A1(reg_sp_wr), .A2(r1_wr), .ZN(n_271));
   AOI22_X1_LVT i_24_27 (.A1(n_24_0), .A2(reg_incr_val[13]), .B1(r4_wr), 
      .B2(pc_sw[13]), .ZN(n_24_14));
   INV_X1_LVT i_24_28 (.A(n_24_14), .ZN(n_41));
   AND2_X1_LVT i_18_0 (.A1(n_24), .A2(reg_incr), .ZN(r4_inc));
   INV_X1_LVT i_25_1 (.A(r4_inc), .ZN(n_25_1));
   INV_X1_LVT i_25_0 (.A(r4_wr), .ZN(n_25_0));
   NAND2_X1_LVT i_25_2 (.A1(n_25_1), .A2(n_25_0), .ZN(n_44));
   CLKGATETST_X1_LVT clk_gate_r4_reg (.CK(mclk), .E(n_44), .SE(1'b0), .GCK(n_27));
   DFFR_X1_LVT \r4_reg[13]  (.D(n_41), .RN(n_8), .CK(n_27), .Q(r4[13]), .QN());
   NAND2_X1_LVT i_105_273 (.A1(n_24), .A2(r4[13]), .ZN(n_105_260));
   DFFR_X1_LVT \r3_reg[13]  (.D(pc_sw[13]), .RN(n_8), .CK(n_23), .Q(r3[13]), 
      .QN());
   NAND2_X1_LVT i_105_274 (.A1(n_22), .A2(r3[13]), .ZN(n_105_261));
   DFFR_X1_LVT \r2_reg[13]  (.D(1'b0), .RN(n_8), .CK(mclk), .Q(n_2), .QN());
   NAND2_X1_LVT i_105_275 (.A1(n_21), .A2(n_2), .ZN(n_105_262));
   AOI22_X1_LVT i_24_23 (.A1(n_24_0), .A2(reg_incr_val[11]), .B1(r4_wr), 
      .B2(pc_sw[11]), .ZN(n_24_12));
   INV_X1_LVT i_24_24 (.A(n_24_12), .ZN(n_39));
   DFFR_X1_LVT \r4_reg[11]  (.D(n_39), .RN(n_8), .CK(n_27), .Q(r4[11]), .QN());
   NAND2_X1_LVT i_105_231 (.A1(n_24), .A2(r4[11]), .ZN(n_105_220));
   DFFR_X1_LVT \r3_reg[11]  (.D(pc_sw[11]), .RN(n_8), .CK(n_23), .Q(r3[11]), 
      .QN());
   NAND2_X1_LVT i_105_232 (.A1(n_22), .A2(r3[11]), .ZN(n_105_221));
   DFFR_X1_LVT \r2_reg[11]  (.D(1'b0), .RN(n_8), .CK(mclk), .Q(n_4), .QN());
   NAND2_X1_LVT i_105_233 (.A1(n_21), .A2(n_4), .ZN(n_105_222));
   AOI22_X1_LVT i_24_19 (.A1(n_24_0), .A2(reg_incr_val[9]), .B1(r4_wr), .B2(
      pc_sw[9]), .ZN(n_24_10));
   INV_X1_LVT i_24_20 (.A(n_24_10), .ZN(n_37));
   DFFR_X1_LVT \r4_reg[9]  (.D(n_37), .RN(n_8), .CK(n_27), .Q(r4[9]), .QN());
   NAND2_X1_LVT i_105_189 (.A1(n_24), .A2(r4[9]), .ZN(n_105_180));
   DFFR_X1_LVT \r3_reg[9]  (.D(pc_sw[9]), .RN(n_8), .CK(n_23), .Q(r3[9]), .QN());
   NAND2_X1_LVT i_105_190 (.A1(n_22), .A2(r3[9]), .ZN(n_105_181));
   DFFR_X1_LVT \r2_reg[9]  (.D(1'b0), .RN(n_8), .CK(mclk), .Q(n_6), .QN());
   NAND2_X1_LVT i_105_191 (.A1(n_21), .A2(n_6), .ZN(n_105_182));
   AOI22_X1_LVT i_24_15 (.A1(n_24_0), .A2(reg_incr_val[7]), .B1(r4_wr), .B2(
      reg_dest_val[7]), .ZN(n_24_8));
   INV_X1_LVT i_24_16 (.A(n_24_8), .ZN(n_35));
   DFFR_X1_LVT \r4_reg[7]  (.D(n_35), .RN(n_8), .CK(n_27), .Q(r4[7]), .QN());
   NAND2_X1_LVT i_105_147 (.A1(n_24), .A2(r4[7]), .ZN(n_105_140));
   DFFR_X1_LVT \r3_reg[7]  (.D(reg_dest_val[7]), .RN(n_8), .CK(n_23), .Q(r3[7]), 
      .QN());
   NAND2_X1_LVT i_105_148 (.A1(n_22), .A2(r3[7]), .ZN(n_105_141));
   AOI22_X1_LVT i_2_7 (.A1(n_2_0), .A2(scg1), .B1(r2_wr), .B2(reg_dest_val[7]), 
      .ZN(n_2_4));
   INV_X1_LVT i_2_8 (.A(n_2_4), .ZN(r2_nxt[7]));
   AND2_X1_LVT i_6_7 (.A1(n_6_0), .A2(r2_nxt[7]), .ZN(n_19));
   DFFR_X1_LVT \r2_reg[7]  (.D(n_19), .RN(n_8), .CK(mclk), .Q(scg1), .QN());
   NAND2_X1_LVT i_105_149 (.A1(n_21), .A2(scg1), .ZN(n_105_142));
   AOI22_X1_LVT i_24_11 (.A1(n_24_0), .A2(reg_incr_val[5]), .B1(r4_wr), .B2(
      reg_dest_val[5]), .ZN(n_24_6));
   INV_X1_LVT i_24_12 (.A(n_24_6), .ZN(n_33));
   DFFR_X1_LVT \r4_reg[5]  (.D(n_33), .RN(n_8), .CK(n_27), .Q(r4[5]), .QN());
   NAND2_X1_LVT i_105_105 (.A1(n_24), .A2(r4[5]), .ZN(n_105_100));
   DFFR_X1_LVT \r3_reg[5]  (.D(reg_dest_val[5]), .RN(n_8), .CK(n_23), .Q(r3[5]), 
      .QN());
   NAND2_X1_LVT i_105_106 (.A1(n_22), .A2(r3[5]), .ZN(n_105_101));
   NAND2_X1_LVT i_105_107 (.A1(n_21), .A2(oscoff), .ZN(n_105_102));
   AOI22_X1_LVT i_24_7 (.A1(n_24_0), .A2(reg_incr_val[3]), .B1(r4_wr), .B2(
      reg_dest_val[3]), .ZN(n_24_4));
   INV_X1_LVT i_24_8 (.A(n_24_4), .ZN(n_31));
   DFFR_X1_LVT \r4_reg[3]  (.D(n_31), .RN(n_8), .CK(n_27), .Q(r4[3]), .QN());
   NAND2_X1_LVT i_105_63 (.A1(n_24), .A2(r4[3]), .ZN(n_105_60));
   DFFR_X1_LVT \r3_reg[3]  (.D(reg_dest_val[3]), .RN(n_8), .CK(n_23), .Q(r3[3]), 
      .QN());
   NAND2_X1_LVT i_105_64 (.A1(n_22), .A2(r3[3]), .ZN(n_105_61));
   NAND2_X1_LVT i_105_65 (.A1(n_21), .A2(gie), .ZN(n_105_62));
   INV_X1_LVT i_20_0 (.A(inst_bw), .ZN(n_20_0));
   NOR2_X1_LVT i_20_1 (.A1(n_20_0), .A2(inst_src_in), .ZN(n_25));
   INV_X1_LVT i_21_0 (.A(n_25), .ZN(n_26));
   AOI22_X1_LVT i_24_3 (.A1(n_24_0), .A2(reg_incr_val[1]), .B1(r4_wr), .B2(
      reg_dest_val[1]), .ZN(n_24_2));
   INV_X1_LVT i_24_4 (.A(n_24_2), .ZN(n_29));
   DFFR_X1_LVT \r4_reg[1]  (.D(n_29), .RN(n_8), .CK(n_27), .Q(r4[1]), .QN());
   NAND2_X1_LVT i_105_21 (.A1(n_24), .A2(r4[1]), .ZN(n_105_20));
   DFFR_X1_LVT \r3_reg[1]  (.D(reg_dest_val[1]), .RN(n_8), .CK(n_23), .Q(r3[1]), 
      .QN());
   NAND2_X1_LVT i_105_22 (.A1(n_22), .A2(r3[1]), .ZN(n_105_21));
   INV_X1_LVT i_5_0 (.A(r2_wr), .ZN(n_5_0));
   INV_X1_LVT i_5_6 (.A(alu_stat_wr[1]), .ZN(n_5_5));
   NAND3_X1_LVT i_5_7 (.A1(n_5_0), .A2(n_5_5), .A3(status[1]), .ZN(n_5_6));
   NAND3_X1_LVT i_5_8 (.A1(n_5_5), .A2(r2_wr), .A3(reg_dest_val[1]), .ZN(n_5_7));
   NAND2_X1_LVT i_5_9 (.A1(alu_stat[1]), .A2(alu_stat_wr[1]), .ZN(n_5_8));
   NAND3_X1_LVT i_5_10 (.A1(n_5_6), .A2(n_5_7), .A3(n_5_8), .ZN(n_10));
   AND2_X1_LVT i_6_2 (.A1(n_6_0), .A2(n_10), .ZN(n_14));
   DFFR_X1_LVT \r2_reg[1]  (.D(n_14), .RN(n_8), .CK(mclk), .Q(status[1]), .QN());
   NAND2_X1_LVT i_105_23 (.A1(n_21), .A2(status[1]), .ZN(n_105_22));
   INV_X1_LVT i_106_0 (.A(reg_src[1]), .ZN(n_255));
   AOI222_X1_LVT i_109_0 (.A1(r1_wr), .A2(reg_dest_val[1]), .B1(n_272), .B2(
      reg_sp_val[1]), .C1(n_271), .C2(n_255), .ZN(n_109_0));
   INV_X1_LVT i_109_1 (.A(n_109_0), .ZN(n_273));
   INV_X1_LVT i_110_0 (.A(reg_sp_wr), .ZN(n_110_0));
   INV_X1_LVT i_110_1 (.A(r1_wr), .ZN(n_110_1));
   AND2_X1_LVT i_11_0 (.A1(inst_src_in), .A2(reg_incr), .ZN(r1_inc));
   NAND3_X1_LVT i_110_2 (.A1(n_110_0), .A2(n_110_1), .A3(r1_inc), .ZN(n_110_2));
   NAND3_X1_LVT i_110_3 (.A1(n_110_2), .A2(n_110_0), .A3(n_110_1), .ZN(n_288));
   CLKGATETST_X1_LVT clk_gate_r1_reg (.CK(mclk), .E(n_288), .SE(1'b0), .GCK(
      n_270));
   DFFR_X1_LVT \r1_reg[1]  (.D(n_273), .RN(n_8), .CK(n_270), .Q(r1[1]), .QN());
   NAND2_X1_LVT i_105_24 (.A1(inst_src_in), .A2(r1[1]), .ZN(n_105_23));
   NAND4_X1_LVT i_105_25 (.A1(n_105_20), .A2(n_105_21), .A3(n_105_22), .A4(
      n_105_23), .ZN(n_105_24));
   INV_X1_LVT i_76_0 (.A(inst_src[12]), .ZN(n_76_0));
   NOR2_X1_LVT i_76_1 (.A1(n_76_0), .A2(reg_sr_clr), .ZN(n_178));
   AND2_X1_LVT i_78_0 (.A1(inst_dest[12]), .A2(reg_dest_wr), .ZN(r12_wr));
   INV_X1_LVT i_80_0 (.A(r12_wr), .ZN(n_80_0));
   AOI22_X1_LVT i_80_3 (.A1(n_80_0), .A2(reg_incr_val[1]), .B1(r12_wr), .B2(
      reg_dest_val[1]), .ZN(n_80_2));
   INV_X1_LVT i_80_4 (.A(n_80_2), .ZN(n_181));
   AND2_X1_LVT i_77_0 (.A1(n_178), .A2(reg_incr), .ZN(r12_inc));
   INV_X1_LVT i_81_1 (.A(r12_inc), .ZN(n_81_1));
   INV_X1_LVT i_81_0 (.A(r12_wr), .ZN(n_81_0));
   NAND2_X1_LVT i_81_2 (.A1(n_81_1), .A2(n_81_0), .ZN(n_196));
   CLKGATETST_X1_LVT clk_gate_r12_reg (.CK(mclk), .E(n_196), .SE(1'b0), .GCK(
      n_179));
   DFFR_X1_LVT \r12_reg[1]  (.D(n_181), .RN(n_8), .CK(n_179), .Q(r12[1]), .QN());
   NAND2_X1_LVT i_105_26 (.A1(n_178), .A2(r12[1]), .ZN(n_105_25));
   INV_X1_LVT i_69_0 (.A(inst_src[11]), .ZN(n_69_0));
   NOR2_X1_LVT i_69_1 (.A1(n_69_0), .A2(reg_sr_clr), .ZN(n_159));
   AND2_X1_LVT i_71_0 (.A1(inst_dest[11]), .A2(reg_dest_wr), .ZN(r11_wr));
   INV_X1_LVT i_73_0 (.A(r11_wr), .ZN(n_73_0));
   AOI22_X1_LVT i_73_3 (.A1(n_73_0), .A2(reg_incr_val[1]), .B1(r11_wr), .B2(
      reg_dest_val[1]), .ZN(n_73_2));
   INV_X1_LVT i_73_4 (.A(n_73_2), .ZN(n_162));
   AND2_X1_LVT i_70_0 (.A1(n_159), .A2(reg_incr), .ZN(r11_inc));
   INV_X1_LVT i_74_1 (.A(r11_inc), .ZN(n_74_1));
   INV_X1_LVT i_74_0 (.A(r11_wr), .ZN(n_74_0));
   NAND2_X1_LVT i_74_2 (.A1(n_74_1), .A2(n_74_0), .ZN(n_177));
   CLKGATETST_X1_LVT clk_gate_r11_reg (.CK(mclk), .E(n_177), .SE(1'b0), .GCK(
      n_160));
   DFFR_X1_LVT \r11_reg[1]  (.D(n_162), .RN(n_8), .CK(n_160), .Q(r11[1]), .QN());
   NAND2_X1_LVT i_105_27 (.A1(n_159), .A2(r11[1]), .ZN(n_105_26));
   INV_X1_LVT i_62_0 (.A(inst_src[10]), .ZN(n_62_0));
   NOR2_X1_LVT i_62_1 (.A1(n_62_0), .A2(reg_sr_clr), .ZN(n_140));
   AND2_X1_LVT i_64_0 (.A1(inst_dest[10]), .A2(reg_dest_wr), .ZN(r10_wr));
   INV_X1_LVT i_66_0 (.A(r10_wr), .ZN(n_66_0));
   AOI22_X1_LVT i_66_3 (.A1(n_66_0), .A2(reg_incr_val[1]), .B1(r10_wr), .B2(
      reg_dest_val[1]), .ZN(n_66_2));
   INV_X1_LVT i_66_4 (.A(n_66_2), .ZN(n_143));
   AND2_X1_LVT i_63_0 (.A1(n_140), .A2(reg_incr), .ZN(r10_inc));
   INV_X1_LVT i_67_1 (.A(r10_inc), .ZN(n_67_1));
   INV_X1_LVT i_67_0 (.A(r10_wr), .ZN(n_67_0));
   NAND2_X1_LVT i_67_2 (.A1(n_67_1), .A2(n_67_0), .ZN(n_158));
   CLKGATETST_X1_LVT clk_gate_r10_reg (.CK(mclk), .E(n_158), .SE(1'b0), .GCK(
      n_141));
   DFFR_X1_LVT \r10_reg[1]  (.D(n_143), .RN(n_8), .CK(n_141), .Q(r10[1]), .QN());
   NAND2_X1_LVT i_105_28 (.A1(n_140), .A2(r10[1]), .ZN(n_105_27));
   INV_X1_LVT i_55_0 (.A(inst_src[9]), .ZN(n_55_0));
   NOR2_X1_LVT i_55_1 (.A1(n_55_0), .A2(reg_sr_clr), .ZN(n_121));
   AND2_X1_LVT i_57_0 (.A1(inst_dest[9]), .A2(reg_dest_wr), .ZN(r9_wr));
   INV_X1_LVT i_59_0 (.A(r9_wr), .ZN(n_59_0));
   AOI22_X1_LVT i_59_3 (.A1(n_59_0), .A2(reg_incr_val[1]), .B1(r9_wr), .B2(
      reg_dest_val[1]), .ZN(n_59_2));
   INV_X1_LVT i_59_4 (.A(n_59_2), .ZN(n_124));
   AND2_X1_LVT i_56_0 (.A1(n_121), .A2(reg_incr), .ZN(r9_inc));
   INV_X1_LVT i_60_1 (.A(r9_inc), .ZN(n_60_1));
   INV_X1_LVT i_60_0 (.A(r9_wr), .ZN(n_60_0));
   NAND2_X1_LVT i_60_2 (.A1(n_60_1), .A2(n_60_0), .ZN(n_139));
   CLKGATETST_X1_LVT clk_gate_r9_reg (.CK(mclk), .E(n_139), .SE(1'b0), .GCK(
      n_122));
   DFFR_X1_LVT \r9_reg[1]  (.D(n_124), .RN(n_8), .CK(n_122), .Q(r9[1]), .QN());
   NAND2_X1_LVT i_105_29 (.A1(n_121), .A2(r9[1]), .ZN(n_105_28));
   NAND4_X1_LVT i_105_30 (.A1(n_105_25), .A2(n_105_26), .A3(n_105_27), .A4(
      n_105_28), .ZN(n_105_29));
   INV_X1_LVT i_48_0 (.A(inst_src[8]), .ZN(n_48_0));
   NOR2_X1_LVT i_48_1 (.A1(n_48_0), .A2(reg_sr_clr), .ZN(n_102));
   AND2_X1_LVT i_50_0 (.A1(inst_dest[8]), .A2(reg_dest_wr), .ZN(r8_wr));
   INV_X1_LVT i_52_0 (.A(r8_wr), .ZN(n_52_0));
   AOI22_X1_LVT i_52_3 (.A1(n_52_0), .A2(reg_incr_val[1]), .B1(r8_wr), .B2(
      reg_dest_val[1]), .ZN(n_52_2));
   INV_X1_LVT i_52_4 (.A(n_52_2), .ZN(n_105));
   AND2_X1_LVT i_49_0 (.A1(n_102), .A2(reg_incr), .ZN(r8_inc));
   INV_X1_LVT i_53_1 (.A(r8_inc), .ZN(n_53_1));
   INV_X1_LVT i_53_0 (.A(r8_wr), .ZN(n_53_0));
   NAND2_X1_LVT i_53_2 (.A1(n_53_1), .A2(n_53_0), .ZN(n_120));
   CLKGATETST_X1_LVT clk_gate_r8_reg (.CK(mclk), .E(n_120), .SE(1'b0), .GCK(
      n_103));
   DFFR_X1_LVT \r8_reg[1]  (.D(n_105), .RN(n_8), .CK(n_103), .Q(r8[1]), .QN());
   NAND2_X1_LVT i_105_31 (.A1(n_102), .A2(r8[1]), .ZN(n_105_30));
   INV_X1_LVT i_41_0 (.A(inst_src[7]), .ZN(n_41_0));
   NOR2_X1_LVT i_41_1 (.A1(n_41_0), .A2(reg_sr_clr), .ZN(n_83));
   AND2_X1_LVT i_43_0 (.A1(inst_dest[7]), .A2(reg_dest_wr), .ZN(r7_wr));
   INV_X1_LVT i_45_0 (.A(r7_wr), .ZN(n_45_0));
   AOI22_X1_LVT i_45_3 (.A1(n_45_0), .A2(reg_incr_val[1]), .B1(r7_wr), .B2(
      reg_dest_val[1]), .ZN(n_45_2));
   INV_X1_LVT i_45_4 (.A(n_45_2), .ZN(n_86));
   AND2_X1_LVT i_42_0 (.A1(n_83), .A2(reg_incr), .ZN(r7_inc));
   INV_X1_LVT i_46_1 (.A(r7_inc), .ZN(n_46_1));
   INV_X1_LVT i_46_0 (.A(r7_wr), .ZN(n_46_0));
   NAND2_X1_LVT i_46_2 (.A1(n_46_1), .A2(n_46_0), .ZN(n_101));
   CLKGATETST_X1_LVT clk_gate_r7_reg (.CK(mclk), .E(n_101), .SE(1'b0), .GCK(n_84));
   DFFR_X1_LVT \r7_reg[1]  (.D(n_86), .RN(n_8), .CK(n_84), .Q(r7[1]), .QN());
   NAND2_X1_LVT i_105_32 (.A1(n_83), .A2(r7[1]), .ZN(n_105_31));
   INV_X1_LVT i_34_0 (.A(inst_src[6]), .ZN(n_34_0));
   NOR2_X1_LVT i_34_1 (.A1(n_34_0), .A2(reg_sr_clr), .ZN(n_64));
   AND2_X1_LVT i_36_0 (.A1(inst_dest[6]), .A2(reg_dest_wr), .ZN(r6_wr));
   INV_X1_LVT i_38_0 (.A(r6_wr), .ZN(n_38_0));
   AOI22_X1_LVT i_38_3 (.A1(n_38_0), .A2(reg_incr_val[1]), .B1(r6_wr), .B2(
      reg_dest_val[1]), .ZN(n_38_2));
   INV_X1_LVT i_38_4 (.A(n_38_2), .ZN(n_67));
   AND2_X1_LVT i_35_0 (.A1(n_64), .A2(reg_incr), .ZN(r6_inc));
   INV_X1_LVT i_39_1 (.A(r6_inc), .ZN(n_39_1));
   INV_X1_LVT i_39_0 (.A(r6_wr), .ZN(n_39_0));
   NAND2_X1_LVT i_39_2 (.A1(n_39_1), .A2(n_39_0), .ZN(n_82));
   CLKGATETST_X1_LVT clk_gate_r6_reg (.CK(mclk), .E(n_82), .SE(1'b0), .GCK(n_65));
   DFFR_X1_LVT \r6_reg[1]  (.D(n_67), .RN(n_8), .CK(n_65), .Q(r6[1]), .QN());
   NAND2_X1_LVT i_105_33 (.A1(n_64), .A2(r6[1]), .ZN(n_105_32));
   INV_X1_LVT i_27_0 (.A(inst_src[5]), .ZN(n_27_0));
   NOR2_X1_LVT i_27_1 (.A1(n_27_0), .A2(reg_sr_clr), .ZN(n_45));
   AND2_X1_LVT i_29_0 (.A1(inst_dest[5]), .A2(reg_dest_wr), .ZN(r5_wr));
   INV_X1_LVT i_31_0 (.A(r5_wr), .ZN(n_31_0));
   AOI22_X1_LVT i_31_3 (.A1(n_31_0), .A2(reg_incr_val[1]), .B1(r5_wr), .B2(
      reg_dest_val[1]), .ZN(n_31_2));
   INV_X1_LVT i_31_4 (.A(n_31_2), .ZN(n_48));
   AND2_X1_LVT i_28_0 (.A1(n_45), .A2(reg_incr), .ZN(r5_inc));
   INV_X1_LVT i_32_1 (.A(r5_inc), .ZN(n_32_1));
   INV_X1_LVT i_32_0 (.A(r5_wr), .ZN(n_32_0));
   NAND2_X1_LVT i_32_2 (.A1(n_32_1), .A2(n_32_0), .ZN(n_63));
   CLKGATETST_X1_LVT clk_gate_r5_reg (.CK(mclk), .E(n_63), .SE(1'b0), .GCK(n_46));
   DFFR_X1_LVT \r5_reg[1]  (.D(n_48), .RN(n_8), .CK(n_46), .Q(r5[1]), .QN());
   NAND2_X1_LVT i_105_34 (.A1(n_45), .A2(r5[1]), .ZN(n_105_33));
   NAND4_X1_LVT i_105_35 (.A1(n_105_30), .A2(n_105_31), .A3(n_105_32), .A4(
      n_105_33), .ZN(n_105_34));
   INV_X1_LVT i_83_0 (.A(inst_src[13]), .ZN(n_83_0));
   NOR2_X1_LVT i_83_1 (.A1(n_83_0), .A2(reg_sr_clr), .ZN(n_197));
   AND2_X1_LVT i_85_0 (.A1(inst_dest[13]), .A2(reg_dest_wr), .ZN(r13_wr));
   INV_X1_LVT i_87_0 (.A(r13_wr), .ZN(n_87_0));
   AOI22_X1_LVT i_87_3 (.A1(n_87_0), .A2(reg_incr_val[1]), .B1(r13_wr), .B2(
      reg_dest_val[1]), .ZN(n_87_2));
   INV_X1_LVT i_87_4 (.A(n_87_2), .ZN(n_200));
   AND2_X1_LVT i_84_0 (.A1(n_197), .A2(reg_incr), .ZN(r13_inc));
   INV_X1_LVT i_88_1 (.A(r13_inc), .ZN(n_88_1));
   INV_X1_LVT i_88_0 (.A(r13_wr), .ZN(n_88_0));
   NAND2_X1_LVT i_88_2 (.A1(n_88_1), .A2(n_88_0), .ZN(n_215));
   CLKGATETST_X1_LVT clk_gate_r13_reg (.CK(mclk), .E(n_215), .SE(1'b0), .GCK(
      n_198));
   DFFR_X1_LVT \r13_reg[1]  (.D(n_200), .RN(n_8), .CK(n_198), .Q(r13[1]), .QN());
   AND2_X1_LVT i_105_36 (.A1(n_197), .A2(r13[1]), .ZN(n_105_35));
   NOR4_X1_LVT i_105_37 (.A1(n_105_24), .A2(n_105_29), .A3(n_105_34), .A4(
      n_105_35), .ZN(n_105_36));
   INV_X1_LVT i_104_0 (.A(inst_src[0]), .ZN(n_104_0));
   NOR2_X1_LVT i_104_1 (.A1(n_104_0), .A2(reg_sr_clr), .ZN(n_254));
   NAND2_X1_LVT i_105_38 (.A1(n_254), .A2(pc[1]), .ZN(n_105_37));
   INV_X1_LVT i_97_0 (.A(inst_src[15]), .ZN(n_97_0));
   NOR2_X1_LVT i_97_1 (.A1(n_97_0), .A2(reg_sr_clr), .ZN(n_235));
   AND2_X1_LVT i_99_0 (.A1(inst_dest[15]), .A2(reg_dest_wr), .ZN(r15_wr));
   INV_X1_LVT i_101_0 (.A(r15_wr), .ZN(n_101_0));
   AOI22_X1_LVT i_101_3 (.A1(n_101_0), .A2(reg_incr_val[1]), .B1(r15_wr), 
      .B2(reg_dest_val[1]), .ZN(n_101_2));
   INV_X1_LVT i_101_4 (.A(n_101_2), .ZN(n_238));
   AND2_X1_LVT i_98_0 (.A1(n_235), .A2(reg_incr), .ZN(r15_inc));
   INV_X1_LVT i_102_1 (.A(r15_inc), .ZN(n_102_1));
   INV_X1_LVT i_102_0 (.A(r15_wr), .ZN(n_102_0));
   NAND2_X1_LVT i_102_2 (.A1(n_102_1), .A2(n_102_0), .ZN(n_253));
   CLKGATETST_X1_LVT clk_gate_r15_reg (.CK(mclk), .E(n_253), .SE(1'b0), .GCK(
      n_236));
   DFFR_X1_LVT \r15_reg[1]  (.D(n_238), .RN(n_8), .CK(n_236), .Q(r15[1]), .QN());
   NAND2_X1_LVT i_105_39 (.A1(n_235), .A2(r15[1]), .ZN(n_105_38));
   INV_X1_LVT i_90_0 (.A(inst_src[14]), .ZN(n_90_0));
   NOR2_X1_LVT i_90_1 (.A1(n_90_0), .A2(reg_sr_clr), .ZN(n_216));
   AND2_X1_LVT i_92_0 (.A1(inst_dest[14]), .A2(reg_dest_wr), .ZN(r14_wr));
   INV_X1_LVT i_94_0 (.A(r14_wr), .ZN(n_94_0));
   AOI22_X1_LVT i_94_3 (.A1(n_94_0), .A2(reg_incr_val[1]), .B1(r14_wr), .B2(
      reg_dest_val[1]), .ZN(n_94_2));
   INV_X1_LVT i_94_4 (.A(n_94_2), .ZN(n_219));
   AND2_X1_LVT i_91_0 (.A1(n_216), .A2(reg_incr), .ZN(r14_inc));
   INV_X1_LVT i_95_1 (.A(r14_inc), .ZN(n_95_1));
   INV_X1_LVT i_95_0 (.A(r14_wr), .ZN(n_95_0));
   NAND2_X1_LVT i_95_2 (.A1(n_95_1), .A2(n_95_0), .ZN(n_234));
   CLKGATETST_X1_LVT clk_gate_r14_reg (.CK(mclk), .E(n_234), .SE(1'b0), .GCK(
      n_217));
   DFFR_X1_LVT \r14_reg[1]  (.D(n_219), .RN(n_8), .CK(n_217), .Q(r14[1]), .QN());
   NAND2_X1_LVT i_105_40 (.A1(n_216), .A2(r14[1]), .ZN(n_105_39));
   NAND4_X1_LVT i_105_41 (.A1(n_105_36), .A2(n_105_37), .A3(n_105_38), .A4(
      n_105_39), .ZN(reg_src[1]));
   AOI22_X1_LVT i_24_1 (.A1(n_24_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r4_wr), .ZN(n_24_1));
   INV_X1_LVT i_24_2 (.A(n_24_1), .ZN(n_28));
   DFFR_X1_LVT \r4_reg[0]  (.D(n_28), .RN(n_8), .CK(n_27), .Q(r4[0]), .QN());
   NAND2_X1_LVT i_105_0 (.A1(r4[0]), .A2(n_24), .ZN(n_105_0));
   DFFR_X1_LVT \r3_reg[0]  (.D(reg_dest_val[0]), .RN(n_8), .CK(n_23), .Q(r3[0]), 
      .QN());
   NAND2_X1_LVT i_105_1 (.A1(r3[0]), .A2(n_22), .ZN(n_105_1));
   INV_X1_LVT i_5_1 (.A(alu_stat_wr[0]), .ZN(n_5_1));
   NAND3_X1_LVT i_5_2 (.A1(n_5_0), .A2(n_5_1), .A3(status[0]), .ZN(n_5_2));
   NAND3_X1_LVT i_5_3 (.A1(n_5_1), .A2(r2_wr), .A3(reg_dest_val[0]), .ZN(n_5_3));
   NAND2_X1_LVT i_5_4 (.A1(alu_stat[0]), .A2(alu_stat_wr[0]), .ZN(n_5_4));
   NAND3_X1_LVT i_5_5 (.A1(n_5_2), .A2(n_5_3), .A3(n_5_4), .ZN(n_9));
   AND2_X1_LVT i_6_1 (.A1(n_6_0), .A2(n_9), .ZN(n_13));
   DFFR_X1_LVT \r2_reg[0]  (.D(n_13), .RN(n_8), .CK(mclk), .Q(status[0]), .QN());
   NAND2_X1_LVT i_105_2 (.A1(status[0]), .A2(n_21), .ZN(n_105_2));
   DFFR_X1_LVT \r1_reg[0]  (.D(1'b0), .RN(n_8), .CK(n_270), .Q(r1[0]), .QN());
   NAND2_X1_LVT i_105_3 (.A1(r1[0]), .A2(inst_src_in), .ZN(n_105_3));
   NAND4_X1_LVT i_105_4 (.A1(n_105_0), .A2(n_105_1), .A3(n_105_2), .A4(n_105_3), 
      .ZN(n_105_4));
   AOI22_X1_LVT i_80_1 (.A1(n_80_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r12_wr), .ZN(n_80_1));
   INV_X1_LVT i_80_2 (.A(n_80_1), .ZN(n_180));
   DFFR_X1_LVT \r12_reg[0]  (.D(n_180), .RN(n_8), .CK(n_179), .Q(r12[0]), .QN());
   NAND2_X1_LVT i_105_5 (.A1(r12[0]), .A2(n_178), .ZN(n_105_5));
   AOI22_X1_LVT i_73_1 (.A1(n_73_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r11_wr), .ZN(n_73_1));
   INV_X1_LVT i_73_2 (.A(n_73_1), .ZN(n_161));
   DFFR_X1_LVT \r11_reg[0]  (.D(n_161), .RN(n_8), .CK(n_160), .Q(r11[0]), .QN());
   NAND2_X1_LVT i_105_6 (.A1(r11[0]), .A2(n_159), .ZN(n_105_6));
   AOI22_X1_LVT i_66_1 (.A1(n_66_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r10_wr), .ZN(n_66_1));
   INV_X1_LVT i_66_2 (.A(n_66_1), .ZN(n_142));
   DFFR_X1_LVT \r10_reg[0]  (.D(n_142), .RN(n_8), .CK(n_141), .Q(r10[0]), .QN());
   NAND2_X1_LVT i_105_7 (.A1(r10[0]), .A2(n_140), .ZN(n_105_7));
   AOI22_X1_LVT i_59_1 (.A1(n_59_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r9_wr), .ZN(n_59_1));
   INV_X1_LVT i_59_2 (.A(n_59_1), .ZN(n_123));
   DFFR_X1_LVT \r9_reg[0]  (.D(n_123), .RN(n_8), .CK(n_122), .Q(r9[0]), .QN());
   NAND2_X1_LVT i_105_8 (.A1(r9[0]), .A2(n_121), .ZN(n_105_8));
   NAND4_X1_LVT i_105_9 (.A1(n_105_5), .A2(n_105_6), .A3(n_105_7), .A4(n_105_8), 
      .ZN(n_105_9));
   AOI22_X1_LVT i_52_1 (.A1(n_52_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r8_wr), .ZN(n_52_1));
   INV_X1_LVT i_52_2 (.A(n_52_1), .ZN(n_104));
   DFFR_X1_LVT \r8_reg[0]  (.D(n_104), .RN(n_8), .CK(n_103), .Q(r8[0]), .QN());
   NAND2_X1_LVT i_105_10 (.A1(r8[0]), .A2(n_102), .ZN(n_105_10));
   AOI22_X1_LVT i_45_1 (.A1(n_45_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r7_wr), .ZN(n_45_1));
   INV_X1_LVT i_45_2 (.A(n_45_1), .ZN(n_85));
   DFFR_X1_LVT \r7_reg[0]  (.D(n_85), .RN(n_8), .CK(n_84), .Q(r7[0]), .QN());
   NAND2_X1_LVT i_105_11 (.A1(r7[0]), .A2(n_83), .ZN(n_105_11));
   AOI22_X1_LVT i_38_1 (.A1(n_38_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r6_wr), .ZN(n_38_1));
   INV_X1_LVT i_38_2 (.A(n_38_1), .ZN(n_66));
   DFFR_X1_LVT \r6_reg[0]  (.D(n_66), .RN(n_8), .CK(n_65), .Q(r6[0]), .QN());
   NAND2_X1_LVT i_105_12 (.A1(r6[0]), .A2(n_64), .ZN(n_105_12));
   AOI22_X1_LVT i_31_1 (.A1(n_31_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r5_wr), .ZN(n_31_1));
   INV_X1_LVT i_31_2 (.A(n_31_1), .ZN(n_47));
   DFFR_X1_LVT \r5_reg[0]  (.D(n_47), .RN(n_8), .CK(n_46), .Q(r5[0]), .QN());
   NAND2_X1_LVT i_105_13 (.A1(r5[0]), .A2(n_45), .ZN(n_105_13));
   NAND4_X1_LVT i_105_14 (.A1(n_105_10), .A2(n_105_11), .A3(n_105_12), .A4(
      n_105_13), .ZN(n_105_14));
   AOI22_X1_LVT i_87_1 (.A1(n_87_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r13_wr), .ZN(n_87_1));
   INV_X1_LVT i_87_2 (.A(n_87_1), .ZN(n_199));
   DFFR_X1_LVT \r13_reg[0]  (.D(n_199), .RN(n_8), .CK(n_198), .Q(r13[0]), .QN());
   AND2_X1_LVT i_105_15 (.A1(r13[0]), .A2(n_197), .ZN(n_105_15));
   NOR4_X1_LVT i_105_16 (.A1(n_105_4), .A2(n_105_9), .A3(n_105_14), .A4(n_105_15), 
      .ZN(n_105_16));
   NAND2_X1_LVT i_105_17 (.A1(pc[0]), .A2(n_254), .ZN(n_105_17));
   AOI22_X1_LVT i_101_1 (.A1(n_101_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r15_wr), .ZN(n_101_1));
   INV_X1_LVT i_101_2 (.A(n_101_1), .ZN(n_237));
   DFFR_X1_LVT \r15_reg[0]  (.D(n_237), .RN(n_8), .CK(n_236), .Q(r15[0]), .QN());
   NAND2_X1_LVT i_105_18 (.A1(r15[0]), .A2(n_235), .ZN(n_105_18));
   AOI22_X1_LVT i_94_1 (.A1(n_94_0), .A2(reg_incr_val[0]), .B1(reg_dest_val[0]), 
      .B2(r14_wr), .ZN(n_94_1));
   INV_X1_LVT i_94_2 (.A(n_94_1), .ZN(n_218));
   DFFR_X1_LVT \r14_reg[0]  (.D(n_218), .RN(n_8), .CK(n_217), .Q(r14[0]), .QN());
   NAND2_X1_LVT i_105_19 (.A1(r14[0]), .A2(n_216), .ZN(n_105_19));
   NAND4_X1_LVT i_105_20 (.A1(n_105_16), .A2(n_105_17), .A3(n_105_18), .A4(
      n_105_19), .ZN(reg_src[0]));
   HA_X1_LVT i_22_0 (.A(n_25), .B(reg_src[0]), .CO(n_22_0), .S(reg_incr_val[0]));
   FA_X1_LVT i_22_1 (.A(n_26), .B(reg_src[1]), .CI(n_22_0), .CO(n_22_1), 
      .S(reg_incr_val[1]));
   HA_X1_LVT i_22_2 (.A(reg_src[2]), .B(n_22_1), .CO(n_22_2), .S(reg_incr_val[2]));
   AOI22_X1_LVT i_24_5 (.A1(n_24_0), .A2(reg_incr_val[2]), .B1(r4_wr), .B2(
      reg_dest_val[2]), .ZN(n_24_3));
   INV_X1_LVT i_24_6 (.A(n_24_3), .ZN(n_30));
   DFFR_X1_LVT \r4_reg[2]  (.D(n_30), .RN(n_8), .CK(n_27), .Q(r4[2]), .QN());
   NAND2_X1_LVT i_105_42 (.A1(n_24), .A2(r4[2]), .ZN(n_105_40));
   DFFR_X1_LVT \r3_reg[2]  (.D(reg_dest_val[2]), .RN(n_8), .CK(n_23), .Q(r3[2]), 
      .QN());
   NAND2_X1_LVT i_105_43 (.A1(n_22), .A2(r3[2]), .ZN(n_105_41));
   INV_X1_LVT i_5_11 (.A(alu_stat_wr[2]), .ZN(n_5_9));
   NAND3_X1_LVT i_5_12 (.A1(n_5_0), .A2(n_5_9), .A3(status[2]), .ZN(n_5_10));
   NAND3_X1_LVT i_5_13 (.A1(n_5_9), .A2(r2_wr), .A3(reg_dest_val[2]), .ZN(n_5_11));
   NAND2_X1_LVT i_5_14 (.A1(alu_stat[2]), .A2(alu_stat_wr[2]), .ZN(n_5_12));
   NAND3_X1_LVT i_5_15 (.A1(n_5_10), .A2(n_5_11), .A3(n_5_12), .ZN(n_11));
   AND2_X1_LVT i_6_3 (.A1(n_6_0), .A2(n_11), .ZN(n_15));
   DFFR_X1_LVT \r2_reg[2]  (.D(n_15), .RN(n_8), .CK(mclk), .Q(status[2]), .QN());
   NAND2_X1_LVT i_105_44 (.A1(n_21), .A2(status[2]), .ZN(n_105_42));
   AOI222_X1_LVT i_109_2 (.A1(r1_wr), .A2(reg_dest_val[2]), .B1(n_272), .B2(
      reg_sp_val[2]), .C1(n_271), .C2(n_256), .ZN(n_109_1));
   INV_X1_LVT i_109_3 (.A(n_109_1), .ZN(n_274));
   DFFR_X1_LVT \r1_reg[2]  (.D(n_274), .RN(n_8), .CK(n_270), .Q(r1[2]), .QN());
   NAND2_X1_LVT i_105_45 (.A1(inst_src_in), .A2(r1[2]), .ZN(n_105_43));
   NAND4_X1_LVT i_105_46 (.A1(n_105_40), .A2(n_105_41), .A3(n_105_42), .A4(
      n_105_43), .ZN(n_105_44));
   AOI22_X1_LVT i_80_5 (.A1(n_80_0), .A2(reg_incr_val[2]), .B1(r12_wr), .B2(
      reg_dest_val[2]), .ZN(n_80_3));
   INV_X1_LVT i_80_6 (.A(n_80_3), .ZN(n_182));
   DFFR_X1_LVT \r12_reg[2]  (.D(n_182), .RN(n_8), .CK(n_179), .Q(r12[2]), .QN());
   NAND2_X1_LVT i_105_47 (.A1(n_178), .A2(r12[2]), .ZN(n_105_45));
   AOI22_X1_LVT i_73_5 (.A1(n_73_0), .A2(reg_incr_val[2]), .B1(r11_wr), .B2(
      reg_dest_val[2]), .ZN(n_73_3));
   INV_X1_LVT i_73_6 (.A(n_73_3), .ZN(n_163));
   DFFR_X1_LVT \r11_reg[2]  (.D(n_163), .RN(n_8), .CK(n_160), .Q(r11[2]), .QN());
   NAND2_X1_LVT i_105_48 (.A1(n_159), .A2(r11[2]), .ZN(n_105_46));
   AOI22_X1_LVT i_66_5 (.A1(n_66_0), .A2(reg_incr_val[2]), .B1(r10_wr), .B2(
      reg_dest_val[2]), .ZN(n_66_3));
   INV_X1_LVT i_66_6 (.A(n_66_3), .ZN(n_144));
   DFFR_X1_LVT \r10_reg[2]  (.D(n_144), .RN(n_8), .CK(n_141), .Q(r10[2]), .QN());
   NAND2_X1_LVT i_105_49 (.A1(n_140), .A2(r10[2]), .ZN(n_105_47));
   AOI22_X1_LVT i_59_5 (.A1(n_59_0), .A2(reg_incr_val[2]), .B1(r9_wr), .B2(
      reg_dest_val[2]), .ZN(n_59_3));
   INV_X1_LVT i_59_6 (.A(n_59_3), .ZN(n_125));
   DFFR_X1_LVT \r9_reg[2]  (.D(n_125), .RN(n_8), .CK(n_122), .Q(r9[2]), .QN());
   NAND2_X1_LVT i_105_50 (.A1(n_121), .A2(r9[2]), .ZN(n_105_48));
   NAND4_X1_LVT i_105_51 (.A1(n_105_45), .A2(n_105_46), .A3(n_105_47), .A4(
      n_105_48), .ZN(n_105_49));
   AOI22_X1_LVT i_52_5 (.A1(n_52_0), .A2(reg_incr_val[2]), .B1(r8_wr), .B2(
      reg_dest_val[2]), .ZN(n_52_3));
   INV_X1_LVT i_52_6 (.A(n_52_3), .ZN(n_106));
   DFFR_X1_LVT \r8_reg[2]  (.D(n_106), .RN(n_8), .CK(n_103), .Q(r8[2]), .QN());
   NAND2_X1_LVT i_105_52 (.A1(n_102), .A2(r8[2]), .ZN(n_105_50));
   AOI22_X1_LVT i_45_5 (.A1(n_45_0), .A2(reg_incr_val[2]), .B1(r7_wr), .B2(
      reg_dest_val[2]), .ZN(n_45_3));
   INV_X1_LVT i_45_6 (.A(n_45_3), .ZN(n_87));
   DFFR_X1_LVT \r7_reg[2]  (.D(n_87), .RN(n_8), .CK(n_84), .Q(r7[2]), .QN());
   NAND2_X1_LVT i_105_53 (.A1(n_83), .A2(r7[2]), .ZN(n_105_51));
   AOI22_X1_LVT i_38_5 (.A1(n_38_0), .A2(reg_incr_val[2]), .B1(r6_wr), .B2(
      reg_dest_val[2]), .ZN(n_38_3));
   INV_X1_LVT i_38_6 (.A(n_38_3), .ZN(n_68));
   DFFR_X1_LVT \r6_reg[2]  (.D(n_68), .RN(n_8), .CK(n_65), .Q(r6[2]), .QN());
   NAND2_X1_LVT i_105_54 (.A1(n_64), .A2(r6[2]), .ZN(n_105_52));
   AOI22_X1_LVT i_31_5 (.A1(n_31_0), .A2(reg_incr_val[2]), .B1(r5_wr), .B2(
      reg_dest_val[2]), .ZN(n_31_3));
   INV_X1_LVT i_31_6 (.A(n_31_3), .ZN(n_49));
   DFFR_X1_LVT \r5_reg[2]  (.D(n_49), .RN(n_8), .CK(n_46), .Q(r5[2]), .QN());
   NAND2_X1_LVT i_105_55 (.A1(n_45), .A2(r5[2]), .ZN(n_105_53));
   NAND4_X1_LVT i_105_56 (.A1(n_105_50), .A2(n_105_51), .A3(n_105_52), .A4(
      n_105_53), .ZN(n_105_54));
   AOI22_X1_LVT i_87_5 (.A1(n_87_0), .A2(reg_incr_val[2]), .B1(r13_wr), .B2(
      reg_dest_val[2]), .ZN(n_87_3));
   INV_X1_LVT i_87_6 (.A(n_87_3), .ZN(n_201));
   DFFR_X1_LVT \r13_reg[2]  (.D(n_201), .RN(n_8), .CK(n_198), .Q(r13[2]), .QN());
   AND2_X1_LVT i_105_57 (.A1(n_197), .A2(r13[2]), .ZN(n_105_55));
   NOR4_X1_LVT i_105_58 (.A1(n_105_44), .A2(n_105_49), .A3(n_105_54), .A4(
      n_105_55), .ZN(n_105_56));
   NAND2_X1_LVT i_105_59 (.A1(n_254), .A2(pc[2]), .ZN(n_105_57));
   AOI22_X1_LVT i_101_5 (.A1(n_101_0), .A2(reg_incr_val[2]), .B1(r15_wr), 
      .B2(reg_dest_val[2]), .ZN(n_101_3));
   INV_X1_LVT i_101_6 (.A(n_101_3), .ZN(n_239));
   DFFR_X1_LVT \r15_reg[2]  (.D(n_239), .RN(n_8), .CK(n_236), .Q(r15[2]), .QN());
   NAND2_X1_LVT i_105_60 (.A1(n_235), .A2(r15[2]), .ZN(n_105_58));
   AOI22_X1_LVT i_94_5 (.A1(n_94_0), .A2(reg_incr_val[2]), .B1(r14_wr), .B2(
      reg_dest_val[2]), .ZN(n_94_3));
   INV_X1_LVT i_94_6 (.A(n_94_3), .ZN(n_220));
   DFFR_X1_LVT \r14_reg[2]  (.D(n_220), .RN(n_8), .CK(n_217), .Q(r14[2]), .QN());
   NAND2_X1_LVT i_105_61 (.A1(n_216), .A2(r14[2]), .ZN(n_105_59));
   NAND4_X1_LVT i_105_62 (.A1(n_105_56), .A2(n_105_57), .A3(n_105_58), .A4(
      n_105_59), .ZN(reg_src[2]));
   HA_X1_LVT i_106_1 (.A(reg_src[2]), .B(reg_src[1]), .CO(n_106_0), .S(n_256));
   HA_X1_LVT i_106_2 (.A(reg_src[3]), .B(n_106_0), .CO(n_106_1), .S(n_257));
   AOI222_X1_LVT i_109_4 (.A1(r1_wr), .A2(reg_dest_val[3]), .B1(n_272), .B2(
      reg_sp_val[3]), .C1(n_271), .C2(n_257), .ZN(n_109_2));
   INV_X1_LVT i_109_5 (.A(n_109_2), .ZN(n_275));
   DFFR_X1_LVT \r1_reg[3]  (.D(n_275), .RN(n_8), .CK(n_270), .Q(r1[3]), .QN());
   NAND2_X1_LVT i_105_66 (.A1(inst_src_in), .A2(r1[3]), .ZN(n_105_63));
   NAND4_X1_LVT i_105_67 (.A1(n_105_60), .A2(n_105_61), .A3(n_105_62), .A4(
      n_105_63), .ZN(n_105_64));
   AOI22_X1_LVT i_80_7 (.A1(n_80_0), .A2(reg_incr_val[3]), .B1(r12_wr), .B2(
      reg_dest_val[3]), .ZN(n_80_4));
   INV_X1_LVT i_80_8 (.A(n_80_4), .ZN(n_183));
   DFFR_X1_LVT \r12_reg[3]  (.D(n_183), .RN(n_8), .CK(n_179), .Q(r12[3]), .QN());
   NAND2_X1_LVT i_105_68 (.A1(n_178), .A2(r12[3]), .ZN(n_105_65));
   AOI22_X1_LVT i_73_7 (.A1(n_73_0), .A2(reg_incr_val[3]), .B1(r11_wr), .B2(
      reg_dest_val[3]), .ZN(n_73_4));
   INV_X1_LVT i_73_8 (.A(n_73_4), .ZN(n_164));
   DFFR_X1_LVT \r11_reg[3]  (.D(n_164), .RN(n_8), .CK(n_160), .Q(r11[3]), .QN());
   NAND2_X1_LVT i_105_69 (.A1(n_159), .A2(r11[3]), .ZN(n_105_66));
   AOI22_X1_LVT i_66_7 (.A1(n_66_0), .A2(reg_incr_val[3]), .B1(r10_wr), .B2(
      reg_dest_val[3]), .ZN(n_66_4));
   INV_X1_LVT i_66_8 (.A(n_66_4), .ZN(n_145));
   DFFR_X1_LVT \r10_reg[3]  (.D(n_145), .RN(n_8), .CK(n_141), .Q(r10[3]), .QN());
   NAND2_X1_LVT i_105_70 (.A1(n_140), .A2(r10[3]), .ZN(n_105_67));
   AOI22_X1_LVT i_59_7 (.A1(n_59_0), .A2(reg_incr_val[3]), .B1(r9_wr), .B2(
      reg_dest_val[3]), .ZN(n_59_4));
   INV_X1_LVT i_59_8 (.A(n_59_4), .ZN(n_126));
   DFFR_X1_LVT \r9_reg[3]  (.D(n_126), .RN(n_8), .CK(n_122), .Q(r9[3]), .QN());
   NAND2_X1_LVT i_105_71 (.A1(n_121), .A2(r9[3]), .ZN(n_105_68));
   NAND4_X1_LVT i_105_72 (.A1(n_105_65), .A2(n_105_66), .A3(n_105_67), .A4(
      n_105_68), .ZN(n_105_69));
   AOI22_X1_LVT i_52_7 (.A1(n_52_0), .A2(reg_incr_val[3]), .B1(r8_wr), .B2(
      reg_dest_val[3]), .ZN(n_52_4));
   INV_X1_LVT i_52_8 (.A(n_52_4), .ZN(n_107));
   DFFR_X1_LVT \r8_reg[3]  (.D(n_107), .RN(n_8), .CK(n_103), .Q(r8[3]), .QN());
   NAND2_X1_LVT i_105_73 (.A1(n_102), .A2(r8[3]), .ZN(n_105_70));
   AOI22_X1_LVT i_45_7 (.A1(n_45_0), .A2(reg_incr_val[3]), .B1(r7_wr), .B2(
      reg_dest_val[3]), .ZN(n_45_4));
   INV_X1_LVT i_45_8 (.A(n_45_4), .ZN(n_88));
   DFFR_X1_LVT \r7_reg[3]  (.D(n_88), .RN(n_8), .CK(n_84), .Q(r7[3]), .QN());
   NAND2_X1_LVT i_105_74 (.A1(n_83), .A2(r7[3]), .ZN(n_105_71));
   AOI22_X1_LVT i_38_7 (.A1(n_38_0), .A2(reg_incr_val[3]), .B1(r6_wr), .B2(
      reg_dest_val[3]), .ZN(n_38_4));
   INV_X1_LVT i_38_8 (.A(n_38_4), .ZN(n_69));
   DFFR_X1_LVT \r6_reg[3]  (.D(n_69), .RN(n_8), .CK(n_65), .Q(r6[3]), .QN());
   NAND2_X1_LVT i_105_75 (.A1(n_64), .A2(r6[3]), .ZN(n_105_72));
   AOI22_X1_LVT i_31_7 (.A1(n_31_0), .A2(reg_incr_val[3]), .B1(r5_wr), .B2(
      reg_dest_val[3]), .ZN(n_31_4));
   INV_X1_LVT i_31_8 (.A(n_31_4), .ZN(n_50));
   DFFR_X1_LVT \r5_reg[3]  (.D(n_50), .RN(n_8), .CK(n_46), .Q(r5[3]), .QN());
   NAND2_X1_LVT i_105_76 (.A1(n_45), .A2(r5[3]), .ZN(n_105_73));
   NAND4_X1_LVT i_105_77 (.A1(n_105_70), .A2(n_105_71), .A3(n_105_72), .A4(
      n_105_73), .ZN(n_105_74));
   AOI22_X1_LVT i_87_7 (.A1(n_87_0), .A2(reg_incr_val[3]), .B1(r13_wr), .B2(
      reg_dest_val[3]), .ZN(n_87_4));
   INV_X1_LVT i_87_8 (.A(n_87_4), .ZN(n_202));
   DFFR_X1_LVT \r13_reg[3]  (.D(n_202), .RN(n_8), .CK(n_198), .Q(r13[3]), .QN());
   AND2_X1_LVT i_105_78 (.A1(n_197), .A2(r13[3]), .ZN(n_105_75));
   NOR4_X1_LVT i_105_79 (.A1(n_105_64), .A2(n_105_69), .A3(n_105_74), .A4(
      n_105_75), .ZN(n_105_76));
   NAND2_X1_LVT i_105_80 (.A1(n_254), .A2(pc[3]), .ZN(n_105_77));
   AOI22_X1_LVT i_101_7 (.A1(n_101_0), .A2(reg_incr_val[3]), .B1(r15_wr), 
      .B2(reg_dest_val[3]), .ZN(n_101_4));
   INV_X1_LVT i_101_8 (.A(n_101_4), .ZN(n_240));
   DFFR_X1_LVT \r15_reg[3]  (.D(n_240), .RN(n_8), .CK(n_236), .Q(r15[3]), .QN());
   NAND2_X1_LVT i_105_81 (.A1(n_235), .A2(r15[3]), .ZN(n_105_78));
   AOI22_X1_LVT i_94_7 (.A1(n_94_0), .A2(reg_incr_val[3]), .B1(r14_wr), .B2(
      reg_dest_val[3]), .ZN(n_94_4));
   INV_X1_LVT i_94_8 (.A(n_94_4), .ZN(n_221));
   DFFR_X1_LVT \r14_reg[3]  (.D(n_221), .RN(n_8), .CK(n_217), .Q(r14[3]), .QN());
   NAND2_X1_LVT i_105_82 (.A1(n_216), .A2(r14[3]), .ZN(n_105_79));
   NAND4_X1_LVT i_105_83 (.A1(n_105_76), .A2(n_105_77), .A3(n_105_78), .A4(
      n_105_79), .ZN(reg_src[3]));
   HA_X1_LVT i_22_3 (.A(reg_src[3]), .B(n_22_2), .CO(n_22_3), .S(reg_incr_val[3]));
   HA_X1_LVT i_22_4 (.A(reg_src[4]), .B(n_22_3), .CO(n_22_4), .S(reg_incr_val[4]));
   AOI22_X1_LVT i_24_9 (.A1(n_24_0), .A2(reg_incr_val[4]), .B1(r4_wr), .B2(
      reg_dest_val[4]), .ZN(n_24_5));
   INV_X1_LVT i_24_10 (.A(n_24_5), .ZN(n_32));
   DFFR_X1_LVT \r4_reg[4]  (.D(n_32), .RN(n_8), .CK(n_27), .Q(r4[4]), .QN());
   NAND2_X1_LVT i_105_84 (.A1(n_24), .A2(r4[4]), .ZN(n_105_80));
   DFFR_X1_LVT \r3_reg[4]  (.D(reg_dest_val[4]), .RN(n_8), .CK(n_23), .Q(r3[4]), 
      .QN());
   NAND2_X1_LVT i_105_85 (.A1(n_22), .A2(r3[4]), .ZN(n_105_81));
   NAND2_X1_LVT i_105_86 (.A1(n_21), .A2(n_7), .ZN(n_105_82));
   AOI222_X1_LVT i_109_6 (.A1(r1_wr), .A2(reg_dest_val[4]), .B1(n_272), .B2(
      reg_sp_val[4]), .C1(n_271), .C2(n_258), .ZN(n_109_3));
   INV_X1_LVT i_109_7 (.A(n_109_3), .ZN(n_276));
   DFFR_X1_LVT \r1_reg[4]  (.D(n_276), .RN(n_8), .CK(n_270), .Q(r1[4]), .QN());
   NAND2_X1_LVT i_105_87 (.A1(inst_src_in), .A2(r1[4]), .ZN(n_105_83));
   NAND4_X1_LVT i_105_88 (.A1(n_105_80), .A2(n_105_81), .A3(n_105_82), .A4(
      n_105_83), .ZN(n_105_84));
   AOI22_X1_LVT i_80_9 (.A1(n_80_0), .A2(reg_incr_val[4]), .B1(r12_wr), .B2(
      reg_dest_val[4]), .ZN(n_80_5));
   INV_X1_LVT i_80_10 (.A(n_80_5), .ZN(n_184));
   DFFR_X1_LVT \r12_reg[4]  (.D(n_184), .RN(n_8), .CK(n_179), .Q(r12[4]), .QN());
   NAND2_X1_LVT i_105_89 (.A1(n_178), .A2(r12[4]), .ZN(n_105_85));
   AOI22_X1_LVT i_73_9 (.A1(n_73_0), .A2(reg_incr_val[4]), .B1(r11_wr), .B2(
      reg_dest_val[4]), .ZN(n_73_5));
   INV_X1_LVT i_73_10 (.A(n_73_5), .ZN(n_165));
   DFFR_X1_LVT \r11_reg[4]  (.D(n_165), .RN(n_8), .CK(n_160), .Q(r11[4]), .QN());
   NAND2_X1_LVT i_105_90 (.A1(n_159), .A2(r11[4]), .ZN(n_105_86));
   AOI22_X1_LVT i_66_9 (.A1(n_66_0), .A2(reg_incr_val[4]), .B1(r10_wr), .B2(
      reg_dest_val[4]), .ZN(n_66_5));
   INV_X1_LVT i_66_10 (.A(n_66_5), .ZN(n_146));
   DFFR_X1_LVT \r10_reg[4]  (.D(n_146), .RN(n_8), .CK(n_141), .Q(r10[4]), .QN());
   NAND2_X1_LVT i_105_91 (.A1(n_140), .A2(r10[4]), .ZN(n_105_87));
   AOI22_X1_LVT i_59_9 (.A1(n_59_0), .A2(reg_incr_val[4]), .B1(r9_wr), .B2(
      reg_dest_val[4]), .ZN(n_59_5));
   INV_X1_LVT i_59_10 (.A(n_59_5), .ZN(n_127));
   DFFR_X1_LVT \r9_reg[4]  (.D(n_127), .RN(n_8), .CK(n_122), .Q(r9[4]), .QN());
   NAND2_X1_LVT i_105_92 (.A1(n_121), .A2(r9[4]), .ZN(n_105_88));
   NAND4_X1_LVT i_105_93 (.A1(n_105_85), .A2(n_105_86), .A3(n_105_87), .A4(
      n_105_88), .ZN(n_105_89));
   AOI22_X1_LVT i_52_9 (.A1(n_52_0), .A2(reg_incr_val[4]), .B1(r8_wr), .B2(
      reg_dest_val[4]), .ZN(n_52_5));
   INV_X1_LVT i_52_10 (.A(n_52_5), .ZN(n_108));
   DFFR_X1_LVT \r8_reg[4]  (.D(n_108), .RN(n_8), .CK(n_103), .Q(r8[4]), .QN());
   NAND2_X1_LVT i_105_94 (.A1(n_102), .A2(r8[4]), .ZN(n_105_90));
   AOI22_X1_LVT i_45_9 (.A1(n_45_0), .A2(reg_incr_val[4]), .B1(r7_wr), .B2(
      reg_dest_val[4]), .ZN(n_45_5));
   INV_X1_LVT i_45_10 (.A(n_45_5), .ZN(n_89));
   DFFR_X1_LVT \r7_reg[4]  (.D(n_89), .RN(n_8), .CK(n_84), .Q(r7[4]), .QN());
   NAND2_X1_LVT i_105_95 (.A1(n_83), .A2(r7[4]), .ZN(n_105_91));
   AOI22_X1_LVT i_38_9 (.A1(n_38_0), .A2(reg_incr_val[4]), .B1(r6_wr), .B2(
      reg_dest_val[4]), .ZN(n_38_5));
   INV_X1_LVT i_38_10 (.A(n_38_5), .ZN(n_70));
   DFFR_X1_LVT \r6_reg[4]  (.D(n_70), .RN(n_8), .CK(n_65), .Q(r6[4]), .QN());
   NAND2_X1_LVT i_105_96 (.A1(n_64), .A2(r6[4]), .ZN(n_105_92));
   AOI22_X1_LVT i_31_9 (.A1(n_31_0), .A2(reg_incr_val[4]), .B1(r5_wr), .B2(
      reg_dest_val[4]), .ZN(n_31_5));
   INV_X1_LVT i_31_10 (.A(n_31_5), .ZN(n_51));
   DFFR_X1_LVT \r5_reg[4]  (.D(n_51), .RN(n_8), .CK(n_46), .Q(r5[4]), .QN());
   NAND2_X1_LVT i_105_97 (.A1(n_45), .A2(r5[4]), .ZN(n_105_93));
   NAND4_X1_LVT i_105_98 (.A1(n_105_90), .A2(n_105_91), .A3(n_105_92), .A4(
      n_105_93), .ZN(n_105_94));
   AOI22_X1_LVT i_87_9 (.A1(n_87_0), .A2(reg_incr_val[4]), .B1(r13_wr), .B2(
      reg_dest_val[4]), .ZN(n_87_5));
   INV_X1_LVT i_87_10 (.A(n_87_5), .ZN(n_203));
   DFFR_X1_LVT \r13_reg[4]  (.D(n_203), .RN(n_8), .CK(n_198), .Q(r13[4]), .QN());
   AND2_X1_LVT i_105_99 (.A1(n_197), .A2(r13[4]), .ZN(n_105_95));
   NOR4_X1_LVT i_105_100 (.A1(n_105_84), .A2(n_105_89), .A3(n_105_94), .A4(
      n_105_95), .ZN(n_105_96));
   NAND2_X1_LVT i_105_101 (.A1(n_254), .A2(pc[4]), .ZN(n_105_97));
   AOI22_X1_LVT i_101_9 (.A1(n_101_0), .A2(reg_incr_val[4]), .B1(r15_wr), 
      .B2(reg_dest_val[4]), .ZN(n_101_5));
   INV_X1_LVT i_101_10 (.A(n_101_5), .ZN(n_241));
   DFFR_X1_LVT \r15_reg[4]  (.D(n_241), .RN(n_8), .CK(n_236), .Q(r15[4]), .QN());
   NAND2_X1_LVT i_105_102 (.A1(n_235), .A2(r15[4]), .ZN(n_105_98));
   AOI22_X1_LVT i_94_9 (.A1(n_94_0), .A2(reg_incr_val[4]), .B1(r14_wr), .B2(
      reg_dest_val[4]), .ZN(n_94_5));
   INV_X1_LVT i_94_10 (.A(n_94_5), .ZN(n_222));
   DFFR_X1_LVT \r14_reg[4]  (.D(n_222), .RN(n_8), .CK(n_217), .Q(r14[4]), .QN());
   NAND2_X1_LVT i_105_103 (.A1(n_216), .A2(r14[4]), .ZN(n_105_99));
   NAND4_X1_LVT i_105_104 (.A1(n_105_96), .A2(n_105_97), .A3(n_105_98), .A4(
      n_105_99), .ZN(reg_src[4]));
   HA_X1_LVT i_106_3 (.A(reg_src[4]), .B(n_106_1), .CO(n_106_2), .S(n_258));
   HA_X1_LVT i_106_4 (.A(reg_src[5]), .B(n_106_2), .CO(n_106_3), .S(n_259));
   AOI222_X1_LVT i_109_8 (.A1(r1_wr), .A2(reg_dest_val[5]), .B1(n_272), .B2(
      reg_sp_val[5]), .C1(n_271), .C2(n_259), .ZN(n_109_4));
   INV_X1_LVT i_109_9 (.A(n_109_4), .ZN(n_277));
   DFFR_X1_LVT \r1_reg[5]  (.D(n_277), .RN(n_8), .CK(n_270), .Q(r1[5]), .QN());
   NAND2_X1_LVT i_105_108 (.A1(inst_src_in), .A2(r1[5]), .ZN(n_105_103));
   NAND4_X1_LVT i_105_109 (.A1(n_105_100), .A2(n_105_101), .A3(n_105_102), 
      .A4(n_105_103), .ZN(n_105_104));
   AOI22_X1_LVT i_80_11 (.A1(n_80_0), .A2(reg_incr_val[5]), .B1(r12_wr), 
      .B2(reg_dest_val[5]), .ZN(n_80_6));
   INV_X1_LVT i_80_12 (.A(n_80_6), .ZN(n_185));
   DFFR_X1_LVT \r12_reg[5]  (.D(n_185), .RN(n_8), .CK(n_179), .Q(r12[5]), .QN());
   NAND2_X1_LVT i_105_110 (.A1(n_178), .A2(r12[5]), .ZN(n_105_105));
   AOI22_X1_LVT i_73_11 (.A1(n_73_0), .A2(reg_incr_val[5]), .B1(r11_wr), 
      .B2(reg_dest_val[5]), .ZN(n_73_6));
   INV_X1_LVT i_73_12 (.A(n_73_6), .ZN(n_166));
   DFFR_X1_LVT \r11_reg[5]  (.D(n_166), .RN(n_8), .CK(n_160), .Q(r11[5]), .QN());
   NAND2_X1_LVT i_105_111 (.A1(n_159), .A2(r11[5]), .ZN(n_105_106));
   AOI22_X1_LVT i_66_11 (.A1(n_66_0), .A2(reg_incr_val[5]), .B1(r10_wr), 
      .B2(reg_dest_val[5]), .ZN(n_66_6));
   INV_X1_LVT i_66_12 (.A(n_66_6), .ZN(n_147));
   DFFR_X1_LVT \r10_reg[5]  (.D(n_147), .RN(n_8), .CK(n_141), .Q(r10[5]), .QN());
   NAND2_X1_LVT i_105_112 (.A1(n_140), .A2(r10[5]), .ZN(n_105_107));
   AOI22_X1_LVT i_59_11 (.A1(n_59_0), .A2(reg_incr_val[5]), .B1(r9_wr), .B2(
      reg_dest_val[5]), .ZN(n_59_6));
   INV_X1_LVT i_59_12 (.A(n_59_6), .ZN(n_128));
   DFFR_X1_LVT \r9_reg[5]  (.D(n_128), .RN(n_8), .CK(n_122), .Q(r9[5]), .QN());
   NAND2_X1_LVT i_105_113 (.A1(n_121), .A2(r9[5]), .ZN(n_105_108));
   NAND4_X1_LVT i_105_114 (.A1(n_105_105), .A2(n_105_106), .A3(n_105_107), 
      .A4(n_105_108), .ZN(n_105_109));
   AOI22_X1_LVT i_52_11 (.A1(n_52_0), .A2(reg_incr_val[5]), .B1(r8_wr), .B2(
      reg_dest_val[5]), .ZN(n_52_6));
   INV_X1_LVT i_52_12 (.A(n_52_6), .ZN(n_109));
   DFFR_X1_LVT \r8_reg[5]  (.D(n_109), .RN(n_8), .CK(n_103), .Q(r8[5]), .QN());
   NAND2_X1_LVT i_105_115 (.A1(n_102), .A2(r8[5]), .ZN(n_105_110));
   AOI22_X1_LVT i_45_11 (.A1(n_45_0), .A2(reg_incr_val[5]), .B1(r7_wr), .B2(
      reg_dest_val[5]), .ZN(n_45_6));
   INV_X1_LVT i_45_12 (.A(n_45_6), .ZN(n_90));
   DFFR_X1_LVT \r7_reg[5]  (.D(n_90), .RN(n_8), .CK(n_84), .Q(r7[5]), .QN());
   NAND2_X1_LVT i_105_116 (.A1(n_83), .A2(r7[5]), .ZN(n_105_111));
   AOI22_X1_LVT i_38_11 (.A1(n_38_0), .A2(reg_incr_val[5]), .B1(r6_wr), .B2(
      reg_dest_val[5]), .ZN(n_38_6));
   INV_X1_LVT i_38_12 (.A(n_38_6), .ZN(n_71));
   DFFR_X1_LVT \r6_reg[5]  (.D(n_71), .RN(n_8), .CK(n_65), .Q(r6[5]), .QN());
   NAND2_X1_LVT i_105_117 (.A1(n_64), .A2(r6[5]), .ZN(n_105_112));
   AOI22_X1_LVT i_31_11 (.A1(n_31_0), .A2(reg_incr_val[5]), .B1(r5_wr), .B2(
      reg_dest_val[5]), .ZN(n_31_6));
   INV_X1_LVT i_31_12 (.A(n_31_6), .ZN(n_52));
   DFFR_X1_LVT \r5_reg[5]  (.D(n_52), .RN(n_8), .CK(n_46), .Q(r5[5]), .QN());
   NAND2_X1_LVT i_105_118 (.A1(n_45), .A2(r5[5]), .ZN(n_105_113));
   NAND4_X1_LVT i_105_119 (.A1(n_105_110), .A2(n_105_111), .A3(n_105_112), 
      .A4(n_105_113), .ZN(n_105_114));
   AOI22_X1_LVT i_87_11 (.A1(n_87_0), .A2(reg_incr_val[5]), .B1(r13_wr), 
      .B2(reg_dest_val[5]), .ZN(n_87_6));
   INV_X1_LVT i_87_12 (.A(n_87_6), .ZN(n_204));
   DFFR_X1_LVT \r13_reg[5]  (.D(n_204), .RN(n_8), .CK(n_198), .Q(r13[5]), .QN());
   AND2_X1_LVT i_105_120 (.A1(n_197), .A2(r13[5]), .ZN(n_105_115));
   NOR4_X1_LVT i_105_121 (.A1(n_105_104), .A2(n_105_109), .A3(n_105_114), 
      .A4(n_105_115), .ZN(n_105_116));
   NAND2_X1_LVT i_105_122 (.A1(n_254), .A2(pc[5]), .ZN(n_105_117));
   AOI22_X1_LVT i_101_11 (.A1(n_101_0), .A2(reg_incr_val[5]), .B1(r15_wr), 
      .B2(reg_dest_val[5]), .ZN(n_101_6));
   INV_X1_LVT i_101_12 (.A(n_101_6), .ZN(n_242));
   DFFR_X1_LVT \r15_reg[5]  (.D(n_242), .RN(n_8), .CK(n_236), .Q(r15[5]), .QN());
   NAND2_X1_LVT i_105_123 (.A1(n_235), .A2(r15[5]), .ZN(n_105_118));
   AOI22_X1_LVT i_94_11 (.A1(n_94_0), .A2(reg_incr_val[5]), .B1(r14_wr), 
      .B2(reg_dest_val[5]), .ZN(n_94_6));
   INV_X1_LVT i_94_12 (.A(n_94_6), .ZN(n_223));
   DFFR_X1_LVT \r14_reg[5]  (.D(n_223), .RN(n_8), .CK(n_217), .Q(r14[5]), .QN());
   NAND2_X1_LVT i_105_124 (.A1(n_216), .A2(r14[5]), .ZN(n_105_119));
   NAND4_X1_LVT i_105_125 (.A1(n_105_116), .A2(n_105_117), .A3(n_105_118), 
      .A4(n_105_119), .ZN(reg_src[5]));
   HA_X1_LVT i_22_5 (.A(reg_src[5]), .B(n_22_4), .CO(n_22_5), .S(reg_incr_val[5]));
   HA_X1_LVT i_22_6 (.A(reg_src[6]), .B(n_22_5), .CO(n_22_6), .S(reg_incr_val[6]));
   AOI22_X1_LVT i_24_13 (.A1(n_24_0), .A2(reg_incr_val[6]), .B1(r4_wr), .B2(
      reg_dest_val[6]), .ZN(n_24_7));
   INV_X1_LVT i_24_14 (.A(n_24_7), .ZN(n_34));
   DFFR_X1_LVT \r4_reg[6]  (.D(n_34), .RN(n_8), .CK(n_27), .Q(r4[6]), .QN());
   NAND2_X1_LVT i_105_126 (.A1(n_24), .A2(r4[6]), .ZN(n_105_120));
   DFFR_X1_LVT \r3_reg[6]  (.D(reg_dest_val[6]), .RN(n_8), .CK(n_23), .Q(r3[6]), 
      .QN());
   NAND2_X1_LVT i_105_127 (.A1(n_22), .A2(r3[6]), .ZN(n_105_121));
   AOI22_X1_LVT i_2_5 (.A1(n_2_0), .A2(scg0), .B1(r2_wr), .B2(reg_dest_val[6]), 
      .ZN(n_2_3));
   INV_X1_LVT i_2_6 (.A(n_2_3), .ZN(r2_nxt[6]));
   AND2_X1_LVT i_6_6 (.A1(n_6_0), .A2(r2_nxt[6]), .ZN(n_18));
   DFFR_X1_LVT \r2_reg[6]  (.D(n_18), .RN(n_8), .CK(mclk), .Q(scg0), .QN());
   NAND2_X1_LVT i_105_128 (.A1(n_21), .A2(scg0), .ZN(n_105_122));
   AOI222_X1_LVT i_109_10 (.A1(r1_wr), .A2(reg_dest_val[6]), .B1(n_272), 
      .B2(reg_sp_val[6]), .C1(n_271), .C2(n_260), .ZN(n_109_5));
   INV_X1_LVT i_109_11 (.A(n_109_5), .ZN(n_278));
   DFFR_X1_LVT \r1_reg[6]  (.D(n_278), .RN(n_8), .CK(n_270), .Q(r1[6]), .QN());
   NAND2_X1_LVT i_105_129 (.A1(inst_src_in), .A2(r1[6]), .ZN(n_105_123));
   NAND4_X1_LVT i_105_130 (.A1(n_105_120), .A2(n_105_121), .A3(n_105_122), 
      .A4(n_105_123), .ZN(n_105_124));
   AOI22_X1_LVT i_80_13 (.A1(n_80_0), .A2(reg_incr_val[6]), .B1(r12_wr), 
      .B2(reg_dest_val[6]), .ZN(n_80_7));
   INV_X1_LVT i_80_14 (.A(n_80_7), .ZN(n_186));
   DFFR_X1_LVT \r12_reg[6]  (.D(n_186), .RN(n_8), .CK(n_179), .Q(r12[6]), .QN());
   NAND2_X1_LVT i_105_131 (.A1(n_178), .A2(r12[6]), .ZN(n_105_125));
   AOI22_X1_LVT i_73_13 (.A1(n_73_0), .A2(reg_incr_val[6]), .B1(r11_wr), 
      .B2(reg_dest_val[6]), .ZN(n_73_7));
   INV_X1_LVT i_73_14 (.A(n_73_7), .ZN(n_167));
   DFFR_X1_LVT \r11_reg[6]  (.D(n_167), .RN(n_8), .CK(n_160), .Q(r11[6]), .QN());
   NAND2_X1_LVT i_105_132 (.A1(n_159), .A2(r11[6]), .ZN(n_105_126));
   AOI22_X1_LVT i_66_13 (.A1(n_66_0), .A2(reg_incr_val[6]), .B1(r10_wr), 
      .B2(reg_dest_val[6]), .ZN(n_66_7));
   INV_X1_LVT i_66_14 (.A(n_66_7), .ZN(n_148));
   DFFR_X1_LVT \r10_reg[6]  (.D(n_148), .RN(n_8), .CK(n_141), .Q(r10[6]), .QN());
   NAND2_X1_LVT i_105_133 (.A1(n_140), .A2(r10[6]), .ZN(n_105_127));
   AOI22_X1_LVT i_59_13 (.A1(n_59_0), .A2(reg_incr_val[6]), .B1(r9_wr), .B2(
      reg_dest_val[6]), .ZN(n_59_7));
   INV_X1_LVT i_59_14 (.A(n_59_7), .ZN(n_129));
   DFFR_X1_LVT \r9_reg[6]  (.D(n_129), .RN(n_8), .CK(n_122), .Q(r9[6]), .QN());
   NAND2_X1_LVT i_105_134 (.A1(n_121), .A2(r9[6]), .ZN(n_105_128));
   NAND4_X1_LVT i_105_135 (.A1(n_105_125), .A2(n_105_126), .A3(n_105_127), 
      .A4(n_105_128), .ZN(n_105_129));
   AOI22_X1_LVT i_52_13 (.A1(n_52_0), .A2(reg_incr_val[6]), .B1(r8_wr), .B2(
      reg_dest_val[6]), .ZN(n_52_7));
   INV_X1_LVT i_52_14 (.A(n_52_7), .ZN(n_110));
   DFFR_X1_LVT \r8_reg[6]  (.D(n_110), .RN(n_8), .CK(n_103), .Q(r8[6]), .QN());
   NAND2_X1_LVT i_105_136 (.A1(n_102), .A2(r8[6]), .ZN(n_105_130));
   AOI22_X1_LVT i_45_13 (.A1(n_45_0), .A2(reg_incr_val[6]), .B1(r7_wr), .B2(
      reg_dest_val[6]), .ZN(n_45_7));
   INV_X1_LVT i_45_14 (.A(n_45_7), .ZN(n_91));
   DFFR_X1_LVT \r7_reg[6]  (.D(n_91), .RN(n_8), .CK(n_84), .Q(r7[6]), .QN());
   NAND2_X1_LVT i_105_137 (.A1(n_83), .A2(r7[6]), .ZN(n_105_131));
   AOI22_X1_LVT i_38_13 (.A1(n_38_0), .A2(reg_incr_val[6]), .B1(r6_wr), .B2(
      reg_dest_val[6]), .ZN(n_38_7));
   INV_X1_LVT i_38_14 (.A(n_38_7), .ZN(n_72));
   DFFR_X1_LVT \r6_reg[6]  (.D(n_72), .RN(n_8), .CK(n_65), .Q(r6[6]), .QN());
   NAND2_X1_LVT i_105_138 (.A1(n_64), .A2(r6[6]), .ZN(n_105_132));
   AOI22_X1_LVT i_31_13 (.A1(n_31_0), .A2(reg_incr_val[6]), .B1(r5_wr), .B2(
      reg_dest_val[6]), .ZN(n_31_7));
   INV_X1_LVT i_31_14 (.A(n_31_7), .ZN(n_53));
   DFFR_X1_LVT \r5_reg[6]  (.D(n_53), .RN(n_8), .CK(n_46), .Q(r5[6]), .QN());
   NAND2_X1_LVT i_105_139 (.A1(n_45), .A2(r5[6]), .ZN(n_105_133));
   NAND4_X1_LVT i_105_140 (.A1(n_105_130), .A2(n_105_131), .A3(n_105_132), 
      .A4(n_105_133), .ZN(n_105_134));
   AOI22_X1_LVT i_87_13 (.A1(n_87_0), .A2(reg_incr_val[6]), .B1(r13_wr), 
      .B2(reg_dest_val[6]), .ZN(n_87_7));
   INV_X1_LVT i_87_14 (.A(n_87_7), .ZN(n_205));
   DFFR_X1_LVT \r13_reg[6]  (.D(n_205), .RN(n_8), .CK(n_198), .Q(r13[6]), .QN());
   AND2_X1_LVT i_105_141 (.A1(n_197), .A2(r13[6]), .ZN(n_105_135));
   NOR4_X1_LVT i_105_142 (.A1(n_105_124), .A2(n_105_129), .A3(n_105_134), 
      .A4(n_105_135), .ZN(n_105_136));
   NAND2_X1_LVT i_105_143 (.A1(n_254), .A2(pc[6]), .ZN(n_105_137));
   AOI22_X1_LVT i_101_13 (.A1(n_101_0), .A2(reg_incr_val[6]), .B1(r15_wr), 
      .B2(reg_dest_val[6]), .ZN(n_101_7));
   INV_X1_LVT i_101_14 (.A(n_101_7), .ZN(n_243));
   DFFR_X1_LVT \r15_reg[6]  (.D(n_243), .RN(n_8), .CK(n_236), .Q(r15[6]), .QN());
   NAND2_X1_LVT i_105_144 (.A1(n_235), .A2(r15[6]), .ZN(n_105_138));
   AOI22_X1_LVT i_94_13 (.A1(n_94_0), .A2(reg_incr_val[6]), .B1(r14_wr), 
      .B2(reg_dest_val[6]), .ZN(n_94_7));
   INV_X1_LVT i_94_14 (.A(n_94_7), .ZN(n_224));
   DFFR_X1_LVT \r14_reg[6]  (.D(n_224), .RN(n_8), .CK(n_217), .Q(r14[6]), .QN());
   NAND2_X1_LVT i_105_145 (.A1(n_216), .A2(r14[6]), .ZN(n_105_139));
   NAND4_X1_LVT i_105_146 (.A1(n_105_136), .A2(n_105_137), .A3(n_105_138), 
      .A4(n_105_139), .ZN(reg_src[6]));
   HA_X1_LVT i_106_5 (.A(reg_src[6]), .B(n_106_3), .CO(n_106_4), .S(n_260));
   HA_X1_LVT i_106_6 (.A(reg_src[7]), .B(n_106_4), .CO(n_106_5), .S(n_261));
   AOI222_X1_LVT i_109_12 (.A1(r1_wr), .A2(reg_dest_val[7]), .B1(n_272), 
      .B2(reg_sp_val[7]), .C1(n_271), .C2(n_261), .ZN(n_109_6));
   INV_X1_LVT i_109_13 (.A(n_109_6), .ZN(n_279));
   DFFR_X1_LVT \r1_reg[7]  (.D(n_279), .RN(n_8), .CK(n_270), .Q(r1[7]), .QN());
   NAND2_X1_LVT i_105_150 (.A1(inst_src_in), .A2(r1[7]), .ZN(n_105_143));
   NAND4_X1_LVT i_105_151 (.A1(n_105_140), .A2(n_105_141), .A3(n_105_142), 
      .A4(n_105_143), .ZN(n_105_144));
   AOI22_X1_LVT i_80_15 (.A1(n_80_0), .A2(reg_incr_val[7]), .B1(r12_wr), 
      .B2(reg_dest_val[7]), .ZN(n_80_8));
   INV_X1_LVT i_80_16 (.A(n_80_8), .ZN(n_187));
   DFFR_X1_LVT \r12_reg[7]  (.D(n_187), .RN(n_8), .CK(n_179), .Q(r12[7]), .QN());
   NAND2_X1_LVT i_105_152 (.A1(n_178), .A2(r12[7]), .ZN(n_105_145));
   AOI22_X1_LVT i_73_15 (.A1(n_73_0), .A2(reg_incr_val[7]), .B1(r11_wr), 
      .B2(reg_dest_val[7]), .ZN(n_73_8));
   INV_X1_LVT i_73_16 (.A(n_73_8), .ZN(n_168));
   DFFR_X1_LVT \r11_reg[7]  (.D(n_168), .RN(n_8), .CK(n_160), .Q(r11[7]), .QN());
   NAND2_X1_LVT i_105_153 (.A1(n_159), .A2(r11[7]), .ZN(n_105_146));
   AOI22_X1_LVT i_66_15 (.A1(n_66_0), .A2(reg_incr_val[7]), .B1(r10_wr), 
      .B2(reg_dest_val[7]), .ZN(n_66_8));
   INV_X1_LVT i_66_16 (.A(n_66_8), .ZN(n_149));
   DFFR_X1_LVT \r10_reg[7]  (.D(n_149), .RN(n_8), .CK(n_141), .Q(r10[7]), .QN());
   NAND2_X1_LVT i_105_154 (.A1(n_140), .A2(r10[7]), .ZN(n_105_147));
   AOI22_X1_LVT i_59_15 (.A1(n_59_0), .A2(reg_incr_val[7]), .B1(r9_wr), .B2(
      reg_dest_val[7]), .ZN(n_59_8));
   INV_X1_LVT i_59_16 (.A(n_59_8), .ZN(n_130));
   DFFR_X1_LVT \r9_reg[7]  (.D(n_130), .RN(n_8), .CK(n_122), .Q(r9[7]), .QN());
   NAND2_X1_LVT i_105_155 (.A1(n_121), .A2(r9[7]), .ZN(n_105_148));
   NAND4_X1_LVT i_105_156 (.A1(n_105_145), .A2(n_105_146), .A3(n_105_147), 
      .A4(n_105_148), .ZN(n_105_149));
   AOI22_X1_LVT i_52_15 (.A1(n_52_0), .A2(reg_incr_val[7]), .B1(r8_wr), .B2(
      reg_dest_val[7]), .ZN(n_52_8));
   INV_X1_LVT i_52_16 (.A(n_52_8), .ZN(n_111));
   DFFR_X1_LVT \r8_reg[7]  (.D(n_111), .RN(n_8), .CK(n_103), .Q(r8[7]), .QN());
   NAND2_X1_LVT i_105_157 (.A1(n_102), .A2(r8[7]), .ZN(n_105_150));
   AOI22_X1_LVT i_45_15 (.A1(n_45_0), .A2(reg_incr_val[7]), .B1(r7_wr), .B2(
      reg_dest_val[7]), .ZN(n_45_8));
   INV_X1_LVT i_45_16 (.A(n_45_8), .ZN(n_92));
   DFFR_X1_LVT \r7_reg[7]  (.D(n_92), .RN(n_8), .CK(n_84), .Q(r7[7]), .QN());
   NAND2_X1_LVT i_105_158 (.A1(n_83), .A2(r7[7]), .ZN(n_105_151));
   AOI22_X1_LVT i_38_15 (.A1(n_38_0), .A2(reg_incr_val[7]), .B1(r6_wr), .B2(
      reg_dest_val[7]), .ZN(n_38_8));
   INV_X1_LVT i_38_16 (.A(n_38_8), .ZN(n_73));
   DFFR_X1_LVT \r6_reg[7]  (.D(n_73), .RN(n_8), .CK(n_65), .Q(r6[7]), .QN());
   NAND2_X1_LVT i_105_159 (.A1(n_64), .A2(r6[7]), .ZN(n_105_152));
   AOI22_X1_LVT i_31_15 (.A1(n_31_0), .A2(reg_incr_val[7]), .B1(r5_wr), .B2(
      reg_dest_val[7]), .ZN(n_31_8));
   INV_X1_LVT i_31_16 (.A(n_31_8), .ZN(n_54));
   DFFR_X1_LVT \r5_reg[7]  (.D(n_54), .RN(n_8), .CK(n_46), .Q(r5[7]), .QN());
   NAND2_X1_LVT i_105_160 (.A1(n_45), .A2(r5[7]), .ZN(n_105_153));
   NAND4_X1_LVT i_105_161 (.A1(n_105_150), .A2(n_105_151), .A3(n_105_152), 
      .A4(n_105_153), .ZN(n_105_154));
   AOI22_X1_LVT i_87_15 (.A1(n_87_0), .A2(reg_incr_val[7]), .B1(r13_wr), 
      .B2(reg_dest_val[7]), .ZN(n_87_8));
   INV_X1_LVT i_87_16 (.A(n_87_8), .ZN(n_206));
   DFFR_X1_LVT \r13_reg[7]  (.D(n_206), .RN(n_8), .CK(n_198), .Q(r13[7]), .QN());
   AND2_X1_LVT i_105_162 (.A1(n_197), .A2(r13[7]), .ZN(n_105_155));
   NOR4_X1_LVT i_105_163 (.A1(n_105_144), .A2(n_105_149), .A3(n_105_154), 
      .A4(n_105_155), .ZN(n_105_156));
   NAND2_X1_LVT i_105_164 (.A1(n_254), .A2(pc[7]), .ZN(n_105_157));
   AOI22_X1_LVT i_101_15 (.A1(n_101_0), .A2(reg_incr_val[7]), .B1(r15_wr), 
      .B2(reg_dest_val[7]), .ZN(n_101_8));
   INV_X1_LVT i_101_16 (.A(n_101_8), .ZN(n_244));
   DFFR_X1_LVT \r15_reg[7]  (.D(n_244), .RN(n_8), .CK(n_236), .Q(r15[7]), .QN());
   NAND2_X1_LVT i_105_165 (.A1(n_235), .A2(r15[7]), .ZN(n_105_158));
   AOI22_X1_LVT i_94_15 (.A1(n_94_0), .A2(reg_incr_val[7]), .B1(r14_wr), 
      .B2(reg_dest_val[7]), .ZN(n_94_8));
   INV_X1_LVT i_94_16 (.A(n_94_8), .ZN(n_225));
   DFFR_X1_LVT \r14_reg[7]  (.D(n_225), .RN(n_8), .CK(n_217), .Q(r14[7]), .QN());
   NAND2_X1_LVT i_105_166 (.A1(n_216), .A2(r14[7]), .ZN(n_105_159));
   NAND4_X1_LVT i_105_167 (.A1(n_105_156), .A2(n_105_157), .A3(n_105_158), 
      .A4(n_105_159), .ZN(reg_src[7]));
   HA_X1_LVT i_22_7 (.A(reg_src[7]), .B(n_22_6), .CO(n_22_7), .S(reg_incr_val[7]));
   HA_X1_LVT i_22_8 (.A(reg_src[8]), .B(n_22_7), .CO(n_22_8), .S(reg_incr_val[8]));
   AOI22_X1_LVT i_24_17 (.A1(n_24_0), .A2(reg_incr_val[8]), .B1(r4_wr), .B2(
      pc_sw[8]), .ZN(n_24_9));
   INV_X1_LVT i_24_18 (.A(n_24_9), .ZN(n_36));
   DFFR_X1_LVT \r4_reg[8]  (.D(n_36), .RN(n_8), .CK(n_27), .Q(r4[8]), .QN());
   NAND2_X1_LVT i_105_168 (.A1(n_24), .A2(r4[8]), .ZN(n_105_160));
   DFFR_X1_LVT \r3_reg[8]  (.D(pc_sw[8]), .RN(n_8), .CK(n_23), .Q(r3[8]), .QN());
   NAND2_X1_LVT i_105_169 (.A1(n_22), .A2(r3[8]), .ZN(n_105_161));
   INV_X1_LVT i_5_16 (.A(alu_stat_wr[3]), .ZN(n_5_13));
   NAND3_X1_LVT i_5_17 (.A1(n_5_0), .A2(n_5_13), .A3(status[3]), .ZN(n_5_14));
   NAND3_X1_LVT i_5_18 (.A1(n_5_13), .A2(r2_wr), .A3(pc_sw[8]), .ZN(n_5_15));
   NAND2_X1_LVT i_5_19 (.A1(alu_stat[3]), .A2(alu_stat_wr[3]), .ZN(n_5_16));
   NAND3_X1_LVT i_5_20 (.A1(n_5_14), .A2(n_5_15), .A3(n_5_16), .ZN(n_12));
   AND2_X1_LVT i_6_8 (.A1(n_6_0), .A2(n_12), .ZN(n_20));
   DFFR_X1_LVT \r2_reg[8]  (.D(n_20), .RN(n_8), .CK(mclk), .Q(status[3]), .QN());
   NAND2_X1_LVT i_105_170 (.A1(n_21), .A2(status[3]), .ZN(n_105_162));
   AOI222_X1_LVT i_109_14 (.A1(r1_wr), .A2(pc_sw[8]), .B1(n_272), .B2(
      reg_sp_val[8]), .C1(n_271), .C2(n_262), .ZN(n_109_7));
   INV_X1_LVT i_109_15 (.A(n_109_7), .ZN(n_280));
   DFFR_X1_LVT \r1_reg[8]  (.D(n_280), .RN(n_8), .CK(n_270), .Q(r1[8]), .QN());
   NAND2_X1_LVT i_105_171 (.A1(inst_src_in), .A2(r1[8]), .ZN(n_105_163));
   NAND4_X1_LVT i_105_172 (.A1(n_105_160), .A2(n_105_161), .A3(n_105_162), 
      .A4(n_105_163), .ZN(n_105_164));
   AOI22_X1_LVT i_80_17 (.A1(n_80_0), .A2(reg_incr_val[8]), .B1(r12_wr), 
      .B2(pc_sw[8]), .ZN(n_80_9));
   INV_X1_LVT i_80_18 (.A(n_80_9), .ZN(n_188));
   DFFR_X1_LVT \r12_reg[8]  (.D(n_188), .RN(n_8), .CK(n_179), .Q(r12[8]), .QN());
   NAND2_X1_LVT i_105_173 (.A1(n_178), .A2(r12[8]), .ZN(n_105_165));
   AOI22_X1_LVT i_73_17 (.A1(n_73_0), .A2(reg_incr_val[8]), .B1(r11_wr), 
      .B2(pc_sw[8]), .ZN(n_73_9));
   INV_X1_LVT i_73_18 (.A(n_73_9), .ZN(n_169));
   DFFR_X1_LVT \r11_reg[8]  (.D(n_169), .RN(n_8), .CK(n_160), .Q(r11[8]), .QN());
   NAND2_X1_LVT i_105_174 (.A1(n_159), .A2(r11[8]), .ZN(n_105_166));
   AOI22_X1_LVT i_66_17 (.A1(n_66_0), .A2(reg_incr_val[8]), .B1(r10_wr), 
      .B2(pc_sw[8]), .ZN(n_66_9));
   INV_X1_LVT i_66_18 (.A(n_66_9), .ZN(n_150));
   DFFR_X1_LVT \r10_reg[8]  (.D(n_150), .RN(n_8), .CK(n_141), .Q(r10[8]), .QN());
   NAND2_X1_LVT i_105_175 (.A1(n_140), .A2(r10[8]), .ZN(n_105_167));
   AOI22_X1_LVT i_59_17 (.A1(n_59_0), .A2(reg_incr_val[8]), .B1(r9_wr), .B2(
      pc_sw[8]), .ZN(n_59_9));
   INV_X1_LVT i_59_18 (.A(n_59_9), .ZN(n_131));
   DFFR_X1_LVT \r9_reg[8]  (.D(n_131), .RN(n_8), .CK(n_122), .Q(r9[8]), .QN());
   NAND2_X1_LVT i_105_176 (.A1(n_121), .A2(r9[8]), .ZN(n_105_168));
   NAND4_X1_LVT i_105_177 (.A1(n_105_165), .A2(n_105_166), .A3(n_105_167), 
      .A4(n_105_168), .ZN(n_105_169));
   AOI22_X1_LVT i_52_17 (.A1(n_52_0), .A2(reg_incr_val[8]), .B1(r8_wr), .B2(
      pc_sw[8]), .ZN(n_52_9));
   INV_X1_LVT i_52_18 (.A(n_52_9), .ZN(n_112));
   DFFR_X1_LVT \r8_reg[8]  (.D(n_112), .RN(n_8), .CK(n_103), .Q(r8[8]), .QN());
   NAND2_X1_LVT i_105_178 (.A1(n_102), .A2(r8[8]), .ZN(n_105_170));
   AOI22_X1_LVT i_45_17 (.A1(n_45_0), .A2(reg_incr_val[8]), .B1(r7_wr), .B2(
      pc_sw[8]), .ZN(n_45_9));
   INV_X1_LVT i_45_18 (.A(n_45_9), .ZN(n_93));
   DFFR_X1_LVT \r7_reg[8]  (.D(n_93), .RN(n_8), .CK(n_84), .Q(r7[8]), .QN());
   NAND2_X1_LVT i_105_179 (.A1(n_83), .A2(r7[8]), .ZN(n_105_171));
   AOI22_X1_LVT i_38_17 (.A1(n_38_0), .A2(reg_incr_val[8]), .B1(r6_wr), .B2(
      pc_sw[8]), .ZN(n_38_9));
   INV_X1_LVT i_38_18 (.A(n_38_9), .ZN(n_74));
   DFFR_X1_LVT \r6_reg[8]  (.D(n_74), .RN(n_8), .CK(n_65), .Q(r6[8]), .QN());
   NAND2_X1_LVT i_105_180 (.A1(n_64), .A2(r6[8]), .ZN(n_105_172));
   AOI22_X1_LVT i_31_17 (.A1(n_31_0), .A2(reg_incr_val[8]), .B1(r5_wr), .B2(
      pc_sw[8]), .ZN(n_31_9));
   INV_X1_LVT i_31_18 (.A(n_31_9), .ZN(n_55));
   DFFR_X1_LVT \r5_reg[8]  (.D(n_55), .RN(n_8), .CK(n_46), .Q(r5[8]), .QN());
   NAND2_X1_LVT i_105_181 (.A1(n_45), .A2(r5[8]), .ZN(n_105_173));
   NAND4_X1_LVT i_105_182 (.A1(n_105_170), .A2(n_105_171), .A3(n_105_172), 
      .A4(n_105_173), .ZN(n_105_174));
   AOI22_X1_LVT i_87_17 (.A1(n_87_0), .A2(reg_incr_val[8]), .B1(r13_wr), 
      .B2(pc_sw[8]), .ZN(n_87_9));
   INV_X1_LVT i_87_18 (.A(n_87_9), .ZN(n_207));
   DFFR_X1_LVT \r13_reg[8]  (.D(n_207), .RN(n_8), .CK(n_198), .Q(r13[8]), .QN());
   AND2_X1_LVT i_105_183 (.A1(n_197), .A2(r13[8]), .ZN(n_105_175));
   NOR4_X1_LVT i_105_184 (.A1(n_105_164), .A2(n_105_169), .A3(n_105_174), 
      .A4(n_105_175), .ZN(n_105_176));
   NAND2_X1_LVT i_105_185 (.A1(n_254), .A2(pc[8]), .ZN(n_105_177));
   AOI22_X1_LVT i_101_17 (.A1(n_101_0), .A2(reg_incr_val[8]), .B1(r15_wr), 
      .B2(pc_sw[8]), .ZN(n_101_9));
   INV_X1_LVT i_101_18 (.A(n_101_9), .ZN(n_245));
   DFFR_X1_LVT \r15_reg[8]  (.D(n_245), .RN(n_8), .CK(n_236), .Q(r15[8]), .QN());
   NAND2_X1_LVT i_105_186 (.A1(n_235), .A2(r15[8]), .ZN(n_105_178));
   AOI22_X1_LVT i_94_17 (.A1(n_94_0), .A2(reg_incr_val[8]), .B1(r14_wr), 
      .B2(pc_sw[8]), .ZN(n_94_9));
   INV_X1_LVT i_94_18 (.A(n_94_9), .ZN(n_226));
   DFFR_X1_LVT \r14_reg[8]  (.D(n_226), .RN(n_8), .CK(n_217), .Q(r14[8]), .QN());
   NAND2_X1_LVT i_105_187 (.A1(n_216), .A2(r14[8]), .ZN(n_105_179));
   NAND4_X1_LVT i_105_188 (.A1(n_105_176), .A2(n_105_177), .A3(n_105_178), 
      .A4(n_105_179), .ZN(reg_src[8]));
   HA_X1_LVT i_106_7 (.A(reg_src[8]), .B(n_106_5), .CO(n_106_6), .S(n_262));
   HA_X1_LVT i_106_8 (.A(reg_src[9]), .B(n_106_6), .CO(n_106_7), .S(n_263));
   AOI222_X1_LVT i_109_16 (.A1(r1_wr), .A2(pc_sw[9]), .B1(n_272), .B2(
      reg_sp_val[9]), .C1(n_271), .C2(n_263), .ZN(n_109_8));
   INV_X1_LVT i_109_17 (.A(n_109_8), .ZN(n_281));
   DFFR_X1_LVT \r1_reg[9]  (.D(n_281), .RN(n_8), .CK(n_270), .Q(r1[9]), .QN());
   NAND2_X1_LVT i_105_192 (.A1(inst_src_in), .A2(r1[9]), .ZN(n_105_183));
   NAND4_X1_LVT i_105_193 (.A1(n_105_180), .A2(n_105_181), .A3(n_105_182), 
      .A4(n_105_183), .ZN(n_105_184));
   AOI22_X1_LVT i_80_19 (.A1(n_80_0), .A2(reg_incr_val[9]), .B1(r12_wr), 
      .B2(pc_sw[9]), .ZN(n_80_10));
   INV_X1_LVT i_80_20 (.A(n_80_10), .ZN(n_189));
   DFFR_X1_LVT \r12_reg[9]  (.D(n_189), .RN(n_8), .CK(n_179), .Q(r12[9]), .QN());
   NAND2_X1_LVT i_105_194 (.A1(n_178), .A2(r12[9]), .ZN(n_105_185));
   AOI22_X1_LVT i_73_19 (.A1(n_73_0), .A2(reg_incr_val[9]), .B1(r11_wr), 
      .B2(pc_sw[9]), .ZN(n_73_10));
   INV_X1_LVT i_73_20 (.A(n_73_10), .ZN(n_170));
   DFFR_X1_LVT \r11_reg[9]  (.D(n_170), .RN(n_8), .CK(n_160), .Q(r11[9]), .QN());
   NAND2_X1_LVT i_105_195 (.A1(n_159), .A2(r11[9]), .ZN(n_105_186));
   AOI22_X1_LVT i_66_19 (.A1(n_66_0), .A2(reg_incr_val[9]), .B1(r10_wr), 
      .B2(pc_sw[9]), .ZN(n_66_10));
   INV_X1_LVT i_66_20 (.A(n_66_10), .ZN(n_151));
   DFFR_X1_LVT \r10_reg[9]  (.D(n_151), .RN(n_8), .CK(n_141), .Q(r10[9]), .QN());
   NAND2_X1_LVT i_105_196 (.A1(n_140), .A2(r10[9]), .ZN(n_105_187));
   AOI22_X1_LVT i_59_19 (.A1(n_59_0), .A2(reg_incr_val[9]), .B1(r9_wr), .B2(
      pc_sw[9]), .ZN(n_59_10));
   INV_X1_LVT i_59_20 (.A(n_59_10), .ZN(n_132));
   DFFR_X1_LVT \r9_reg[9]  (.D(n_132), .RN(n_8), .CK(n_122), .Q(r9[9]), .QN());
   NAND2_X1_LVT i_105_197 (.A1(n_121), .A2(r9[9]), .ZN(n_105_188));
   NAND4_X1_LVT i_105_198 (.A1(n_105_185), .A2(n_105_186), .A3(n_105_187), 
      .A4(n_105_188), .ZN(n_105_189));
   AOI22_X1_LVT i_52_19 (.A1(n_52_0), .A2(reg_incr_val[9]), .B1(r8_wr), .B2(
      pc_sw[9]), .ZN(n_52_10));
   INV_X1_LVT i_52_20 (.A(n_52_10), .ZN(n_113));
   DFFR_X1_LVT \r8_reg[9]  (.D(n_113), .RN(n_8), .CK(n_103), .Q(r8[9]), .QN());
   NAND2_X1_LVT i_105_199 (.A1(n_102), .A2(r8[9]), .ZN(n_105_190));
   AOI22_X1_LVT i_45_19 (.A1(n_45_0), .A2(reg_incr_val[9]), .B1(r7_wr), .B2(
      pc_sw[9]), .ZN(n_45_10));
   INV_X1_LVT i_45_20 (.A(n_45_10), .ZN(n_94));
   DFFR_X1_LVT \r7_reg[9]  (.D(n_94), .RN(n_8), .CK(n_84), .Q(r7[9]), .QN());
   NAND2_X1_LVT i_105_200 (.A1(n_83), .A2(r7[9]), .ZN(n_105_191));
   AOI22_X1_LVT i_38_19 (.A1(n_38_0), .A2(reg_incr_val[9]), .B1(r6_wr), .B2(
      pc_sw[9]), .ZN(n_38_10));
   INV_X1_LVT i_38_20 (.A(n_38_10), .ZN(n_75));
   DFFR_X1_LVT \r6_reg[9]  (.D(n_75), .RN(n_8), .CK(n_65), .Q(r6[9]), .QN());
   NAND2_X1_LVT i_105_201 (.A1(n_64), .A2(r6[9]), .ZN(n_105_192));
   AOI22_X1_LVT i_31_19 (.A1(n_31_0), .A2(reg_incr_val[9]), .B1(r5_wr), .B2(
      pc_sw[9]), .ZN(n_31_10));
   INV_X1_LVT i_31_20 (.A(n_31_10), .ZN(n_56));
   DFFR_X1_LVT \r5_reg[9]  (.D(n_56), .RN(n_8), .CK(n_46), .Q(r5[9]), .QN());
   NAND2_X1_LVT i_105_202 (.A1(n_45), .A2(r5[9]), .ZN(n_105_193));
   NAND4_X1_LVT i_105_203 (.A1(n_105_190), .A2(n_105_191), .A3(n_105_192), 
      .A4(n_105_193), .ZN(n_105_194));
   AOI22_X1_LVT i_87_19 (.A1(n_87_0), .A2(reg_incr_val[9]), .B1(r13_wr), 
      .B2(pc_sw[9]), .ZN(n_87_10));
   INV_X1_LVT i_87_20 (.A(n_87_10), .ZN(n_208));
   DFFR_X1_LVT \r13_reg[9]  (.D(n_208), .RN(n_8), .CK(n_198), .Q(r13[9]), .QN());
   AND2_X1_LVT i_105_204 (.A1(n_197), .A2(r13[9]), .ZN(n_105_195));
   NOR4_X1_LVT i_105_205 (.A1(n_105_184), .A2(n_105_189), .A3(n_105_194), 
      .A4(n_105_195), .ZN(n_105_196));
   NAND2_X1_LVT i_105_206 (.A1(n_254), .A2(pc[9]), .ZN(n_105_197));
   AOI22_X1_LVT i_101_19 (.A1(n_101_0), .A2(reg_incr_val[9]), .B1(r15_wr), 
      .B2(pc_sw[9]), .ZN(n_101_10));
   INV_X1_LVT i_101_20 (.A(n_101_10), .ZN(n_246));
   DFFR_X1_LVT \r15_reg[9]  (.D(n_246), .RN(n_8), .CK(n_236), .Q(r15[9]), .QN());
   NAND2_X1_LVT i_105_207 (.A1(n_235), .A2(r15[9]), .ZN(n_105_198));
   AOI22_X1_LVT i_94_19 (.A1(n_94_0), .A2(reg_incr_val[9]), .B1(r14_wr), 
      .B2(pc_sw[9]), .ZN(n_94_10));
   INV_X1_LVT i_94_20 (.A(n_94_10), .ZN(n_227));
   DFFR_X1_LVT \r14_reg[9]  (.D(n_227), .RN(n_8), .CK(n_217), .Q(r14[9]), .QN());
   NAND2_X1_LVT i_105_208 (.A1(n_216), .A2(r14[9]), .ZN(n_105_199));
   NAND4_X1_LVT i_105_209 (.A1(n_105_196), .A2(n_105_197), .A3(n_105_198), 
      .A4(n_105_199), .ZN(reg_src[9]));
   HA_X1_LVT i_22_9 (.A(reg_src[9]), .B(n_22_8), .CO(n_22_9), .S(reg_incr_val[9]));
   HA_X1_LVT i_22_10 (.A(reg_src[10]), .B(n_22_9), .CO(n_22_10), .S(
      reg_incr_val[10]));
   AOI22_X1_LVT i_24_21 (.A1(n_24_0), .A2(reg_incr_val[10]), .B1(r4_wr), 
      .B2(pc_sw[10]), .ZN(n_24_11));
   INV_X1_LVT i_24_22 (.A(n_24_11), .ZN(n_38));
   DFFR_X1_LVT \r4_reg[10]  (.D(n_38), .RN(n_8), .CK(n_27), .Q(r4[10]), .QN());
   NAND2_X1_LVT i_105_210 (.A1(n_24), .A2(r4[10]), .ZN(n_105_200));
   DFFR_X1_LVT \r3_reg[10]  (.D(pc_sw[10]), .RN(n_8), .CK(n_23), .Q(r3[10]), 
      .QN());
   NAND2_X1_LVT i_105_211 (.A1(n_22), .A2(r3[10]), .ZN(n_105_201));
   DFFR_X1_LVT \r2_reg[10]  (.D(1'b0), .RN(n_8), .CK(mclk), .Q(n_5), .QN());
   NAND2_X1_LVT i_105_212 (.A1(n_21), .A2(n_5), .ZN(n_105_202));
   AOI222_X1_LVT i_109_18 (.A1(r1_wr), .A2(pc_sw[10]), .B1(n_272), .B2(
      reg_sp_val[10]), .C1(n_271), .C2(n_264), .ZN(n_109_9));
   INV_X1_LVT i_109_19 (.A(n_109_9), .ZN(n_282));
   DFFR_X1_LVT \r1_reg[10]  (.D(n_282), .RN(n_8), .CK(n_270), .Q(r1[10]), .QN());
   NAND2_X1_LVT i_105_213 (.A1(inst_src_in), .A2(r1[10]), .ZN(n_105_203));
   NAND4_X1_LVT i_105_214 (.A1(n_105_200), .A2(n_105_201), .A3(n_105_202), 
      .A4(n_105_203), .ZN(n_105_204));
   AOI22_X1_LVT i_80_21 (.A1(n_80_0), .A2(reg_incr_val[10]), .B1(r12_wr), 
      .B2(pc_sw[10]), .ZN(n_80_11));
   INV_X1_LVT i_80_22 (.A(n_80_11), .ZN(n_190));
   DFFR_X1_LVT \r12_reg[10]  (.D(n_190), .RN(n_8), .CK(n_179), .Q(r12[10]), 
      .QN());
   NAND2_X1_LVT i_105_215 (.A1(n_178), .A2(r12[10]), .ZN(n_105_205));
   AOI22_X1_LVT i_73_21 (.A1(n_73_0), .A2(reg_incr_val[10]), .B1(r11_wr), 
      .B2(pc_sw[10]), .ZN(n_73_11));
   INV_X1_LVT i_73_22 (.A(n_73_11), .ZN(n_171));
   DFFR_X1_LVT \r11_reg[10]  (.D(n_171), .RN(n_8), .CK(n_160), .Q(r11[10]), 
      .QN());
   NAND2_X1_LVT i_105_216 (.A1(n_159), .A2(r11[10]), .ZN(n_105_206));
   AOI22_X1_LVT i_66_21 (.A1(n_66_0), .A2(reg_incr_val[10]), .B1(r10_wr), 
      .B2(pc_sw[10]), .ZN(n_66_11));
   INV_X1_LVT i_66_22 (.A(n_66_11), .ZN(n_152));
   DFFR_X1_LVT \r10_reg[10]  (.D(n_152), .RN(n_8), .CK(n_141), .Q(r10[10]), 
      .QN());
   NAND2_X1_LVT i_105_217 (.A1(n_140), .A2(r10[10]), .ZN(n_105_207));
   AOI22_X1_LVT i_59_21 (.A1(n_59_0), .A2(reg_incr_val[10]), .B1(r9_wr), 
      .B2(pc_sw[10]), .ZN(n_59_11));
   INV_X1_LVT i_59_22 (.A(n_59_11), .ZN(n_133));
   DFFR_X1_LVT \r9_reg[10]  (.D(n_133), .RN(n_8), .CK(n_122), .Q(r9[10]), .QN());
   NAND2_X1_LVT i_105_218 (.A1(n_121), .A2(r9[10]), .ZN(n_105_208));
   NAND4_X1_LVT i_105_219 (.A1(n_105_205), .A2(n_105_206), .A3(n_105_207), 
      .A4(n_105_208), .ZN(n_105_209));
   AOI22_X1_LVT i_52_21 (.A1(n_52_0), .A2(reg_incr_val[10]), .B1(r8_wr), 
      .B2(pc_sw[10]), .ZN(n_52_11));
   INV_X1_LVT i_52_22 (.A(n_52_11), .ZN(n_114));
   DFFR_X1_LVT \r8_reg[10]  (.D(n_114), .RN(n_8), .CK(n_103), .Q(r8[10]), .QN());
   NAND2_X1_LVT i_105_220 (.A1(n_102), .A2(r8[10]), .ZN(n_105_210));
   AOI22_X1_LVT i_45_21 (.A1(n_45_0), .A2(reg_incr_val[10]), .B1(r7_wr), 
      .B2(pc_sw[10]), .ZN(n_45_11));
   INV_X1_LVT i_45_22 (.A(n_45_11), .ZN(n_95));
   DFFR_X1_LVT \r7_reg[10]  (.D(n_95), .RN(n_8), .CK(n_84), .Q(r7[10]), .QN());
   NAND2_X1_LVT i_105_221 (.A1(n_83), .A2(r7[10]), .ZN(n_105_211));
   AOI22_X1_LVT i_38_21 (.A1(n_38_0), .A2(reg_incr_val[10]), .B1(r6_wr), 
      .B2(pc_sw[10]), .ZN(n_38_11));
   INV_X1_LVT i_38_22 (.A(n_38_11), .ZN(n_76));
   DFFR_X1_LVT \r6_reg[10]  (.D(n_76), .RN(n_8), .CK(n_65), .Q(r6[10]), .QN());
   NAND2_X1_LVT i_105_222 (.A1(n_64), .A2(r6[10]), .ZN(n_105_212));
   AOI22_X1_LVT i_31_21 (.A1(n_31_0), .A2(reg_incr_val[10]), .B1(r5_wr), 
      .B2(pc_sw[10]), .ZN(n_31_11));
   INV_X1_LVT i_31_22 (.A(n_31_11), .ZN(n_57));
   DFFR_X1_LVT \r5_reg[10]  (.D(n_57), .RN(n_8), .CK(n_46), .Q(r5[10]), .QN());
   NAND2_X1_LVT i_105_223 (.A1(n_45), .A2(r5[10]), .ZN(n_105_213));
   NAND4_X1_LVT i_105_224 (.A1(n_105_210), .A2(n_105_211), .A3(n_105_212), 
      .A4(n_105_213), .ZN(n_105_214));
   AOI22_X1_LVT i_87_21 (.A1(n_87_0), .A2(reg_incr_val[10]), .B1(r13_wr), 
      .B2(pc_sw[10]), .ZN(n_87_11));
   INV_X1_LVT i_87_22 (.A(n_87_11), .ZN(n_209));
   DFFR_X1_LVT \r13_reg[10]  (.D(n_209), .RN(n_8), .CK(n_198), .Q(r13[10]), 
      .QN());
   AND2_X1_LVT i_105_225 (.A1(n_197), .A2(r13[10]), .ZN(n_105_215));
   NOR4_X1_LVT i_105_226 (.A1(n_105_204), .A2(n_105_209), .A3(n_105_214), 
      .A4(n_105_215), .ZN(n_105_216));
   NAND2_X1_LVT i_105_227 (.A1(n_254), .A2(pc[10]), .ZN(n_105_217));
   AOI22_X1_LVT i_101_21 (.A1(n_101_0), .A2(reg_incr_val[10]), .B1(r15_wr), 
      .B2(pc_sw[10]), .ZN(n_101_11));
   INV_X1_LVT i_101_22 (.A(n_101_11), .ZN(n_247));
   DFFR_X1_LVT \r15_reg[10]  (.D(n_247), .RN(n_8), .CK(n_236), .Q(r15[10]), 
      .QN());
   NAND2_X1_LVT i_105_228 (.A1(n_235), .A2(r15[10]), .ZN(n_105_218));
   AOI22_X1_LVT i_94_21 (.A1(n_94_0), .A2(reg_incr_val[10]), .B1(r14_wr), 
      .B2(pc_sw[10]), .ZN(n_94_11));
   INV_X1_LVT i_94_22 (.A(n_94_11), .ZN(n_228));
   DFFR_X1_LVT \r14_reg[10]  (.D(n_228), .RN(n_8), .CK(n_217), .Q(r14[10]), 
      .QN());
   NAND2_X1_LVT i_105_229 (.A1(n_216), .A2(r14[10]), .ZN(n_105_219));
   NAND4_X1_LVT i_105_230 (.A1(n_105_216), .A2(n_105_217), .A3(n_105_218), 
      .A4(n_105_219), .ZN(reg_src[10]));
   HA_X1_LVT i_106_9 (.A(reg_src[10]), .B(n_106_7), .CO(n_106_8), .S(n_264));
   HA_X1_LVT i_106_10 (.A(reg_src[11]), .B(n_106_8), .CO(n_106_9), .S(n_265));
   AOI222_X1_LVT i_109_20 (.A1(r1_wr), .A2(pc_sw[11]), .B1(n_272), .B2(
      reg_sp_val[11]), .C1(n_271), .C2(n_265), .ZN(n_109_10));
   INV_X1_LVT i_109_21 (.A(n_109_10), .ZN(n_283));
   DFFR_X1_LVT \r1_reg[11]  (.D(n_283), .RN(n_8), .CK(n_270), .Q(r1[11]), .QN());
   NAND2_X1_LVT i_105_234 (.A1(inst_src_in), .A2(r1[11]), .ZN(n_105_223));
   NAND4_X1_LVT i_105_235 (.A1(n_105_220), .A2(n_105_221), .A3(n_105_222), 
      .A4(n_105_223), .ZN(n_105_224));
   AOI22_X1_LVT i_80_23 (.A1(n_80_0), .A2(reg_incr_val[11]), .B1(r12_wr), 
      .B2(pc_sw[11]), .ZN(n_80_12));
   INV_X1_LVT i_80_24 (.A(n_80_12), .ZN(n_191));
   DFFR_X1_LVT \r12_reg[11]  (.D(n_191), .RN(n_8), .CK(n_179), .Q(r12[11]), 
      .QN());
   NAND2_X1_LVT i_105_236 (.A1(n_178), .A2(r12[11]), .ZN(n_105_225));
   AOI22_X1_LVT i_73_23 (.A1(n_73_0), .A2(reg_incr_val[11]), .B1(r11_wr), 
      .B2(pc_sw[11]), .ZN(n_73_12));
   INV_X1_LVT i_73_24 (.A(n_73_12), .ZN(n_172));
   DFFR_X1_LVT \r11_reg[11]  (.D(n_172), .RN(n_8), .CK(n_160), .Q(r11[11]), 
      .QN());
   NAND2_X1_LVT i_105_237 (.A1(n_159), .A2(r11[11]), .ZN(n_105_226));
   AOI22_X1_LVT i_66_23 (.A1(n_66_0), .A2(reg_incr_val[11]), .B1(r10_wr), 
      .B2(pc_sw[11]), .ZN(n_66_12));
   INV_X1_LVT i_66_24 (.A(n_66_12), .ZN(n_153));
   DFFR_X1_LVT \r10_reg[11]  (.D(n_153), .RN(n_8), .CK(n_141), .Q(r10[11]), 
      .QN());
   NAND2_X1_LVT i_105_238 (.A1(n_140), .A2(r10[11]), .ZN(n_105_227));
   AOI22_X1_LVT i_59_23 (.A1(n_59_0), .A2(reg_incr_val[11]), .B1(r9_wr), 
      .B2(pc_sw[11]), .ZN(n_59_12));
   INV_X1_LVT i_59_24 (.A(n_59_12), .ZN(n_134));
   DFFR_X1_LVT \r9_reg[11]  (.D(n_134), .RN(n_8), .CK(n_122), .Q(r9[11]), .QN());
   NAND2_X1_LVT i_105_239 (.A1(n_121), .A2(r9[11]), .ZN(n_105_228));
   NAND4_X1_LVT i_105_240 (.A1(n_105_225), .A2(n_105_226), .A3(n_105_227), 
      .A4(n_105_228), .ZN(n_105_229));
   AOI22_X1_LVT i_52_23 (.A1(n_52_0), .A2(reg_incr_val[11]), .B1(r8_wr), 
      .B2(pc_sw[11]), .ZN(n_52_12));
   INV_X1_LVT i_52_24 (.A(n_52_12), .ZN(n_115));
   DFFR_X1_LVT \r8_reg[11]  (.D(n_115), .RN(n_8), .CK(n_103), .Q(r8[11]), .QN());
   NAND2_X1_LVT i_105_241 (.A1(n_102), .A2(r8[11]), .ZN(n_105_230));
   AOI22_X1_LVT i_45_23 (.A1(n_45_0), .A2(reg_incr_val[11]), .B1(r7_wr), 
      .B2(pc_sw[11]), .ZN(n_45_12));
   INV_X1_LVT i_45_24 (.A(n_45_12), .ZN(n_96));
   DFFR_X1_LVT \r7_reg[11]  (.D(n_96), .RN(n_8), .CK(n_84), .Q(r7[11]), .QN());
   NAND2_X1_LVT i_105_242 (.A1(n_83), .A2(r7[11]), .ZN(n_105_231));
   AOI22_X1_LVT i_38_23 (.A1(n_38_0), .A2(reg_incr_val[11]), .B1(r6_wr), 
      .B2(pc_sw[11]), .ZN(n_38_12));
   INV_X1_LVT i_38_24 (.A(n_38_12), .ZN(n_77));
   DFFR_X1_LVT \r6_reg[11]  (.D(n_77), .RN(n_8), .CK(n_65), .Q(r6[11]), .QN());
   NAND2_X1_LVT i_105_243 (.A1(n_64), .A2(r6[11]), .ZN(n_105_232));
   AOI22_X1_LVT i_31_23 (.A1(n_31_0), .A2(reg_incr_val[11]), .B1(r5_wr), 
      .B2(pc_sw[11]), .ZN(n_31_12));
   INV_X1_LVT i_31_24 (.A(n_31_12), .ZN(n_58));
   DFFR_X1_LVT \r5_reg[11]  (.D(n_58), .RN(n_8), .CK(n_46), .Q(r5[11]), .QN());
   NAND2_X1_LVT i_105_244 (.A1(n_45), .A2(r5[11]), .ZN(n_105_233));
   NAND4_X1_LVT i_105_245 (.A1(n_105_230), .A2(n_105_231), .A3(n_105_232), 
      .A4(n_105_233), .ZN(n_105_234));
   AOI22_X1_LVT i_87_23 (.A1(n_87_0), .A2(reg_incr_val[11]), .B1(r13_wr), 
      .B2(pc_sw[11]), .ZN(n_87_12));
   INV_X1_LVT i_87_24 (.A(n_87_12), .ZN(n_210));
   DFFR_X1_LVT \r13_reg[11]  (.D(n_210), .RN(n_8), .CK(n_198), .Q(r13[11]), 
      .QN());
   AND2_X1_LVT i_105_246 (.A1(n_197), .A2(r13[11]), .ZN(n_105_235));
   NOR4_X1_LVT i_105_247 (.A1(n_105_224), .A2(n_105_229), .A3(n_105_234), 
      .A4(n_105_235), .ZN(n_105_236));
   NAND2_X1_LVT i_105_248 (.A1(n_254), .A2(pc[11]), .ZN(n_105_237));
   AOI22_X1_LVT i_101_23 (.A1(n_101_0), .A2(reg_incr_val[11]), .B1(r15_wr), 
      .B2(pc_sw[11]), .ZN(n_101_12));
   INV_X1_LVT i_101_24 (.A(n_101_12), .ZN(n_248));
   DFFR_X1_LVT \r15_reg[11]  (.D(n_248), .RN(n_8), .CK(n_236), .Q(r15[11]), 
      .QN());
   NAND2_X1_LVT i_105_249 (.A1(n_235), .A2(r15[11]), .ZN(n_105_238));
   AOI22_X1_LVT i_94_23 (.A1(n_94_0), .A2(reg_incr_val[11]), .B1(r14_wr), 
      .B2(pc_sw[11]), .ZN(n_94_12));
   INV_X1_LVT i_94_24 (.A(n_94_12), .ZN(n_229));
   DFFR_X1_LVT \r14_reg[11]  (.D(n_229), .RN(n_8), .CK(n_217), .Q(r14[11]), 
      .QN());
   NAND2_X1_LVT i_105_250 (.A1(n_216), .A2(r14[11]), .ZN(n_105_239));
   NAND4_X1_LVT i_105_251 (.A1(n_105_236), .A2(n_105_237), .A3(n_105_238), 
      .A4(n_105_239), .ZN(reg_src[11]));
   HA_X1_LVT i_22_11 (.A(reg_src[11]), .B(n_22_10), .CO(n_22_11), .S(
      reg_incr_val[11]));
   HA_X1_LVT i_22_12 (.A(reg_src[12]), .B(n_22_11), .CO(n_22_12), .S(
      reg_incr_val[12]));
   AOI22_X1_LVT i_24_25 (.A1(n_24_0), .A2(reg_incr_val[12]), .B1(r4_wr), 
      .B2(pc_sw[12]), .ZN(n_24_13));
   INV_X1_LVT i_24_26 (.A(n_24_13), .ZN(n_40));
   DFFR_X1_LVT \r4_reg[12]  (.D(n_40), .RN(n_8), .CK(n_27), .Q(r4[12]), .QN());
   NAND2_X1_LVT i_105_252 (.A1(n_24), .A2(r4[12]), .ZN(n_105_240));
   DFFR_X1_LVT \r3_reg[12]  (.D(pc_sw[12]), .RN(n_8), .CK(n_23), .Q(r3[12]), 
      .QN());
   NAND2_X1_LVT i_105_253 (.A1(n_22), .A2(r3[12]), .ZN(n_105_241));
   DFFR_X1_LVT \r2_reg[12]  (.D(1'b0), .RN(n_8), .CK(mclk), .Q(n_3), .QN());
   NAND2_X1_LVT i_105_254 (.A1(n_21), .A2(n_3), .ZN(n_105_242));
   AOI222_X1_LVT i_109_22 (.A1(r1_wr), .A2(pc_sw[12]), .B1(n_272), .B2(
      reg_sp_val[12]), .C1(n_271), .C2(n_266), .ZN(n_109_11));
   INV_X1_LVT i_109_23 (.A(n_109_11), .ZN(n_284));
   DFFR_X1_LVT \r1_reg[12]  (.D(n_284), .RN(n_8), .CK(n_270), .Q(r1[12]), .QN());
   NAND2_X1_LVT i_105_255 (.A1(inst_src_in), .A2(r1[12]), .ZN(n_105_243));
   NAND4_X1_LVT i_105_256 (.A1(n_105_240), .A2(n_105_241), .A3(n_105_242), 
      .A4(n_105_243), .ZN(n_105_244));
   AOI22_X1_LVT i_80_25 (.A1(n_80_0), .A2(reg_incr_val[12]), .B1(r12_wr), 
      .B2(pc_sw[12]), .ZN(n_80_13));
   INV_X1_LVT i_80_26 (.A(n_80_13), .ZN(n_192));
   DFFR_X1_LVT \r12_reg[12]  (.D(n_192), .RN(n_8), .CK(n_179), .Q(r12[12]), 
      .QN());
   NAND2_X1_LVT i_105_257 (.A1(n_178), .A2(r12[12]), .ZN(n_105_245));
   AOI22_X1_LVT i_73_25 (.A1(n_73_0), .A2(reg_incr_val[12]), .B1(r11_wr), 
      .B2(pc_sw[12]), .ZN(n_73_13));
   INV_X1_LVT i_73_26 (.A(n_73_13), .ZN(n_173));
   DFFR_X1_LVT \r11_reg[12]  (.D(n_173), .RN(n_8), .CK(n_160), .Q(r11[12]), 
      .QN());
   NAND2_X1_LVT i_105_258 (.A1(n_159), .A2(r11[12]), .ZN(n_105_246));
   AOI22_X1_LVT i_66_25 (.A1(n_66_0), .A2(reg_incr_val[12]), .B1(r10_wr), 
      .B2(pc_sw[12]), .ZN(n_66_13));
   INV_X1_LVT i_66_26 (.A(n_66_13), .ZN(n_154));
   DFFR_X1_LVT \r10_reg[12]  (.D(n_154), .RN(n_8), .CK(n_141), .Q(r10[12]), 
      .QN());
   NAND2_X1_LVT i_105_259 (.A1(n_140), .A2(r10[12]), .ZN(n_105_247));
   AOI22_X1_LVT i_59_25 (.A1(n_59_0), .A2(reg_incr_val[12]), .B1(r9_wr), 
      .B2(pc_sw[12]), .ZN(n_59_13));
   INV_X1_LVT i_59_26 (.A(n_59_13), .ZN(n_135));
   DFFR_X1_LVT \r9_reg[12]  (.D(n_135), .RN(n_8), .CK(n_122), .Q(r9[12]), .QN());
   NAND2_X1_LVT i_105_260 (.A1(n_121), .A2(r9[12]), .ZN(n_105_248));
   NAND4_X1_LVT i_105_261 (.A1(n_105_245), .A2(n_105_246), .A3(n_105_247), 
      .A4(n_105_248), .ZN(n_105_249));
   AOI22_X1_LVT i_52_25 (.A1(n_52_0), .A2(reg_incr_val[12]), .B1(r8_wr), 
      .B2(pc_sw[12]), .ZN(n_52_13));
   INV_X1_LVT i_52_26 (.A(n_52_13), .ZN(n_116));
   DFFR_X1_LVT \r8_reg[12]  (.D(n_116), .RN(n_8), .CK(n_103), .Q(r8[12]), .QN());
   NAND2_X1_LVT i_105_262 (.A1(n_102), .A2(r8[12]), .ZN(n_105_250));
   AOI22_X1_LVT i_45_25 (.A1(n_45_0), .A2(reg_incr_val[12]), .B1(r7_wr), 
      .B2(pc_sw[12]), .ZN(n_45_13));
   INV_X1_LVT i_45_26 (.A(n_45_13), .ZN(n_97));
   DFFR_X1_LVT \r7_reg[12]  (.D(n_97), .RN(n_8), .CK(n_84), .Q(r7[12]), .QN());
   NAND2_X1_LVT i_105_263 (.A1(n_83), .A2(r7[12]), .ZN(n_105_251));
   AOI22_X1_LVT i_38_25 (.A1(n_38_0), .A2(reg_incr_val[12]), .B1(r6_wr), 
      .B2(pc_sw[12]), .ZN(n_38_13));
   INV_X1_LVT i_38_26 (.A(n_38_13), .ZN(n_78));
   DFFR_X1_LVT \r6_reg[12]  (.D(n_78), .RN(n_8), .CK(n_65), .Q(r6[12]), .QN());
   NAND2_X1_LVT i_105_264 (.A1(n_64), .A2(r6[12]), .ZN(n_105_252));
   AOI22_X1_LVT i_31_25 (.A1(n_31_0), .A2(reg_incr_val[12]), .B1(r5_wr), 
      .B2(pc_sw[12]), .ZN(n_31_13));
   INV_X1_LVT i_31_26 (.A(n_31_13), .ZN(n_59));
   DFFR_X1_LVT \r5_reg[12]  (.D(n_59), .RN(n_8), .CK(n_46), .Q(r5[12]), .QN());
   NAND2_X1_LVT i_105_265 (.A1(n_45), .A2(r5[12]), .ZN(n_105_253));
   NAND4_X1_LVT i_105_266 (.A1(n_105_250), .A2(n_105_251), .A3(n_105_252), 
      .A4(n_105_253), .ZN(n_105_254));
   AOI22_X1_LVT i_87_25 (.A1(n_87_0), .A2(reg_incr_val[12]), .B1(r13_wr), 
      .B2(pc_sw[12]), .ZN(n_87_13));
   INV_X1_LVT i_87_26 (.A(n_87_13), .ZN(n_211));
   DFFR_X1_LVT \r13_reg[12]  (.D(n_211), .RN(n_8), .CK(n_198), .Q(r13[12]), 
      .QN());
   AND2_X1_LVT i_105_267 (.A1(n_197), .A2(r13[12]), .ZN(n_105_255));
   NOR4_X1_LVT i_105_268 (.A1(n_105_244), .A2(n_105_249), .A3(n_105_254), 
      .A4(n_105_255), .ZN(n_105_256));
   NAND2_X1_LVT i_105_269 (.A1(n_254), .A2(pc[12]), .ZN(n_105_257));
   AOI22_X1_LVT i_101_25 (.A1(n_101_0), .A2(reg_incr_val[12]), .B1(r15_wr), 
      .B2(pc_sw[12]), .ZN(n_101_13));
   INV_X1_LVT i_101_26 (.A(n_101_13), .ZN(n_249));
   DFFR_X1_LVT \r15_reg[12]  (.D(n_249), .RN(n_8), .CK(n_236), .Q(r15[12]), 
      .QN());
   NAND2_X1_LVT i_105_270 (.A1(n_235), .A2(r15[12]), .ZN(n_105_258));
   AOI22_X1_LVT i_94_25 (.A1(n_94_0), .A2(reg_incr_val[12]), .B1(r14_wr), 
      .B2(pc_sw[12]), .ZN(n_94_13));
   INV_X1_LVT i_94_26 (.A(n_94_13), .ZN(n_230));
   DFFR_X1_LVT \r14_reg[12]  (.D(n_230), .RN(n_8), .CK(n_217), .Q(r14[12]), 
      .QN());
   NAND2_X1_LVT i_105_271 (.A1(n_216), .A2(r14[12]), .ZN(n_105_259));
   NAND4_X1_LVT i_105_272 (.A1(n_105_256), .A2(n_105_257), .A3(n_105_258), 
      .A4(n_105_259), .ZN(reg_src[12]));
   HA_X1_LVT i_106_11 (.A(reg_src[12]), .B(n_106_9), .CO(n_106_10), .S(n_266));
   HA_X1_LVT i_106_12 (.A(reg_src[13]), .B(n_106_10), .CO(n_106_11), .S(n_267));
   AOI222_X1_LVT i_109_24 (.A1(r1_wr), .A2(pc_sw[13]), .B1(n_272), .B2(
      reg_sp_val[13]), .C1(n_271), .C2(n_267), .ZN(n_109_12));
   INV_X1_LVT i_109_25 (.A(n_109_12), .ZN(n_285));
   DFFR_X1_LVT \r1_reg[13]  (.D(n_285), .RN(n_8), .CK(n_270), .Q(r1[13]), .QN());
   NAND2_X1_LVT i_105_276 (.A1(inst_src_in), .A2(r1[13]), .ZN(n_105_263));
   NAND4_X1_LVT i_105_277 (.A1(n_105_260), .A2(n_105_261), .A3(n_105_262), 
      .A4(n_105_263), .ZN(n_105_264));
   AOI22_X1_LVT i_80_27 (.A1(n_80_0), .A2(reg_incr_val[13]), .B1(r12_wr), 
      .B2(pc_sw[13]), .ZN(n_80_14));
   INV_X1_LVT i_80_28 (.A(n_80_14), .ZN(n_193));
   DFFR_X1_LVT \r12_reg[13]  (.D(n_193), .RN(n_8), .CK(n_179), .Q(r12[13]), 
      .QN());
   NAND2_X1_LVT i_105_278 (.A1(n_178), .A2(r12[13]), .ZN(n_105_265));
   AOI22_X1_LVT i_73_27 (.A1(n_73_0), .A2(reg_incr_val[13]), .B1(r11_wr), 
      .B2(pc_sw[13]), .ZN(n_73_14));
   INV_X1_LVT i_73_28 (.A(n_73_14), .ZN(n_174));
   DFFR_X1_LVT \r11_reg[13]  (.D(n_174), .RN(n_8), .CK(n_160), .Q(r11[13]), 
      .QN());
   NAND2_X1_LVT i_105_279 (.A1(n_159), .A2(r11[13]), .ZN(n_105_266));
   AOI22_X1_LVT i_66_27 (.A1(n_66_0), .A2(reg_incr_val[13]), .B1(r10_wr), 
      .B2(pc_sw[13]), .ZN(n_66_14));
   INV_X1_LVT i_66_28 (.A(n_66_14), .ZN(n_155));
   DFFR_X1_LVT \r10_reg[13]  (.D(n_155), .RN(n_8), .CK(n_141), .Q(r10[13]), 
      .QN());
   NAND2_X1_LVT i_105_280 (.A1(n_140), .A2(r10[13]), .ZN(n_105_267));
   AOI22_X1_LVT i_59_27 (.A1(n_59_0), .A2(reg_incr_val[13]), .B1(r9_wr), 
      .B2(pc_sw[13]), .ZN(n_59_14));
   INV_X1_LVT i_59_28 (.A(n_59_14), .ZN(n_136));
   DFFR_X1_LVT \r9_reg[13]  (.D(n_136), .RN(n_8), .CK(n_122), .Q(r9[13]), .QN());
   NAND2_X1_LVT i_105_281 (.A1(n_121), .A2(r9[13]), .ZN(n_105_268));
   NAND4_X1_LVT i_105_282 (.A1(n_105_265), .A2(n_105_266), .A3(n_105_267), 
      .A4(n_105_268), .ZN(n_105_269));
   AOI22_X1_LVT i_52_27 (.A1(n_52_0), .A2(reg_incr_val[13]), .B1(r8_wr), 
      .B2(pc_sw[13]), .ZN(n_52_14));
   INV_X1_LVT i_52_28 (.A(n_52_14), .ZN(n_117));
   DFFR_X1_LVT \r8_reg[13]  (.D(n_117), .RN(n_8), .CK(n_103), .Q(r8[13]), .QN());
   NAND2_X1_LVT i_105_283 (.A1(n_102), .A2(r8[13]), .ZN(n_105_270));
   AOI22_X1_LVT i_45_27 (.A1(n_45_0), .A2(reg_incr_val[13]), .B1(r7_wr), 
      .B2(pc_sw[13]), .ZN(n_45_14));
   INV_X1_LVT i_45_28 (.A(n_45_14), .ZN(n_98));
   DFFR_X1_LVT \r7_reg[13]  (.D(n_98), .RN(n_8), .CK(n_84), .Q(r7[13]), .QN());
   NAND2_X1_LVT i_105_284 (.A1(n_83), .A2(r7[13]), .ZN(n_105_271));
   AOI22_X1_LVT i_38_27 (.A1(n_38_0), .A2(reg_incr_val[13]), .B1(r6_wr), 
      .B2(pc_sw[13]), .ZN(n_38_14));
   INV_X1_LVT i_38_28 (.A(n_38_14), .ZN(n_79));
   DFFR_X1_LVT \r6_reg[13]  (.D(n_79), .RN(n_8), .CK(n_65), .Q(r6[13]), .QN());
   NAND2_X1_LVT i_105_285 (.A1(n_64), .A2(r6[13]), .ZN(n_105_272));
   AOI22_X1_LVT i_31_27 (.A1(n_31_0), .A2(reg_incr_val[13]), .B1(r5_wr), 
      .B2(pc_sw[13]), .ZN(n_31_14));
   INV_X1_LVT i_31_28 (.A(n_31_14), .ZN(n_60));
   DFFR_X1_LVT \r5_reg[13]  (.D(n_60), .RN(n_8), .CK(n_46), .Q(r5[13]), .QN());
   NAND2_X1_LVT i_105_286 (.A1(n_45), .A2(r5[13]), .ZN(n_105_273));
   NAND4_X1_LVT i_105_287 (.A1(n_105_270), .A2(n_105_271), .A3(n_105_272), 
      .A4(n_105_273), .ZN(n_105_274));
   AOI22_X1_LVT i_87_27 (.A1(n_87_0), .A2(reg_incr_val[13]), .B1(r13_wr), 
      .B2(pc_sw[13]), .ZN(n_87_14));
   INV_X1_LVT i_87_28 (.A(n_87_14), .ZN(n_212));
   DFFR_X1_LVT \r13_reg[13]  (.D(n_212), .RN(n_8), .CK(n_198), .Q(r13[13]), 
      .QN());
   AND2_X1_LVT i_105_288 (.A1(n_197), .A2(r13[13]), .ZN(n_105_275));
   NOR4_X1_LVT i_105_289 (.A1(n_105_264), .A2(n_105_269), .A3(n_105_274), 
      .A4(n_105_275), .ZN(n_105_276));
   NAND2_X1_LVT i_105_290 (.A1(n_254), .A2(pc[13]), .ZN(n_105_277));
   AOI22_X1_LVT i_101_27 (.A1(n_101_0), .A2(reg_incr_val[13]), .B1(r15_wr), 
      .B2(pc_sw[13]), .ZN(n_101_14));
   INV_X1_LVT i_101_28 (.A(n_101_14), .ZN(n_250));
   DFFR_X1_LVT \r15_reg[13]  (.D(n_250), .RN(n_8), .CK(n_236), .Q(r15[13]), 
      .QN());
   NAND2_X1_LVT i_105_291 (.A1(n_235), .A2(r15[13]), .ZN(n_105_278));
   AOI22_X1_LVT i_94_27 (.A1(n_94_0), .A2(reg_incr_val[13]), .B1(r14_wr), 
      .B2(pc_sw[13]), .ZN(n_94_14));
   INV_X1_LVT i_94_28 (.A(n_94_14), .ZN(n_231));
   DFFR_X1_LVT \r14_reg[13]  (.D(n_231), .RN(n_8), .CK(n_217), .Q(r14[13]), 
      .QN());
   NAND2_X1_LVT i_105_292 (.A1(n_216), .A2(r14[13]), .ZN(n_105_279));
   NAND4_X1_LVT i_105_293 (.A1(n_105_276), .A2(n_105_277), .A3(n_105_278), 
      .A4(n_105_279), .ZN(reg_src[13]));
   HA_X1_LVT i_22_13 (.A(reg_src[13]), .B(n_22_12), .CO(n_22_13), .S(
      reg_incr_val[13]));
   HA_X1_LVT i_22_14 (.A(reg_src[14]), .B(n_22_13), .CO(n_22_14), .S(
      reg_incr_val[14]));
   AOI22_X1_LVT i_24_29 (.A1(n_24_0), .A2(reg_incr_val[14]), .B1(r4_wr), 
      .B2(pc_sw[14]), .ZN(n_24_15));
   INV_X1_LVT i_24_30 (.A(n_24_15), .ZN(n_42));
   DFFR_X1_LVT \r4_reg[14]  (.D(n_42), .RN(n_8), .CK(n_27), .Q(r4[14]), .QN());
   NAND2_X1_LVT i_105_294 (.A1(n_24), .A2(r4[14]), .ZN(n_105_280));
   DFFR_X1_LVT \r3_reg[14]  (.D(pc_sw[14]), .RN(n_8), .CK(n_23), .Q(r3[14]), 
      .QN());
   NAND2_X1_LVT i_105_295 (.A1(n_22), .A2(r3[14]), .ZN(n_105_281));
   DFFR_X1_LVT \r2_reg[14]  (.D(1'b0), .RN(n_8), .CK(mclk), .Q(n_1), .QN());
   NAND2_X1_LVT i_105_296 (.A1(n_21), .A2(n_1), .ZN(n_105_282));
   AOI222_X1_LVT i_109_26 (.A1(r1_wr), .A2(pc_sw[14]), .B1(n_272), .B2(
      reg_sp_val[14]), .C1(n_271), .C2(n_268), .ZN(n_109_13));
   INV_X1_LVT i_109_27 (.A(n_109_13), .ZN(n_286));
   DFFR_X1_LVT \r1_reg[14]  (.D(n_286), .RN(n_8), .CK(n_270), .Q(r1[14]), .QN());
   NAND2_X1_LVT i_105_297 (.A1(inst_src_in), .A2(r1[14]), .ZN(n_105_283));
   NAND4_X1_LVT i_105_298 (.A1(n_105_280), .A2(n_105_281), .A3(n_105_282), 
      .A4(n_105_283), .ZN(n_105_284));
   AOI22_X1_LVT i_80_29 (.A1(n_80_0), .A2(reg_incr_val[14]), .B1(r12_wr), 
      .B2(pc_sw[14]), .ZN(n_80_15));
   INV_X1_LVT i_80_30 (.A(n_80_15), .ZN(n_194));
   DFFR_X1_LVT \r12_reg[14]  (.D(n_194), .RN(n_8), .CK(n_179), .Q(r12[14]), 
      .QN());
   NAND2_X1_LVT i_105_299 (.A1(n_178), .A2(r12[14]), .ZN(n_105_285));
   AOI22_X1_LVT i_73_29 (.A1(n_73_0), .A2(reg_incr_val[14]), .B1(r11_wr), 
      .B2(pc_sw[14]), .ZN(n_73_15));
   INV_X1_LVT i_73_30 (.A(n_73_15), .ZN(n_175));
   DFFR_X1_LVT \r11_reg[14]  (.D(n_175), .RN(n_8), .CK(n_160), .Q(r11[14]), 
      .QN());
   NAND2_X1_LVT i_105_300 (.A1(n_159), .A2(r11[14]), .ZN(n_105_286));
   AOI22_X1_LVT i_66_29 (.A1(n_66_0), .A2(reg_incr_val[14]), .B1(r10_wr), 
      .B2(pc_sw[14]), .ZN(n_66_15));
   INV_X1_LVT i_66_30 (.A(n_66_15), .ZN(n_156));
   DFFR_X1_LVT \r10_reg[14]  (.D(n_156), .RN(n_8), .CK(n_141), .Q(r10[14]), 
      .QN());
   NAND2_X1_LVT i_105_301 (.A1(n_140), .A2(r10[14]), .ZN(n_105_287));
   AOI22_X1_LVT i_59_29 (.A1(n_59_0), .A2(reg_incr_val[14]), .B1(r9_wr), 
      .B2(pc_sw[14]), .ZN(n_59_15));
   INV_X1_LVT i_59_30 (.A(n_59_15), .ZN(n_137));
   DFFR_X1_LVT \r9_reg[14]  (.D(n_137), .RN(n_8), .CK(n_122), .Q(r9[14]), .QN());
   NAND2_X1_LVT i_105_302 (.A1(n_121), .A2(r9[14]), .ZN(n_105_288));
   NAND4_X1_LVT i_105_303 (.A1(n_105_285), .A2(n_105_286), .A3(n_105_287), 
      .A4(n_105_288), .ZN(n_105_289));
   AOI22_X1_LVT i_52_29 (.A1(n_52_0), .A2(reg_incr_val[14]), .B1(r8_wr), 
      .B2(pc_sw[14]), .ZN(n_52_15));
   INV_X1_LVT i_52_30 (.A(n_52_15), .ZN(n_118));
   DFFR_X1_LVT \r8_reg[14]  (.D(n_118), .RN(n_8), .CK(n_103), .Q(r8[14]), .QN());
   NAND2_X1_LVT i_105_304 (.A1(n_102), .A2(r8[14]), .ZN(n_105_290));
   AOI22_X1_LVT i_45_29 (.A1(n_45_0), .A2(reg_incr_val[14]), .B1(r7_wr), 
      .B2(pc_sw[14]), .ZN(n_45_15));
   INV_X1_LVT i_45_30 (.A(n_45_15), .ZN(n_99));
   DFFR_X1_LVT \r7_reg[14]  (.D(n_99), .RN(n_8), .CK(n_84), .Q(r7[14]), .QN());
   NAND2_X1_LVT i_105_305 (.A1(n_83), .A2(r7[14]), .ZN(n_105_291));
   AOI22_X1_LVT i_38_29 (.A1(n_38_0), .A2(reg_incr_val[14]), .B1(r6_wr), 
      .B2(pc_sw[14]), .ZN(n_38_15));
   INV_X1_LVT i_38_30 (.A(n_38_15), .ZN(n_80));
   DFFR_X1_LVT \r6_reg[14]  (.D(n_80), .RN(n_8), .CK(n_65), .Q(r6[14]), .QN());
   NAND2_X1_LVT i_105_306 (.A1(n_64), .A2(r6[14]), .ZN(n_105_292));
   AOI22_X1_LVT i_31_29 (.A1(n_31_0), .A2(reg_incr_val[14]), .B1(r5_wr), 
      .B2(pc_sw[14]), .ZN(n_31_15));
   INV_X1_LVT i_31_30 (.A(n_31_15), .ZN(n_61));
   DFFR_X1_LVT \r5_reg[14]  (.D(n_61), .RN(n_8), .CK(n_46), .Q(r5[14]), .QN());
   NAND2_X1_LVT i_105_307 (.A1(n_45), .A2(r5[14]), .ZN(n_105_293));
   NAND4_X1_LVT i_105_308 (.A1(n_105_290), .A2(n_105_291), .A3(n_105_292), 
      .A4(n_105_293), .ZN(n_105_294));
   AOI22_X1_LVT i_87_29 (.A1(n_87_0), .A2(reg_incr_val[14]), .B1(r13_wr), 
      .B2(pc_sw[14]), .ZN(n_87_15));
   INV_X1_LVT i_87_30 (.A(n_87_15), .ZN(n_213));
   DFFR_X1_LVT \r13_reg[14]  (.D(n_213), .RN(n_8), .CK(n_198), .Q(r13[14]), 
      .QN());
   AND2_X1_LVT i_105_309 (.A1(n_197), .A2(r13[14]), .ZN(n_105_295));
   NOR4_X1_LVT i_105_310 (.A1(n_105_284), .A2(n_105_289), .A3(n_105_294), 
      .A4(n_105_295), .ZN(n_105_296));
   NAND2_X1_LVT i_105_311 (.A1(n_254), .A2(pc[14]), .ZN(n_105_297));
   AOI22_X1_LVT i_101_29 (.A1(n_101_0), .A2(reg_incr_val[14]), .B1(r15_wr), 
      .B2(pc_sw[14]), .ZN(n_101_15));
   INV_X1_LVT i_101_30 (.A(n_101_15), .ZN(n_251));
   DFFR_X1_LVT \r15_reg[14]  (.D(n_251), .RN(n_8), .CK(n_236), .Q(r15[14]), 
      .QN());
   NAND2_X1_LVT i_105_312 (.A1(n_235), .A2(r15[14]), .ZN(n_105_298));
   AOI22_X1_LVT i_94_29 (.A1(n_94_0), .A2(reg_incr_val[14]), .B1(r14_wr), 
      .B2(pc_sw[14]), .ZN(n_94_15));
   INV_X1_LVT i_94_30 (.A(n_94_15), .ZN(n_232));
   DFFR_X1_LVT \r14_reg[14]  (.D(n_232), .RN(n_8), .CK(n_217), .Q(r14[14]), 
      .QN());
   NAND2_X1_LVT i_105_313 (.A1(n_216), .A2(r14[14]), .ZN(n_105_299));
   NAND4_X1_LVT i_105_314 (.A1(n_105_296), .A2(n_105_297), .A3(n_105_298), 
      .A4(n_105_299), .ZN(reg_src[14]));
   HA_X1_LVT i_106_13 (.A(reg_src[14]), .B(n_106_11), .CO(n_106_12), .S(n_268));
   XNOR2_X1_LVT i_106_14 (.A(reg_src[15]), .B(n_106_12), .ZN(n_106_13));
   INV_X1_LVT i_106_15 (.A(n_106_13), .ZN(n_269));
   AOI222_X1_LVT i_109_28 (.A1(r1_wr), .A2(pc_sw[15]), .B1(n_272), .B2(
      reg_sp_val[15]), .C1(n_271), .C2(n_269), .ZN(n_109_14));
   INV_X1_LVT i_109_29 (.A(n_109_14), .ZN(n_287));
   DFFR_X1_LVT \r1_reg[15]  (.D(n_287), .RN(n_8), .CK(n_270), .Q(r1[15]), .QN());
   NAND2_X1_LVT i_105_318 (.A1(inst_src_in), .A2(r1[15]), .ZN(n_105_303));
   NAND4_X1_LVT i_105_319 (.A1(n_105_300), .A2(n_105_301), .A3(n_105_302), 
      .A4(n_105_303), .ZN(n_105_304));
   AOI22_X1_LVT i_80_31 (.A1(n_80_0), .A2(reg_incr_val[15]), .B1(r12_wr), 
      .B2(pc_sw[15]), .ZN(n_80_16));
   INV_X1_LVT i_80_32 (.A(n_80_16), .ZN(n_195));
   DFFR_X1_LVT \r12_reg[15]  (.D(n_195), .RN(n_8), .CK(n_179), .Q(r12[15]), 
      .QN());
   NAND2_X1_LVT i_105_320 (.A1(n_178), .A2(r12[15]), .ZN(n_105_305));
   AOI22_X1_LVT i_73_31 (.A1(n_73_0), .A2(reg_incr_val[15]), .B1(r11_wr), 
      .B2(pc_sw[15]), .ZN(n_73_16));
   INV_X1_LVT i_73_32 (.A(n_73_16), .ZN(n_176));
   DFFR_X1_LVT \r11_reg[15]  (.D(n_176), .RN(n_8), .CK(n_160), .Q(r11[15]), 
      .QN());
   NAND2_X1_LVT i_105_321 (.A1(n_159), .A2(r11[15]), .ZN(n_105_306));
   AOI22_X1_LVT i_66_31 (.A1(n_66_0), .A2(reg_incr_val[15]), .B1(r10_wr), 
      .B2(pc_sw[15]), .ZN(n_66_16));
   INV_X1_LVT i_66_32 (.A(n_66_16), .ZN(n_157));
   DFFR_X1_LVT \r10_reg[15]  (.D(n_157), .RN(n_8), .CK(n_141), .Q(r10[15]), 
      .QN());
   NAND2_X1_LVT i_105_322 (.A1(n_140), .A2(r10[15]), .ZN(n_105_307));
   AOI22_X1_LVT i_59_31 (.A1(n_59_0), .A2(reg_incr_val[15]), .B1(r9_wr), 
      .B2(pc_sw[15]), .ZN(n_59_16));
   INV_X1_LVT i_59_32 (.A(n_59_16), .ZN(n_138));
   DFFR_X1_LVT \r9_reg[15]  (.D(n_138), .RN(n_8), .CK(n_122), .Q(r9[15]), .QN());
   NAND2_X1_LVT i_105_323 (.A1(n_121), .A2(r9[15]), .ZN(n_105_308));
   NAND4_X1_LVT i_105_324 (.A1(n_105_305), .A2(n_105_306), .A3(n_105_307), 
      .A4(n_105_308), .ZN(n_105_309));
   AOI22_X1_LVT i_52_31 (.A1(n_52_0), .A2(reg_incr_val[15]), .B1(r8_wr), 
      .B2(pc_sw[15]), .ZN(n_52_16));
   INV_X1_LVT i_52_32 (.A(n_52_16), .ZN(n_119));
   DFFR_X1_LVT \r8_reg[15]  (.D(n_119), .RN(n_8), .CK(n_103), .Q(r8[15]), .QN());
   NAND2_X1_LVT i_105_325 (.A1(n_102), .A2(r8[15]), .ZN(n_105_310));
   AOI22_X1_LVT i_45_31 (.A1(n_45_0), .A2(reg_incr_val[15]), .B1(r7_wr), 
      .B2(pc_sw[15]), .ZN(n_45_16));
   INV_X1_LVT i_45_32 (.A(n_45_16), .ZN(n_100));
   DFFR_X1_LVT \r7_reg[15]  (.D(n_100), .RN(n_8), .CK(n_84), .Q(r7[15]), .QN());
   NAND2_X1_LVT i_105_326 (.A1(n_83), .A2(r7[15]), .ZN(n_105_311));
   AOI22_X1_LVT i_38_31 (.A1(n_38_0), .A2(reg_incr_val[15]), .B1(r6_wr), 
      .B2(pc_sw[15]), .ZN(n_38_16));
   INV_X1_LVT i_38_32 (.A(n_38_16), .ZN(n_81));
   DFFR_X1_LVT \r6_reg[15]  (.D(n_81), .RN(n_8), .CK(n_65), .Q(r6[15]), .QN());
   NAND2_X1_LVT i_105_327 (.A1(n_64), .A2(r6[15]), .ZN(n_105_312));
   AOI22_X1_LVT i_31_31 (.A1(n_31_0), .A2(reg_incr_val[15]), .B1(r5_wr), 
      .B2(pc_sw[15]), .ZN(n_31_16));
   INV_X1_LVT i_31_32 (.A(n_31_16), .ZN(n_62));
   DFFR_X1_LVT \r5_reg[15]  (.D(n_62), .RN(n_8), .CK(n_46), .Q(r5[15]), .QN());
   NAND2_X1_LVT i_105_328 (.A1(n_45), .A2(r5[15]), .ZN(n_105_313));
   NAND4_X1_LVT i_105_329 (.A1(n_105_310), .A2(n_105_311), .A3(n_105_312), 
      .A4(n_105_313), .ZN(n_105_314));
   AOI22_X1_LVT i_87_31 (.A1(n_87_0), .A2(reg_incr_val[15]), .B1(r13_wr), 
      .B2(pc_sw[15]), .ZN(n_87_16));
   INV_X1_LVT i_87_32 (.A(n_87_16), .ZN(n_214));
   DFFR_X1_LVT \r13_reg[15]  (.D(n_214), .RN(n_8), .CK(n_198), .Q(r13[15]), 
      .QN());
   AND2_X1_LVT i_105_330 (.A1(n_197), .A2(r13[15]), .ZN(n_105_315));
   NOR4_X1_LVT i_105_331 (.A1(n_105_304), .A2(n_105_309), .A3(n_105_314), 
      .A4(n_105_315), .ZN(n_105_316));
   NAND2_X1_LVT i_105_332 (.A1(n_254), .A2(pc[15]), .ZN(n_105_317));
   AOI22_X1_LVT i_101_31 (.A1(n_101_0), .A2(reg_incr_val[15]), .B1(r15_wr), 
      .B2(pc_sw[15]), .ZN(n_101_16));
   INV_X1_LVT i_101_32 (.A(n_101_16), .ZN(n_252));
   DFFR_X1_LVT \r15_reg[15]  (.D(n_252), .RN(n_8), .CK(n_236), .Q(r15[15]), 
      .QN());
   NAND2_X1_LVT i_105_333 (.A1(n_235), .A2(r15[15]), .ZN(n_105_318));
   AOI22_X1_LVT i_94_31 (.A1(n_94_0), .A2(reg_incr_val[15]), .B1(r14_wr), 
      .B2(pc_sw[15]), .ZN(n_94_16));
   INV_X1_LVT i_94_32 (.A(n_94_16), .ZN(n_233));
   DFFR_X1_LVT \r14_reg[15]  (.D(n_233), .RN(n_8), .CK(n_217), .Q(r14[15]), 
      .QN());
   NAND2_X1_LVT i_105_334 (.A1(n_216), .A2(r14[15]), .ZN(n_105_319));
   NAND4_X1_LVT i_105_335 (.A1(n_105_316), .A2(n_105_317), .A3(n_105_318), 
      .A4(n_105_319), .ZN(reg_src[15]));
   XNOR2_X1_LVT i_22_15 (.A(reg_src[15]), .B(n_22_14), .ZN(n_22_15));
   INV_X1_LVT i_22_16 (.A(n_22_15), .ZN(reg_incr_val[15]));
   AOI22_X1_LVT i_24_31 (.A1(n_24_0), .A2(reg_incr_val[15]), .B1(r4_wr), 
      .B2(pc_sw[15]), .ZN(n_24_16));
   INV_X1_LVT i_24_32 (.A(n_24_16), .ZN(n_43));
   DFFR_X1_LVT \r4_reg[15]  (.D(n_43), .RN(n_8), .CK(n_27), .Q(r4[15]), .QN());
   NAND2_X1_LVT i_112_315 (.A1(inst_dest[4]), .A2(r4[15]), .ZN(n_112_300));
   NAND2_X1_LVT i_112_316 (.A1(inst_dest[3]), .A2(r3[15]), .ZN(n_112_301));
   NAND2_X1_LVT i_112_317 (.A1(inst_dest[2]), .A2(n_0), .ZN(n_112_302));
   NAND2_X1_LVT i_112_318 (.A1(inst_dest[1]), .A2(r1[15]), .ZN(n_112_303));
   NAND4_X1_LVT i_112_319 (.A1(n_112_300), .A2(n_112_301), .A3(n_112_302), 
      .A4(n_112_303), .ZN(n_112_304));
   NAND2_X1_LVT i_112_320 (.A1(inst_dest[12]), .A2(r12[15]), .ZN(n_112_305));
   NAND2_X1_LVT i_112_321 (.A1(inst_dest[11]), .A2(r11[15]), .ZN(n_112_306));
   NAND2_X1_LVT i_112_322 (.A1(inst_dest[10]), .A2(r10[15]), .ZN(n_112_307));
   NAND2_X1_LVT i_112_323 (.A1(inst_dest[9]), .A2(r9[15]), .ZN(n_112_308));
   NAND4_X1_LVT i_112_324 (.A1(n_112_305), .A2(n_112_306), .A3(n_112_307), 
      .A4(n_112_308), .ZN(n_112_309));
   NAND2_X1_LVT i_112_325 (.A1(inst_dest[8]), .A2(r8[15]), .ZN(n_112_310));
   NAND2_X1_LVT i_112_326 (.A1(inst_dest[7]), .A2(r7[15]), .ZN(n_112_311));
   NAND2_X1_LVT i_112_327 (.A1(inst_dest[6]), .A2(r6[15]), .ZN(n_112_312));
   NAND2_X1_LVT i_112_328 (.A1(inst_dest[5]), .A2(r5[15]), .ZN(n_112_313));
   NAND4_X1_LVT i_112_329 (.A1(n_112_310), .A2(n_112_311), .A3(n_112_312), 
      .A4(n_112_313), .ZN(n_112_314));
   AND2_X1_LVT i_112_330 (.A1(inst_dest[13]), .A2(r13[15]), .ZN(n_112_315));
   NOR4_X1_LVT i_112_331 (.A1(n_112_304), .A2(n_112_309), .A3(n_112_314), 
      .A4(n_112_315), .ZN(n_112_316));
   NAND2_X1_LVT i_112_332 (.A1(inst_dest[0]), .A2(pc[15]), .ZN(n_112_317));
   NAND2_X1_LVT i_112_333 (.A1(inst_dest[15]), .A2(r15[15]), .ZN(n_112_318));
   NAND2_X1_LVT i_112_334 (.A1(inst_dest[14]), .A2(r14[15]), .ZN(n_112_319));
   NAND4_X1_LVT i_112_335 (.A1(n_112_316), .A2(n_112_317), .A3(n_112_318), 
      .A4(n_112_319), .ZN(reg_dest[15]));
   NAND2_X1_LVT i_112_294 (.A1(inst_dest[4]), .A2(r4[14]), .ZN(n_112_280));
   NAND2_X1_LVT i_112_295 (.A1(inst_dest[3]), .A2(r3[14]), .ZN(n_112_281));
   NAND2_X1_LVT i_112_296 (.A1(inst_dest[2]), .A2(n_1), .ZN(n_112_282));
   NAND2_X1_LVT i_112_297 (.A1(inst_dest[1]), .A2(r1[14]), .ZN(n_112_283));
   NAND4_X1_LVT i_112_298 (.A1(n_112_280), .A2(n_112_281), .A3(n_112_282), 
      .A4(n_112_283), .ZN(n_112_284));
   NAND2_X1_LVT i_112_299 (.A1(inst_dest[12]), .A2(r12[14]), .ZN(n_112_285));
   NAND2_X1_LVT i_112_300 (.A1(inst_dest[11]), .A2(r11[14]), .ZN(n_112_286));
   NAND2_X1_LVT i_112_301 (.A1(inst_dest[10]), .A2(r10[14]), .ZN(n_112_287));
   NAND2_X1_LVT i_112_302 (.A1(inst_dest[9]), .A2(r9[14]), .ZN(n_112_288));
   NAND4_X1_LVT i_112_303 (.A1(n_112_285), .A2(n_112_286), .A3(n_112_287), 
      .A4(n_112_288), .ZN(n_112_289));
   NAND2_X1_LVT i_112_304 (.A1(inst_dest[8]), .A2(r8[14]), .ZN(n_112_290));
   NAND2_X1_LVT i_112_305 (.A1(inst_dest[7]), .A2(r7[14]), .ZN(n_112_291));
   NAND2_X1_LVT i_112_306 (.A1(inst_dest[6]), .A2(r6[14]), .ZN(n_112_292));
   NAND2_X1_LVT i_112_307 (.A1(inst_dest[5]), .A2(r5[14]), .ZN(n_112_293));
   NAND4_X1_LVT i_112_308 (.A1(n_112_290), .A2(n_112_291), .A3(n_112_292), 
      .A4(n_112_293), .ZN(n_112_294));
   AND2_X1_LVT i_112_309 (.A1(inst_dest[13]), .A2(r13[14]), .ZN(n_112_295));
   NOR4_X1_LVT i_112_310 (.A1(n_112_284), .A2(n_112_289), .A3(n_112_294), 
      .A4(n_112_295), .ZN(n_112_296));
   NAND2_X1_LVT i_112_311 (.A1(inst_dest[0]), .A2(pc[14]), .ZN(n_112_297));
   NAND2_X1_LVT i_112_312 (.A1(inst_dest[15]), .A2(r15[14]), .ZN(n_112_298));
   NAND2_X1_LVT i_112_313 (.A1(inst_dest[14]), .A2(r14[14]), .ZN(n_112_299));
   NAND4_X1_LVT i_112_314 (.A1(n_112_296), .A2(n_112_297), .A3(n_112_298), 
      .A4(n_112_299), .ZN(reg_dest[14]));
   NAND2_X1_LVT i_112_273 (.A1(inst_dest[4]), .A2(r4[13]), .ZN(n_112_260));
   NAND2_X1_LVT i_112_274 (.A1(inst_dest[3]), .A2(r3[13]), .ZN(n_112_261));
   NAND2_X1_LVT i_112_275 (.A1(inst_dest[2]), .A2(n_2), .ZN(n_112_262));
   NAND2_X1_LVT i_112_276 (.A1(inst_dest[1]), .A2(r1[13]), .ZN(n_112_263));
   NAND4_X1_LVT i_112_277 (.A1(n_112_260), .A2(n_112_261), .A3(n_112_262), 
      .A4(n_112_263), .ZN(n_112_264));
   NAND2_X1_LVT i_112_278 (.A1(inst_dest[12]), .A2(r12[13]), .ZN(n_112_265));
   NAND2_X1_LVT i_112_279 (.A1(inst_dest[11]), .A2(r11[13]), .ZN(n_112_266));
   NAND2_X1_LVT i_112_280 (.A1(inst_dest[10]), .A2(r10[13]), .ZN(n_112_267));
   NAND2_X1_LVT i_112_281 (.A1(inst_dest[9]), .A2(r9[13]), .ZN(n_112_268));
   NAND4_X1_LVT i_112_282 (.A1(n_112_265), .A2(n_112_266), .A3(n_112_267), 
      .A4(n_112_268), .ZN(n_112_269));
   NAND2_X1_LVT i_112_283 (.A1(inst_dest[8]), .A2(r8[13]), .ZN(n_112_270));
   NAND2_X1_LVT i_112_284 (.A1(inst_dest[7]), .A2(r7[13]), .ZN(n_112_271));
   NAND2_X1_LVT i_112_285 (.A1(inst_dest[6]), .A2(r6[13]), .ZN(n_112_272));
   NAND2_X1_LVT i_112_286 (.A1(inst_dest[5]), .A2(r5[13]), .ZN(n_112_273));
   NAND4_X1_LVT i_112_287 (.A1(n_112_270), .A2(n_112_271), .A3(n_112_272), 
      .A4(n_112_273), .ZN(n_112_274));
   AND2_X1_LVT i_112_288 (.A1(inst_dest[13]), .A2(r13[13]), .ZN(n_112_275));
   NOR4_X1_LVT i_112_289 (.A1(n_112_264), .A2(n_112_269), .A3(n_112_274), 
      .A4(n_112_275), .ZN(n_112_276));
   NAND2_X1_LVT i_112_290 (.A1(inst_dest[0]), .A2(pc[13]), .ZN(n_112_277));
   NAND2_X1_LVT i_112_291 (.A1(inst_dest[15]), .A2(r15[13]), .ZN(n_112_278));
   NAND2_X1_LVT i_112_292 (.A1(inst_dest[14]), .A2(r14[13]), .ZN(n_112_279));
   NAND4_X1_LVT i_112_293 (.A1(n_112_276), .A2(n_112_277), .A3(n_112_278), 
      .A4(n_112_279), .ZN(reg_dest[13]));
   NAND2_X1_LVT i_112_252 (.A1(inst_dest[4]), .A2(r4[12]), .ZN(n_112_240));
   NAND2_X1_LVT i_112_253 (.A1(inst_dest[3]), .A2(r3[12]), .ZN(n_112_241));
   NAND2_X1_LVT i_112_254 (.A1(inst_dest[2]), .A2(n_3), .ZN(n_112_242));
   NAND2_X1_LVT i_112_255 (.A1(inst_dest[1]), .A2(r1[12]), .ZN(n_112_243));
   NAND4_X1_LVT i_112_256 (.A1(n_112_240), .A2(n_112_241), .A3(n_112_242), 
      .A4(n_112_243), .ZN(n_112_244));
   NAND2_X1_LVT i_112_257 (.A1(inst_dest[12]), .A2(r12[12]), .ZN(n_112_245));
   NAND2_X1_LVT i_112_258 (.A1(inst_dest[11]), .A2(r11[12]), .ZN(n_112_246));
   NAND2_X1_LVT i_112_259 (.A1(inst_dest[10]), .A2(r10[12]), .ZN(n_112_247));
   NAND2_X1_LVT i_112_260 (.A1(inst_dest[9]), .A2(r9[12]), .ZN(n_112_248));
   NAND4_X1_LVT i_112_261 (.A1(n_112_245), .A2(n_112_246), .A3(n_112_247), 
      .A4(n_112_248), .ZN(n_112_249));
   NAND2_X1_LVT i_112_262 (.A1(inst_dest[8]), .A2(r8[12]), .ZN(n_112_250));
   NAND2_X1_LVT i_112_263 (.A1(inst_dest[7]), .A2(r7[12]), .ZN(n_112_251));
   NAND2_X1_LVT i_112_264 (.A1(inst_dest[6]), .A2(r6[12]), .ZN(n_112_252));
   NAND2_X1_LVT i_112_265 (.A1(inst_dest[5]), .A2(r5[12]), .ZN(n_112_253));
   NAND4_X1_LVT i_112_266 (.A1(n_112_250), .A2(n_112_251), .A3(n_112_252), 
      .A4(n_112_253), .ZN(n_112_254));
   AND2_X1_LVT i_112_267 (.A1(inst_dest[13]), .A2(r13[12]), .ZN(n_112_255));
   NOR4_X1_LVT i_112_268 (.A1(n_112_244), .A2(n_112_249), .A3(n_112_254), 
      .A4(n_112_255), .ZN(n_112_256));
   NAND2_X1_LVT i_112_269 (.A1(inst_dest[0]), .A2(pc[12]), .ZN(n_112_257));
   NAND2_X1_LVT i_112_270 (.A1(inst_dest[15]), .A2(r15[12]), .ZN(n_112_258));
   NAND2_X1_LVT i_112_271 (.A1(inst_dest[14]), .A2(r14[12]), .ZN(n_112_259));
   NAND4_X1_LVT i_112_272 (.A1(n_112_256), .A2(n_112_257), .A3(n_112_258), 
      .A4(n_112_259), .ZN(reg_dest[12]));
   NAND2_X1_LVT i_112_231 (.A1(inst_dest[4]), .A2(r4[11]), .ZN(n_112_220));
   NAND2_X1_LVT i_112_232 (.A1(inst_dest[3]), .A2(r3[11]), .ZN(n_112_221));
   NAND2_X1_LVT i_112_233 (.A1(inst_dest[2]), .A2(n_4), .ZN(n_112_222));
   NAND2_X1_LVT i_112_234 (.A1(inst_dest[1]), .A2(r1[11]), .ZN(n_112_223));
   NAND4_X1_LVT i_112_235 (.A1(n_112_220), .A2(n_112_221), .A3(n_112_222), 
      .A4(n_112_223), .ZN(n_112_224));
   NAND2_X1_LVT i_112_236 (.A1(inst_dest[12]), .A2(r12[11]), .ZN(n_112_225));
   NAND2_X1_LVT i_112_237 (.A1(inst_dest[11]), .A2(r11[11]), .ZN(n_112_226));
   NAND2_X1_LVT i_112_238 (.A1(inst_dest[10]), .A2(r10[11]), .ZN(n_112_227));
   NAND2_X1_LVT i_112_239 (.A1(inst_dest[9]), .A2(r9[11]), .ZN(n_112_228));
   NAND4_X1_LVT i_112_240 (.A1(n_112_225), .A2(n_112_226), .A3(n_112_227), 
      .A4(n_112_228), .ZN(n_112_229));
   NAND2_X1_LVT i_112_241 (.A1(inst_dest[8]), .A2(r8[11]), .ZN(n_112_230));
   NAND2_X1_LVT i_112_242 (.A1(inst_dest[7]), .A2(r7[11]), .ZN(n_112_231));
   NAND2_X1_LVT i_112_243 (.A1(inst_dest[6]), .A2(r6[11]), .ZN(n_112_232));
   NAND2_X1_LVT i_112_244 (.A1(inst_dest[5]), .A2(r5[11]), .ZN(n_112_233));
   NAND4_X1_LVT i_112_245 (.A1(n_112_230), .A2(n_112_231), .A3(n_112_232), 
      .A4(n_112_233), .ZN(n_112_234));
   AND2_X1_LVT i_112_246 (.A1(inst_dest[13]), .A2(r13[11]), .ZN(n_112_235));
   NOR4_X1_LVT i_112_247 (.A1(n_112_224), .A2(n_112_229), .A3(n_112_234), 
      .A4(n_112_235), .ZN(n_112_236));
   NAND2_X1_LVT i_112_248 (.A1(inst_dest[0]), .A2(pc[11]), .ZN(n_112_237));
   NAND2_X1_LVT i_112_249 (.A1(inst_dest[15]), .A2(r15[11]), .ZN(n_112_238));
   NAND2_X1_LVT i_112_250 (.A1(inst_dest[14]), .A2(r14[11]), .ZN(n_112_239));
   NAND4_X1_LVT i_112_251 (.A1(n_112_236), .A2(n_112_237), .A3(n_112_238), 
      .A4(n_112_239), .ZN(reg_dest[11]));
   NAND2_X1_LVT i_112_210 (.A1(inst_dest[4]), .A2(r4[10]), .ZN(n_112_200));
   NAND2_X1_LVT i_112_211 (.A1(inst_dest[3]), .A2(r3[10]), .ZN(n_112_201));
   NAND2_X1_LVT i_112_212 (.A1(inst_dest[2]), .A2(n_5), .ZN(n_112_202));
   NAND2_X1_LVT i_112_213 (.A1(inst_dest[1]), .A2(r1[10]), .ZN(n_112_203));
   NAND4_X1_LVT i_112_214 (.A1(n_112_200), .A2(n_112_201), .A3(n_112_202), 
      .A4(n_112_203), .ZN(n_112_204));
   NAND2_X1_LVT i_112_215 (.A1(inst_dest[12]), .A2(r12[10]), .ZN(n_112_205));
   NAND2_X1_LVT i_112_216 (.A1(inst_dest[11]), .A2(r11[10]), .ZN(n_112_206));
   NAND2_X1_LVT i_112_217 (.A1(inst_dest[10]), .A2(r10[10]), .ZN(n_112_207));
   NAND2_X1_LVT i_112_218 (.A1(inst_dest[9]), .A2(r9[10]), .ZN(n_112_208));
   NAND4_X1_LVT i_112_219 (.A1(n_112_205), .A2(n_112_206), .A3(n_112_207), 
      .A4(n_112_208), .ZN(n_112_209));
   NAND2_X1_LVT i_112_220 (.A1(inst_dest[8]), .A2(r8[10]), .ZN(n_112_210));
   NAND2_X1_LVT i_112_221 (.A1(inst_dest[7]), .A2(r7[10]), .ZN(n_112_211));
   NAND2_X1_LVT i_112_222 (.A1(inst_dest[6]), .A2(r6[10]), .ZN(n_112_212));
   NAND2_X1_LVT i_112_223 (.A1(inst_dest[5]), .A2(r5[10]), .ZN(n_112_213));
   NAND4_X1_LVT i_112_224 (.A1(n_112_210), .A2(n_112_211), .A3(n_112_212), 
      .A4(n_112_213), .ZN(n_112_214));
   AND2_X1_LVT i_112_225 (.A1(inst_dest[13]), .A2(r13[10]), .ZN(n_112_215));
   NOR4_X1_LVT i_112_226 (.A1(n_112_204), .A2(n_112_209), .A3(n_112_214), 
      .A4(n_112_215), .ZN(n_112_216));
   NAND2_X1_LVT i_112_227 (.A1(inst_dest[0]), .A2(pc[10]), .ZN(n_112_217));
   NAND2_X1_LVT i_112_228 (.A1(inst_dest[15]), .A2(r15[10]), .ZN(n_112_218));
   NAND2_X1_LVT i_112_229 (.A1(inst_dest[14]), .A2(r14[10]), .ZN(n_112_219));
   NAND4_X1_LVT i_112_230 (.A1(n_112_216), .A2(n_112_217), .A3(n_112_218), 
      .A4(n_112_219), .ZN(reg_dest[10]));
   NAND2_X1_LVT i_112_189 (.A1(inst_dest[4]), .A2(r4[9]), .ZN(n_112_180));
   NAND2_X1_LVT i_112_190 (.A1(inst_dest[3]), .A2(r3[9]), .ZN(n_112_181));
   NAND2_X1_LVT i_112_191 (.A1(inst_dest[2]), .A2(n_6), .ZN(n_112_182));
   NAND2_X1_LVT i_112_192 (.A1(inst_dest[1]), .A2(r1[9]), .ZN(n_112_183));
   NAND4_X1_LVT i_112_193 (.A1(n_112_180), .A2(n_112_181), .A3(n_112_182), 
      .A4(n_112_183), .ZN(n_112_184));
   NAND2_X1_LVT i_112_194 (.A1(inst_dest[12]), .A2(r12[9]), .ZN(n_112_185));
   NAND2_X1_LVT i_112_195 (.A1(inst_dest[11]), .A2(r11[9]), .ZN(n_112_186));
   NAND2_X1_LVT i_112_196 (.A1(inst_dest[10]), .A2(r10[9]), .ZN(n_112_187));
   NAND2_X1_LVT i_112_197 (.A1(inst_dest[9]), .A2(r9[9]), .ZN(n_112_188));
   NAND4_X1_LVT i_112_198 (.A1(n_112_185), .A2(n_112_186), .A3(n_112_187), 
      .A4(n_112_188), .ZN(n_112_189));
   NAND2_X1_LVT i_112_199 (.A1(inst_dest[8]), .A2(r8[9]), .ZN(n_112_190));
   NAND2_X1_LVT i_112_200 (.A1(inst_dest[7]), .A2(r7[9]), .ZN(n_112_191));
   NAND2_X1_LVT i_112_201 (.A1(inst_dest[6]), .A2(r6[9]), .ZN(n_112_192));
   NAND2_X1_LVT i_112_202 (.A1(inst_dest[5]), .A2(r5[9]), .ZN(n_112_193));
   NAND4_X1_LVT i_112_203 (.A1(n_112_190), .A2(n_112_191), .A3(n_112_192), 
      .A4(n_112_193), .ZN(n_112_194));
   AND2_X1_LVT i_112_204 (.A1(inst_dest[13]), .A2(r13[9]), .ZN(n_112_195));
   NOR4_X1_LVT i_112_205 (.A1(n_112_184), .A2(n_112_189), .A3(n_112_194), 
      .A4(n_112_195), .ZN(n_112_196));
   NAND2_X1_LVT i_112_206 (.A1(inst_dest[0]), .A2(pc[9]), .ZN(n_112_197));
   NAND2_X1_LVT i_112_207 (.A1(inst_dest[15]), .A2(r15[9]), .ZN(n_112_198));
   NAND2_X1_LVT i_112_208 (.A1(inst_dest[14]), .A2(r14[9]), .ZN(n_112_199));
   NAND4_X1_LVT i_112_209 (.A1(n_112_196), .A2(n_112_197), .A3(n_112_198), 
      .A4(n_112_199), .ZN(reg_dest[9]));
   NAND2_X1_LVT i_112_168 (.A1(inst_dest[4]), .A2(r4[8]), .ZN(n_112_160));
   NAND2_X1_LVT i_112_169 (.A1(inst_dest[3]), .A2(r3[8]), .ZN(n_112_161));
   NAND2_X1_LVT i_112_170 (.A1(inst_dest[2]), .A2(status[3]), .ZN(n_112_162));
   NAND2_X1_LVT i_112_171 (.A1(inst_dest[1]), .A2(r1[8]), .ZN(n_112_163));
   NAND4_X1_LVT i_112_172 (.A1(n_112_160), .A2(n_112_161), .A3(n_112_162), 
      .A4(n_112_163), .ZN(n_112_164));
   NAND2_X1_LVT i_112_173 (.A1(inst_dest[12]), .A2(r12[8]), .ZN(n_112_165));
   NAND2_X1_LVT i_112_174 (.A1(inst_dest[11]), .A2(r11[8]), .ZN(n_112_166));
   NAND2_X1_LVT i_112_175 (.A1(inst_dest[10]), .A2(r10[8]), .ZN(n_112_167));
   NAND2_X1_LVT i_112_176 (.A1(inst_dest[9]), .A2(r9[8]), .ZN(n_112_168));
   NAND4_X1_LVT i_112_177 (.A1(n_112_165), .A2(n_112_166), .A3(n_112_167), 
      .A4(n_112_168), .ZN(n_112_169));
   NAND2_X1_LVT i_112_178 (.A1(inst_dest[8]), .A2(r8[8]), .ZN(n_112_170));
   NAND2_X1_LVT i_112_179 (.A1(inst_dest[7]), .A2(r7[8]), .ZN(n_112_171));
   NAND2_X1_LVT i_112_180 (.A1(inst_dest[6]), .A2(r6[8]), .ZN(n_112_172));
   NAND2_X1_LVT i_112_181 (.A1(inst_dest[5]), .A2(r5[8]), .ZN(n_112_173));
   NAND4_X1_LVT i_112_182 (.A1(n_112_170), .A2(n_112_171), .A3(n_112_172), 
      .A4(n_112_173), .ZN(n_112_174));
   AND2_X1_LVT i_112_183 (.A1(inst_dest[13]), .A2(r13[8]), .ZN(n_112_175));
   NOR4_X1_LVT i_112_184 (.A1(n_112_164), .A2(n_112_169), .A3(n_112_174), 
      .A4(n_112_175), .ZN(n_112_176));
   NAND2_X1_LVT i_112_185 (.A1(inst_dest[0]), .A2(pc[8]), .ZN(n_112_177));
   NAND2_X1_LVT i_112_186 (.A1(inst_dest[15]), .A2(r15[8]), .ZN(n_112_178));
   NAND2_X1_LVT i_112_187 (.A1(inst_dest[14]), .A2(r14[8]), .ZN(n_112_179));
   NAND4_X1_LVT i_112_188 (.A1(n_112_176), .A2(n_112_177), .A3(n_112_178), 
      .A4(n_112_179), .ZN(reg_dest[8]));
   NAND2_X1_LVT i_112_147 (.A1(inst_dest[4]), .A2(r4[7]), .ZN(n_112_140));
   NAND2_X1_LVT i_112_148 (.A1(inst_dest[3]), .A2(r3[7]), .ZN(n_112_141));
   NAND2_X1_LVT i_112_149 (.A1(inst_dest[2]), .A2(scg1), .ZN(n_112_142));
   NAND2_X1_LVT i_112_150 (.A1(inst_dest[1]), .A2(r1[7]), .ZN(n_112_143));
   NAND4_X1_LVT i_112_151 (.A1(n_112_140), .A2(n_112_141), .A3(n_112_142), 
      .A4(n_112_143), .ZN(n_112_144));
   NAND2_X1_LVT i_112_152 (.A1(inst_dest[12]), .A2(r12[7]), .ZN(n_112_145));
   NAND2_X1_LVT i_112_153 (.A1(inst_dest[11]), .A2(r11[7]), .ZN(n_112_146));
   NAND2_X1_LVT i_112_154 (.A1(inst_dest[10]), .A2(r10[7]), .ZN(n_112_147));
   NAND2_X1_LVT i_112_155 (.A1(inst_dest[9]), .A2(r9[7]), .ZN(n_112_148));
   NAND4_X1_LVT i_112_156 (.A1(n_112_145), .A2(n_112_146), .A3(n_112_147), 
      .A4(n_112_148), .ZN(n_112_149));
   NAND2_X1_LVT i_112_157 (.A1(inst_dest[8]), .A2(r8[7]), .ZN(n_112_150));
   NAND2_X1_LVT i_112_158 (.A1(inst_dest[7]), .A2(r7[7]), .ZN(n_112_151));
   NAND2_X1_LVT i_112_159 (.A1(inst_dest[6]), .A2(r6[7]), .ZN(n_112_152));
   NAND2_X1_LVT i_112_160 (.A1(inst_dest[5]), .A2(r5[7]), .ZN(n_112_153));
   NAND4_X1_LVT i_112_161 (.A1(n_112_150), .A2(n_112_151), .A3(n_112_152), 
      .A4(n_112_153), .ZN(n_112_154));
   AND2_X1_LVT i_112_162 (.A1(inst_dest[13]), .A2(r13[7]), .ZN(n_112_155));
   NOR4_X1_LVT i_112_163 (.A1(n_112_144), .A2(n_112_149), .A3(n_112_154), 
      .A4(n_112_155), .ZN(n_112_156));
   NAND2_X1_LVT i_112_164 (.A1(inst_dest[0]), .A2(pc[7]), .ZN(n_112_157));
   NAND2_X1_LVT i_112_165 (.A1(inst_dest[15]), .A2(r15[7]), .ZN(n_112_158));
   NAND2_X1_LVT i_112_166 (.A1(inst_dest[14]), .A2(r14[7]), .ZN(n_112_159));
   NAND4_X1_LVT i_112_167 (.A1(n_112_156), .A2(n_112_157), .A3(n_112_158), 
      .A4(n_112_159), .ZN(reg_dest[7]));
   NAND2_X1_LVT i_112_126 (.A1(inst_dest[4]), .A2(r4[6]), .ZN(n_112_120));
   NAND2_X1_LVT i_112_127 (.A1(inst_dest[3]), .A2(r3[6]), .ZN(n_112_121));
   NAND2_X1_LVT i_112_128 (.A1(inst_dest[2]), .A2(scg0), .ZN(n_112_122));
   NAND2_X1_LVT i_112_129 (.A1(inst_dest[1]), .A2(r1[6]), .ZN(n_112_123));
   NAND4_X1_LVT i_112_130 (.A1(n_112_120), .A2(n_112_121), .A3(n_112_122), 
      .A4(n_112_123), .ZN(n_112_124));
   NAND2_X1_LVT i_112_131 (.A1(inst_dest[12]), .A2(r12[6]), .ZN(n_112_125));
   NAND2_X1_LVT i_112_132 (.A1(inst_dest[11]), .A2(r11[6]), .ZN(n_112_126));
   NAND2_X1_LVT i_112_133 (.A1(inst_dest[10]), .A2(r10[6]), .ZN(n_112_127));
   NAND2_X1_LVT i_112_134 (.A1(inst_dest[9]), .A2(r9[6]), .ZN(n_112_128));
   NAND4_X1_LVT i_112_135 (.A1(n_112_125), .A2(n_112_126), .A3(n_112_127), 
      .A4(n_112_128), .ZN(n_112_129));
   NAND2_X1_LVT i_112_136 (.A1(inst_dest[8]), .A2(r8[6]), .ZN(n_112_130));
   NAND2_X1_LVT i_112_137 (.A1(inst_dest[7]), .A2(r7[6]), .ZN(n_112_131));
   NAND2_X1_LVT i_112_138 (.A1(inst_dest[6]), .A2(r6[6]), .ZN(n_112_132));
   NAND2_X1_LVT i_112_139 (.A1(inst_dest[5]), .A2(r5[6]), .ZN(n_112_133));
   NAND4_X1_LVT i_112_140 (.A1(n_112_130), .A2(n_112_131), .A3(n_112_132), 
      .A4(n_112_133), .ZN(n_112_134));
   AND2_X1_LVT i_112_141 (.A1(inst_dest[13]), .A2(r13[6]), .ZN(n_112_135));
   NOR4_X1_LVT i_112_142 (.A1(n_112_124), .A2(n_112_129), .A3(n_112_134), 
      .A4(n_112_135), .ZN(n_112_136));
   NAND2_X1_LVT i_112_143 (.A1(inst_dest[0]), .A2(pc[6]), .ZN(n_112_137));
   NAND2_X1_LVT i_112_144 (.A1(inst_dest[15]), .A2(r15[6]), .ZN(n_112_138));
   NAND2_X1_LVT i_112_145 (.A1(inst_dest[14]), .A2(r14[6]), .ZN(n_112_139));
   NAND4_X1_LVT i_112_146 (.A1(n_112_136), .A2(n_112_137), .A3(n_112_138), 
      .A4(n_112_139), .ZN(reg_dest[6]));
   NAND2_X1_LVT i_112_105 (.A1(inst_dest[4]), .A2(r4[5]), .ZN(n_112_100));
   NAND2_X1_LVT i_112_106 (.A1(inst_dest[3]), .A2(r3[5]), .ZN(n_112_101));
   NAND2_X1_LVT i_112_107 (.A1(inst_dest[2]), .A2(oscoff), .ZN(n_112_102));
   NAND2_X1_LVT i_112_108 (.A1(inst_dest[1]), .A2(r1[5]), .ZN(n_112_103));
   NAND4_X1_LVT i_112_109 (.A1(n_112_100), .A2(n_112_101), .A3(n_112_102), 
      .A4(n_112_103), .ZN(n_112_104));
   NAND2_X1_LVT i_112_110 (.A1(inst_dest[12]), .A2(r12[5]), .ZN(n_112_105));
   NAND2_X1_LVT i_112_111 (.A1(inst_dest[11]), .A2(r11[5]), .ZN(n_112_106));
   NAND2_X1_LVT i_112_112 (.A1(inst_dest[10]), .A2(r10[5]), .ZN(n_112_107));
   NAND2_X1_LVT i_112_113 (.A1(inst_dest[9]), .A2(r9[5]), .ZN(n_112_108));
   NAND4_X1_LVT i_112_114 (.A1(n_112_105), .A2(n_112_106), .A3(n_112_107), 
      .A4(n_112_108), .ZN(n_112_109));
   NAND2_X1_LVT i_112_115 (.A1(inst_dest[8]), .A2(r8[5]), .ZN(n_112_110));
   NAND2_X1_LVT i_112_116 (.A1(inst_dest[7]), .A2(r7[5]), .ZN(n_112_111));
   NAND2_X1_LVT i_112_117 (.A1(inst_dest[6]), .A2(r6[5]), .ZN(n_112_112));
   NAND2_X1_LVT i_112_118 (.A1(inst_dest[5]), .A2(r5[5]), .ZN(n_112_113));
   NAND4_X1_LVT i_112_119 (.A1(n_112_110), .A2(n_112_111), .A3(n_112_112), 
      .A4(n_112_113), .ZN(n_112_114));
   AND2_X1_LVT i_112_120 (.A1(inst_dest[13]), .A2(r13[5]), .ZN(n_112_115));
   NOR4_X1_LVT i_112_121 (.A1(n_112_104), .A2(n_112_109), .A3(n_112_114), 
      .A4(n_112_115), .ZN(n_112_116));
   NAND2_X1_LVT i_112_122 (.A1(inst_dest[0]), .A2(pc[5]), .ZN(n_112_117));
   NAND2_X1_LVT i_112_123 (.A1(inst_dest[15]), .A2(r15[5]), .ZN(n_112_118));
   NAND2_X1_LVT i_112_124 (.A1(inst_dest[14]), .A2(r14[5]), .ZN(n_112_119));
   NAND4_X1_LVT i_112_125 (.A1(n_112_116), .A2(n_112_117), .A3(n_112_118), 
      .A4(n_112_119), .ZN(reg_dest[5]));
   NAND2_X1_LVT i_112_84 (.A1(inst_dest[4]), .A2(r4[4]), .ZN(n_112_80));
   NAND2_X1_LVT i_112_85 (.A1(inst_dest[3]), .A2(r3[4]), .ZN(n_112_81));
   NAND2_X1_LVT i_112_86 (.A1(inst_dest[2]), .A2(n_7), .ZN(n_112_82));
   NAND2_X1_LVT i_112_87 (.A1(inst_dest[1]), .A2(r1[4]), .ZN(n_112_83));
   NAND4_X1_LVT i_112_88 (.A1(n_112_80), .A2(n_112_81), .A3(n_112_82), .A4(
      n_112_83), .ZN(n_112_84));
   NAND2_X1_LVT i_112_89 (.A1(inst_dest[12]), .A2(r12[4]), .ZN(n_112_85));
   NAND2_X1_LVT i_112_90 (.A1(inst_dest[11]), .A2(r11[4]), .ZN(n_112_86));
   NAND2_X1_LVT i_112_91 (.A1(inst_dest[10]), .A2(r10[4]), .ZN(n_112_87));
   NAND2_X1_LVT i_112_92 (.A1(inst_dest[9]), .A2(r9[4]), .ZN(n_112_88));
   NAND4_X1_LVT i_112_93 (.A1(n_112_85), .A2(n_112_86), .A3(n_112_87), .A4(
      n_112_88), .ZN(n_112_89));
   NAND2_X1_LVT i_112_94 (.A1(inst_dest[8]), .A2(r8[4]), .ZN(n_112_90));
   NAND2_X1_LVT i_112_95 (.A1(inst_dest[7]), .A2(r7[4]), .ZN(n_112_91));
   NAND2_X1_LVT i_112_96 (.A1(inst_dest[6]), .A2(r6[4]), .ZN(n_112_92));
   NAND2_X1_LVT i_112_97 (.A1(inst_dest[5]), .A2(r5[4]), .ZN(n_112_93));
   NAND4_X1_LVT i_112_98 (.A1(n_112_90), .A2(n_112_91), .A3(n_112_92), .A4(
      n_112_93), .ZN(n_112_94));
   AND2_X1_LVT i_112_99 (.A1(inst_dest[13]), .A2(r13[4]), .ZN(n_112_95));
   NOR4_X1_LVT i_112_100 (.A1(n_112_84), .A2(n_112_89), .A3(n_112_94), .A4(
      n_112_95), .ZN(n_112_96));
   NAND2_X1_LVT i_112_101 (.A1(inst_dest[0]), .A2(pc[4]), .ZN(n_112_97));
   NAND2_X1_LVT i_112_102 (.A1(inst_dest[15]), .A2(r15[4]), .ZN(n_112_98));
   NAND2_X1_LVT i_112_103 (.A1(inst_dest[14]), .A2(r14[4]), .ZN(n_112_99));
   NAND4_X1_LVT i_112_104 (.A1(n_112_96), .A2(n_112_97), .A3(n_112_98), .A4(
      n_112_99), .ZN(reg_dest[4]));
   NAND2_X1_LVT i_112_63 (.A1(inst_dest[4]), .A2(r4[3]), .ZN(n_112_60));
   NAND2_X1_LVT i_112_64 (.A1(inst_dest[3]), .A2(r3[3]), .ZN(n_112_61));
   NAND2_X1_LVT i_112_65 (.A1(inst_dest[2]), .A2(gie), .ZN(n_112_62));
   NAND2_X1_LVT i_112_66 (.A1(inst_dest[1]), .A2(r1[3]), .ZN(n_112_63));
   NAND4_X1_LVT i_112_67 (.A1(n_112_60), .A2(n_112_61), .A3(n_112_62), .A4(
      n_112_63), .ZN(n_112_64));
   NAND2_X1_LVT i_112_68 (.A1(inst_dest[12]), .A2(r12[3]), .ZN(n_112_65));
   NAND2_X1_LVT i_112_69 (.A1(inst_dest[11]), .A2(r11[3]), .ZN(n_112_66));
   NAND2_X1_LVT i_112_70 (.A1(inst_dest[10]), .A2(r10[3]), .ZN(n_112_67));
   NAND2_X1_LVT i_112_71 (.A1(inst_dest[9]), .A2(r9[3]), .ZN(n_112_68));
   NAND4_X1_LVT i_112_72 (.A1(n_112_65), .A2(n_112_66), .A3(n_112_67), .A4(
      n_112_68), .ZN(n_112_69));
   NAND2_X1_LVT i_112_73 (.A1(inst_dest[8]), .A2(r8[3]), .ZN(n_112_70));
   NAND2_X1_LVT i_112_74 (.A1(inst_dest[7]), .A2(r7[3]), .ZN(n_112_71));
   NAND2_X1_LVT i_112_75 (.A1(inst_dest[6]), .A2(r6[3]), .ZN(n_112_72));
   NAND2_X1_LVT i_112_76 (.A1(inst_dest[5]), .A2(r5[3]), .ZN(n_112_73));
   NAND4_X1_LVT i_112_77 (.A1(n_112_70), .A2(n_112_71), .A3(n_112_72), .A4(
      n_112_73), .ZN(n_112_74));
   AND2_X1_LVT i_112_78 (.A1(inst_dest[13]), .A2(r13[3]), .ZN(n_112_75));
   NOR4_X1_LVT i_112_79 (.A1(n_112_64), .A2(n_112_69), .A3(n_112_74), .A4(
      n_112_75), .ZN(n_112_76));
   NAND2_X1_LVT i_112_80 (.A1(inst_dest[0]), .A2(pc[3]), .ZN(n_112_77));
   NAND2_X1_LVT i_112_81 (.A1(inst_dest[15]), .A2(r15[3]), .ZN(n_112_78));
   NAND2_X1_LVT i_112_82 (.A1(inst_dest[14]), .A2(r14[3]), .ZN(n_112_79));
   NAND4_X1_LVT i_112_83 (.A1(n_112_76), .A2(n_112_77), .A3(n_112_78), .A4(
      n_112_79), .ZN(reg_dest[3]));
   NAND2_X1_LVT i_112_42 (.A1(inst_dest[4]), .A2(r4[2]), .ZN(n_112_40));
   NAND2_X1_LVT i_112_43 (.A1(inst_dest[3]), .A2(r3[2]), .ZN(n_112_41));
   NAND2_X1_LVT i_112_44 (.A1(inst_dest[2]), .A2(status[2]), .ZN(n_112_42));
   NAND2_X1_LVT i_112_45 (.A1(inst_dest[1]), .A2(r1[2]), .ZN(n_112_43));
   NAND4_X1_LVT i_112_46 (.A1(n_112_40), .A2(n_112_41), .A3(n_112_42), .A4(
      n_112_43), .ZN(n_112_44));
   NAND2_X1_LVT i_112_47 (.A1(inst_dest[12]), .A2(r12[2]), .ZN(n_112_45));
   NAND2_X1_LVT i_112_48 (.A1(inst_dest[11]), .A2(r11[2]), .ZN(n_112_46));
   NAND2_X1_LVT i_112_49 (.A1(inst_dest[10]), .A2(r10[2]), .ZN(n_112_47));
   NAND2_X1_LVT i_112_50 (.A1(inst_dest[9]), .A2(r9[2]), .ZN(n_112_48));
   NAND4_X1_LVT i_112_51 (.A1(n_112_45), .A2(n_112_46), .A3(n_112_47), .A4(
      n_112_48), .ZN(n_112_49));
   NAND2_X1_LVT i_112_52 (.A1(inst_dest[8]), .A2(r8[2]), .ZN(n_112_50));
   NAND2_X1_LVT i_112_53 (.A1(inst_dest[7]), .A2(r7[2]), .ZN(n_112_51));
   NAND2_X1_LVT i_112_54 (.A1(inst_dest[6]), .A2(r6[2]), .ZN(n_112_52));
   NAND2_X1_LVT i_112_55 (.A1(inst_dest[5]), .A2(r5[2]), .ZN(n_112_53));
   NAND4_X1_LVT i_112_56 (.A1(n_112_50), .A2(n_112_51), .A3(n_112_52), .A4(
      n_112_53), .ZN(n_112_54));
   AND2_X1_LVT i_112_57 (.A1(inst_dest[13]), .A2(r13[2]), .ZN(n_112_55));
   NOR4_X1_LVT i_112_58 (.A1(n_112_44), .A2(n_112_49), .A3(n_112_54), .A4(
      n_112_55), .ZN(n_112_56));
   NAND2_X1_LVT i_112_59 (.A1(inst_dest[0]), .A2(pc[2]), .ZN(n_112_57));
   NAND2_X1_LVT i_112_60 (.A1(inst_dest[15]), .A2(r15[2]), .ZN(n_112_58));
   NAND2_X1_LVT i_112_61 (.A1(inst_dest[14]), .A2(r14[2]), .ZN(n_112_59));
   NAND4_X1_LVT i_112_62 (.A1(n_112_56), .A2(n_112_57), .A3(n_112_58), .A4(
      n_112_59), .ZN(reg_dest[2]));
   NAND2_X1_LVT i_112_21 (.A1(inst_dest[4]), .A2(r4[1]), .ZN(n_112_20));
   NAND2_X1_LVT i_112_22 (.A1(inst_dest[3]), .A2(r3[1]), .ZN(n_112_21));
   NAND2_X1_LVT i_112_23 (.A1(inst_dest[2]), .A2(status[1]), .ZN(n_112_22));
   NAND2_X1_LVT i_112_24 (.A1(inst_dest[1]), .A2(r1[1]), .ZN(n_112_23));
   NAND4_X1_LVT i_112_25 (.A1(n_112_20), .A2(n_112_21), .A3(n_112_22), .A4(
      n_112_23), .ZN(n_112_24));
   NAND2_X1_LVT i_112_26 (.A1(inst_dest[12]), .A2(r12[1]), .ZN(n_112_25));
   NAND2_X1_LVT i_112_27 (.A1(inst_dest[11]), .A2(r11[1]), .ZN(n_112_26));
   NAND2_X1_LVT i_112_28 (.A1(inst_dest[10]), .A2(r10[1]), .ZN(n_112_27));
   NAND2_X1_LVT i_112_29 (.A1(inst_dest[9]), .A2(r9[1]), .ZN(n_112_28));
   NAND4_X1_LVT i_112_30 (.A1(n_112_25), .A2(n_112_26), .A3(n_112_27), .A4(
      n_112_28), .ZN(n_112_29));
   NAND2_X1_LVT i_112_31 (.A1(inst_dest[8]), .A2(r8[1]), .ZN(n_112_30));
   NAND2_X1_LVT i_112_32 (.A1(inst_dest[7]), .A2(r7[1]), .ZN(n_112_31));
   NAND2_X1_LVT i_112_33 (.A1(inst_dest[6]), .A2(r6[1]), .ZN(n_112_32));
   NAND2_X1_LVT i_112_34 (.A1(inst_dest[5]), .A2(r5[1]), .ZN(n_112_33));
   NAND4_X1_LVT i_112_35 (.A1(n_112_30), .A2(n_112_31), .A3(n_112_32), .A4(
      n_112_33), .ZN(n_112_34));
   AND2_X1_LVT i_112_36 (.A1(inst_dest[13]), .A2(r13[1]), .ZN(n_112_35));
   NOR4_X1_LVT i_112_37 (.A1(n_112_24), .A2(n_112_29), .A3(n_112_34), .A4(
      n_112_35), .ZN(n_112_36));
   NAND2_X1_LVT i_112_38 (.A1(inst_dest[0]), .A2(pc[1]), .ZN(n_112_37));
   NAND2_X1_LVT i_112_39 (.A1(inst_dest[15]), .A2(r15[1]), .ZN(n_112_38));
   NAND2_X1_LVT i_112_40 (.A1(inst_dest[14]), .A2(r14[1]), .ZN(n_112_39));
   NAND4_X1_LVT i_112_41 (.A1(n_112_36), .A2(n_112_37), .A3(n_112_38), .A4(
      n_112_39), .ZN(reg_dest[1]));
   NAND2_X1_LVT i_112_0 (.A1(r4[0]), .A2(inst_dest[4]), .ZN(n_112_0));
   NAND2_X1_LVT i_112_1 (.A1(r3[0]), .A2(inst_dest[3]), .ZN(n_112_1));
   NAND2_X1_LVT i_112_2 (.A1(status[0]), .A2(inst_dest[2]), .ZN(n_112_2));
   NAND2_X1_LVT i_112_3 (.A1(r1[0]), .A2(inst_dest[1]), .ZN(n_112_3));
   NAND4_X1_LVT i_112_4 (.A1(n_112_0), .A2(n_112_1), .A3(n_112_2), .A4(n_112_3), 
      .ZN(n_112_4));
   NAND2_X1_LVT i_112_5 (.A1(r12[0]), .A2(inst_dest[12]), .ZN(n_112_5));
   NAND2_X1_LVT i_112_6 (.A1(r11[0]), .A2(inst_dest[11]), .ZN(n_112_6));
   NAND2_X1_LVT i_112_7 (.A1(r10[0]), .A2(inst_dest[10]), .ZN(n_112_7));
   NAND2_X1_LVT i_112_8 (.A1(r9[0]), .A2(inst_dest[9]), .ZN(n_112_8));
   NAND4_X1_LVT i_112_9 (.A1(n_112_5), .A2(n_112_6), .A3(n_112_7), .A4(n_112_8), 
      .ZN(n_112_9));
   NAND2_X1_LVT i_112_10 (.A1(r8[0]), .A2(inst_dest[8]), .ZN(n_112_10));
   NAND2_X1_LVT i_112_11 (.A1(r7[0]), .A2(inst_dest[7]), .ZN(n_112_11));
   NAND2_X1_LVT i_112_12 (.A1(r6[0]), .A2(inst_dest[6]), .ZN(n_112_12));
   NAND2_X1_LVT i_112_13 (.A1(r5[0]), .A2(inst_dest[5]), .ZN(n_112_13));
   NAND4_X1_LVT i_112_14 (.A1(n_112_10), .A2(n_112_11), .A3(n_112_12), .A4(
      n_112_13), .ZN(n_112_14));
   AND2_X1_LVT i_112_15 (.A1(r13[0]), .A2(inst_dest[13]), .ZN(n_112_15));
   NOR4_X1_LVT i_112_16 (.A1(n_112_4), .A2(n_112_9), .A3(n_112_14), .A4(n_112_15), 
      .ZN(n_112_16));
   NAND2_X1_LVT i_112_17 (.A1(pc[0]), .A2(inst_dest[0]), .ZN(n_112_17));
   NAND2_X1_LVT i_112_18 (.A1(r15[0]), .A2(inst_dest[15]), .ZN(n_112_18));
   NAND2_X1_LVT i_112_19 (.A1(r14[0]), .A2(inst_dest[14]), .ZN(n_112_19));
   NAND4_X1_LVT i_112_20 (.A1(n_112_16), .A2(n_112_17), .A3(n_112_18), .A4(
      n_112_19), .ZN(reg_dest[0]));
endmodule

module omsp_execution_unit(cpuoff, dbg_reg_din, gie, mab, mb_en, mb_wr, mdb_out, 
      oscoff, pc_sw, pc_sw_wr, scg0, scg1, dbg_halt_st, dbg_mem_dout, dbg_reg_wr, 
      e_state, exec_done, inst_ad, inst_as, inst_alu, inst_bw, inst_dest, 
      inst_dext, inst_irq_rst, inst_jmp, inst_mov, inst_sext, inst_so, inst_src, 
      inst_type, mclk, mdb_in, pc, pc_nxt, puc_rst, scan_enable);
   output cpuoff;
   output [15:0]dbg_reg_din;
   output gie;
   output [15:0]mab;
   output mb_en;
   output [1:0]mb_wr;
   output [15:0]mdb_out;
   output oscoff;
   output [15:0]pc_sw;
   output pc_sw_wr;
   output scg0;
   output scg1;
   input dbg_halt_st;
   input [15:0]dbg_mem_dout;
   input dbg_reg_wr;
   input [3:0]e_state;
   input exec_done;
   input [7:0]inst_ad;
   input [7:0]inst_as;
   input [11:0]inst_alu;
   input inst_bw;
   input [15:0]inst_dest;
   input [15:0]inst_dext;
   input inst_irq_rst;
   input [7:0]inst_jmp;
   input inst_mov;
   input [15:0]inst_sext;
   input [7:0]inst_so;
   input [15:0]inst_src;
   input [2:0]inst_type;
   input mclk;
   input [15:0]mdb_in;
   input [15:0]pc;
   input [15:0]pc_nxt;
   input puc_rst;
   input scan_enable;

   wire [3:0]alu_stat_wr;
   wire [3:0]alu_stat;
   wire [15:0]alu_out;
   wire [3:0]status;
   wire [15:0]reg_src;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
   wire n_0_3;
   wire reg_sr_clr;
   wire n_4_0;
   wire n_4_1;
   wire mb_wr_det;
   wire n_7_0;
   wire n_7_1;
   wire n_7_2;
   wire n_7_3;
   wire n_7_4;
   wire n_8_0;
   wire n_8_1;
   wire n_8_2;
   wire n_8_3;
   wire mab_lsb;
   wire [15:0]mdb_out_nxt;
   wire n_13_0;
   wire n_13_1;
   wire n_13_2;
   wire n_13_3;
   wire n_13_4;
   wire n_13_5;
   wire n_13_6;
   wire n_13_7;
   wire n_13_8;
   wire n_13_9;
   wire n_13_10;
   wire n_13_11;
   wire n_13_12;
   wire n_13_13;
   wire n_13_14;
   wire n_13_15;
   wire n_13_16;
   wire n_13_17;
   wire n_13_18;
   wire n_14_0;
   wire n_14_1;
   wire n_15_0;
   wire n_15_1;
   wire n_15_2;
   wire n_15_3;
   wire n_17_0;
   wire n_17_1;
   wire n_17_2;
   wire n_17_3;
   wire n_17_4;
   wire n_17_5;
   wire n_17_6;
   wire n_17_7;
   wire n_17_8;
   wire n_21_0;
   wire n_21_1;
   wire n_21_2;
   wire n_21_3;
   wire n_21_4;
   wire reg_dest_wr;
   wire n_23_0;
   wire reg_pc_call;
   wire n_30_0;
   wire n_30_1;
   wire n_30_2;
   wire reg_sp_wr;
   wire reg_sr_wr;
   wire n_32_0;
   wire reg_incr;
   wire n_34_0;
   wire n_34_1;
   wire n_34_2;
   wire n_34_3;
   wire n_34_4;
   wire n_34_5;
   wire n_34_6;
   wire n_34_7;
   wire n_34_8;
   wire n_34_9;
   wire n_34_10;
   wire n_34_11;
   wire n_34_12;
   wire n_34_13;
   wire n_34_14;
   wire n_34_15;
   wire n_34_16;
   wire n_34_17;
   wire n_39_0;
   wire n_39_1;
   wire n_39_2;
   wire n_39_3;
   wire n_39_4;
   wire n_39_5;
   wire n_39_6;
   wire n_39_7;
   wire n_39_8;
   wire n_40_0;
   wire n_40_1;
   wire n_40_2;
   wire n_40_3;
   wire n_40_4;
   wire n_40_5;
   wire n_40_6;
   wire n_41_0;
   wire n_41_1;
   wire n_41_2;
   wire n_41_3;
   wire n_41_4;
   wire n_41_5;
   wire n_41_6;
   wire n_41_7;
   wire n_41_8;
   wire n_41_9;
   wire n_41_10;
   wire n_41_11;
   wire n_41_12;
   wire n_41_13;
   wire n_41_14;
   wire n_41_15;
   wire n_41_16;
   wire n_41_17;
   wire n_41_18;
   wire n_41_19;
   wire n_41_20;
   wire n_41_21;
   wire n_41_22;
   wire n_41_23;
   wire n_41_24;
   wire n_41_25;
   wire n_41_26;
   wire n_41_27;
   wire n_41_28;
   wire n_41_29;
   wire n_41_30;
   wire n_41_31;
   wire n_41_32;
   wire n_41_33;
   wire n_41_34;
   wire n_41_35;
   wire n_41_36;
   wire n_41_37;
   wire n_41_38;
   wire n_41_39;
   wire n_41_40;
   wire n_41_41;
   wire n_41_42;
   wire n_41_43;
   wire n_41_44;
   wire n_41_45;
   wire n_41_46;
   wire n_41_47;
   wire n_41_48;
   wire n_41_49;
   wire n_41_50;
   wire n_41_51;
   wire n_41_52;
   wire n_41_53;
   wire n_41_54;
   wire n_41_55;
   wire n_41_56;
   wire n_41_57;
   wire n_41_58;
   wire n_41_59;
   wire n_41_60;
   wire n_41_61;
   wire n_41_62;
   wire n_41_63;
   wire n_41_64;
   wire n_41_65;
   wire n_41_66;
   wire n_41_67;
   wire n_41_68;
   wire n_41_69;
   wire n_41_70;
   wire n_41_71;
   wire n_41_72;
   wire n_41_73;
   wire n_41_74;
   wire n_41_75;
   wire n_41_76;
   wire n_41_77;
   wire n_41_78;
   wire n_41_79;
   wire mdb_in_buf_en;
   wire [15:0]mdb_in_buf;
   wire mdb_in_buf_valid;
   wire n_44_0;
   wire n_44_1;
   wire n_45_0;
   wire n_45_1;
   wire n_45_2;
   wire n_48_0;
   wire n_48_1;
   wire n_48_2;
   wire n_48_3;
   wire n_48_4;
   wire n_48_5;
   wire n_48_6;
   wire n_48_7;
   wire n_48_8;
   wire n_48_9;
   wire n_49_0;
   wire n_49_1;
   wire n_49_2;
   wire n_49_3;
   wire n_49_4;
   wire n_49_5;
   wire n_49_6;
   wire n_49_7;
   wire n_49_8;
   wire n_49_9;
   wire n_50_0;
   wire n_50_1;
   wire n_50_2;
   wire n_50_3;
   wire n_50_4;
   wire n_50_5;
   wire n_50_6;
   wire n_50_7;
   wire n_50_8;
   wire n_50_9;
   wire n_50_10;
   wire n_50_11;
   wire n_50_12;
   wire n_50_13;
   wire n_50_14;
   wire n_50_15;
   wire n_50_16;
   wire n_50_17;
   wire n_50_18;
   wire n_50_19;
   wire n_50_20;
   wire n_50_21;
   wire n_50_22;
   wire n_50_23;
   wire n_50_24;
   wire n_50_25;
   wire n_50_26;
   wire n_50_27;
   wire n_50_28;
   wire n_50_29;
   wire n_50_30;
   wire n_50_31;
   wire n_50_32;
   wire n_50_33;
   wire n_50_34;
   wire n_50_35;
   wire n_50_36;
   wire n_50_37;
   wire n_50_38;
   wire n_50_39;
   wire n_50_40;
   wire n_50_41;
   wire n_50_42;
   wire n_50_43;
   wire n_50_44;
   wire n_50_45;
   wire n_50_46;
   wire n_50_47;
   wire n_50_48;
   wire n_50_49;
   wire n_50_50;
   wire n_50_51;
   wire n_50_52;
   wire n_50_53;
   wire n_50_54;
   wire n_50_55;
   wire n_50_56;
   wire n_50_57;
   wire n_50_58;
   wire n_50_59;
   wire n_50_60;
   wire n_50_61;
   wire n_50_62;
   wire n_50_63;
   wire n_50_64;
   wire n_50_65;
   wire n_50_66;
   wire n_50_67;
   wire n_50_68;
   wire n_50_69;
   wire n_50_70;
   wire n_50_71;
   wire n_50_72;
   wire n_50_73;
   wire n_50_74;
   wire n_50_75;
   wire n_50_76;
   wire n_50_77;
   wire n_50_78;
   wire n_50_79;
   wire n_50_80;
   wire n_50_81;
   wire n_50_82;
   wire n_50_83;
   wire n_50_84;
   wire n_50_85;
   wire n_50_86;
   wire n_50_87;
   wire n_50_88;
   wire n_50_89;
   wire n_50_90;
   wire n_50_91;
   wire n_50_92;
   wire n_50_93;
   wire n_50_94;
   wire n_50_95;

   INV_X1_LVT i_0_0 (.A(e_state[3]), .ZN(n_0_0));
   INV_X1_LVT i_0_1 (.A(e_state[0]), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(e_state[1]), .ZN(n_0_2));
   NOR4_X1_LVT i_0_3 (.A1(n_0_0), .A2(n_0_1), .A3(n_0_2), .A4(e_state[2]), 
      .ZN(n_0));
   OR3_X1_LVT i_38_0 (.A1(inst_as[4]), .A2(inst_as[1]), .A3(inst_as[6]), 
      .ZN(n_69));
   INV_X1_LVT i_0_4 (.A(e_state[2]), .ZN(n_0_3));
   NOR4_X1_LVT i_0_5 (.A1(n_0_2), .A2(n_0_3), .A3(e_state[0]), .A4(e_state[3]), 
      .ZN(n_1));
   NOR4_X1_LVT i_0_6 (.A1(n_0_3), .A2(n_0_1), .A3(n_0_2), .A4(e_state[3]), 
      .ZN(n_2));
   AOI22_X1_LVT i_39_11 (.A1(n_69), .A2(n_1), .B1(n_69), .B2(n_2), .ZN(n_39_8));
   INV_X1_LVT i_39_12 (.A(n_39_8), .ZN(n_73));
   INV_X1_LVT i_40_4 (.A(n_73), .ZN(n_40_4));
   NOR2_X1_LVT i_40_5 (.A1(n_40_4), .A2(dbg_halt_st), .ZN(n_74));
   NAND2_X1_LVT i_41_90 (.A1(n_74), .A2(inst_sext[15]), .ZN(n_41_75));
   OR2_X1_LVT i_40_0 (.A1(n_73), .A2(dbg_halt_st), .ZN(n_40_0));
   NOR4_X1_LVT i_0_7 (.A1(n_0_2), .A2(n_0_0), .A3(e_state[0]), .A4(e_state[2]), 
      .ZN(n_3));
   AND2_X1_LVT i_22_0 (.A1(inst_so[6]), .A2(n_3), .ZN(n_40));
   INV_X1_LVT i_39_8 (.A(n_40), .ZN(n_39_6));
   INV_X1_LVT i_2_0 (.A(inst_so[6]), .ZN(n_10));
   AND2_X1_LVT i_36_0 (.A1(n_0), .A2(n_10), .ZN(n_67));
   INV_X1_LVT i_39_9 (.A(n_67), .ZN(n_39_7));
   OR3_X1_LVT i_37_0 (.A1(inst_ad[0]), .A2(inst_type[0]), .A3(inst_type[1]), 
      .ZN(n_68));
   OAI21_X1_LVT i_39_10 (.A(n_39_6), .B1(n_39_7), .B2(n_68), .ZN(n_72));
   INV_X1_LVT i_40_6 (.A(n_72), .ZN(n_40_5));
   NOR2_X1_LVT i_40_7 (.A1(n_40_0), .A2(n_40_5), .ZN(n_75));
   INV_X1_LVT i_33_0 (.A(inst_bw), .ZN(n_47));
   INV_X1_LVT i_6_0 (.A(inst_alu[11]), .ZN(n_13));
   INV_X1_LVT i_3_0 (.A(inst_irq_rst), .ZN(n_11));
   NOR4_X1_LVT i_0_10 (.A1(n_0_1), .A2(n_0_2), .A3(e_state[2]), .A4(e_state[3]), 
      .ZN(n_6));
   NOR4_X1_LVT i_0_9 (.A1(n_0_1), .A2(e_state[1]), .A3(e_state[2]), .A4(
      e_state[3]), .ZN(n_5));
   OAI21_X1_LVT i_4_0 (.A(n_11), .B1(n_6), .B2(n_5), .ZN(n_4_0));
   NAND2_X1_LVT i_4_1 (.A1(n_10), .A2(n_3), .ZN(n_4_1));
   NAND2_X1_LVT i_4_2 (.A1(n_4_0), .A2(n_4_1), .ZN(n_12));
   OR2_X1_LVT i_5_0 (.A1(n_12), .A2(n_2), .ZN(mb_wr_det));
   AND2_X1_LVT i_7_0 (.A1(n_13), .A2(mb_wr_det), .ZN(n_7_0));
   NOR4_X1_LVT i_0_8 (.A1(n_0_1), .A2(n_0_0), .A3(e_state[1]), .A4(e_state[2]), 
      .ZN(n_4));
   INV_X1_LVT i_7_1 (.A(n_4), .ZN(n_7_1));
   NOR3_X1_LVT i_7_2 (.A1(n_7_1), .A2(inst_type[0]), .A3(inst_mov), .ZN(n_7_2));
   INV_X1_LVT i_7_3 (.A(n_1), .ZN(n_7_3));
   NOR2_X1_LVT i_7_4 (.A1(n_7_3), .A2(inst_as[5]), .ZN(n_7_4));
   AND2_X1_LVT i_1_0 (.A1(n_0), .A2(inst_so[6]), .ZN(n_9));
   OR4_X1_LVT i_7_5 (.A1(n_7_0), .A2(n_7_2), .A3(n_7_4), .A4(n_9), .ZN(mb_en));
   CLKGATETST_X1_LVT clk_gate_mab_lsb_reg (.CK(mclk), .E(mb_en), .SE(1'b0), 
      .GCK(n_16));
   INV_X1_LVT i_11_0 (.A(puc_rst), .ZN(n_18));
   DFFR_X1_LVT mab_lsb_reg (.D(mab[0]), .RN(n_18), .CK(n_16), .Q(mab_lsb), .QN());
   AND2_X1_LVT i_33_2 (.A1(mab_lsb), .A2(inst_bw), .ZN(n_49));
   NOR2_X1_LVT i_33_1 (.A1(n_47), .A2(mab_lsb), .ZN(n_48));
   NOR3_X1_LVT i_34_17 (.A1(n_47), .A2(n_49), .A3(n_48), .ZN(n_34_9));
   INV_X1_LVT i_34_32 (.A(mdb_in[15]), .ZN(n_34_17));
   NOR2_X1_LVT i_34_33 (.A1(n_34_9), .A2(n_34_17), .ZN(n_65));
   NAND2_X1_LVT i_41_91 (.A1(n_75), .A2(n_65), .ZN(n_41_76));
   NOR2_X1_LVT i_40_1 (.A1(n_40_0), .A2(n_72), .ZN(n_40_1));
   INV_X1_LVT i_39_3 (.A(n_4), .ZN(n_39_2));
   OR2_X1_LVT i_18_0 (.A1(inst_so[4]), .A2(inst_so[5]), .ZN(n_37));
   OR2_X1_LVT i_19_0 (.A1(inst_so[6]), .A2(n_37), .ZN(n_38));
   NOR3_X1_LVT i_39_4 (.A1(n_39_2), .A2(inst_ad[6]), .A3(n_38), .ZN(n_39_3));
   INV_X1_LVT i_39_5 (.A(inst_ad[6]), .ZN(n_39_4));
   AOI221_X1_LVT i_39_6 (.A(n_39_3), .B1(n_39_4), .B2(n_3), .C1(n_68), .C2(n_67), 
      .ZN(n_39_5));
   INV_X1_LVT i_39_7 (.A(n_39_5), .ZN(n_71));
   AND2_X1_LVT i_40_8 (.A1(n_40_1), .A2(n_71), .ZN(n_76));
   NAND2_X1_LVT i_41_92 (.A1(n_76), .A2(dbg_reg_din[15]), .ZN(n_41_77));
   INV_X1_LVT i_40_2 (.A(n_71), .ZN(n_40_2));
   NAND2_X1_LVT i_40_3 (.A1(n_40_1), .A2(n_40_2), .ZN(n_40_3));
   OR2_X1_LVT i_24_0 (.A1(inst_as[2]), .A2(inst_as[3]), .ZN(n_41));
   AND2_X1_LVT i_25_0 (.A1(inst_src[1]), .A2(n_41), .ZN(n_42));
   AND3_X1_LVT i_26_0 (.A1(n_42), .A2(n_1), .A3(n_37), .ZN(n_43));
   NOR4_X1_LVT i_0_12 (.A1(n_0_1), .A2(n_0_3), .A3(e_state[1]), .A4(e_state[3]), 
      .ZN(n_8));
   AND3_X1_LVT i_27_0 (.A1(inst_as[1]), .A2(n_8), .A3(n_37), .ZN(n_44));
   OR2_X1_LVT i_29_0 (.A1(n_5), .A2(n_6), .ZN(n_46));
   OR2_X1_LVT i_35_0 (.A1(n_44), .A2(n_46), .ZN(n_66));
   NOR4_X1_LVT i_0_11 (.A1(n_0_2), .A2(e_state[0]), .A3(e_state[2]), .A4(
      e_state[3]), .ZN(n_7));
   NOR3_X1_LVT i_39_0 (.A1(n_43), .A2(n_66), .A3(n_7), .ZN(n_39_0));
   AND2_X1_LVT i_28_0 (.A1(n_37), .A2(n_4), .ZN(n_45));
   NAND2_X1_LVT i_39_1 (.A1(n_10), .A2(n_45), .ZN(n_39_1));
   NAND2_X1_LVT i_39_2 (.A1(n_39_0), .A2(n_39_1), .ZN(n_70));
   INV_X1_LVT i_40_9 (.A(n_70), .ZN(n_40_6));
   NOR2_X1_LVT i_40_10 (.A1(n_40_3), .A2(n_40_6), .ZN(n_77));
   INV_X1_LVT i_41_8 (.A(n_77), .ZN(n_41_7));
   NAND4_X1_LVT i_41_93 (.A1(n_41_75), .A2(n_41_76), .A3(n_41_77), .A4(n_41_7), 
      .ZN(n_41_78));
   AOI21_X1_LVT i_41_94 (.A(n_41_78), .B1(dbg_halt_st), .B2(dbg_mem_dout[15]), 
      .ZN(n_41_79));
   INV_X1_LVT i_41_95 (.A(n_41_79), .ZN(n_93));
   NAND2_X1_LVT i_41_84 (.A1(n_74), .A2(inst_sext[14]), .ZN(n_41_70));
   INV_X1_LVT i_34_30 (.A(mdb_in[14]), .ZN(n_34_16));
   NOR2_X1_LVT i_34_31 (.A1(n_34_9), .A2(n_34_16), .ZN(n_64));
   NAND2_X1_LVT i_41_85 (.A1(n_75), .A2(n_64), .ZN(n_41_71));
   NAND2_X1_LVT i_41_86 (.A1(n_76), .A2(dbg_reg_din[14]), .ZN(n_41_72));
   NAND4_X1_LVT i_41_87 (.A1(n_41_70), .A2(n_41_71), .A3(n_41_72), .A4(n_41_7), 
      .ZN(n_41_73));
   AOI21_X1_LVT i_41_88 (.A(n_41_73), .B1(dbg_halt_st), .B2(dbg_mem_dout[14]), 
      .ZN(n_41_74));
   INV_X1_LVT i_41_89 (.A(n_41_74), .ZN(n_92));
   NAND2_X1_LVT i_41_78 (.A1(n_74), .A2(inst_sext[13]), .ZN(n_41_65));
   INV_X1_LVT i_34_28 (.A(mdb_in[13]), .ZN(n_34_15));
   NOR2_X1_LVT i_34_29 (.A1(n_34_9), .A2(n_34_15), .ZN(n_63));
   NAND2_X1_LVT i_41_79 (.A1(n_75), .A2(n_63), .ZN(n_41_66));
   NAND2_X1_LVT i_41_80 (.A1(n_76), .A2(dbg_reg_din[13]), .ZN(n_41_67));
   NAND4_X1_LVT i_41_81 (.A1(n_41_65), .A2(n_41_66), .A3(n_41_67), .A4(n_41_7), 
      .ZN(n_41_68));
   AOI21_X1_LVT i_41_82 (.A(n_41_68), .B1(dbg_halt_st), .B2(dbg_mem_dout[13]), 
      .ZN(n_41_69));
   INV_X1_LVT i_41_83 (.A(n_41_69), .ZN(n_91));
   NAND2_X1_LVT i_41_72 (.A1(n_74), .A2(inst_sext[12]), .ZN(n_41_60));
   INV_X1_LVT i_34_26 (.A(mdb_in[12]), .ZN(n_34_14));
   NOR2_X1_LVT i_34_27 (.A1(n_34_9), .A2(n_34_14), .ZN(n_62));
   NAND2_X1_LVT i_41_73 (.A1(n_75), .A2(n_62), .ZN(n_41_61));
   NAND2_X1_LVT i_41_74 (.A1(n_76), .A2(dbg_reg_din[12]), .ZN(n_41_62));
   NAND4_X1_LVT i_41_75 (.A1(n_41_60), .A2(n_41_61), .A3(n_41_62), .A4(n_41_7), 
      .ZN(n_41_63));
   AOI21_X1_LVT i_41_76 (.A(n_41_63), .B1(dbg_halt_st), .B2(dbg_mem_dout[12]), 
      .ZN(n_41_64));
   INV_X1_LVT i_41_77 (.A(n_41_64), .ZN(n_90));
   NAND2_X1_LVT i_41_66 (.A1(n_74), .A2(inst_sext[11]), .ZN(n_41_55));
   INV_X1_LVT i_34_24 (.A(mdb_in[11]), .ZN(n_34_13));
   NOR2_X1_LVT i_34_25 (.A1(n_34_9), .A2(n_34_13), .ZN(n_61));
   NAND2_X1_LVT i_41_67 (.A1(n_75), .A2(n_61), .ZN(n_41_56));
   NAND2_X1_LVT i_41_68 (.A1(n_76), .A2(dbg_reg_din[11]), .ZN(n_41_57));
   NAND4_X1_LVT i_41_69 (.A1(n_41_55), .A2(n_41_56), .A3(n_41_57), .A4(n_41_7), 
      .ZN(n_41_58));
   AOI21_X1_LVT i_41_70 (.A(n_41_58), .B1(dbg_halt_st), .B2(dbg_mem_dout[11]), 
      .ZN(n_41_59));
   INV_X1_LVT i_41_71 (.A(n_41_59), .ZN(n_89));
   NAND2_X1_LVT i_41_60 (.A1(n_74), .A2(inst_sext[10]), .ZN(n_41_50));
   INV_X1_LVT i_34_22 (.A(mdb_in[10]), .ZN(n_34_12));
   NOR2_X1_LVT i_34_23 (.A1(n_34_9), .A2(n_34_12), .ZN(n_60));
   NAND2_X1_LVT i_41_61 (.A1(n_75), .A2(n_60), .ZN(n_41_51));
   NAND2_X1_LVT i_41_62 (.A1(n_76), .A2(dbg_reg_din[10]), .ZN(n_41_52));
   NAND4_X1_LVT i_41_63 (.A1(n_41_50), .A2(n_41_51), .A3(n_41_52), .A4(n_41_7), 
      .ZN(n_41_53));
   AOI21_X1_LVT i_41_64 (.A(n_41_53), .B1(dbg_halt_st), .B2(dbg_mem_dout[10]), 
      .ZN(n_41_54));
   INV_X1_LVT i_41_65 (.A(n_41_54), .ZN(n_88));
   NAND2_X1_LVT i_41_54 (.A1(n_74), .A2(inst_sext[9]), .ZN(n_41_45));
   INV_X1_LVT i_34_20 (.A(mdb_in[9]), .ZN(n_34_11));
   NOR2_X1_LVT i_34_21 (.A1(n_34_9), .A2(n_34_11), .ZN(n_59));
   NAND2_X1_LVT i_41_55 (.A1(n_75), .A2(n_59), .ZN(n_41_46));
   NAND2_X1_LVT i_41_56 (.A1(n_76), .A2(dbg_reg_din[9]), .ZN(n_41_47));
   NAND4_X1_LVT i_41_57 (.A1(n_41_45), .A2(n_41_46), .A3(n_41_47), .A4(n_41_7), 
      .ZN(n_41_48));
   AOI21_X1_LVT i_41_58 (.A(n_41_48), .B1(dbg_halt_st), .B2(dbg_mem_dout[9]), 
      .ZN(n_41_49));
   INV_X1_LVT i_41_59 (.A(n_41_49), .ZN(n_87));
   NAND2_X1_LVT i_41_48 (.A1(n_74), .A2(inst_sext[8]), .ZN(n_41_40));
   INV_X1_LVT i_34_18 (.A(mdb_in[8]), .ZN(n_34_10));
   NOR2_X1_LVT i_34_19 (.A1(n_34_9), .A2(n_34_10), .ZN(n_58));
   NAND2_X1_LVT i_41_49 (.A1(n_75), .A2(n_58), .ZN(n_41_41));
   NAND2_X1_LVT i_41_50 (.A1(n_76), .A2(dbg_reg_din[8]), .ZN(n_41_42));
   NAND4_X1_LVT i_41_51 (.A1(n_41_40), .A2(n_41_41), .A3(n_41_42), .A4(n_41_7), 
      .ZN(n_41_43));
   AOI21_X1_LVT i_41_52 (.A(n_41_43), .B1(dbg_halt_st), .B2(dbg_mem_dout[8]), 
      .ZN(n_41_44));
   INV_X1_LVT i_41_53 (.A(n_41_44), .ZN(n_86));
   NAND2_X1_LVT i_41_42 (.A1(n_74), .A2(inst_sext[7]), .ZN(n_41_35));
   OR2_X1_LVT i_34_0 (.A1(n_47), .A2(n_48), .ZN(n_34_0));
   AOI22_X1_LVT i_34_15 (.A1(n_34_0), .A2(mdb_in[7]), .B1(n_49), .B2(mdb_in[15]), 
      .ZN(n_34_8));
   INV_X1_LVT i_34_16 (.A(n_34_8), .ZN(n_57));
   NAND2_X1_LVT i_41_43 (.A1(n_75), .A2(n_57), .ZN(n_41_36));
   NAND2_X1_LVT i_41_44 (.A1(n_76), .A2(dbg_reg_din[7]), .ZN(n_41_37));
   NAND4_X1_LVT i_41_45 (.A1(n_41_35), .A2(n_41_36), .A3(n_41_37), .A4(n_41_7), 
      .ZN(n_41_38));
   AOI21_X1_LVT i_41_46 (.A(n_41_38), .B1(dbg_halt_st), .B2(dbg_mem_dout[7]), 
      .ZN(n_41_39));
   INV_X1_LVT i_41_47 (.A(n_41_39), .ZN(n_85));
   NAND2_X1_LVT i_41_36 (.A1(n_74), .A2(inst_sext[6]), .ZN(n_41_30));
   AOI22_X1_LVT i_34_13 (.A1(n_34_0), .A2(mdb_in[6]), .B1(n_49), .B2(mdb_in[14]), 
      .ZN(n_34_7));
   INV_X1_LVT i_34_14 (.A(n_34_7), .ZN(n_56));
   NAND2_X1_LVT i_41_37 (.A1(n_75), .A2(n_56), .ZN(n_41_31));
   NAND2_X1_LVT i_41_38 (.A1(n_76), .A2(dbg_reg_din[6]), .ZN(n_41_32));
   NAND4_X1_LVT i_41_39 (.A1(n_41_30), .A2(n_41_31), .A3(n_41_32), .A4(n_41_7), 
      .ZN(n_41_33));
   AOI21_X1_LVT i_41_40 (.A(n_41_33), .B1(dbg_halt_st), .B2(dbg_mem_dout[6]), 
      .ZN(n_41_34));
   INV_X1_LVT i_41_41 (.A(n_41_34), .ZN(n_84));
   NAND2_X1_LVT i_41_30 (.A1(n_74), .A2(inst_sext[5]), .ZN(n_41_25));
   AOI22_X1_LVT i_34_11 (.A1(n_34_0), .A2(mdb_in[5]), .B1(n_49), .B2(mdb_in[13]), 
      .ZN(n_34_6));
   INV_X1_LVT i_34_12 (.A(n_34_6), .ZN(n_55));
   NAND2_X1_LVT i_41_31 (.A1(n_75), .A2(n_55), .ZN(n_41_26));
   NAND2_X1_LVT i_41_32 (.A1(n_76), .A2(dbg_reg_din[5]), .ZN(n_41_27));
   NAND4_X1_LVT i_41_33 (.A1(n_41_25), .A2(n_41_26), .A3(n_41_27), .A4(n_41_7), 
      .ZN(n_41_28));
   AOI21_X1_LVT i_41_34 (.A(n_41_28), .B1(dbg_halt_st), .B2(dbg_mem_dout[5]), 
      .ZN(n_41_29));
   INV_X1_LVT i_41_35 (.A(n_41_29), .ZN(n_83));
   NAND2_X1_LVT i_41_24 (.A1(n_74), .A2(inst_sext[4]), .ZN(n_41_20));
   AOI22_X1_LVT i_34_9 (.A1(n_34_0), .A2(mdb_in[4]), .B1(n_49), .B2(mdb_in[12]), 
      .ZN(n_34_5));
   INV_X1_LVT i_34_10 (.A(n_34_5), .ZN(n_54));
   NAND2_X1_LVT i_41_25 (.A1(n_75), .A2(n_54), .ZN(n_41_21));
   NAND2_X1_LVT i_41_26 (.A1(n_76), .A2(dbg_reg_din[4]), .ZN(n_41_22));
   NAND4_X1_LVT i_41_27 (.A1(n_41_20), .A2(n_41_21), .A3(n_41_22), .A4(n_41_7), 
      .ZN(n_41_23));
   AOI21_X1_LVT i_41_28 (.A(n_41_23), .B1(dbg_halt_st), .B2(dbg_mem_dout[4]), 
      .ZN(n_41_24));
   INV_X1_LVT i_41_29 (.A(n_41_24), .ZN(n_82));
   NAND2_X1_LVT i_41_18 (.A1(n_74), .A2(inst_sext[3]), .ZN(n_41_15));
   AOI22_X1_LVT i_34_7 (.A1(n_34_0), .A2(mdb_in[3]), .B1(n_49), .B2(mdb_in[11]), 
      .ZN(n_34_4));
   INV_X1_LVT i_34_8 (.A(n_34_4), .ZN(n_53));
   NAND2_X1_LVT i_41_19 (.A1(n_75), .A2(n_53), .ZN(n_41_16));
   NAND2_X1_LVT i_41_20 (.A1(n_76), .A2(dbg_reg_din[3]), .ZN(n_41_17));
   NAND4_X1_LVT i_41_21 (.A1(n_41_15), .A2(n_41_16), .A3(n_41_17), .A4(n_41_7), 
      .ZN(n_41_18));
   AOI21_X1_LVT i_41_22 (.A(n_41_18), .B1(dbg_halt_st), .B2(dbg_mem_dout[3]), 
      .ZN(n_41_19));
   INV_X1_LVT i_41_23 (.A(n_41_19), .ZN(n_81));
   NAND2_X1_LVT i_41_12 (.A1(n_74), .A2(inst_sext[2]), .ZN(n_41_10));
   AOI22_X1_LVT i_34_5 (.A1(n_34_0), .A2(mdb_in[2]), .B1(n_49), .B2(mdb_in[10]), 
      .ZN(n_34_3));
   INV_X1_LVT i_34_6 (.A(n_34_3), .ZN(n_52));
   NAND2_X1_LVT i_41_13 (.A1(n_75), .A2(n_52), .ZN(n_41_11));
   NAND2_X1_LVT i_41_14 (.A1(n_76), .A2(dbg_reg_din[2]), .ZN(n_41_12));
   NAND4_X1_LVT i_41_15 (.A1(n_41_10), .A2(n_41_11), .A3(n_41_12), .A4(n_41_7), 
      .ZN(n_41_13));
   AOI21_X1_LVT i_41_16 (.A(n_41_13), .B1(dbg_halt_st), .B2(dbg_mem_dout[2]), 
      .ZN(n_41_14));
   INV_X1_LVT i_41_17 (.A(n_41_14), .ZN(n_80));
   NAND2_X1_LVT i_41_5 (.A1(n_74), .A2(inst_sext[1]), .ZN(n_41_4));
   AOI22_X1_LVT i_34_3 (.A1(n_34_0), .A2(mdb_in[1]), .B1(n_49), .B2(mdb_in[9]), 
      .ZN(n_34_2));
   INV_X1_LVT i_34_4 (.A(n_34_2), .ZN(n_51));
   NAND2_X1_LVT i_41_6 (.A1(n_75), .A2(n_51), .ZN(n_41_5));
   NAND2_X1_LVT i_41_7 (.A1(n_76), .A2(dbg_reg_din[1]), .ZN(n_41_6));
   NAND4_X1_LVT i_41_9 (.A1(n_41_4), .A2(n_41_5), .A3(n_41_6), .A4(n_41_7), 
      .ZN(n_41_8));
   AOI21_X1_LVT i_41_10 (.A(n_41_8), .B1(dbg_halt_st), .B2(dbg_mem_dout[1]), 
      .ZN(n_41_9));
   INV_X1_LVT i_41_11 (.A(n_41_9), .ZN(n_79));
   NAND2_X1_LVT i_41_0 (.A1(dbg_mem_dout[0]), .A2(dbg_halt_st), .ZN(n_41_0));
   NAND2_X1_LVT i_41_1 (.A1(inst_sext[0]), .A2(n_74), .ZN(n_41_1));
   AOI22_X1_LVT i_34_1 (.A1(n_34_0), .A2(mdb_in[0]), .B1(mdb_in[8]), .B2(n_49), 
      .ZN(n_34_1));
   INV_X1_LVT i_34_2 (.A(n_34_1), .ZN(n_50));
   NAND2_X1_LVT i_41_2 (.A1(n_50), .A2(n_75), .ZN(n_41_2));
   NAND2_X1_LVT i_41_3 (.A1(dbg_reg_din[0]), .A2(n_76), .ZN(n_41_3));
   NAND4_X1_LVT i_41_4 (.A1(n_41_0), .A2(n_41_1), .A3(n_41_2), .A4(n_41_3), 
      .ZN(n_78));
   OR2_X1_LVT i_48_8 (.A1(n_45), .A2(n_66), .ZN(n_102));
   NOR4_X1_LVT i_0_13 (.A1(e_state[0]), .A2(e_state[1]), .A3(e_state[2]), 
      .A4(e_state[3]), .ZN(reg_sr_clr));
   NOR2_X1_LVT i_48_9 (.A1(reg_sr_clr), .A2(n_7), .ZN(n_48_5));
   INV_X1_LVT i_48_10 (.A(inst_type[1]), .ZN(n_48_6));
   NAND3_X1_LVT i_48_11 (.A1(n_48_6), .A2(inst_as[0]), .A3(n_0), .ZN(n_48_7));
   INV_X1_LVT i_47_0 (.A(inst_as[6]), .ZN(n_98));
   NAND2_X1_LVT i_48_12 (.A1(n_2), .A2(n_98), .ZN(n_48_8));
   NAND2_X1_LVT i_48_13 (.A1(n_98), .A2(n_1), .ZN(n_48_9));
   NAND4_X1_LVT i_48_14 (.A1(n_48_5), .A2(n_48_7), .A3(n_48_8), .A4(n_48_9), 
      .ZN(n_103));
   NOR2_X1_LVT i_49_0 (.A1(n_102), .A2(n_103), .ZN(n_49_0));
   INV_X1_LVT i_49_8 (.A(n_49_0), .ZN(n_49_7));
   INV_X1_LVT i_44_0 (.A(e_state[2]), .ZN(n_44_0));
   NAND4_X1_LVT i_44_1 (.A1(n_44_0), .A2(e_state[0]), .A3(e_state[1]), .A4(
      e_state[3]), .ZN(n_44_1));
   DFFR_X1_LVT mdb_in_buf_en_reg (.D(n_1), .RN(n_18), .CK(mclk), .Q(
      mdb_in_buf_en), .QN());
   AND2_X1_LVT i_44_2 (.A1(n_44_1), .A2(mdb_in_buf_en), .ZN(n_96));
   INV_X1_LVT i_45_0 (.A(e_state[2]), .ZN(n_45_0));
   NAND4_X1_LVT i_45_1 (.A1(n_45_0), .A2(e_state[0]), .A3(e_state[1]), .A4(
      e_state[3]), .ZN(n_45_1));
   NAND2_X1_LVT i_45_2 (.A1(n_45_1), .A2(mdb_in_buf_en), .ZN(n_45_2));
   NAND2_X1_LVT i_45_3 (.A1(n_45_2), .A2(n_45_1), .ZN(n_97));
   CLKGATETST_X1_LVT clk_gate_mdb_in_buf_valid_reg (.CK(mclk), .E(n_97), 
      .SE(1'b0), .GCK(n_95));
   DFFR_X1_LVT mdb_in_buf_valid_reg (.D(n_96), .RN(n_18), .CK(n_95), .Q(
      mdb_in_buf_valid), .QN());
   OAI21_X1_LVT i_48_5 (.A(n_0), .B1(n_41), .B2(n_69), .ZN(n_48_3));
   AND2_X1_LVT i_31_0 (.A1(n_4), .A2(inst_so[6]), .ZN(reg_sr_wr));
   INV_X1_LVT i_48_6 (.A(reg_sr_wr), .ZN(n_48_4));
   NAND2_X1_LVT i_48_7 (.A1(n_48_3), .A2(n_48_4), .ZN(n_101));
   NAND2_X1_LVT i_49_1 (.A1(mdb_in_buf_valid), .A2(n_101), .ZN(n_49_1));
   NOR2_X1_LVT i_49_9 (.A1(n_49_7), .A2(n_49_1), .ZN(n_105));
   CLKGATETST_X1_LVT clk_gate_mdb_in_buf_reg (.CK(mclk), .E(mdb_in_buf_en), 
      .SE(1'b0), .GCK(n_94));
   DFFR_X1_LVT \mdb_in_buf_reg[15]  (.D(n_65), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[15]), .QN());
   NAND2_X1_LVT i_50_105 (.A1(n_105), .A2(mdb_in_buf[15]), .ZN(n_50_90));
   NAND2_X1_LVT i_49_2 (.A1(n_49_0), .A2(n_49_1), .ZN(n_49_2));
   INV_X1_LVT i_49_10 (.A(n_101), .ZN(n_49_8));
   NOR2_X1_LVT i_49_11 (.A1(n_49_2), .A2(n_49_8), .ZN(n_106));
   NAND2_X1_LVT i_50_106 (.A1(n_106), .A2(n_65), .ZN(n_50_91));
   NOR2_X1_LVT i_49_3 (.A1(n_49_2), .A2(n_101), .ZN(n_49_3));
   INV_X1_LVT i_20_0 (.A(n_38), .ZN(n_39));
   NAND2_X1_LVT i_48_2 (.A1(n_3), .A2(n_39), .ZN(n_48_1));
   INV_X1_LVT i_48_3 (.A(n_4), .ZN(n_48_2));
   OAI21_X1_LVT i_48_4 (.A(n_48_1), .B1(n_48_2), .B2(n_37), .ZN(n_100));
   AND2_X1_LVT i_49_12 (.A1(n_49_3), .A2(n_100), .ZN(n_107));
   NAND2_X1_LVT i_50_107 (.A1(n_107), .A2(inst_dext[15]), .ZN(n_50_92));
   INV_X1_LVT i_49_4 (.A(n_100), .ZN(n_49_4));
   NAND2_X1_LVT i_49_5 (.A1(n_49_3), .A2(n_49_4), .ZN(n_49_5));
   OR4_X1_LVT i_48_0 (.A1(inst_as[7]), .A2(inst_as[5]), .A3(inst_type[1]), 
      .A4(inst_so[6]), .ZN(n_48_0));
   AND2_X1_LVT i_48_1 (.A1(n_48_0), .A2(n_0), .ZN(n_99));
   INV_X1_LVT i_49_13 (.A(n_99), .ZN(n_49_9));
   NOR2_X1_LVT i_49_14 (.A1(n_49_5), .A2(n_49_9), .ZN(n_108));
   NAND2_X1_LVT i_50_108 (.A1(n_108), .A2(inst_sext[15]), .ZN(n_50_93));
   NAND4_X1_LVT i_50_109 (.A1(n_50_90), .A2(n_50_91), .A3(n_50_92), .A4(n_50_93), 
      .ZN(n_50_94));
   INV_X1_LVT i_49_6 (.A(n_102), .ZN(n_49_6));
   NOR2_X1_LVT i_49_7 (.A1(n_49_6), .A2(n_103), .ZN(n_104));
   AOI221_X1_LVT i_50_110 (.A(n_50_94), .B1(n_103), .B2(reg_src[15]), .C1(n_104), 
      .C2(dbg_reg_din[15]), .ZN(n_50_95));
   INV_X1_LVT i_50_111 (.A(n_50_95), .ZN(n_124));
   DFFR_X1_LVT \mdb_in_buf_reg[14]  (.D(n_64), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[14]), .QN());
   NAND2_X1_LVT i_50_98 (.A1(n_105), .A2(mdb_in_buf[14]), .ZN(n_50_84));
   NAND2_X1_LVT i_50_99 (.A1(n_106), .A2(n_64), .ZN(n_50_85));
   NAND2_X1_LVT i_50_100 (.A1(n_107), .A2(inst_dext[14]), .ZN(n_50_86));
   NAND2_X1_LVT i_50_101 (.A1(n_108), .A2(inst_sext[14]), .ZN(n_50_87));
   NAND4_X1_LVT i_50_102 (.A1(n_50_84), .A2(n_50_85), .A3(n_50_86), .A4(n_50_87), 
      .ZN(n_50_88));
   AOI221_X1_LVT i_50_103 (.A(n_50_88), .B1(n_103), .B2(reg_src[14]), .C1(n_104), 
      .C2(dbg_reg_din[14]), .ZN(n_50_89));
   INV_X1_LVT i_50_104 (.A(n_50_89), .ZN(n_123));
   DFFR_X1_LVT \mdb_in_buf_reg[13]  (.D(n_63), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[13]), .QN());
   NAND2_X1_LVT i_50_91 (.A1(n_105), .A2(mdb_in_buf[13]), .ZN(n_50_78));
   NAND2_X1_LVT i_50_92 (.A1(n_106), .A2(n_63), .ZN(n_50_79));
   NAND2_X1_LVT i_50_93 (.A1(n_107), .A2(inst_dext[13]), .ZN(n_50_80));
   NAND2_X1_LVT i_50_94 (.A1(n_108), .A2(inst_sext[13]), .ZN(n_50_81));
   NAND4_X1_LVT i_50_95 (.A1(n_50_78), .A2(n_50_79), .A3(n_50_80), .A4(n_50_81), 
      .ZN(n_50_82));
   AOI221_X1_LVT i_50_96 (.A(n_50_82), .B1(n_103), .B2(reg_src[13]), .C1(n_104), 
      .C2(dbg_reg_din[13]), .ZN(n_50_83));
   INV_X1_LVT i_50_97 (.A(n_50_83), .ZN(n_122));
   DFFR_X1_LVT \mdb_in_buf_reg[12]  (.D(n_62), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[12]), .QN());
   NAND2_X1_LVT i_50_84 (.A1(n_105), .A2(mdb_in_buf[12]), .ZN(n_50_72));
   NAND2_X1_LVT i_50_85 (.A1(n_106), .A2(n_62), .ZN(n_50_73));
   NAND2_X1_LVT i_50_86 (.A1(n_107), .A2(inst_dext[12]), .ZN(n_50_74));
   NAND2_X1_LVT i_50_87 (.A1(n_108), .A2(inst_sext[12]), .ZN(n_50_75));
   NAND4_X1_LVT i_50_88 (.A1(n_50_72), .A2(n_50_73), .A3(n_50_74), .A4(n_50_75), 
      .ZN(n_50_76));
   AOI221_X1_LVT i_50_89 (.A(n_50_76), .B1(n_103), .B2(reg_src[12]), .C1(n_104), 
      .C2(dbg_reg_din[12]), .ZN(n_50_77));
   INV_X1_LVT i_50_90 (.A(n_50_77), .ZN(n_121));
   DFFR_X1_LVT \mdb_in_buf_reg[11]  (.D(n_61), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[11]), .QN());
   NAND2_X1_LVT i_50_77 (.A1(n_105), .A2(mdb_in_buf[11]), .ZN(n_50_66));
   NAND2_X1_LVT i_50_78 (.A1(n_106), .A2(n_61), .ZN(n_50_67));
   NAND2_X1_LVT i_50_79 (.A1(n_107), .A2(inst_dext[11]), .ZN(n_50_68));
   NAND2_X1_LVT i_50_80 (.A1(n_108), .A2(inst_sext[11]), .ZN(n_50_69));
   NAND4_X1_LVT i_50_81 (.A1(n_50_66), .A2(n_50_67), .A3(n_50_68), .A4(n_50_69), 
      .ZN(n_50_70));
   AOI221_X1_LVT i_50_82 (.A(n_50_70), .B1(n_103), .B2(reg_src[11]), .C1(n_104), 
      .C2(dbg_reg_din[11]), .ZN(n_50_71));
   INV_X1_LVT i_50_83 (.A(n_50_71), .ZN(n_120));
   DFFR_X1_LVT \mdb_in_buf_reg[10]  (.D(n_60), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[10]), .QN());
   NAND2_X1_LVT i_50_70 (.A1(n_105), .A2(mdb_in_buf[10]), .ZN(n_50_60));
   NAND2_X1_LVT i_50_71 (.A1(n_106), .A2(n_60), .ZN(n_50_61));
   NAND2_X1_LVT i_50_72 (.A1(n_107), .A2(inst_dext[10]), .ZN(n_50_62));
   NAND2_X1_LVT i_50_73 (.A1(n_108), .A2(inst_sext[10]), .ZN(n_50_63));
   NAND4_X1_LVT i_50_74 (.A1(n_50_60), .A2(n_50_61), .A3(n_50_62), .A4(n_50_63), 
      .ZN(n_50_64));
   AOI221_X1_LVT i_50_75 (.A(n_50_64), .B1(n_103), .B2(reg_src[10]), .C1(n_104), 
      .C2(dbg_reg_din[10]), .ZN(n_50_65));
   INV_X1_LVT i_50_76 (.A(n_50_65), .ZN(n_119));
   DFFR_X1_LVT \mdb_in_buf_reg[9]  (.D(n_59), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[9]), .QN());
   NAND2_X1_LVT i_50_63 (.A1(n_105), .A2(mdb_in_buf[9]), .ZN(n_50_54));
   NAND2_X1_LVT i_50_64 (.A1(n_106), .A2(n_59), .ZN(n_50_55));
   NAND2_X1_LVT i_50_65 (.A1(n_107), .A2(inst_dext[9]), .ZN(n_50_56));
   NAND2_X1_LVT i_50_66 (.A1(n_108), .A2(inst_sext[9]), .ZN(n_50_57));
   NAND4_X1_LVT i_50_67 (.A1(n_50_54), .A2(n_50_55), .A3(n_50_56), .A4(n_50_57), 
      .ZN(n_50_58));
   AOI221_X1_LVT i_50_68 (.A(n_50_58), .B1(n_103), .B2(reg_src[9]), .C1(n_104), 
      .C2(dbg_reg_din[9]), .ZN(n_50_59));
   INV_X1_LVT i_50_69 (.A(n_50_59), .ZN(n_118));
   DFFR_X1_LVT \mdb_in_buf_reg[8]  (.D(n_58), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[8]), .QN());
   NAND2_X1_LVT i_50_56 (.A1(n_105), .A2(mdb_in_buf[8]), .ZN(n_50_48));
   NAND2_X1_LVT i_50_57 (.A1(n_106), .A2(n_58), .ZN(n_50_49));
   NAND2_X1_LVT i_50_58 (.A1(n_107), .A2(inst_dext[8]), .ZN(n_50_50));
   NAND2_X1_LVT i_50_59 (.A1(n_108), .A2(inst_sext[8]), .ZN(n_50_51));
   NAND4_X1_LVT i_50_60 (.A1(n_50_48), .A2(n_50_49), .A3(n_50_50), .A4(n_50_51), 
      .ZN(n_50_52));
   AOI221_X1_LVT i_50_61 (.A(n_50_52), .B1(n_103), .B2(reg_src[8]), .C1(n_104), 
      .C2(dbg_reg_din[8]), .ZN(n_50_53));
   INV_X1_LVT i_50_62 (.A(n_50_53), .ZN(n_117));
   DFFR_X1_LVT \mdb_in_buf_reg[7]  (.D(n_57), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[7]), .QN());
   NAND2_X1_LVT i_50_49 (.A1(n_105), .A2(mdb_in_buf[7]), .ZN(n_50_42));
   NAND2_X1_LVT i_50_50 (.A1(n_106), .A2(n_57), .ZN(n_50_43));
   NAND2_X1_LVT i_50_51 (.A1(n_107), .A2(inst_dext[7]), .ZN(n_50_44));
   NAND2_X1_LVT i_50_52 (.A1(n_108), .A2(inst_sext[7]), .ZN(n_50_45));
   NAND4_X1_LVT i_50_53 (.A1(n_50_42), .A2(n_50_43), .A3(n_50_44), .A4(n_50_45), 
      .ZN(n_50_46));
   AOI221_X1_LVT i_50_54 (.A(n_50_46), .B1(n_103), .B2(reg_src[7]), .C1(n_104), 
      .C2(dbg_reg_din[7]), .ZN(n_50_47));
   INV_X1_LVT i_50_55 (.A(n_50_47), .ZN(n_116));
   DFFR_X1_LVT \mdb_in_buf_reg[6]  (.D(n_56), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[6]), .QN());
   NAND2_X1_LVT i_50_42 (.A1(n_105), .A2(mdb_in_buf[6]), .ZN(n_50_36));
   NAND2_X1_LVT i_50_43 (.A1(n_106), .A2(n_56), .ZN(n_50_37));
   NAND2_X1_LVT i_50_44 (.A1(n_107), .A2(inst_dext[6]), .ZN(n_50_38));
   NAND2_X1_LVT i_50_45 (.A1(n_108), .A2(inst_sext[6]), .ZN(n_50_39));
   NAND4_X1_LVT i_50_46 (.A1(n_50_36), .A2(n_50_37), .A3(n_50_38), .A4(n_50_39), 
      .ZN(n_50_40));
   AOI221_X1_LVT i_50_47 (.A(n_50_40), .B1(n_103), .B2(reg_src[6]), .C1(n_104), 
      .C2(dbg_reg_din[6]), .ZN(n_50_41));
   INV_X1_LVT i_50_48 (.A(n_50_41), .ZN(n_115));
   DFFR_X1_LVT \mdb_in_buf_reg[5]  (.D(n_55), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[5]), .QN());
   NAND2_X1_LVT i_50_35 (.A1(n_105), .A2(mdb_in_buf[5]), .ZN(n_50_30));
   NAND2_X1_LVT i_50_36 (.A1(n_106), .A2(n_55), .ZN(n_50_31));
   NAND2_X1_LVT i_50_37 (.A1(n_107), .A2(inst_dext[5]), .ZN(n_50_32));
   NAND2_X1_LVT i_50_38 (.A1(n_108), .A2(inst_sext[5]), .ZN(n_50_33));
   NAND4_X1_LVT i_50_39 (.A1(n_50_30), .A2(n_50_31), .A3(n_50_32), .A4(n_50_33), 
      .ZN(n_50_34));
   AOI221_X1_LVT i_50_40 (.A(n_50_34), .B1(n_103), .B2(reg_src[5]), .C1(n_104), 
      .C2(dbg_reg_din[5]), .ZN(n_50_35));
   INV_X1_LVT i_50_41 (.A(n_50_35), .ZN(n_114));
   DFFR_X1_LVT \mdb_in_buf_reg[4]  (.D(n_54), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[4]), .QN());
   NAND2_X1_LVT i_50_28 (.A1(n_105), .A2(mdb_in_buf[4]), .ZN(n_50_24));
   NAND2_X1_LVT i_50_29 (.A1(n_106), .A2(n_54), .ZN(n_50_25));
   NAND2_X1_LVT i_50_30 (.A1(n_107), .A2(inst_dext[4]), .ZN(n_50_26));
   NAND2_X1_LVT i_50_31 (.A1(n_108), .A2(inst_sext[4]), .ZN(n_50_27));
   NAND4_X1_LVT i_50_32 (.A1(n_50_24), .A2(n_50_25), .A3(n_50_26), .A4(n_50_27), 
      .ZN(n_50_28));
   AOI221_X1_LVT i_50_33 (.A(n_50_28), .B1(n_103), .B2(reg_src[4]), .C1(n_104), 
      .C2(dbg_reg_din[4]), .ZN(n_50_29));
   INV_X1_LVT i_50_34 (.A(n_50_29), .ZN(n_113));
   DFFR_X1_LVT \mdb_in_buf_reg[3]  (.D(n_53), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[3]), .QN());
   NAND2_X1_LVT i_50_21 (.A1(n_105), .A2(mdb_in_buf[3]), .ZN(n_50_18));
   NAND2_X1_LVT i_50_22 (.A1(n_106), .A2(n_53), .ZN(n_50_19));
   NAND2_X1_LVT i_50_23 (.A1(n_107), .A2(inst_dext[3]), .ZN(n_50_20));
   NAND2_X1_LVT i_50_24 (.A1(n_108), .A2(inst_sext[3]), .ZN(n_50_21));
   NAND4_X1_LVT i_50_25 (.A1(n_50_18), .A2(n_50_19), .A3(n_50_20), .A4(n_50_21), 
      .ZN(n_50_22));
   AOI221_X1_LVT i_50_26 (.A(n_50_22), .B1(n_103), .B2(reg_src[3]), .C1(n_104), 
      .C2(dbg_reg_din[3]), .ZN(n_50_23));
   INV_X1_LVT i_50_27 (.A(n_50_23), .ZN(n_112));
   DFFR_X1_LVT \mdb_in_buf_reg[2]  (.D(n_52), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[2]), .QN());
   NAND2_X1_LVT i_50_14 (.A1(n_105), .A2(mdb_in_buf[2]), .ZN(n_50_12));
   NAND2_X1_LVT i_50_15 (.A1(n_106), .A2(n_52), .ZN(n_50_13));
   NAND2_X1_LVT i_50_16 (.A1(n_107), .A2(inst_dext[2]), .ZN(n_50_14));
   NAND2_X1_LVT i_50_17 (.A1(n_108), .A2(inst_sext[2]), .ZN(n_50_15));
   NAND4_X1_LVT i_50_18 (.A1(n_50_12), .A2(n_50_13), .A3(n_50_14), .A4(n_50_15), 
      .ZN(n_50_16));
   AOI221_X1_LVT i_50_19 (.A(n_50_16), .B1(n_103), .B2(reg_src[2]), .C1(n_104), 
      .C2(dbg_reg_din[2]), .ZN(n_50_17));
   INV_X1_LVT i_50_20 (.A(n_50_17), .ZN(n_111));
   DFFR_X1_LVT \mdb_in_buf_reg[1]  (.D(n_51), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[1]), .QN());
   NAND2_X1_LVT i_50_7 (.A1(n_105), .A2(mdb_in_buf[1]), .ZN(n_50_6));
   NAND2_X1_LVT i_50_8 (.A1(n_106), .A2(n_51), .ZN(n_50_7));
   NAND2_X1_LVT i_50_9 (.A1(n_107), .A2(inst_dext[1]), .ZN(n_50_8));
   NAND2_X1_LVT i_50_10 (.A1(n_108), .A2(inst_sext[1]), .ZN(n_50_9));
   NAND4_X1_LVT i_50_11 (.A1(n_50_6), .A2(n_50_7), .A3(n_50_8), .A4(n_50_9), 
      .ZN(n_50_10));
   AOI221_X1_LVT i_50_12 (.A(n_50_10), .B1(n_103), .B2(reg_src[1]), .C1(n_104), 
      .C2(dbg_reg_din[1]), .ZN(n_50_11));
   INV_X1_LVT i_50_13 (.A(n_50_11), .ZN(n_110));
   DFFR_X1_LVT \mdb_in_buf_reg[0]  (.D(n_50), .RN(n_18), .CK(n_94), .Q(
      mdb_in_buf[0]), .QN());
   NAND2_X1_LVT i_50_0 (.A1(mdb_in_buf[0]), .A2(n_105), .ZN(n_50_0));
   NAND2_X1_LVT i_50_1 (.A1(n_50), .A2(n_106), .ZN(n_50_1));
   NAND2_X1_LVT i_50_2 (.A1(inst_dext[0]), .A2(n_107), .ZN(n_50_2));
   NAND2_X1_LVT i_50_3 (.A1(inst_sext[0]), .A2(n_108), .ZN(n_50_3));
   NAND4_X1_LVT i_50_4 (.A1(n_50_0), .A2(n_50_1), .A3(n_50_2), .A4(n_50_3), 
      .ZN(n_50_4));
   AOI221_X1_LVT i_50_5 (.A(n_50_4), .B1(reg_src[0]), .B2(n_103), .C1(
      dbg_reg_din[0]), .C2(n_104), .ZN(n_50_5));
   INV_X1_LVT i_50_6 (.A(n_50_5), .ZN(n_109));
   omsp_alu alu_0 (.alu_out(alu_out), .alu_out_add(mab), .alu_stat(alu_stat), 
      .alu_stat_wr(alu_stat_wr), .dbg_halt_st(dbg_halt_st), .exec_cycle(n_0), 
      .inst_alu(inst_alu), .inst_bw(inst_bw), .inst_jmp(inst_jmp), .inst_so(
      inst_so), .op_dst({n_93, n_92, n_91, n_90, n_89, n_88, n_87, n_86, n_85, 
      n_84, n_83, n_82, n_81, n_80, n_79, n_78}), .op_src({n_124, n_123, n_122, 
      n_121, n_120, n_119, n_118, n_117, n_116, n_115, n_114, n_113, n_112, 
      n_111, n_110, n_109}), .status(status));
   NAND3_X1_LVT i_21_0 (.A1(inst_type[2]), .A2(inst_ad[0]), .A3(n_13), .ZN(
      n_21_0));
   NAND3_X1_LVT i_21_1 (.A1(inst_as[0]), .A2(n_39), .A3(inst_type[0]), .ZN(
      n_21_1));
   INV_X1_LVT i_21_2 (.A(inst_type[1]), .ZN(n_21_2));
   NAND3_X1_LVT i_21_3 (.A1(n_21_0), .A2(n_21_1), .A3(n_21_2), .ZN(n_21_3));
   AOI21_X1_LVT i_21_4 (.A(dbg_reg_wr), .B1(n_21_3), .B2(n_0), .ZN(n_21_4));
   INV_X1_LVT i_21_5 (.A(n_21_4), .ZN(reg_dest_wr));
   AOI21_X1_LVT i_23_0 (.A(n_40), .B1(inst_so[5]), .B2(n_0), .ZN(n_23_0));
   INV_X1_LVT i_23_1 (.A(n_23_0), .ZN(reg_pc_call));
   AND2_X1_LVT i_30_0 (.A1(n_11), .A2(n_46), .ZN(n_30_0));
   INV_X1_LVT i_30_1 (.A(n_45), .ZN(n_30_1));
   NOR3_X1_LVT i_30_2 (.A1(n_30_1), .A2(n_42), .A3(inst_as[1]), .ZN(n_30_2));
   OR4_X1_LVT i_30_3 (.A1(n_30_0), .A2(n_30_2), .A3(n_44), .A4(n_43), .ZN(
      reg_sp_wr));
   AOI221_X1_LVT i_32_0 (.A(n_9), .B1(exec_done), .B2(inst_as[3]), .C1(n_1), 
      .C2(inst_so[6]), .ZN(n_32_0));
   INV_X1_LVT i_32_1 (.A(n_32_0), .ZN(reg_incr));
   omsp_register_file register_file_0 (.cpuoff(cpuoff), .gie(gie), .oscoff(
      oscoff), .pc_sw(pc_sw), .pc_sw_wr(pc_sw_wr), .reg_dest(dbg_reg_din), 
      .reg_src(reg_src), .scg0(scg0), .scg1(scg1), .status(status), .alu_stat(
      alu_stat), .alu_stat_wr(alu_stat_wr), .inst_bw(inst_bw), .inst_dest(
      inst_dest), .inst_src(inst_src), .mclk(mclk), .pc(pc), .puc_rst(puc_rst), 
      .reg_dest_val(alu_out), .reg_dest_wr(reg_dest_wr), .reg_pc_call(
      reg_pc_call), .reg_sp_val(mab), .reg_sp_wr(reg_sp_wr), .reg_sr_wr(
      reg_sr_wr), .reg_sr_clr(reg_sr_clr), .reg_incr(reg_incr), .scan_enable(
      scan_enable));
   OR2_X1_LVT i_8_0 (.A1(inst_bw), .A2(inst_alu[11]), .ZN(n_8_0));
   INV_X1_LVT i_8_1 (.A(inst_alu[11]), .ZN(n_8_1));
   NAND2_X1_LVT i_8_2 (.A1(n_8_1), .A2(inst_bw), .ZN(n_8_2));
   INV_X1_LVT i_8_4 (.A(mab[0]), .ZN(n_8_3));
   OAI21_X1_LVT i_8_5 (.A(n_8_0), .B1(n_8_2), .B2(n_8_3), .ZN(n_15));
   AND2_X1_LVT i_9_1 (.A1(mb_wr_det), .A2(n_15), .ZN(mb_wr[1]));
   OAI21_X1_LVT i_8_3 (.A(n_8_0), .B1(n_8_2), .B2(mab[0]), .ZN(n_14));
   AND2_X1_LVT i_9_0 (.A1(mb_wr_det), .A2(n_14), .ZN(mb_wr[0]));
   INV_X1_LVT i_17_0 (.A(inst_bw), .ZN(n_17_0));
   NAND2_X1_LVT i_13_0 (.A1(e_state[0]), .A2(e_state[3]), .ZN(n_13_0));
   NOR3_X1_LVT i_13_1 (.A1(n_13_0), .A2(e_state[1]), .A3(e_state[2]), .ZN(n_13_1));
   INV_X1_LVT i_13_2 (.A(n_13_1), .ZN(n_13_2));
   AOI22_X1_LVT i_13_33 (.A1(n_13_2), .A2(alu_out[15]), .B1(n_13_1), .B2(
      pc_nxt[15]), .ZN(n_13_18));
   INV_X1_LVT i_13_34 (.A(n_13_18), .ZN(n_34));
   INV_X1_LVT i_14_0 (.A(inst_so[5]), .ZN(n_14_0));
   AOI211_X1_LVT i_14_1 (.A(n_7), .B(reg_sr_clr), .C1(n_14_0), .C2(n_0), 
      .ZN(n_14_1));
   INV_X1_LVT i_14_2 (.A(n_14_1), .ZN(n_35));
   INV_X1_LVT i_15_3 (.A(n_35), .ZN(n_15_3));
   NAND2_X1_LVT i_15_0 (.A1(e_state[0]), .A2(e_state[3]), .ZN(n_15_0));
   NOR3_X1_LVT i_15_1 (.A1(n_15_0), .A2(e_state[1]), .A3(e_state[2]), .ZN(n_15_1));
   INV_X1_LVT i_15_2 (.A(n_15_1), .ZN(n_15_2));
   NAND2_X1_LVT i_15_4 (.A1(n_15_3), .A2(n_15_2), .ZN(n_36));
   CLKGATETST_X1_LVT clk_gate_mdb_out_nxt_reg (.CK(mclk), .E(n_36), .SE(1'b0), 
      .GCK(n_17));
   DFFR_X1_LVT \mdb_out_nxt_reg[15]  (.D(n_34), .RN(n_18), .CK(n_17), .Q(
      mdb_out_nxt[15]), .QN());
   AOI22_X1_LVT i_13_17 (.A1(n_13_2), .A2(alu_out[7]), .B1(n_13_1), .B2(
      pc_nxt[7]), .ZN(n_13_10));
   INV_X1_LVT i_13_18 (.A(n_13_10), .ZN(n_26));
   DFFR_X1_LVT \mdb_out_nxt_reg[7]  (.D(n_26), .RN(n_18), .CK(n_17), .Q(
      mdb_out[7]), .QN());
   AOI22_X1_LVT i_17_15 (.A1(n_17_0), .A2(mdb_out_nxt[15]), .B1(inst_bw), 
      .B2(mdb_out[7]), .ZN(n_17_8));
   INV_X1_LVT i_17_16 (.A(n_17_8), .ZN(mdb_out[15]));
   AOI22_X1_LVT i_13_31 (.A1(n_13_2), .A2(alu_out[14]), .B1(n_13_1), .B2(
      pc_nxt[14]), .ZN(n_13_17));
   INV_X1_LVT i_13_32 (.A(n_13_17), .ZN(n_33));
   DFFR_X1_LVT \mdb_out_nxt_reg[14]  (.D(n_33), .RN(n_18), .CK(n_17), .Q(
      mdb_out_nxt[14]), .QN());
   AOI22_X1_LVT i_13_15 (.A1(n_13_2), .A2(alu_out[6]), .B1(n_13_1), .B2(
      pc_nxt[6]), .ZN(n_13_9));
   INV_X1_LVT i_13_16 (.A(n_13_9), .ZN(n_25));
   DFFR_X1_LVT \mdb_out_nxt_reg[6]  (.D(n_25), .RN(n_18), .CK(n_17), .Q(
      mdb_out[6]), .QN());
   AOI22_X1_LVT i_17_13 (.A1(n_17_0), .A2(mdb_out_nxt[14]), .B1(inst_bw), 
      .B2(mdb_out[6]), .ZN(n_17_7));
   INV_X1_LVT i_17_14 (.A(n_17_7), .ZN(mdb_out[14]));
   AOI22_X1_LVT i_13_29 (.A1(n_13_2), .A2(alu_out[13]), .B1(n_13_1), .B2(
      pc_nxt[13]), .ZN(n_13_16));
   INV_X1_LVT i_13_30 (.A(n_13_16), .ZN(n_32));
   DFFR_X1_LVT \mdb_out_nxt_reg[13]  (.D(n_32), .RN(n_18), .CK(n_17), .Q(
      mdb_out_nxt[13]), .QN());
   AOI22_X1_LVT i_13_13 (.A1(n_13_2), .A2(alu_out[5]), .B1(n_13_1), .B2(
      pc_nxt[5]), .ZN(n_13_8));
   INV_X1_LVT i_13_14 (.A(n_13_8), .ZN(n_24));
   DFFR_X1_LVT \mdb_out_nxt_reg[5]  (.D(n_24), .RN(n_18), .CK(n_17), .Q(
      mdb_out[5]), .QN());
   AOI22_X1_LVT i_17_11 (.A1(n_17_0), .A2(mdb_out_nxt[13]), .B1(inst_bw), 
      .B2(mdb_out[5]), .ZN(n_17_6));
   INV_X1_LVT i_17_12 (.A(n_17_6), .ZN(mdb_out[13]));
   AOI22_X1_LVT i_13_27 (.A1(n_13_2), .A2(alu_out[12]), .B1(n_13_1), .B2(
      pc_nxt[12]), .ZN(n_13_15));
   INV_X1_LVT i_13_28 (.A(n_13_15), .ZN(n_31));
   DFFR_X1_LVT \mdb_out_nxt_reg[12]  (.D(n_31), .RN(n_18), .CK(n_17), .Q(
      mdb_out_nxt[12]), .QN());
   AOI22_X1_LVT i_13_11 (.A1(n_13_2), .A2(alu_out[4]), .B1(n_13_1), .B2(
      pc_nxt[4]), .ZN(n_13_7));
   INV_X1_LVT i_13_12 (.A(n_13_7), .ZN(n_23));
   DFFR_X1_LVT \mdb_out_nxt_reg[4]  (.D(n_23), .RN(n_18), .CK(n_17), .Q(
      mdb_out[4]), .QN());
   AOI22_X1_LVT i_17_9 (.A1(n_17_0), .A2(mdb_out_nxt[12]), .B1(inst_bw), 
      .B2(mdb_out[4]), .ZN(n_17_5));
   INV_X1_LVT i_17_10 (.A(n_17_5), .ZN(mdb_out[12]));
   AOI22_X1_LVT i_13_25 (.A1(n_13_2), .A2(alu_out[11]), .B1(n_13_1), .B2(
      pc_nxt[11]), .ZN(n_13_14));
   INV_X1_LVT i_13_26 (.A(n_13_14), .ZN(n_30));
   DFFR_X1_LVT \mdb_out_nxt_reg[11]  (.D(n_30), .RN(n_18), .CK(n_17), .Q(
      mdb_out_nxt[11]), .QN());
   AOI22_X1_LVT i_13_9 (.A1(n_13_2), .A2(alu_out[3]), .B1(n_13_1), .B2(pc_nxt[3]), 
      .ZN(n_13_6));
   INV_X1_LVT i_13_10 (.A(n_13_6), .ZN(n_22));
   DFFR_X1_LVT \mdb_out_nxt_reg[3]  (.D(n_22), .RN(n_18), .CK(n_17), .Q(
      mdb_out[3]), .QN());
   AOI22_X1_LVT i_17_7 (.A1(n_17_0), .A2(mdb_out_nxt[11]), .B1(inst_bw), 
      .B2(mdb_out[3]), .ZN(n_17_4));
   INV_X1_LVT i_17_8 (.A(n_17_4), .ZN(mdb_out[11]));
   AOI22_X1_LVT i_13_23 (.A1(n_13_2), .A2(alu_out[10]), .B1(n_13_1), .B2(
      pc_nxt[10]), .ZN(n_13_13));
   INV_X1_LVT i_13_24 (.A(n_13_13), .ZN(n_29));
   DFFR_X1_LVT \mdb_out_nxt_reg[10]  (.D(n_29), .RN(n_18), .CK(n_17), .Q(
      mdb_out_nxt[10]), .QN());
   AOI22_X1_LVT i_13_7 (.A1(n_13_2), .A2(alu_out[2]), .B1(n_13_1), .B2(pc_nxt[2]), 
      .ZN(n_13_5));
   INV_X1_LVT i_13_8 (.A(n_13_5), .ZN(n_21));
   DFFR_X1_LVT \mdb_out_nxt_reg[2]  (.D(n_21), .RN(n_18), .CK(n_17), .Q(
      mdb_out[2]), .QN());
   AOI22_X1_LVT i_17_5 (.A1(n_17_0), .A2(mdb_out_nxt[10]), .B1(inst_bw), 
      .B2(mdb_out[2]), .ZN(n_17_3));
   INV_X1_LVT i_17_6 (.A(n_17_3), .ZN(mdb_out[10]));
   AOI22_X1_LVT i_13_21 (.A1(n_13_2), .A2(alu_out[9]), .B1(n_13_1), .B2(
      pc_nxt[9]), .ZN(n_13_12));
   INV_X1_LVT i_13_22 (.A(n_13_12), .ZN(n_28));
   DFFR_X1_LVT \mdb_out_nxt_reg[9]  (.D(n_28), .RN(n_18), .CK(n_17), .Q(
      mdb_out_nxt[9]), .QN());
   AOI22_X1_LVT i_13_5 (.A1(n_13_2), .A2(alu_out[1]), .B1(n_13_1), .B2(pc_nxt[1]), 
      .ZN(n_13_4));
   INV_X1_LVT i_13_6 (.A(n_13_4), .ZN(n_20));
   DFFR_X1_LVT \mdb_out_nxt_reg[1]  (.D(n_20), .RN(n_18), .CK(n_17), .Q(
      mdb_out[1]), .QN());
   AOI22_X1_LVT i_17_3 (.A1(n_17_0), .A2(mdb_out_nxt[9]), .B1(inst_bw), .B2(
      mdb_out[1]), .ZN(n_17_2));
   INV_X1_LVT i_17_4 (.A(n_17_2), .ZN(mdb_out[9]));
   AOI22_X1_LVT i_13_19 (.A1(n_13_2), .A2(alu_out[8]), .B1(n_13_1), .B2(
      pc_nxt[8]), .ZN(n_13_11));
   INV_X1_LVT i_13_20 (.A(n_13_11), .ZN(n_27));
   DFFR_X1_LVT \mdb_out_nxt_reg[8]  (.D(n_27), .RN(n_18), .CK(n_17), .Q(
      mdb_out_nxt[8]), .QN());
   AOI22_X1_LVT i_13_3 (.A1(n_13_2), .A2(alu_out[0]), .B1(n_13_1), .B2(pc_nxt[0]), 
      .ZN(n_13_3));
   INV_X1_LVT i_13_4 (.A(n_13_3), .ZN(n_19));
   DFFR_X1_LVT \mdb_out_nxt_reg[0]  (.D(n_19), .RN(n_18), .CK(n_17), .Q(
      mdb_out[0]), .QN());
   AOI22_X1_LVT i_17_1 (.A1(n_17_0), .A2(mdb_out_nxt[8]), .B1(mdb_out[0]), 
      .B2(inst_bw), .ZN(n_17_1));
   INV_X1_LVT i_17_2 (.A(n_17_1), .ZN(mdb_out[8]));
endmodule

module omsp_sync_cell__2_19(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_clock_gate__2_7(gclk, clk, enable, scan_enable);
   output gclk;
   input clk;
   input enable;
   input scan_enable;

   wire enable_in;
   wire enable_latch;

   OR2_X1_LVT i_0_0 (.A1(enable), .A2(scan_enable), .ZN(enable_in));
   INV_X1_LVT i_1_0 (.A(clk), .ZN(n_0));
   DLH_X1_LVT enable_latch_reg (.D(enable_in), .G(n_0), .Q(enable_latch));
   AND2_X1_LVT i_3_0 (.A1(clk), .A2(enable_latch), .ZN(gclk));
endmodule

module omsp_sync_reset(rst_s, clk, rst_a);
   output rst_s;
   input clk;
   input rst_a;

   INV_X1_LVT i_0_0 (.A(rst_a), .ZN(n_0));
   DFFS_X1_LVT \data_sync_reg[0]  (.D(1'b0), .SN(n_0), .CK(clk), .Q(n_1), .QN());
   DFFS_X1_LVT \data_sync_reg[1]  (.D(n_1), .SN(n_0), .CK(clk), .Q(rst_s), .QN());
endmodule

module omsp_scan_mux__2_59(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_scan_mux__2_61(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_sync_cell__2_21(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_scan_mux__2_63(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_and_gate__2_31(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_29(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_sync_cell__2_17(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_clock_gate__2_3(gclk, clk, enable, scan_enable);
   output gclk;
   input clk;
   input enable;
   input scan_enable;

   wire enable_in;
   wire enable_latch;

   OR2_X1_LVT i_0_0 (.A1(enable), .A2(scan_enable), .ZN(enable_in));
   INV_X1_LVT i_1_0 (.A(clk), .ZN(n_0));
   DLH_X1_LVT enable_latch_reg (.D(enable_in), .G(n_0), .Q(enable_latch));
   AND2_X1_LVT i_3_0 (.A1(clk), .A2(enable_latch), .ZN(gclk));
endmodule

module omsp_clock_gate__2_11(gclk, clk, enable, scan_enable);
   output gclk;
   input clk;
   input enable;
   input scan_enable;

   wire enable_in;
   wire enable_latch;

   OR2_X1_LVT i_0_0 (.A1(enable), .A2(scan_enable), .ZN(enable_in));
   INV_X1_LVT i_1_0 (.A(clk), .ZN(n_0));
   DLH_X1_LVT enable_latch_reg (.D(enable_in), .G(n_0), .Q(enable_latch));
   AND2_X1_LVT i_3_0 (.A1(clk), .A2(enable_latch), .ZN(gclk));
endmodule

module omsp_clock_gate__2_15(gclk, clk, enable, scan_enable);
   output gclk;
   input clk;
   input enable;
   input scan_enable;

   wire enable_in;
   wire enable_latch;

   OR2_X1_LVT i_0_0 (.A1(enable), .A2(scan_enable), .ZN(enable_in));
   INV_X1_LVT i_1_0 (.A(clk), .ZN(n_0));
   DLH_X1_LVT enable_latch_reg (.D(enable_in), .G(n_0), .Q(enable_latch));
   AND2_X1_LVT i_3_0 (.A1(clk), .A2(enable_latch), .ZN(gclk));
endmodule

module omsp_scan_mux__2_65(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_and_gate__2_51(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_35(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_37(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_33(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_39(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_41(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_43(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_45(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_49(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_47(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_scan_mux__2_67(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_scan_mux__2_69(data_out, data_in_scan, data_in_func, scan_mode);
   output data_out;
   input data_in_scan;
   input data_in_func;
   input scan_mode;

   wire n_0_0;
   wire n_0_1;

   INV_X1_LVT i_0_0 (.A(scan_mode), .ZN(n_0_0));
   AOI22_X1_LVT i_0_1 (.A1(n_0_0), .A2(data_in_func), .B1(data_in_scan), 
      .B2(scan_mode), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(n_0_1), .ZN(data_out));
endmodule

module omsp_sync_cell__2_23(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_and_gate__2_53(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_and_gate__2_57(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_sync_cell__2_25(data_out, clk, data_in, rst);
   output data_out;
   input clk;
   input data_in;
   input rst;

   INV_X1_LVT i_0_0 (.A(rst), .ZN(n_0));
   DFFR_X1_LVT \data_sync_reg[0]  (.D(data_in), .RN(n_0), .CK(clk), .Q(n_1), 
      .QN());
   DFFR_X1_LVT \data_sync_reg[1]  (.D(n_1), .RN(n_0), .CK(clk), .Q(data_out), 
      .QN());
endmodule

module omsp_and_gate__2_55(y, a, b);
   output y;
   input a;
   input b;

   AND2_X1_LVT i_0_0 (.A1(a), .A2(b), .ZN(y));
endmodule

module omsp_clock_gate(gclk, clk, enable, scan_enable);
   output gclk;
   input clk;
   input enable;
   input scan_enable;

   wire enable_in;
   wire enable_latch;

   OR2_X1_LVT i_0_0 (.A1(enable), .A2(scan_enable), .ZN(enable_in));
   INV_X1_LVT i_1_0 (.A(clk), .ZN(n_0));
   DLH_X1_LVT enable_latch_reg (.D(enable_in), .G(n_0), .Q(enable_latch));
   AND2_X1_LVT i_3_0 (.A1(clk), .A2(enable_latch), .ZN(gclk));
endmodule

module omsp_clock_module(aclk, aclk_en, cpu_en_s, cpu_mclk, dma_mclk, dbg_clk, 
      dbg_en_s, dbg_rst, dco_enable, dco_wkup, lfxt_enable, lfxt_wkup, per_dout, 
      por, puc_pnd_set, puc_rst, smclk, smclk_en, cpu_en, cpuoff, dbg_cpu_reset, 
      dbg_en, dco_clk, lfxt_clk, mclk_dma_enable, mclk_dma_wkup, mclk_enable, 
      mclk_wkup, oscoff, per_addr, per_din, per_en, per_we, reset_n, scan_enable, 
      scan_mode, scg0, scg1, wdt_reset);
   output aclk;
   output aclk_en;
   output cpu_en_s;
   output cpu_mclk;
   output dma_mclk;
   output dbg_clk;
   output dbg_en_s;
   output dbg_rst;
   output dco_enable;
   output dco_wkup;
   output lfxt_enable;
   output lfxt_wkup;
   output [15:0]per_dout;
   output por;
   output puc_pnd_set;
   output puc_rst;
   output smclk;
   output smclk_en;
   input cpu_en;
   input cpuoff;
   input dbg_cpu_reset;
   input dbg_en;
   input dco_clk;
   input lfxt_clk;
   input mclk_dma_enable;
   input mclk_dma_wkup;
   input mclk_enable;
   input mclk_wkup;
   input oscoff;
   input [13:0]per_addr;
   input [15:0]per_din;
   input per_en;
   input [1:0]per_we;
   input reset_n;
   input scan_enable;
   input scan_mode;
   input scg0;
   input scg1;
   input wdt_reset;

   wire cpuoff_and_mclk_dma_wkup;
   wire cpuoff_and_mclk_dma_wkup_s;
   wire mclk_wkup_s;
   wire cpuoff_and_mclk_dma_enable;
   wire por_noscan;
   wire puc_a_scan;
   wire puc_noscan_n;
   wire scg0_and_mclk_dma_enable;
   wire cpuoff_and_mclk_enable;
   wire cpu_enabled_with_dco;
   wire dco_not_enabled_by_dbg;
   wire dco_disable_by_scg0;
   wire dco_disable_by_cpu_en;
   wire dco_enable_nxt;
   wire scg0_and_mclk_dma_wkup;
   wire dco_en_wkup;
   wire dco_mclk_wkup;
   wire dco_wkup_set_scan_observe;
   wire dco_wkup_set_scan;
   wire dco_wkup_n;
   wire scg1_and_mclk_dma_enable;
   wire scg1_and_mclk_dma_wkup;
   wire scg1_and_mclk_dma_wkup_s;
   wire nodiv_mclk_n;
   wire dco_disable;
   wire n_1_0;
   wire n_7_0;
   wire n_7_1;
   wire n_7_2;
   wire n_7_3;
   wire reg_sel;
   wire reg_read;
   wire n_10_0;
   wire n_11_0;
   wire reg_lo_write;
   wire bcsctl2_wr;
   wire [7:0]bcsctl2;
   wire reg_hi_write;
   wire bcsctl1_wr;
   wire [7:0]bcsctl1;
   wire [2:0]aclk_div;
   wire n_23_0;
   wire n_23_1;
   wire n_28_0;
   wire n_28_1;
   wire n_28_2;
   wire n_28_3;
   wire n_28_4;
   wire n_28_5;
   wire n_28_6;
   wire n_28_7;
   wire n_28_8;
   wire n_28_9;
   wire aclk_div_sel;
   wire n_29_0;
   wire aclk_div_en;
   wire [2:0]mclk_div;
   wire n_31_0;
   wire n_31_1;
   wire n_36_0;
   wire n_36_1;
   wire n_36_2;
   wire n_36_3;
   wire n_36_4;
   wire n_36_5;
   wire n_36_6;
   wire n_36_7;
   wire n_36_8;
   wire n_36_9;
   wire mclk_div_sel;
   wire n_37_0;
   wire n_37_1;
   wire mclk_active;
   wire mclk_div_en;
   wire n_39_0;
   wire mclk_dma_div_en;
   wire por_a;
   wire dbg_rst_nxt;
   wire dbg_rst_noscan;
   wire dco_wkup_set;
   wire n_46_0;
   wire [2:0]smclk_div;
   wire n_48_0;
   wire n_48_1;
   wire n_53_0;
   wire n_53_1;
   wire n_53_2;
   wire n_53_3;
   wire n_53_4;
   wire n_53_5;
   wire n_53_6;
   wire n_53_7;
   wire n_53_8;
   wire n_53_9;
   wire smclk_div_sel;
   wire n_54_0;
   wire n_54_1;
   wire n_54_2;
   wire smclk_div_en;
   wire puc_a;

   assign aclk_en = 1'b1;
   assign cpu_en_s = cpu_en;
   assign dbg_en_s = dbg_en;
   assign lfxt_enable = 1'b1;
   assign lfxt_wkup = 1'b0;
   assign smclk_en = 1'b1;

   NAND3_X1_LVT i_7_0 (.A1(per_addr[3]), .A2(per_addr[5]), .A3(per_en), .ZN(
      n_7_0));
   NOR4_X1_LVT i_7_1 (.A1(n_7_0), .A2(per_addr[11]), .A3(per_addr[12]), .A4(
      per_addr[13]), .ZN(n_7_1));
   NOR4_X1_LVT i_7_2 (.A1(per_addr[7]), .A2(per_addr[8]), .A3(per_addr[9]), 
      .A4(per_addr[10]), .ZN(n_7_2));
   NAND2_X1_LVT i_7_3 (.A1(n_7_1), .A2(n_7_2), .ZN(n_7_3));
   NOR3_X1_LVT i_7_4 (.A1(n_7_3), .A2(per_addr[4]), .A3(per_addr[6]), .ZN(
      reg_sel));
   AND2_X1_LVT i_16_0 (.A1(per_we[1]), .A2(reg_sel), .ZN(reg_hi_write));
   NAND2_X1_LVT i_11_0 (.A1(per_addr[0]), .A2(per_addr[1]), .ZN(n_11_0));
   NOR2_X1_LVT i_11_1 (.A1(n_11_0), .A2(per_addr[2]), .ZN(n_5));
   AND2_X1_LVT i_17_0 (.A1(reg_hi_write), .A2(n_5), .ZN(bcsctl1_wr));
   INV_X1_LVT i_40_0 (.A(reset_n), .ZN(por_a));
   omsp_sync_cell__2_19 sync_cell_mclk_wkup (.data_out(mclk_wkup_s), .clk(
      dco_clk), .data_in(mclk_wkup), .rst(puc_rst));
   NOR2_X1_LVT i_37_0 (.A1(mclk_enable), .A2(mclk_wkup_s), .ZN(n_37_0));
   NAND2_X1_LVT i_37_1 (.A1(dbg_en), .A2(cpu_en), .ZN(n_37_1));
   NAND2_X1_LVT i_37_2 (.A1(n_37_0), .A2(n_37_1), .ZN(mclk_active));
   AND2_X1_LVT i_13_0 (.A1(per_we[0]), .A2(reg_sel), .ZN(reg_lo_write));
   INV_X1_LVT i_10_0 (.A(per_addr[2]), .ZN(n_10_0));
   NOR3_X1_LVT i_10_1 (.A1(n_10_0), .A2(per_addr[0]), .A3(per_addr[1]), .ZN(n_4));
   AND2_X1_LVT i_14_0 (.A1(reg_lo_write), .A2(n_4), .ZN(bcsctl2_wr));
   CLKGATETST_X1_LVT clk_gate_bcsctl2_reg (.CK(dma_mclk), .E(bcsctl2_wr), 
      .SE(1'b0), .GCK(n_8));
   DFFR_X1_LVT \bcsctl2_reg[5]  (.D(per_din[5]), .RN(n_10), .CK(n_8), .Q(
      bcsctl2[5]), .QN());
   INV_X1_LVT i_36_2 (.A(bcsctl2[5]), .ZN(n_36_2));
   DFFR_X1_LVT \bcsctl2_reg[4]  (.D(per_din[4]), .RN(n_10), .CK(n_8), .Q(
      bcsctl2[4]), .QN());
   OR2_X1_LVT i_36_3 (.A1(n_36_2), .A2(bcsctl2[4]), .ZN(n_36_3));
   INV_X1_LVT i_31_0 (.A(mclk_div[0]), .ZN(n_19));
   OR2_X1_LVT i_32_0 (.A1(bcsctl2[4]), .A2(bcsctl2[5]), .ZN(n_22));
   CLKGATETST_X1_LVT clk_gate_mclk_div_reg (.CK(dco_clk), .E(n_22), .SE(1'b0), 
      .GCK(n_18));
   DFFR_X1_LVT \mclk_div_reg[0]  (.D(n_19), .RN(n_10), .CK(n_18), .Q(mclk_div[0]), 
      .QN());
   HA_X1_LVT i_31_1 (.A(mclk_div[1]), .B(mclk_div[0]), .CO(n_31_0), .S(n_20));
   DFFR_X1_LVT \mclk_div_reg[1]  (.D(n_20), .RN(n_10), .CK(n_18), .Q(mclk_div[1]), 
      .QN());
   XNOR2_X1_LVT i_31_2 (.A(mclk_div[2]), .B(n_31_0), .ZN(n_31_1));
   INV_X1_LVT i_31_3 (.A(n_31_1), .ZN(n_21));
   DFFR_X1_LVT \mclk_div_reg[2]  (.D(n_21), .RN(n_10), .CK(n_18), .Q(mclk_div[2]), 
      .QN());
   AND3_X1_LVT i_34_0 (.A1(mclk_div[0]), .A2(mclk_div[1]), .A3(mclk_div[2]), 
      .ZN(n_23));
   INV_X1_LVT i_36_4 (.A(n_36_3), .ZN(n_36_4));
   AND2_X1_LVT i_35_0 (.A1(mclk_div[0]), .A2(mclk_div[1]), .ZN(n_24));
   AOI22_X1_LVT i_36_5 (.A1(n_36_3), .A2(n_23), .B1(n_36_4), .B2(n_24), .ZN(
      n_36_5));
   INV_X1_LVT i_36_6 (.A(n_36_5), .ZN(n_36_6));
   NAND2_X1_LVT i_36_7 (.A1(n_36_2), .A2(bcsctl2[4]), .ZN(n_36_7));
   INV_X1_LVT i_36_8 (.A(n_36_7), .ZN(n_36_8));
   AOI22_X1_LVT i_36_9 (.A1(n_36_6), .A2(n_36_7), .B1(n_36_8), .B2(mclk_div[0]), 
      .ZN(n_36_9));
   NOR2_X1_LVT i_36_0 (.A1(bcsctl2[4]), .A2(bcsctl2[5]), .ZN(n_36_0));
   INV_X1_LVT i_36_1 (.A(n_36_0), .ZN(n_36_1));
   NAND2_X1_LVT i_36_10 (.A1(n_36_9), .A2(n_36_1), .ZN(mclk_div_sel));
   AND2_X1_LVT i_38_0 (.A1(mclk_active), .A2(mclk_div_sel), .ZN(mclk_div_en));
   omsp_clock_gate__2_7 clock_gate_mclk (.gclk(cpu_mclk), .clk(dco_clk), 
      .enable(mclk_div_en), .scan_enable(scan_enable));
   INV_X1_LVT i_41_0 (.A(dbg_en), .ZN(dbg_rst_nxt));
   omsp_sync_reset sync_reset_por (.rst_s(por_noscan), .clk(dco_clk), .rst_a(
      por_a));
   omsp_scan_mux__2_59 scan_mux_por (.data_out(por), .data_in_scan(por_a), 
      .data_in_func(por_noscan), .scan_mode(scan_mode));
   INV_X1_LVT i_3_0 (.A(por), .ZN(n_1));
   DFFS_X1_LVT dbg_rst_noscan_reg (.D(dbg_rst_nxt), .SN(n_1), .CK(cpu_mclk), 
      .Q(dbg_rst_noscan), .QN());
   AND3_X1_LVT i_46_0 (.A1(dbg_en), .A2(puc_pnd_set), .A3(dbg_rst_noscan), 
      .ZN(n_46_0));
   NOR2_X1_LVT i_46_1 (.A1(n_46_0), .A2(dbg_cpu_reset), .ZN(n_28));
   OR2_X1_LVT i_59_0 (.A1(por), .A2(wdt_reset), .ZN(puc_a));
   omsp_scan_mux__2_61 scan_mux_puc_rst_a (.data_out(puc_a_scan), .data_in_scan(
      por_a), .data_in_func(puc_a), .scan_mode(scan_mode));
   omsp_sync_cell__2_21 sync_cell_puc (.data_out(puc_noscan_n), .clk(cpu_mclk), 
      .data_in(n_28), .rst(puc_a_scan));
   INV_X1_LVT i_21_0 (.A(puc_noscan_n), .ZN(puc_pnd_set));
   omsp_scan_mux__2_63 scan_mux_puc_rst (.data_out(puc_rst), .data_in_scan(por_a), 
      .data_in_func(puc_pnd_set), .scan_mode(scan_mode));
   INV_X1_LVT i_18_0 (.A(puc_rst), .ZN(n_10));
   DFFR_X1_LVT \bcsctl1_reg[0]  (.D(per_din[8]), .RN(n_10), .CK(n_9), .Q(
      bcsctl1[0]), .QN());
   omsp_and_gate__2_31 and_cpuoff_mclk_dma_en (.y(cpuoff_and_mclk_dma_enable), 
      .a(bcsctl1[0]), .b(mclk_dma_enable));
   omsp_and_gate__2_29 and_cpuoff_mclk_dma_wkup (.y(cpuoff_and_mclk_dma_wkup), 
      .a(bcsctl1[0]), .b(mclk_dma_wkup));
   omsp_sync_cell__2_17 sync_cell_mclk_dma_wkup (.data_out(
      cpuoff_and_mclk_dma_wkup_s), .clk(dco_clk), .data_in(
      cpuoff_and_mclk_dma_wkup), .rst(puc_rst));
   OR3_X1_LVT i_39_0 (.A1(cpuoff_and_mclk_dma_enable), .A2(mclk_active), 
      .A3(cpuoff_and_mclk_dma_wkup_s), .ZN(n_39_0));
   AND2_X1_LVT i_39_1 (.A1(n_39_0), .A2(mclk_div_sel), .ZN(mclk_dma_div_en));
   omsp_clock_gate__2_3 clock_gate_dma_mclk (.gclk(dma_mclk), .clk(dco_clk), 
      .enable(mclk_dma_div_en), .scan_enable(scan_enable));
   CLKGATETST_X1_LVT clk_gate_bcsctl1_reg (.CK(dma_mclk), .E(bcsctl1_wr), 
      .SE(1'b0), .GCK(n_9));
   DFFR_X1_LVT \bcsctl1_reg[5]  (.D(per_din[13]), .RN(n_10), .CK(n_9), .Q(
      bcsctl1[5]), .QN());
   INV_X1_LVT i_28_2 (.A(bcsctl1[5]), .ZN(n_28_2));
   DFFR_X1_LVT \bcsctl1_reg[4]  (.D(per_din[12]), .RN(n_10), .CK(n_9), .Q(
      bcsctl1[4]), .QN());
   OR2_X1_LVT i_28_3 (.A1(n_28_2), .A2(bcsctl1[4]), .ZN(n_28_3));
   INV_X1_LVT i_23_0 (.A(aclk_div[0]), .ZN(n_12));
   OR2_X1_LVT i_24_0 (.A1(bcsctl1[4]), .A2(bcsctl1[5]), .ZN(n_15));
   CLKGATETST_X1_LVT clk_gate_aclk_div_reg (.CK(dco_clk), .E(n_15), .SE(1'b0), 
      .GCK(n_11));
   DFFR_X1_LVT \aclk_div_reg[0]  (.D(n_12), .RN(n_10), .CK(n_11), .Q(aclk_div[0]), 
      .QN());
   HA_X1_LVT i_23_1 (.A(aclk_div[1]), .B(aclk_div[0]), .CO(n_23_0), .S(n_13));
   DFFR_X1_LVT \aclk_div_reg[1]  (.D(n_13), .RN(n_10), .CK(n_11), .Q(aclk_div[1]), 
      .QN());
   XNOR2_X1_LVT i_23_2 (.A(aclk_div[2]), .B(n_23_0), .ZN(n_23_1));
   INV_X1_LVT i_23_3 (.A(n_23_1), .ZN(n_14));
   DFFR_X1_LVT \aclk_div_reg[2]  (.D(n_14), .RN(n_10), .CK(n_11), .Q(aclk_div[2]), 
      .QN());
   AND3_X1_LVT i_26_0 (.A1(aclk_div[0]), .A2(aclk_div[1]), .A3(aclk_div[2]), 
      .ZN(n_16));
   INV_X1_LVT i_28_4 (.A(n_28_3), .ZN(n_28_4));
   AND2_X1_LVT i_27_0 (.A1(aclk_div[0]), .A2(aclk_div[1]), .ZN(n_17));
   AOI22_X1_LVT i_28_5 (.A1(n_28_3), .A2(n_16), .B1(n_28_4), .B2(n_17), .ZN(
      n_28_5));
   INV_X1_LVT i_28_6 (.A(n_28_5), .ZN(n_28_6));
   NAND2_X1_LVT i_28_7 (.A1(n_28_2), .A2(bcsctl1[4]), .ZN(n_28_7));
   INV_X1_LVT i_28_8 (.A(n_28_7), .ZN(n_28_8));
   AOI22_X1_LVT i_28_9 (.A1(n_28_6), .A2(n_28_7), .B1(n_28_8), .B2(aclk_div[0]), 
      .ZN(n_28_9));
   NOR2_X1_LVT i_28_0 (.A1(bcsctl1[4]), .A2(bcsctl1[5]), .ZN(n_28_0));
   INV_X1_LVT i_28_1 (.A(n_28_0), .ZN(n_28_1));
   NAND2_X1_LVT i_28_10 (.A1(n_28_9), .A2(n_28_1), .ZN(aclk_div_sel));
   NAND2_X1_LVT i_29_0 (.A1(cpu_en), .A2(aclk_div_sel), .ZN(n_29_0));
   NOR2_X1_LVT i_29_1 (.A1(n_29_0), .A2(oscoff), .ZN(aclk_div_en));
   omsp_clock_gate__2_11 clock_gate_aclk (.gclk(aclk), .clk(dco_clk), .enable(
      aclk_div_en), .scan_enable(scan_enable));
   omsp_clock_gate__2_15 clock_gate_dbg_clk (.gclk(dbg_clk), .clk(cpu_mclk), 
      .enable(dbg_en), .scan_enable(scan_enable));
   omsp_scan_mux__2_65 scan_mux_dbg_rst (.data_out(dbg_rst), .data_in_scan(por_a), 
      .data_in_func(dbg_rst_noscan), .scan_mode(scan_mode));
   DFFR_X1_LVT \bcsctl2_reg[7]  (.D(1'b0), .RN(n_10), .CK(n_8), .Q(bcsctl2[7]), 
      .QN());
   INV_X1_LVT i_58_0 (.A(bcsctl2[7]), .ZN(n_39));
   omsp_and_gate__2_51 and_dco_mclk_wkup (.y(dco_mclk_wkup), .a(mclk_wkup), 
      .b(n_39));
   INV_X1_LVT i_57_0 (.A(dco_enable), .ZN(n_38));
   omsp_and_gate__2_35 and_cpuoff_mclk_en (.y(cpuoff_and_mclk_enable), .a(cpuoff), 
      .b(mclk_enable));
   omsp_and_gate__2_37 and_dco_dis1 (.y(cpu_enabled_with_dco), .a(n_39), 
      .b(cpuoff_and_mclk_enable));
   DFFR_X1_LVT \bcsctl1_reg[2]  (.D(per_din[10]), .RN(n_10), .CK(n_9), .Q(
      bcsctl1[2]), .QN());
   omsp_and_gate__2_33 and_scg0_mclk_dma_en (.y(scg0_and_mclk_dma_enable), 
      .a(bcsctl1[2]), .b(mclk_dma_enable));
   NOR2_X1_LVT i_60_0 (.A1(cpu_enabled_with_dco), .A2(scg0_and_mclk_dma_enable), 
      .ZN(n_40));
   omsp_and_gate__2_39 and_dco_dis2 (.y(dco_not_enabled_by_dbg), .a(dbg_rst_nxt), 
      .b(n_40));
   omsp_and_gate__2_41 and_dco_dis3 (.y(dco_disable_by_scg0), .a(scg0), .b(
      dco_not_enabled_by_dbg));
   INV_X1_LVT i_42_0 (.A(dco_disable_by_scg0), .ZN(n_25));
   INV_X1_LVT i_55_0 (.A(cpu_en), .ZN(n_36));
   INV_X1_LVT i_56_0 (.A(mclk_enable), .ZN(n_37));
   omsp_and_gate__2_43 and_dco_dis4 (.y(dco_disable_by_cpu_en), .a(n_36), 
      .b(n_37));
   INV_X1_LVT i_43_0 (.A(dco_disable_by_cpu_en), .ZN(n_26));
   omsp_and_gate__2_45 and_dco_dis5 (.y(dco_enable_nxt), .a(n_25), .b(n_26));
   omsp_and_gate__2_49 and_dco_en_wkup (.y(dco_en_wkup), .a(n_38), .b(
      dco_enable_nxt));
   omsp_and_gate__2_47 and_scg0_mclk_dma_wkup (.y(scg0_and_mclk_dma_wkup), 
      .a(bcsctl1[2]), .b(mclk_dma_wkup));
   OR3_X1_LVT i_44_0 (.A1(dco_mclk_wkup), .A2(dco_en_wkup), .A3(
      scg0_and_mclk_dma_wkup), .ZN(dco_wkup_set));
   omsp_scan_mux__2_67 scan_mux_dco_wkup_observe (.data_out(
      dco_wkup_set_scan_observe), .data_in_scan(dco_wkup_set), .data_in_func(
      1'b0), .scan_mode(scan_mode));
   INV_X1_LVT i_1_0 (.A(dco_wkup_set_scan_observe), .ZN(n_1_0));
   NAND2_X1_LVT i_1_1 (.A1(n_1_0), .A2(dco_enable_nxt), .ZN(n_0));
   DFFS_X1_LVT dco_disable_reg (.D(n_0), .SN(n_1), .CK(dco_clk), .Q(dco_disable), 
      .QN());
   INV_X1_LVT i_5_0 (.A(dco_disable), .ZN(n_2));
   INV_X1_LVT i_0_0 (.A(dco_clk), .ZN(nodiv_mclk_n));
   DFFR_X1_LVT dco_enable_reg (.D(n_2), .RN(n_1), .CK(nodiv_mclk_n), .Q(
      dco_enable), .QN());
   OR2_X1_LVT i_61_0 (.A1(dco_wkup_set), .A2(por), .ZN(n_41));
   omsp_scan_mux__2_69 scan_mux_dco_wkup (.data_out(dco_wkup_set_scan), 
      .data_in_scan(por_a), .data_in_func(n_41), .scan_mode(scan_mode));
   omsp_sync_cell__2_23 sync_cell_dco_wkup (.data_out(dco_wkup_n), .clk(
      nodiv_mclk_n), .data_in(1'b1), .rst(dco_wkup_set_scan));
   INV_X1_LVT i_45_0 (.A(dco_wkup_n), .ZN(n_27));
   omsp_and_gate__2_53 and_dco_wkup (.y(dco_wkup), .a(n_27), .b(cpu_en));
   NOR2_X1_LVT i_8_0 (.A1(per_we[0]), .A2(per_we[1]), .ZN(n_3));
   AND2_X1_LVT i_9_0 (.A1(n_3), .A2(reg_sel), .ZN(reg_read));
   AND2_X1_LVT i_12_0 (.A1(reg_read), .A2(n_5), .ZN(n_6));
   DFFR_X1_LVT \bcsctl1_reg[7]  (.D(1'b0), .RN(n_10), .CK(n_9), .Q(bcsctl1[7]), 
      .QN());
   AND2_X1_LVT i_20_15 (.A1(n_6), .A2(bcsctl1[7]), .ZN(per_dout[15]));
   DFFR_X1_LVT \bcsctl1_reg[6]  (.D(1'b0), .RN(n_10), .CK(n_9), .Q(bcsctl1[6]), 
      .QN());
   AND2_X1_LVT i_20_14 (.A1(n_6), .A2(bcsctl1[6]), .ZN(per_dout[14]));
   AND2_X1_LVT i_20_13 (.A1(n_6), .A2(bcsctl1[5]), .ZN(per_dout[13]));
   AND2_X1_LVT i_20_12 (.A1(n_6), .A2(bcsctl1[4]), .ZN(per_dout[12]));
   DFFR_X1_LVT \bcsctl1_reg[3]  (.D(per_din[11]), .RN(n_10), .CK(n_9), .Q(
      bcsctl1[3]), .QN());
   AND2_X1_LVT i_20_11 (.A1(n_6), .A2(bcsctl1[3]), .ZN(per_dout[11]));
   AND2_X1_LVT i_20_10 (.A1(n_6), .A2(bcsctl1[2]), .ZN(per_dout[10]));
   DFFR_X1_LVT \bcsctl1_reg[1]  (.D(1'b0), .RN(n_10), .CK(n_9), .Q(bcsctl1[1]), 
      .QN());
   AND2_X1_LVT i_20_9 (.A1(n_6), .A2(bcsctl1[1]), .ZN(per_dout[9]));
   AND2_X1_LVT i_20_8 (.A1(bcsctl1[0]), .A2(n_6), .ZN(per_dout[8]));
   AND2_X1_LVT i_12_1 (.A1(reg_read), .A2(n_4), .ZN(n_7));
   AND2_X1_LVT i_20_7 (.A1(n_7), .A2(bcsctl2[7]), .ZN(per_dout[7]));
   DFFR_X1_LVT \bcsctl2_reg[6]  (.D(1'b0), .RN(n_10), .CK(n_8), .Q(bcsctl2[6]), 
      .QN());
   AND2_X1_LVT i_20_6 (.A1(n_7), .A2(bcsctl2[6]), .ZN(per_dout[6]));
   AND2_X1_LVT i_20_5 (.A1(n_7), .A2(bcsctl2[5]), .ZN(per_dout[5]));
   AND2_X1_LVT i_20_4 (.A1(n_7), .A2(bcsctl2[4]), .ZN(per_dout[4]));
   DFFR_X1_LVT \bcsctl2_reg[3]  (.D(1'b0), .RN(n_10), .CK(n_8), .Q(bcsctl2[3]), 
      .QN());
   AND2_X1_LVT i_20_3 (.A1(n_7), .A2(bcsctl2[3]), .ZN(per_dout[3]));
   DFFR_X1_LVT \bcsctl2_reg[2]  (.D(per_din[2]), .RN(n_10), .CK(n_8), .Q(
      bcsctl2[2]), .QN());
   AND2_X1_LVT i_20_2 (.A1(n_7), .A2(bcsctl2[2]), .ZN(per_dout[2]));
   DFFR_X1_LVT \bcsctl2_reg[1]  (.D(per_din[1]), .RN(n_10), .CK(n_8), .Q(
      bcsctl2[1]), .QN());
   AND2_X1_LVT i_20_1 (.A1(n_7), .A2(bcsctl2[1]), .ZN(per_dout[1]));
   DFFR_X1_LVT \bcsctl2_reg[0]  (.D(1'b0), .RN(n_10), .CK(n_8), .Q(bcsctl2[0]), 
      .QN());
   AND2_X1_LVT i_20_0 (.A1(bcsctl2[0]), .A2(n_7), .ZN(per_dout[0]));
   INV_X1_LVT i_54_0 (.A(scg1), .ZN(n_54_0));
   omsp_and_gate__2_57 and_scg1_mclk_dma_wkup (.y(scg1_and_mclk_dma_wkup), 
      .a(bcsctl1[3]), .b(mclk_dma_wkup));
   omsp_sync_cell__2_25 sync_cell_smclk_dma_wkup (.data_out(
      scg1_and_mclk_dma_wkup_s), .clk(dco_clk), .data_in(scg1_and_mclk_dma_wkup), 
      .rst(puc_rst));
   omsp_and_gate__2_55 and_scg1_mclk_dma_en (.y(scg1_and_mclk_dma_enable), 
      .a(bcsctl1[3]), .b(mclk_dma_enable));
   NOR3_X1_LVT i_54_1 (.A1(n_54_0), .A2(scg1_and_mclk_dma_wkup_s), .A3(
      scg1_and_mclk_dma_enable), .ZN(n_54_1));
   INV_X1_LVT i_53_2 (.A(bcsctl2[2]), .ZN(n_53_2));
   OR2_X1_LVT i_53_3 (.A1(n_53_2), .A2(bcsctl2[1]), .ZN(n_53_3));
   INV_X1_LVT i_48_0 (.A(smclk_div[0]), .ZN(n_30));
   OR2_X1_LVT i_49_0 (.A1(bcsctl2[1]), .A2(bcsctl2[2]), .ZN(n_33));
   CLKGATETST_X1_LVT clk_gate_smclk_div_reg (.CK(dco_clk), .E(n_33), .SE(1'b0), 
      .GCK(n_29));
   DFFR_X1_LVT \smclk_div_reg[0]  (.D(n_30), .RN(n_10), .CK(n_29), .Q(
      smclk_div[0]), .QN());
   HA_X1_LVT i_48_1 (.A(smclk_div[1]), .B(smclk_div[0]), .CO(n_48_0), .S(n_31));
   DFFR_X1_LVT \smclk_div_reg[1]  (.D(n_31), .RN(n_10), .CK(n_29), .Q(
      smclk_div[1]), .QN());
   XNOR2_X1_LVT i_48_2 (.A(smclk_div[2]), .B(n_48_0), .ZN(n_48_1));
   INV_X1_LVT i_48_3 (.A(n_48_1), .ZN(n_32));
   DFFR_X1_LVT \smclk_div_reg[2]  (.D(n_32), .RN(n_10), .CK(n_29), .Q(
      smclk_div[2]), .QN());
   AND3_X1_LVT i_51_0 (.A1(smclk_div[0]), .A2(smclk_div[1]), .A3(smclk_div[2]), 
      .ZN(n_34));
   INV_X1_LVT i_53_4 (.A(n_53_3), .ZN(n_53_4));
   AND2_X1_LVT i_52_0 (.A1(smclk_div[0]), .A2(smclk_div[1]), .ZN(n_35));
   AOI22_X1_LVT i_53_5 (.A1(n_53_3), .A2(n_34), .B1(n_53_4), .B2(n_35), .ZN(
      n_53_5));
   INV_X1_LVT i_53_6 (.A(n_53_5), .ZN(n_53_6));
   NAND2_X1_LVT i_53_7 (.A1(n_53_2), .A2(bcsctl2[1]), .ZN(n_53_7));
   INV_X1_LVT i_53_8 (.A(n_53_7), .ZN(n_53_8));
   AOI22_X1_LVT i_53_9 (.A1(n_53_6), .A2(n_53_7), .B1(n_53_8), .B2(smclk_div[0]), 
      .ZN(n_53_9));
   NOR2_X1_LVT i_53_0 (.A1(bcsctl2[1]), .A2(bcsctl2[2]), .ZN(n_53_0));
   INV_X1_LVT i_53_1 (.A(n_53_0), .ZN(n_53_1));
   NAND2_X1_LVT i_53_10 (.A1(n_53_9), .A2(n_53_1), .ZN(smclk_div_sel));
   NAND2_X1_LVT i_54_2 (.A1(cpu_en), .A2(smclk_div_sel), .ZN(n_54_2));
   NOR2_X1_LVT i_54_3 (.A1(n_54_1), .A2(n_54_2), .ZN(smclk_div_en));
   omsp_clock_gate clock_gate_smclk (.gclk(smclk), .clk(dco_clk), .enable(
      smclk_div_en), .scan_enable(scan_enable));
endmodule

module openMSP430(aclk, aclk_en, dbg_freeze, dbg_i2c_sda_out, dbg_uart_txd, 
      dco_enable, dco_wkup, dmem_addr, dmem_cen, dmem_din, dmem_wen, irq_acc, 
      lfxt_enable, lfxt_wkup, mclk, dma_dout, dma_ready, dma_resp, per_addr, 
      per_din, per_en, per_we, pmem_addr, pmem_cen, pmem_din, pmem_wen, puc_rst, 
      smclk, smclk_en, cpu_en, dbg_en, dbg_i2c_addr, dbg_i2c_broadcast, 
      dbg_i2c_scl, dbg_i2c_sda_in, dbg_uart_rxd, dco_clk, dmem_dout, irq, 
      lfxt_clk, dma_addr, dma_din, dma_en, dma_priority, dma_we, dma_wkup, nmi, 
      per_dout, pmem_dout, reset_n, scan_enable, scan_mode, wkup);
   output aclk;
   output aclk_en;
   output dbg_freeze;
   output dbg_i2c_sda_out;
   output dbg_uart_txd;
   output dco_enable;
   output dco_wkup;
   output [8:0]dmem_addr;
   output dmem_cen;
   output [15:0]dmem_din;
   output [1:0]dmem_wen;
   output [13:0]irq_acc;
   output lfxt_enable;
   output lfxt_wkup;
   output mclk;
   output [15:0]dma_dout;
   output dma_ready;
   output dma_resp;
   output [13:0]per_addr;
   output [15:0]per_din;
   output per_en;
   output [1:0]per_we;
   output [10:0]pmem_addr;
   output pmem_cen;
   output [15:0]pmem_din;
   output [1:0]pmem_wen;
   output puc_rst;
   output smclk;
   output smclk_en;
   input cpu_en;
   input dbg_en;
   input [6:0]dbg_i2c_addr;
   input [6:0]dbg_i2c_broadcast;
   input dbg_i2c_scl;
   input dbg_i2c_sda_in;
   input dbg_uart_rxd;
   input dco_clk;
   input [15:0]dmem_dout;
   input [13:0]irq;
   input lfxt_clk;
   input [14:0]dma_addr;
   input [15:0]dma_din;
   input dma_en;
   input dma_priority;
   input [1:0]dma_we;
   input dma_wkup;
   input nmi;
   input [15:0]per_dout;
   input [15:0]pmem_dout;
   input reset_n;
   input scan_enable;
   input scan_mode;
   input wkup;

   wire wdtnmies;
   wire wdtifg;
   wire wdt_wkup;
   wire wdt_reset;
   wire wdt_irq;
   wire [15:0]per_dout_wdog;
   wire scg1;
   wire scg0;
   wire pc_sw_wr;
   wire [15:0]pc_sw;
   wire oscoff;
   wire [15:0]eu_mdb_out;
   wire [1:0]eu_mb_wr;
   wire eu_mb_en;
   wire [15:0]eu_mab;
   wire gie;
   wire [15:0]dbg_reg_din;
   wire cpuoff;
   wire [15:0]pc_nxt;
   wire [15:0]pc;
   wire nmi_acc;
   wire mclk_wkup;
   wire mclk_enable;
   wire mclk_dma_wkup;
   wire mclk_dma_enable;
   wire fe_mb_en;
   wire [2:0]inst_type;
   wire [15:0]inst_src;
   wire [7:0]inst_so;
   wire [15:0]inst_sext;
   wire inst_mov;
   wire [7:0]inst_jmp;
   wire inst_irq_rst;
   wire [15:0]inst_dext;
   wire [15:0]inst_dest;
   wire inst_bw;
   wire [11:0]inst_alu;
   wire [7:0]inst_as;
   wire [7:0]inst_ad;
   wire exec_done;
   wire [3:0]e_state;
   wire decode_noirq;
   wire cpu_halt_st;
   wire [15:0]per_dout_mpy;
   wire fe_pmem_wait;
   wire [15:0]fe_mdb_in;
   wire [15:0]eu_mdb_in;
   wire [15:0]dbg_mem_din;
   wire cpu_halt_cmd;
   wire dbg_reg_wr;
   wire [1:0]dbg_mem_wr;
   wire dbg_mem_en;
   wire [15:0]dbg_mem_dout;
   wire [15:0]dbg_mem_addr;
   wire dbg_halt_cmd;
   wire dbg_cpu_reset;
   wire wdtifg_sw_set;
   wire wdtifg_sw_clr;
   wire wdtie;
   wire [15:0]per_dout_sfr;
   wire nmi_wkup;
   wire nmi_pnd;
   wire [31:0]cpu_id;
   wire puc_pnd_set;
   wire por;
   wire [15:0]per_dout_clk;
   wire dbg_rst;
   wire dbg_en_s;
   wire dbg_clk;
   wire cpu_mclk;
   wire cpu_en_s;
   wire n_0_0_0;
   wire [15:0]per_dout_or;
   wire n_0_0_1;
   wire n_0_0_2;
   wire n_0_0_3;
   wire n_0_0_4;
   wire n_0_0_5;
   wire n_0_0_6;
   wire n_0_0_7;
   wire n_0_0_8;
   wire n_0_0_9;
   wire n_0_0_10;
   wire n_0_0_11;
   wire n_0_0_12;
   wire n_0_0_13;
   wire n_0_0_14;
   wire n_0_0_15;

   omsp_watchdog watchdog_0 (.per_dout(per_dout_wdog), .wdt_irq(wdt_irq), 
      .wdt_reset(wdt_reset), .wdt_wkup(wdt_wkup), .wdtifg(wdtifg), .wdtnmies(
      wdtnmies), .aclk(aclk), .aclk_en(aclk_en), .dbg_freeze(dbg_freeze), 
      .mclk(mclk), .per_addr(per_addr), .per_din(per_din), .per_en(per_en), 
      .per_we(per_we), .por(por), .puc_rst(puc_rst), .scan_enable(scan_enable), 
      .scan_mode(scan_mode), .smclk(smclk), .smclk_en(smclk_en), .wdtie(wdtie), 
      .wdtifg_irq_clr(irq_acc[10]), .wdtifg_sw_clr(wdtifg_sw_clr), 
      .wdtifg_sw_set(wdtifg_sw_set));
   omsp_sfr sfr_0 (.cpu_id(cpu_id), .nmi_pnd(nmi_pnd), .nmi_wkup(nmi_wkup), 
      .per_dout(per_dout_sfr), .wdtie(wdtie), .wdtifg_sw_clr(wdtifg_sw_clr), 
      .wdtifg_sw_set(wdtifg_sw_set), .cpu_nr_inst({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
      1'b0, 1'b0, 1'b0}), .cpu_nr_total({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
      1'b0, 1'b0}), .mclk(mclk), .nmi(nmi), .nmi_acc(nmi_acc), .per_addr(
      per_addr), .per_din(per_din), .per_en(per_en), .per_we(per_we), .puc_rst(
      puc_rst), .scan_mode(scan_mode), .wdtifg(wdtifg), .wdtnmies(wdtnmies));
   omsp_dbg dbg_0 (.dbg_cpu_reset(dbg_cpu_reset), .dbg_freeze(dbg_freeze), 
      .dbg_halt_cmd(dbg_halt_cmd), .dbg_i2c_sda_out(dbg_i2c_sda_out), 
      .dbg_mem_addr(dbg_mem_addr), .dbg_mem_dout(dbg_mem_dout), .dbg_mem_en(
      dbg_mem_en), .dbg_mem_wr(dbg_mem_wr), .dbg_reg_wr(dbg_reg_wr), 
      .dbg_uart_txd(dbg_uart_txd), .cpu_en_s(cpu_en_s), .cpu_id(cpu_id), 
      .cpu_nr_inst({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
      .cpu_nr_total({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .dbg_clk(
      dbg_clk), .dbg_en_s(dbg_en_s), .dbg_halt_st(cpu_halt_st), .dbg_i2c_addr(
      dbg_i2c_addr), .dbg_i2c_broadcast(dbg_i2c_broadcast), .dbg_i2c_scl(
      dbg_i2c_scl), .dbg_i2c_sda_in(dbg_i2c_sda_in), .dbg_mem_din(dbg_mem_din), 
      .dbg_reg_din(dbg_reg_din), .dbg_rst(dbg_rst), .dbg_uart_rxd(dbg_uart_rxd), 
      .decode_noirq(decode_noirq), .eu_mab(eu_mab), .eu_mb_en(eu_mb_en), 
      .eu_mb_wr(eu_mb_wr), .fe_mdb_in(fe_mdb_in), .pc(pc), .puc_pnd_set(
      puc_pnd_set));
   omsp_multiplier multiplier_0 (.per_dout(per_dout_mpy), .mclk(mclk), .per_addr(
      per_addr), .per_din(per_din), .per_en(per_en), .per_we(per_we), .puc_rst(
      puc_rst), .scan_enable(scan_enable));
   OR4_X1_LVT i_0_0_30 (.A1(per_dout_mpy[15]), .A2(per_dout_wdog[15]), .A3(
      per_dout_sfr[15]), .A4(per_dout_clk[15]), .ZN(n_0_0_15));
   OR2_X1_LVT i_0_0_31 (.A1(n_0_0_15), .A2(per_dout[15]), .ZN(per_dout_or[15]));
   OR4_X1_LVT i_0_0_28 (.A1(per_dout_mpy[14]), .A2(per_dout_wdog[14]), .A3(
      per_dout_sfr[14]), .A4(per_dout_clk[14]), .ZN(n_0_0_14));
   OR2_X1_LVT i_0_0_29 (.A1(n_0_0_14), .A2(per_dout[14]), .ZN(per_dout_or[14]));
   OR4_X1_LVT i_0_0_26 (.A1(per_dout_mpy[13]), .A2(per_dout_wdog[13]), .A3(
      per_dout_sfr[13]), .A4(per_dout_clk[13]), .ZN(n_0_0_13));
   OR2_X1_LVT i_0_0_27 (.A1(n_0_0_13), .A2(per_dout[13]), .ZN(per_dout_or[13]));
   OR4_X1_LVT i_0_0_24 (.A1(per_dout_mpy[12]), .A2(per_dout_wdog[12]), .A3(
      per_dout_sfr[12]), .A4(per_dout_clk[12]), .ZN(n_0_0_12));
   OR2_X1_LVT i_0_0_25 (.A1(n_0_0_12), .A2(per_dout[12]), .ZN(per_dout_or[12]));
   OR4_X1_LVT i_0_0_22 (.A1(per_dout_mpy[11]), .A2(per_dout_wdog[11]), .A3(
      per_dout_sfr[11]), .A4(per_dout_clk[11]), .ZN(n_0_0_11));
   OR2_X1_LVT i_0_0_23 (.A1(n_0_0_11), .A2(per_dout[11]), .ZN(per_dout_or[11]));
   OR4_X1_LVT i_0_0_20 (.A1(per_dout_mpy[10]), .A2(per_dout_wdog[10]), .A3(
      per_dout_sfr[10]), .A4(per_dout_clk[10]), .ZN(n_0_0_10));
   OR2_X1_LVT i_0_0_21 (.A1(n_0_0_10), .A2(per_dout[10]), .ZN(per_dout_or[10]));
   OR4_X1_LVT i_0_0_18 (.A1(per_dout_mpy[9]), .A2(per_dout_wdog[9]), .A3(
      per_dout_sfr[9]), .A4(per_dout_clk[9]), .ZN(n_0_0_9));
   OR2_X1_LVT i_0_0_19 (.A1(n_0_0_9), .A2(per_dout[9]), .ZN(per_dout_or[9]));
   OR4_X1_LVT i_0_0_16 (.A1(per_dout_mpy[8]), .A2(per_dout_wdog[8]), .A3(
      per_dout_sfr[8]), .A4(per_dout_clk[8]), .ZN(n_0_0_8));
   OR2_X1_LVT i_0_0_17 (.A1(n_0_0_8), .A2(per_dout[8]), .ZN(per_dout_or[8]));
   OR4_X1_LVT i_0_0_14 (.A1(per_dout_mpy[7]), .A2(per_dout_wdog[7]), .A3(
      per_dout_sfr[7]), .A4(per_dout_clk[7]), .ZN(n_0_0_7));
   OR2_X1_LVT i_0_0_15 (.A1(n_0_0_7), .A2(per_dout[7]), .ZN(per_dout_or[7]));
   OR4_X1_LVT i_0_0_12 (.A1(per_dout_mpy[6]), .A2(per_dout_wdog[6]), .A3(
      per_dout_sfr[6]), .A4(per_dout_clk[6]), .ZN(n_0_0_6));
   OR2_X1_LVT i_0_0_13 (.A1(n_0_0_6), .A2(per_dout[6]), .ZN(per_dout_or[6]));
   OR4_X1_LVT i_0_0_10 (.A1(per_dout_mpy[5]), .A2(per_dout_wdog[5]), .A3(
      per_dout_sfr[5]), .A4(per_dout_clk[5]), .ZN(n_0_0_5));
   OR2_X1_LVT i_0_0_11 (.A1(n_0_0_5), .A2(per_dout[5]), .ZN(per_dout_or[5]));
   OR4_X1_LVT i_0_0_8 (.A1(per_dout_mpy[4]), .A2(per_dout_wdog[4]), .A3(
      per_dout_sfr[4]), .A4(per_dout_clk[4]), .ZN(n_0_0_4));
   OR2_X1_LVT i_0_0_9 (.A1(n_0_0_4), .A2(per_dout[4]), .ZN(per_dout_or[4]));
   OR4_X1_LVT i_0_0_6 (.A1(per_dout_mpy[3]), .A2(per_dout_wdog[3]), .A3(
      per_dout_sfr[3]), .A4(per_dout_clk[3]), .ZN(n_0_0_3));
   OR2_X1_LVT i_0_0_7 (.A1(n_0_0_3), .A2(per_dout[3]), .ZN(per_dout_or[3]));
   OR4_X1_LVT i_0_0_4 (.A1(per_dout_mpy[2]), .A2(per_dout_wdog[2]), .A3(
      per_dout_sfr[2]), .A4(per_dout_clk[2]), .ZN(n_0_0_2));
   OR2_X1_LVT i_0_0_5 (.A1(n_0_0_2), .A2(per_dout[2]), .ZN(per_dout_or[2]));
   OR4_X1_LVT i_0_0_2 (.A1(per_dout_mpy[1]), .A2(per_dout_wdog[1]), .A3(
      per_dout_sfr[1]), .A4(per_dout_clk[1]), .ZN(n_0_0_1));
   OR2_X1_LVT i_0_0_3 (.A1(n_0_0_1), .A2(per_dout[1]), .ZN(per_dout_or[1]));
   OR4_X1_LVT i_0_0_0 (.A1(per_dout_mpy[0]), .A2(per_dout_wdog[0]), .A3(
      per_dout_sfr[0]), .A4(per_dout_clk[0]), .ZN(n_0_0_0));
   OR2_X1_LVT i_0_0_1 (.A1(n_0_0_0), .A2(per_dout[0]), .ZN(per_dout_or[0]));
   omsp_mem_backbone mem_backbone_0 (.cpu_halt_cmd(cpu_halt_cmd), .dbg_mem_din(
      dbg_mem_din), .dmem_addr(dmem_addr), .dmem_cen(dmem_cen), .dmem_din(
      dmem_din), .dmem_wen(dmem_wen), .eu_mdb_in(eu_mdb_in), .fe_mdb_in(
      fe_mdb_in), .fe_pmem_wait(fe_pmem_wait), .dma_dout(dma_dout), .dma_ready(
      dma_ready), .dma_resp(dma_resp), .per_addr(per_addr), .per_din(per_din), 
      .per_we(per_we), .per_en(per_en), .pmem_addr(pmem_addr), .pmem_cen(
      pmem_cen), .pmem_din(pmem_din), .pmem_wen(pmem_wen), .cpu_halt_st(
      cpu_halt_st), .dbg_halt_cmd(dbg_halt_cmd), .dbg_mem_addr({dbg_mem_addr[15], 
      dbg_mem_addr[14], dbg_mem_addr[13], dbg_mem_addr[12], dbg_mem_addr[11], 
      dbg_mem_addr[10], dbg_mem_addr[9], dbg_mem_addr[8], dbg_mem_addr[7], 
      dbg_mem_addr[6], dbg_mem_addr[5], dbg_mem_addr[4], dbg_mem_addr[3], 
      dbg_mem_addr[2], dbg_mem_addr[1]}), .dbg_mem_dout(dbg_mem_dout), 
      .dbg_mem_en(dbg_mem_en), .dbg_mem_wr(dbg_mem_wr), .dmem_dout(dmem_dout), 
      .eu_mab({eu_mab[15], eu_mab[14], eu_mab[13], eu_mab[12], eu_mab[11], 
      eu_mab[10], eu_mab[9], eu_mab[8], eu_mab[7], eu_mab[6], eu_mab[5], 
      eu_mab[4], eu_mab[3], eu_mab[2], eu_mab[1]}), .eu_mb_en(eu_mb_en), 
      .eu_mb_wr(eu_mb_wr), .eu_mdb_out(eu_mdb_out), .fe_mab({n_14, n_13, n_12, 
      n_11, n_10, n_9, n_8, n_7, n_6, n_5, n_4, n_3, n_2, n_1, n_0}), .fe_mb_en(
      fe_mb_en), .mclk(mclk), .dma_addr(dma_addr), .dma_din(dma_din), .dma_en(
      dma_en), .dma_priority(dma_priority), .dma_we(dma_we), .per_dout(
      per_dout_or), .pmem_dout(pmem_dout), .puc_rst(puc_rst), .scan_enable(
      scan_enable));
   omsp_frontend frontend_0 (.cpu_halt_st(cpu_halt_st), .decode_noirq(
      decode_noirq), .e_state(e_state), .exec_done(exec_done), .inst_ad(inst_ad), 
      .inst_as(inst_as), .inst_alu(inst_alu), .inst_bw(inst_bw), .inst_dest(
      inst_dest), .inst_dext(inst_dext), .inst_irq_rst(inst_irq_rst), .inst_jmp(
      inst_jmp), .inst_mov(inst_mov), .inst_sext(inst_sext), .inst_so(inst_so), 
      .inst_src(inst_src), .inst_type(inst_type), .irq_acc(irq_acc), .mab({n_14, 
      n_13, n_12, n_11, n_10, n_9, n_8, n_7, n_6, n_5, n_4, n_3, n_2, n_1, n_0, 
      uc_0}), .mb_en(fe_mb_en), .mclk_dma_enable(mclk_dma_enable), 
      .mclk_dma_wkup(mclk_dma_wkup), .mclk_enable(mclk_enable), .mclk_wkup(
      mclk_wkup), .nmi_acc(nmi_acc), .pc(pc), .pc_nxt(pc_nxt), .cpu_en_s(
      cpu_en_s), .cpu_halt_cmd(cpu_halt_cmd), .cpuoff(cpuoff), .dbg_reg_sel({
      dbg_mem_addr[3], dbg_mem_addr[2], dbg_mem_addr[1], dbg_mem_addr[0]}), 
      .dma_en(dma_en), .dma_wkup(dma_wkup), .fe_pmem_wait(fe_pmem_wait), 
      .gie(gie), .irq(irq), .mclk(cpu_mclk), .mdb_in(fe_mdb_in), .nmi_pnd(
      nmi_pnd), .nmi_wkup(nmi_wkup), .pc_sw(pc_sw), .pc_sw_wr(pc_sw_wr), 
      .puc_rst(puc_rst), .scan_enable(scan_enable), .wdt_irq(wdt_irq), .wdt_wkup(
      wdt_wkup), .wkup(wkup));
   omsp_execution_unit execution_unit_0 (.cpuoff(cpuoff), .dbg_reg_din(
      dbg_reg_din), .gie(gie), .mab(eu_mab), .mb_en(eu_mb_en), .mb_wr(eu_mb_wr), 
      .mdb_out(eu_mdb_out), .oscoff(oscoff), .pc_sw(pc_sw), .pc_sw_wr(pc_sw_wr), 
      .scg0(scg0), .scg1(scg1), .dbg_halt_st(cpu_halt_st), .dbg_mem_dout(
      dbg_mem_dout), .dbg_reg_wr(dbg_reg_wr), .e_state(e_state), .exec_done(
      exec_done), .inst_ad(inst_ad), .inst_as(inst_as), .inst_alu(inst_alu), 
      .inst_bw(inst_bw), .inst_dest(inst_dest), .inst_dext(inst_dext), 
      .inst_irq_rst(inst_irq_rst), .inst_jmp(inst_jmp), .inst_mov(inst_mov), 
      .inst_sext(inst_sext), .inst_so(inst_so), .inst_src(inst_src), .inst_type(
      inst_type), .mclk(cpu_mclk), .mdb_in(eu_mdb_in), .pc(pc), .pc_nxt(pc_nxt), 
      .puc_rst(puc_rst), .scan_enable(scan_enable));
   omsp_clock_module clock_module_0 (.aclk(aclk), .aclk_en(aclk_en), .cpu_en_s(
      cpu_en_s), .cpu_mclk(cpu_mclk), .dma_mclk(mclk), .dbg_clk(dbg_clk), 
      .dbg_en_s(dbg_en_s), .dbg_rst(dbg_rst), .dco_enable(dco_enable), .dco_wkup(
      dco_wkup), .lfxt_enable(lfxt_enable), .lfxt_wkup(lfxt_wkup), .per_dout(
      per_dout_clk), .por(por), .puc_pnd_set(puc_pnd_set), .puc_rst(puc_rst), 
      .smclk(smclk), .smclk_en(smclk_en), .cpu_en(cpu_en), .cpuoff(cpuoff), 
      .dbg_cpu_reset(dbg_cpu_reset), .dbg_en(dbg_en), .dco_clk(dco_clk), 
      .lfxt_clk(lfxt_clk), .mclk_dma_enable(mclk_dma_enable), .mclk_dma_wkup(
      mclk_dma_wkup), .mclk_enable(mclk_enable), .mclk_wkup(mclk_wkup), .oscoff(
      oscoff), .per_addr(per_addr), .per_din(per_din), .per_en(per_en), .per_we(
      per_we), .reset_n(reset_n), .scan_enable(scan_enable), .scan_mode(
      scan_mode), .scg0(scg0), .scg1(scg1), .wdt_reset(wdt_reset));
endmodule
