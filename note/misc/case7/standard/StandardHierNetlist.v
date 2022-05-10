module some_ports_empty(A,B,C);
   input [40:0]A;
   inout [40:0]B;
   output [40:0]C;
  submodule1 U1 (.A({A[11],A[10],A[9],A[8],A[7],A[6],A[5],A[4],A[3],A[2],A[1],
      A[0]}), .B({B[11],B[10],B[9],B[8],B[7],B[6],B[5],B[4],B[3],B[2],B[1],B[0]}), 
      .C({C[11],C[10],C[9],C[8],C[7],C[6],C[5],C[4],C[3],C[2],C[1],C[0]}));
  submodule1 U2 (.A({A[23],A[22],A[21],A[20],A[19],A[18],A[17],A[16],A[15],A[14],
      A[13],A[12]}), .B({B[23],B[22],B[21],B[20],B[19],B[18],B[17],B[16],B[15],
      B[14],B[13],B[12]}), .C());
  submodule1 U3 (.A({A[35],A[34],A[33],A[32],A[31],A[30],A[29],A[28],A[27],A[26],
      A[25],A[24]}), .B(), .C({C[35],C[34],C[33],C[32],C[31],C[30],C[29],C[28],
      C[27],C[26],C[25],C[24]}));
endmodule

module submodule1(A,B,C);
   input [11:0]A;
   input [11:0]B;
   output [11:0]C;
  INV_X1_LVT i_0_0 (.A(), .ZN(C[0]));
  INV_X1_LVT i_0_1 (.A(B[0]), .ZN());
  INV_X1_LVT i_0_2 (.A(), .ZN());
  OAI222_X1_LVT i_0_3 (.A1(), .A2(A[2]), .B1(), .B2(B[2]), .C1(A[3]), .C2(), .ZN(
      C[3]));
  INV_X1_LVT i_1_0 (.A(A[4]), .ZN(C[4]));
  INV_X1_LVT i_1_1 (.A(B[4]), .ZN(C[5]));
  INV_X1_LVT i_1_2 (.A(B[5]), .ZN(C[6]));
  OAI222_X1_LVT i_1_3 (.A1(A[5]), .A2(A[6]), .B1(B[5]), .B2(B[6]), .C1(A[7]), 
      .C2(B[7]), .ZN(C[7]));
  INV_X1_LVT i_2_0 (.A(A[8]), .ZN(C[8]));
  INV_X1_LVT i_2_1 (.A(B[8]), .ZN(C[9]));
  INV_X1_LVT i_2_2 (.A(B[9]), .ZN(C[10]));
  OAI222_X1_LVT i_2_3 (.A1(A[9]), .A2(A[10]), .B1(B[9]), .B2(B[10]), .C1(A[11]), 
      .C2(B[11]), .ZN(C[11]));
endmodule

