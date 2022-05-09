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

