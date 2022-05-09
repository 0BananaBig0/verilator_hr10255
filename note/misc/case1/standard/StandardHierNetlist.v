module full_adder(co,sum,a,b,ci);
   output co;
   output sum;
   input a;
   input b;
   input ci;
  full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
  full_adder_sum U0 (.sum(sum), .a(a), .b(b), .ci(ci));
endmodule

module full_adder_co(co,a,b,ci);
   output co;
   input a;
   input b;
   input ci;
   wire n_0_0;
   wire n_0_1;
   wire n_0_2;
  INV_X1_LVT i_0_0 (.ZN(n_0_0), .A(a));
  INV_X1_LVT i_0_1 (.ZN(n_0_1), .A(b));
  INV_X1_LVT i_0_2 (.ZN(n_0_2), .A(ci));
  OAI222_X1_LVT i_0_3 (.ZN(co), .A1(n_0_0), .A2(n_0_1), .B1(n_0_1), .B2(n_0_2), 
      .C1(n_0_0), .C2(n_0_2));
endmodule

module full_adder_sum(sum,a,b,ci);
   output sum;
   input a;
   input b;
   input ci;
   wire n_0_0;
  XNOR2_X1_LVT i_0_0 (.ZN(n_0_0), .A(a), .B(ci));
  XNOR2_X1_LVT i_0_1 (.ZN(sum), .A(n_0_0), .B(b));
endmodule

