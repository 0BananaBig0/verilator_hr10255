module blackbox(a,b,c);
   input a;
   input b;
   output c;
endmodule

module has_memory_PLL_blackbox(chip_en,wr_en,clock,rd_en,addr,wr_data,BYPASS,
      DIVF0,DIVF1,DIVF2,DIVF3,DIVF4,DIVF5,DIVF6,DIVF7,DIVQ0,DIVQ1,DIVQ2,DIVR0,
      DIVR1,DIVR2,DIVR3,DIVR4,DIVR5,FB,FSE,RANGE0,RANGE1,RANGE2,REF,RESET,
      rd_data,c,LOCK,PLLOUT);
   input chip_en;
   input wr_en;
   input clock;
   input rd_en;
   input [9:0]addr;
   input [15:0]wr_data;
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
   output [15:0]rd_data;
   output [15:0]c;
   output LOCK;
   output PLLOUT;
  submodule U1 (.chip_en(chip_en), .wr_en(wr_en), .clock(clock), .rd_en(rd_en), 
      .addr({addr[9],addr[8],addr[7],addr[6],addr[5],addr[4],addr[3],addr[2],
      addr[1],addr[0]}), .wr_data({wr_data[15],wr_data[14],wr_data[13],
      wr_data[12],wr_data[11],wr_data[10],wr_data[9],wr_data[8],wr_data[7],
      wr_data[6],wr_data[5],wr_data[4],wr_data[3],wr_data[2],wr_data[1],
      wr_data[0]}), .rd_data({rd_data[15],rd_data[14],rd_data[13],rd_data[12],
      rd_data[11],rd_data[10],rd_data[9],rd_data[8],rd_data[7],rd_data[6],
      rd_data[5],rd_data[4],rd_data[3],rd_data[2],rd_data[1],rd_data[0]}));
  PLL U0 (.BYPASS(BYPASS), .DIVF0(DIVF0), .DIVF1(DIVF1), .DIVF2(DIVF2), .DIVF3(
      DIVF3), .DIVF4(DIVF4), .DIVF5(DIVF5), .DIVF6(DIVF6), .DIVF7(DIVF7), .DIVQ0(
      DIVQ0), .DIVQ1(DIVQ1), .DIVQ2(DIVQ2), .DIVR0(DIVR0), .DIVR1(DIVR1), .DIVR2(
      DIVR2), .DIVR3(DIVR3), .DIVR4(DIVR4), .DIVR5(DIVR5), .FB(FB), .FSE(FSE), 
      .RANGE0(RANGE0), .RANGE1(RANGE1), .RANGE2(RANGE2), .REF(REF), .RESET(RESET), 
      .LOCK(LOCK), .PLLOUT(PLLOUT));
  blackbox U2 (.a(addr[1]), .b(addr[2]), .c(c[1]));
endmodule

module submodule(chip_en,wr_en,clock,rd_en,addr,wr_data,rd_data);
   input chip_en;
   input wr_en;
   input clock;
   input rd_en;
   input [9:0]addr;
   input [15:0]wr_data;
   output [15:0]rd_data;
  MemGen_16_10 U0 (.chip_en(chip_en), .wr_en(wr_en), .clock(clock), .rd_en(rd_en), 
      .addr({addr[9],addr[8],addr[7],addr[6],addr[5],addr[4],addr[3],addr[2],
      addr[1],addr[0]}), .wr_data({wr_data[15],wr_data[14],wr_data[13],
      wr_data[12],wr_data[11],wr_data[10],wr_data[9],wr_data[8],wr_data[7],
      wr_data[6],wr_data[5],wr_data[4],wr_data[3],wr_data[2],wr_data[1],
      wr_data[0]}), .rd_data({rd_data[15],rd_data[14],rd_data[13],rd_data[12],
      rd_data[11],rd_data[10],rd_data[9],rd_data[8],rd_data[7],rd_data[6],
      rd_data[5],rd_data[4],rd_data[3],rd_data[2],rd_data[1],rd_data[0]}));
endmodule

