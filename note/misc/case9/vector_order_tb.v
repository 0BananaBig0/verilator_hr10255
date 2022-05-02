/*************************************************************************
  > File Name: vector_order_tb.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Tue 19 Apr 2022 04:41:04 PM CST
 ************************************************************************/
`timescale 1ns/1ns
module  vector_order_tb;
  reg[3:0] a;
  wire[3:0] b;
  vector_order U1(a,b);
  initial
  begin
    a = 4'b1011;
    #10 a = 4'b0011;
  end
endmodule
