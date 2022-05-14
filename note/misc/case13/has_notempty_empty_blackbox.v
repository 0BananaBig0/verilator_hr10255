/*************************************************************************
  > File Name: has_notempty_empty_blackbox.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module has_notempty_empty_blackbox(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en,c);
  input chip_en, wr_en, clock, rd_en;
  input[9:0] addr;
  input[15:0] wr_data;
  output[15:0] rd_data, c;
  submodule U1(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en);
  blackbox U2(.a(addr[1]),.b(addr[2]),.c(c[1]));
  XOR2_X1_HVT U3(addr[2], addr[3], c[3]);
endmodule

module submodule(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en);
  input chip_en, wr_en, clock, rd_en;
  input[9:0] addr;
  input[15:0] wr_data;
  output[15:0] rd_data;
  MemGen_16_10 U0(chip_en, wr_en, addr, wr_data, clock, rd_en, rd_data);
endmodule

module blackbox(a,b,c);
  input a;
  input b;
  output c;
endmodule;
