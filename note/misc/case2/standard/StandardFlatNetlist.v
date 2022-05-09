module ripple_adder(co,SUM,A,B,ci);
   output co;
   output [3:0]SUM;
   input [3:0]A;
   input [3:0]B;
   input ci;
   wire [4:0]C;
   wire U0_U1_n_0_0;
   wire U0_U1_n_0_1;
   wire U0_U1_n_0_2;
   wire U0_U0_n_0_0;
   wire U1_U1_n_0_0;
   wire U1_U1_n_0_1;
   wire U1_U1_n_0_2;
   wire U1_U0_n_0_0;
   wire U2_U1_n_0_0;
   wire U2_U1_n_0_1;
   wire U2_U1_n_0_2;
   wire U2_U0_n_0_0;
   wire U3_U1_n_0_0;
   wire U3_U1_n_0_1;
   wire U3_U1_n_0_2;
   wire U3_U0_n_0_0;
  INV_X1_LVT U0_U1_i_0_0 (.ZN(U0_U1_n_0_0), .A(A[0]));
  INV_X1_LVT U0_U1_i_0_1 (.ZN(U0_U1_n_0_1), .A(B[0]));
  INV_X1_LVT U0_U1_i_0_2 (.ZN(U0_U1_n_0_2), .A(ci));
  OAI222_X1_LVT U0_U1_i_0_3 (.ZN(C[1]), .A1(U0_U1_n_0_0), .A2(U0_U1_n_0_1), .B1(
      U0_U1_n_0_1), .B2(U0_U1_n_0_2), .C1(U0_U1_n_0_0), .C2(U0_U1_n_0_2));
  XNOR2_X1_LVT U0_U0_i_0_0 (.ZN(U0_U0_n_0_0), .A(A[0]), .B(ci));
  XNOR2_X1_LVT U0_U0_i_0_1 (.ZN(SUM[0]), .A(U0_U0_n_0_0), .B(B[0]));
  INV_X1_LVT U1_U1_i_0_0 (.ZN(U1_U1_n_0_0), .A(A[1]));
  INV_X1_LVT U1_U1_i_0_1 (.ZN(U1_U1_n_0_1), .A(B[1]));
  INV_X1_LVT U1_U1_i_0_2 (.ZN(U1_U1_n_0_2), .A(C[1]));
  OAI222_X1_LVT U1_U1_i_0_3 (.ZN(C[2]), .A1(U1_U1_n_0_0), .A2(U1_U1_n_0_1), .B1(
      U1_U1_n_0_1), .B2(U1_U1_n_0_2), .C1(U1_U1_n_0_0), .C2(U1_U1_n_0_2));
  XNOR2_X1_LVT U1_U0_i_0_0 (.ZN(U1_U0_n_0_0), .A(A[1]), .B(C[1]));
  XNOR2_X1_LVT U1_U0_i_0_1 (.ZN(SUM[1]), .A(U1_U0_n_0_0), .B(B[1]));
  INV_X1_LVT U2_U1_i_0_0 (.ZN(U2_U1_n_0_0), .A(A[2]));
  INV_X1_LVT U2_U1_i_0_1 (.ZN(U2_U1_n_0_1), .A(B[2]));
  INV_X1_LVT U2_U1_i_0_2 (.ZN(U2_U1_n_0_2), .A(C[2]));
  OAI222_X1_LVT U2_U1_i_0_3 (.ZN(C[3]), .A1(U2_U1_n_0_0), .A2(U2_U1_n_0_1), .B1(
      U2_U1_n_0_1), .B2(U2_U1_n_0_2), .C1(U2_U1_n_0_0), .C2(U2_U1_n_0_2));
  XNOR2_X1_LVT U2_U0_i_0_0 (.ZN(U2_U0_n_0_0), .A(A[2]), .B(C[2]));
  XNOR2_X1_LVT U2_U0_i_0_1 (.ZN(SUM[2]), .A(U2_U0_n_0_0), .B(B[2]));
  INV_X1_LVT U3_U1_i_0_0 (.ZN(U3_U1_n_0_0), .A(A[3]));
  INV_X1_LVT U3_U1_i_0_1 (.ZN(U3_U1_n_0_1), .A(B[3]));
  INV_X1_LVT U3_U1_i_0_2 (.ZN(U3_U1_n_0_2), .A(C[3]));
  OAI222_X1_LVT U3_U1_i_0_3 (.ZN(co), .A1(U3_U1_n_0_0), .A2(U3_U1_n_0_1), .B1(
      U3_U1_n_0_1), .B2(U3_U1_n_0_2), .C1(U3_U1_n_0_0), .C2(U3_U1_n_0_2));
  XNOR2_X1_LVT U3_U0_i_0_0 (.ZN(U3_U0_n_0_0), .A(A[3]), .B(C[3]));
  XNOR2_X1_LVT U3_U0_i_0_1 (.ZN(SUM[3]), .A(U3_U0_n_0_0), .B(B[3]));
endmodule

