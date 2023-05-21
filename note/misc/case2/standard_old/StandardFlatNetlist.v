module ripple_adder(A,B,ci,co,SUM);
   input [3:0]A;
   input [3:0]B;
   input ci;
   output co;
   output [3:0]SUM;
   wire [4:0]C;
   wire U0/U1/n_0_0;
   wire U0/U1/n_0_1;
   wire U0/U1/n_0_2;
   wire U0/U0/n_0_0;
   wire U1/U1/n_0_0;
   wire U1/U1/n_0_1;
   wire U1/U1/n_0_2;
   wire U1/U0/n_0_0;
   wire U2/U1/n_0_0;
   wire U2/U1/n_0_1;
   wire U2/U1/n_0_2;
   wire U2/U0/n_0_0;
   wire U3/U1/n_0_0;
   wire U3/U1/n_0_1;
   wire U3/U1/n_0_2;
   wire U3/U0/n_0_0;
  INV_X1_LVT U0/U1/i_0_0 (.A(A[0]), .ZN(U0/U1/n_0_0));
  INV_X1_LVT U0/U1/i_0_1 (.A(B[0]), .ZN(U0/U1/n_0_1));
  INV_X1_LVT U0/U1/i_0_2 (.A(ci), .ZN(U0/U1/n_0_2));
  OAI222_X1_LVT U0/U1/i_0_3 (.A1(U0/U1/n_0_0), .A2(U0/U1/n_0_1), .B1(U0/U1/n_0_1), 
      .B2(U0/U1/n_0_2), .C1(U0/U1/n_0_0), .C2(U0/U1/n_0_2), .ZN(C[1]));
  XNOR2_X1_LVT U0/U0/i_0_0 (.A(A[0]), .B(ci), .ZN(U0/U0/n_0_0));
  XNOR2_X1_LVT U0/U0/i_0_1 (.A(U0/U0/n_0_0), .B(B[0]), .ZN(SUM[0]));
  INV_X1_LVT U1/U1/i_0_0 (.A(A[1]), .ZN(U1/U1/n_0_0));
  INV_X1_LVT U1/U1/i_0_1 (.A(B[1]), .ZN(U1/U1/n_0_1));
  INV_X1_LVT U1/U1/i_0_2 (.A(C[1]), .ZN(U1/U1/n_0_2));
  OAI222_X1_LVT U1/U1/i_0_3 (.A1(U1/U1/n_0_0), .A2(U1/U1/n_0_1), .B1(U1/U1/n_0_1), 
      .B2(U1/U1/n_0_2), .C1(U1/U1/n_0_0), .C2(U1/U1/n_0_2), .ZN(C[2]));
  XNOR2_X1_LVT U1/U0/i_0_0 (.A(A[1]), .B(C[1]), .ZN(U1/U0/n_0_0));
  XNOR2_X1_LVT U1/U0/i_0_1 (.A(U1/U0/n_0_0), .B(B[1]), .ZN(SUM[1]));
  INV_X1_LVT U2/U1/i_0_0 (.A(A[2]), .ZN(U2/U1/n_0_0));
  INV_X1_LVT U2/U1/i_0_1 (.A(B[2]), .ZN(U2/U1/n_0_1));
  INV_X1_LVT U2/U1/i_0_2 (.A(C[2]), .ZN(U2/U1/n_0_2));
  OAI222_X1_LVT U2/U1/i_0_3 (.A1(U2/U1/n_0_0), .A2(U2/U1/n_0_1), .B1(U2/U1/n_0_1), 
      .B2(U2/U1/n_0_2), .C1(U2/U1/n_0_0), .C2(U2/U1/n_0_2), .ZN(C[3]));
  XNOR2_X1_LVT U2/U0/i_0_0 (.A(A[2]), .B(C[2]), .ZN(U2/U0/n_0_0));
  XNOR2_X1_LVT U2/U0/i_0_1 (.A(U2/U0/n_0_0), .B(B[2]), .ZN(SUM[2]));
  INV_X1_LVT U3/U1/i_0_0 (.A(A[3]), .ZN(U3/U1/n_0_0));
  INV_X1_LVT U3/U1/i_0_1 (.A(B[3]), .ZN(U3/U1/n_0_1));
  INV_X1_LVT U3/U1/i_0_2 (.A(C[3]), .ZN(U3/U1/n_0_2));
  OAI222_X1_LVT U3/U1/i_0_3 (.A1(U3/U1/n_0_0), .A2(U3/U1/n_0_1), .B1(U3/U1/n_0_1), 
      .B2(U3/U1/n_0_2), .C1(U3/U1/n_0_0), .C2(U3/U1/n_0_2), .ZN(co));
  XNOR2_X1_LVT U3/U0/i_0_0 (.A(A[3]), .B(C[3]), .ZN(U3/U0/n_0_0));
  XNOR2_X1_LVT U3/U0/i_0_1 (.A(U3/U0/n_0_0), .B(B[3]), .ZN(SUM[3]));
endmodule

