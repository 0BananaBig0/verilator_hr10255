module full_adder_co(co, a, b, ci);
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
   OAI222_X1_LVT i_0_3 (.A1(n_0_0), .A2(n_0_1), .B1(n_0_1), .B2(n_0_2), .C1(
      n_0_0), .C2(n_0_2), .ZN(co));
endmodule

module full_adder_sum(sum, a, b, ci);
   input a;
   input b;
   input ci;
   output sum;
   wire n_0_0;
   XNOR2_X1_LVT i_0_0 (.A(a), .B(ci), .ZN(n_0_0));
   XNOR2_X1_LVT i_0_1 (.A(n_0_0), .B(b), .ZN(sum));
endmodule

module full_adder(co, sum, a, b, ci);
   input a;
   input b;
   input ci;
   output co;
   output sum;
   full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
   full_adder_sum U0 (.sum(sum), .a(a), .b(b), .ci(ci));
endmodule
