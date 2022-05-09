/*************************************************************************
  > File Name: some_ports_empty.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module some_ports_empty(A,B,C);
  input [40:0] A;
  inout [40:0] B;
  output [40:0] C;
  submodule1 U1(.A(A[11:0]),.B(B[11:0]),.C(C[11:0]));
  submodule1 U2(.A(A[23:12]),.B(B[23:12]),.C());
  submodule1 U3(.A(A[35:24]),.B(),.C(C[35:24]));
endmodule

module submodule1(A,B,C);
   input [11:0] A,B;
   output [11:0] C;
   INV_X1_LVT i_0_0 (.A(), .ZN(C[0]));
   INV_X1_LVT i_0_1 (.A(B[0]), .ZN());
   INV_X1_LVT i_0_2 (.A(), .ZN());
   OAI222_X1_LVT i_0_3 (.A1(), .A2(A[2]), .B1(), .B2(B[2]), .C1(
      A[3] ), .C2(), .ZN(C[3]));
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
