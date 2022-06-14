module blackbox(b,a,c);
   inout b;
   input a;
   output c;
endmodule

module BBTOP(a,b,c,d,e);
   input a;
   input b;
   input c;
   output d;
   output e;
   wire \full_adder_co_U1/n_0[0] ;
   wire \full_adder_co_U1/n_0[1] ;
   wire \full_adder_co_U1/n_0[2] ;
   wire full_adder_co_U1/d;
  assign full_adder_co_U1/d = 1'b0;
  XOR2_X2_HVT XOR2_X2_HVT_U1 (.A(a), .B(b), .Z(d));
  XNOR2_X2_HVT XNOR2_X2_HVT_U2 (.A(b), .B(c), .ZN(e));
  blackbox blackbox_U1 (.b(), .a(), .c());
  INV_X1_LVT full_adder_co_U1/i_0_0 (.A(), .ZN(\full_adder_co_U1/n_0[0] ));
  INV_X1_LVT full_adder_co_U1/i_0_1 (.A(), .ZN(\full_adder_co_U1/n_0[1] ));
  INV_X1_LVT full_adder_co_U1/i_0_2 (.A(), .ZN(\full_adder_co_U1/n_0[2] ));
  OAI222_X1_LVT full_adder_co_U1/i_0_3 (.A1(\full_adder_co_U1/n_0[0] ), .A2(
      \full_adder_co_U1/n_0[1] ), .B1(\full_adder_co_U1/n_0[1] ), .B2(
      \full_adder_co_U1/n_0[2] ), .C1(\full_adder_co_U1/n_0[0] ), .C2(
      \full_adder_co_U1/n_0[2] ), .ZN());
endmodule

