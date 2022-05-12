module blackbox(a,b,c);
   input a;
   input b;
   output c;
endmodule

module has_notempty_empty_blackbox(chip_en,wr_en,clock,rd_en,addr,wr_data,
      rd_data,c);
   input chip_en;
   input wr_en;
   input clock;
   input rd_en;
   input [9:0]addr;
   input [15:0]wr_data;
   output [15:0]rd_data;
   output [15:0]c;
  submodule U1 (.chip_en(chip_en), .wr_en(wr_en), .clock(clock), .rd_en(rd_en), 
      .addr({addr[9],addr[8],addr[7],addr[6],addr[5],addr[4],addr[3],addr[2],
      addr[1],addr[0]}), .wr_data({wr_data[15],wr_data[14],wr_data[13],
      wr_data[12],wr_data[11],wr_data[10],wr_data[9],wr_data[8],wr_data[7],
      wr_data[6],wr_data[5],wr_data[4],wr_data[3],wr_data[2],wr_data[1],
      wr_data[0]}), .rd_data({rd_data[15],rd_data[14],rd_data[13],rd_data[12],
      rd_data[11],rd_data[10],rd_data[9],rd_data[8],rd_data[7],rd_data[6],
      rd_data[5],rd_data[4],rd_data[3],rd_data[2],rd_data[1],rd_data[0]}));
  blackbox U2 (.a(addr[1]), .b(addr[2]), .c(c[1]));
  XOR2_X1_HVT U3 (.A(addr[2]), .B(addr[3]), .Z(c[3]));
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

