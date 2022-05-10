module ripple_adder(A,B,ci,co,SUM);
   input [3:0]A;
   input [3:0]B;
   input ci;
   output co;
   output [3:0]SUM;
   wire [4:0]C;
  full_adder U0 (.a(A[0]), .b(B[0]), .ci(ci), .co(C[1]), .sum(SUM[0]));
  full_adder U1 (.a(A[1]), .b(B[1]), .ci(C[1]), .co(C[2]), .sum(SUM[1]));
  full_adder U2 (.a(A[2]), .b(B[2]), .ci(C[2]), .co(C[3]), .sum(SUM[2]));
  full_adder U3 (.a(A[3]), .b(B[3]), .ci(C[3]), .co(co), .sum(SUM[3]));
endmodule

module full_adder(a,b,ci,co,sum);
   input a;
   input b;
   input ci;
   output co;
   output sum;
  full_adder_co U1 (.a(a), .b(b), .ci(ci), .co(co));
  full_adder_sum U0 (.a(a), .b(b), .ci(ci), .sum(sum));
endmodule

module full_adder_co(a,b,ci,co);
   input a;
   input b;
   input ci;
   output co;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
  INV_X1_LVT i_0_0 (.A(a), .ZN(n_0_0));
  INV_X1_LVT i_0_1 (.A(b), .ZN(n_0_1));
  INV_X1_LVT i_0_2 (.A(ci), .ZN(n_0_2));
  OAI222_X1_LVT i_0_3 (.A1(n_0_0), .A2(n_0_1), .B1(n_0_1), .B2(n_0_2), .C1(n_0_0), 
      .C2(n_0_2), .ZN(co));
endmodule

module full_adder_sum(a,b,ci,sum);
   input a;
   input b;
   input ci;
   output sum;
   wire n_0_0;
  XNOR2_X1_LVT i_0_0 (.A(a), .B(ci), .ZN(n_0_0));
  XNOR2_X1_LVT i_0_1 (.A(n_0_0), .B(b), .ZN(sum));
endmodule

