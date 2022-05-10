/*************************************************************************
  > File Name: vector_combination.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module vector_combination(A,B,C);
  input [40:0] A;
  inout [40:0] B;
  output [40:0] C;
  wire [12:0] D;
  wire [12:0] E;
  wire i;
  assign i = A[3];
  assign E = D;
  assign D ={2'b0,2'b1,A[1:0],A[2],B[4],2'b0,A[3],B[5],1'b0} ;
  submodule U1(.A({D[3:0],E[3:0],i,i,i,i}),.B(B[11:0]),.C(C[11:0]));
  submodule U2(A[23:12],B[23:12],C[23:12]);
  submodule U3(A[35:24],B[35:24],C[35:24]);
endmodule

module submodule(A,B,C);
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
