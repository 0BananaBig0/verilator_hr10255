module instance_no_port_name(A,B,C);
   input [40:0]A;
   inout [40:0]B;
   output [40:0]C;
  INV_X1_LVT U1/i_0_0 (.A(A[0]), .ZN(C[0]));
  INV_X1_LVT U1/i_0_1 (.A(B[0]), .ZN(C[1]));
  INV_X1_LVT U1/i_0_2 (.A(B[1]), .ZN(C[2]));
  OAI222_X1_LVT U1/i_0_3 (.A1(A[1]), .A2(A[2]), .B1(B[1]), .B2(B[2]), .C1(A[3]), 
      .C2(B[3]), .ZN(C[3]));
  INV_X1_LVT U1/i_1_0 (.A(A[4]), .ZN(C[4]));
  INV_X1_LVT U1/i_1_1 (.A(B[4]), .ZN(C[5]));
  INV_X1_LVT U1/i_1_2 (.A(B[5]), .ZN(C[6]));
  OAI222_X1_LVT U1/i_1_3 (.A1(A[5]), .A2(A[6]), .B1(B[5]), .B2(B[6]), .C1(A[7]), 
      .C2(B[7]), .ZN(C[7]));
  INV_X1_LVT U1/i_2_0 (.A(A[8]), .ZN(C[8]));
  INV_X1_LVT U1/i_2_1 (.A(B[8]), .ZN(C[9]));
  INV_X1_LVT U1/i_2_2 (.A(B[9]), .ZN(C[10]));
  OAI222_X1_LVT U1/i_2_3 (.A1(A[9]), .A2(A[10]), .B1(B[9]), .B2(B[10]), .C1(
      A[11]), .C2(B[11]), .ZN(C[11]));
  INV_X1_LVT U2/i_0_0 (.A(A[12]), .ZN(C[12]));
  INV_X1_LVT U2/i_0_1 (.A(B[12]), .ZN(C[13]));
  INV_X1_LVT U2/i_0_2 (.A(B[13]), .ZN(C[14]));
  OAI222_X1_LVT U2/i_0_3 (.A1(A[13]), .A2(A[14]), .B1(B[13]), .B2(B[14]), .C1(
      A[15]), .C2(B[15]), .ZN(C[15]));
  INV_X1_LVT U2/i_1_0 (.A(A[16]), .ZN(C[16]));
  INV_X1_LVT U2/i_1_1 (.A(B[16]), .ZN(C[17]));
  INV_X1_LVT U2/i_1_2 (.A(B[17]), .ZN(C[18]));
  OAI222_X1_LVT U2/i_1_3 (.A1(A[17]), .A2(A[18]), .B1(B[17]), .B2(B[18]), .C1(
      A[19]), .C2(B[19]), .ZN(C[19]));
  INV_X1_LVT U2/i_2_0 (.A(A[20]), .ZN(C[20]));
  INV_X1_LVT U2/i_2_1 (.A(B[20]), .ZN(C[21]));
  INV_X1_LVT U2/i_2_2 (.A(B[21]), .ZN(C[22]));
  OAI222_X1_LVT U2/i_2_3 (.A1(A[21]), .A2(A[22]), .B1(B[21]), .B2(B[22]), .C1(
      A[23]), .C2(B[23]), .ZN(C[23]));
  INV_X1_LVT U3/i_0_0 (.A(A[24]), .ZN(C[24]));
  INV_X1_LVT U3/i_0_1 (.A(B[24]), .ZN(C[25]));
  INV_X1_LVT U3/i_0_2 (.A(B[25]), .ZN(C[26]));
  OAI222_X1_LVT U3/i_0_3 (.A1(A[25]), .A2(A[26]), .B1(B[25]), .B2(B[26]), .C1(
      A[27]), .C2(B[27]), .ZN(C[27]));
  INV_X1_LVT U3/i_1_0 (.A(A[28]), .ZN(C[28]));
  INV_X1_LVT U3/i_1_1 (.A(B[28]), .ZN(C[29]));
  INV_X1_LVT U3/i_1_2 (.A(B[29]), .ZN(C[30]));
  OAI222_X1_LVT U3/i_1_3 (.A1(A[29]), .A2(A[30]), .B1(B[29]), .B2(B[30]), .C1(
      A[31]), .C2(B[31]), .ZN(C[31]));
  INV_X1_LVT U3/i_2_0 (.A(A[32]), .ZN(C[32]));
  INV_X1_LVT U3/i_2_1 (.A(B[32]), .ZN(C[33]));
  INV_X1_LVT U3/i_2_2 (.A(B[33]), .ZN(C[34]));
  OAI222_X1_LVT U3/i_2_3 (.A1(A[33]), .A2(A[34]), .B1(B[33]), .B2(B[34]), .C1(
      A[35]), .C2(B[35]), .ZN(C[35]));
endmodule

