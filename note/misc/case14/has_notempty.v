/*************************************************************************
  > File Name: has_notempty.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module has_notempty(a,b,c,d);
  input a, b;
  output c, d;
  submodule U1(a,b,c);
  XOR2_X1_HVT U3(b,c,d);
endmodule

module submodule(a,b,c);
  input a;
  input b;
  output c;
  XOR2_X1_HVT U3(a, b, c);
endmodule;
