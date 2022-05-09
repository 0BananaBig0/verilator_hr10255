/*************************************************************************
  > File Name: has_inout.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:18:17 PM CST
 ************************************************************************/

module top(a,b,c,d);
  input a;
  input b;
  inout c;
  output d;
  XOR2_X1_HVT U1(.Z(c),.A(a),.B(b));
  submodule1 U2(.c(d),.a(a),.b(c));
endmodule

module submodule1(a,b,c);
  input a;
  input b;
  output c;
  XOR2_X1_HVT U1(.Z(c),.A(a),.B(b));
endmodule
