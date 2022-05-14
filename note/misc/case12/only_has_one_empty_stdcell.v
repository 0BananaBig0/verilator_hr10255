/*************************************************************************
  > File Name: only_has_one_empty_stdcell.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module only_has_one_empty_stdcell(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en);
  input chip_en, wr_en, clock, rd_en;
  input[9:0] addr;
  input[15:0] wr_data;
  output[15:0] rd_data;
  submodule U1(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en);
endmodule

module submodule(rd_data, chip_en, wr_en, addr, wr_data, clock, rd_en);
  input chip_en, wr_en, clock, rd_en;
  input[9:0] addr;
  input[15:0] wr_data;
  output[15:0] rd_data;
  MemGen_16_10 U0(chip_en, wr_en, addr, wr_data, clock, rd_en, rd_data);
endmodule
