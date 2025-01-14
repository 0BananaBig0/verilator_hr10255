module full_adder(a,b,ci,co,sum);
   input a;
   input b;
   input ci;
   output co;
   output sum;
   wire U1/n_0_0;
   wire U1/n_0_1;
   wire U1/n_0_2;
   wire U0/n_0_0;
  INV_X1_LVT U1/i_0_0 (.A(a), .ZN(U1/n_0_0));
  INV_X1_LVT U1/i_0_1 (.A(b), .ZN(U1/n_0_1));
  INV_X1_LVT U1/i_0_2 (.A(ci), .ZN(U1/n_0_2));
  OAI222_X1_LVT U1/i_0_3 (.A1(U1/n_0_0), .A2(U1/n_0_1), .B1(U1/n_0_1), .B2(
      U1/n_0_2), .C1(U1/n_0_0), .C2(U1/n_0_2), .ZN(co));
  XNOR2_X1_LVT U0/i_0_0 (.A(a), .B(ci), .ZN(U0/n_0_0));
  XNOR2_X1_LVT U0/i_0_1 (.A(U0/n_0_0), .B(b), .ZN(sum));
endmodule

