/*************************************************************************
  > File Name: has_valueX_and_valueZ.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module has_bigger_constant_value(A,C);
  input[120:0] A;
  output[120:0] C;
  wire[63:0] slongv;
  assign slongv = {32'b0000_1011_1101_xzxz_zxzx_zzzz_xxxx_0000,A[31:0]};
  assign C=A;
endmodule

