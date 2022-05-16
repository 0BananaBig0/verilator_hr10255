/*************************************************************************
  > File Name: has_bigger_constant_value.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module has_bigger_constant_value(A,B,C);
  input[120:0] A;
  inout[120:0] B;
  output[333:0] C;
  wire[63:0] slongv;
  wire[127:0] longv;
  wire[255:0] llongv;
  assign slongv = 64'd8589934593;// 64'h00000002_00000001
  assign longv = {slongv+1,slongv};// 128'h00000002_00000002 00000002_00000001
  assign llongv = {slongv,longv,slongv};// 256'h00000002_00000001 00000002_00000002 00000002_00000001 00000002_00000001
  submodule1 U1(.A(A[64:0]),.B(B[64:0]),.C(C[64:0]));
  submodule1 U2(.A(A[105:41]),.B(B[105:41]),.C(C[105:41]));
  submodule1 U3(.A(65'h1_00000002_00000002),.B(longv[105:41]),.C(C[170:106]));
endmodule

module submodule1(A,B,C);
  input [64:0] A;
  inout [64:0] B;
  output [64:0] C;
  assign C[64:36] = B[64:36];
  submodule2 U1(.A(A[11:0]),.B(B[11:0]),.C(C[11:0]));
  submodule2 U2(.A(A[23:12]),.B(B[23:12]),.C(C[23:12]));
  submodule2 U3(.A(A[35:24]),.B(B[35:24]),.C(C[35:24]));
endmodule

module submodule2(A,B,C);
   input [11:0] A,B;
   output [11:0] C;
   INV_X1_LVT i_0_0 (.A(A[0]), .ZN(C[0]));
   INV_X1_LVT i_0_1 (.A(B[0]), .ZN(C[1]));
   INV_X1_LVT i_0_2 (.A(B[1]), .ZN(C[2]));
   OAI222_X1_LVT i_0_3 (.A1(A[1]), .A2(A[2]), .B1(B[1]), .B2(B[2]), .C1(
      A[3] ), .C2(B[3] ), .ZN(C[3]));
   INV_X1_LVT i_1_0 (.A(A[4]), .ZN(C[4]));
   INV_X1_LVT i_1_1 (.A(B[4]), .ZN(C[5]));
   INV_X1_LVT i_1_2 (.A(B[5]), .ZN(C[6]));
   OAI222_X1_LVT i_1_3 (.A1(A[5]), .A2(A[6]), .B1(B[5]), .B2(B[6]), .C1(
      A[7] ), .C2(B[7] ), .ZN(C[7]));
   INV_X1_LVT i_2_0 (.A(A[8]), .ZN(C[8]));
   INV_X1_LVT i_2_1 (.A(B[8]), .ZN(C[9]));
   INV_X1_LVT i_2_2 (.A(B[9]), .ZN(C[10]));
   OAI222_X1_LVT i_2_3 (.A1(A[9]), .A2(A[10]), .B1(B[9]), .B2(B[10]), .C1(
      A[11] ), .C2(B[11] ), .ZN(C[11]));
endmodule
