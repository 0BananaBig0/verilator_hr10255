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

   full_adder_co U1 (.co(), .a(a), .b(), .ci(ci));
   full_adder_sum U0 (.sum(sum), .a(), .b(b), .ci(ci));
endmodule
