/*************************************************************************
  > File Name: has_memory_PLL_blackbox.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module has_memory_PLL_blackbox(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en,
    BYPASS, DIVF0, DIVF1, DIVF2, DIVF3, DIVF4, DIVF5, DIVF6, DIVF7, DIVQ0,
    DIVQ1, DIVQ2, DIVR0, DIVR1, DIVR2, DIVR3, DIVR4, DIVR5, FB, FSE, RANGE0, 
    RANGE1, RANGE2, REF, RESET, LOCK, PLLOUT, c);
  input chip_en, wr_en, clock, rd_en;
  input[9:0] addr;
  input[15:0] wr_data;
  input BYPASS, DIVF0, DIVF1, DIVF2, DIVF3, DIVF4, DIVF5, DIVF6, DIVF7, 
    DIVQ0, DIVQ1, DIVQ2, DIVR0, DIVR1, DIVR2, DIVR3, DIVR4, DIVR5, FB, 
    FSE, RANGE0, RANGE1, RANGE2, REF, RESET;
  output[15:0] rd_data, c;
  output LOCK, PLLOUT;
  submodule U1(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en);;
  PLL U0(BYPASS, DIVF0, DIVF1, DIVF2, DIVF3, DIVF4, DIVF5, DIVF6, DIVF7, 
    DIVQ0, DIVQ1, DIVQ2, DIVR0, DIVR1, DIVR2, DIVR3, DIVR4, DIVR5, FB, FSE, 
    RANGE0, RANGE1, RANGE2, REF, RESET, LOCK, PLLOUT);
  blackbox U2(.a(addr[1]),.b(addr[2]),.c(c[1]));
endmodule

module submodule(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en);
  input chip_en, wr_en, clock, rd_en;
  input[9:0] addr;
  input[15:0] wr_data;
  output[15:0] rd_data;
  MemGen_16_10 U0(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en);
endmodule

module blackbox(a,b,c);
  input a;
  input b;
  output c;
endmodule;
