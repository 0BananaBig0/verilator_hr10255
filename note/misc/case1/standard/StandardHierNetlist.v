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

