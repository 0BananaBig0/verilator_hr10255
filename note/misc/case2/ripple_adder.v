/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 21.1-p005 on Sun Dec  5 15:24:30 2021
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 3136148508 */

module full_adder_co(co, a, b, ci);
   output co;
   input a;
   input b;
   input ci;

   wire n_0_0;
   wire n_0_1;
   wire n_0_2;

   INV_X1_LVT i_0_0 (.A(a), .ZN(n_0_0));
   INV_X1_LVT i_0_1 (.A(b), .ZN(n_0_1));
   INV_X1_LVT i_0_2 (.A(ci), .ZN(n_0_2));
   OAI222_X1_LVT i_0_3 (.A1(n_0_0), .A2(n_0_1), .B1(n_0_1), .B2(n_0_2), .C1(
      n_0_0), .C2(n_0_2), .ZN(co));
endmodule

module full_adder_sum(sum, a, b, ci);
   output sum;
   input a;
   input b;
   input ci;

   wire n_0_0;

   XNOR2_X1_LVT i_0_0 (.A(a), .B(ci), .ZN(n_0_0));
   XNOR2_X1_LVT i_0_1 (.A(n_0_0), .B(b), .ZN(sum));
endmodule

module full_adder(co, sum, a, b, ci);
   output co;
   output sum;
   input a;
   input b;
   input ci;

   full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
   full_adder_sum U0 (.sum(sum), .a(a), .b(b), .ci(ci));
endmodule

module ripple_adder(co, SUM, A, B, ci);
   output co;
   output [3:0]SUM;
   input [3:0]A;
   input [3:0]B;
   input ci;

   wire [4:0]C;

   full_adder U0 (.co(C[1]), .sum(SUM[0]), .a(A[0]), .b(B[0]), .ci(ci));
   full_adder U1 (.co(C[2]), .sum(SUM[1]), .a(A[1]), .b(B[1]), .ci(C[1]));
   full_adder U2 (.co(C[3]), .sum(SUM[2]), .a(A[2]), .b(B[2]), .ci(C[2]));
   full_adder U3 (.co(co), .sum(SUM[3]), .a(A[3]), .b(B[3]), .ci(C[3]));
endmodule
