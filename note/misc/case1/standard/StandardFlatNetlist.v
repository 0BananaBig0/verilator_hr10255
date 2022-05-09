module full_adder(co,sum,a,b,ci);
   output co;
   output sum;
   input a;
   input b;
   input ci;
   wire U1_n_0_0;
   wire U1_n_0_1;
   wire U1_n_0_2;
   wire U0_n_0_0;
  INV_X1_LVT U1_i_0_0 (.ZN(U1_n_0_0), .A(a));
  INV_X1_LVT U1_i_0_1 (.ZN(U1_n_0_1), .A(b));
  INV_X1_LVT U1_i_0_2 (.ZN(U1_n_0_2), .A(ci));
  OAI222_X1_LVT U1_i_0_3 (.ZN(co), .A1(U1_n_0_0), .A2(U1_n_0_1), .B1(U1_n_0_1), 
      .B2(U1_n_0_2), .C1(U1_n_0_0), .C2(U1_n_0_2));
  XNOR2_X1_LVT U0_i_0_0 (.ZN(U0_n_0_0), .A(a), .B(ci));
  XNOR2_X1_LVT U0_i_0_1 (.ZN(sum), .A(U0_n_0_0), .B(b));
endmodule

