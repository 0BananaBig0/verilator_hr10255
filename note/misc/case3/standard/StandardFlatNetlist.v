module blackbox(a,b,c);
   input a;
   inout b;
   output c;
endmodule

module BBTOP(a,b,c,d,e);
   input a;
   input b;
   input c;
   output d;
   output e;
   wire \full_adder_co_U1_n_0[0] ;
   wire \full_adder_co_U1_n_0[1] ;
   wire \full_adder_co_U1_n_0[2] ;
   wire full_adder_co_U1_d;
  assign full_adder_co_U1_d = 1'b0;
  XOR2_X2_HVT XOR2_X2_HVT_U1 (.Z(d), .A(a), .B(b));
  XNOR2_X2_HVT XNOR2_X2_HVT_U2 (.ZN(e), .A(b), .B(c));
  blackbox blackbox_U1 (.a(), .b(), .c());
  INV_X1_LVT full_adder_co_U1_i_0_0 (.ZN(\full_adder_co_U1_n_0[0] ), .A());
  INV_X1_LVT full_adder_co_U1_i_0_1 (.ZN(\full_adder_co_U1_n_0[1] ), .A());
  INV_X1_LVT full_adder_co_U1_i_0_2 (.ZN(\full_adder_co_U1_n_0[2] ), .A());
  OAI222_X1_LVT full_adder_co_U1_i_0_3 (.ZN(), .A1(\full_adder_co_U1_n_0[0] ), 
      .A2(\full_adder_co_U1_n_0[1] ), .B1(\full_adder_co_U1_n_0[1] ), .B2(
      \full_adder_co_U1_n_0[2] ), .C1(\full_adder_co_U1_n_0[0] ), .C2(
      \full_adder_co_U1_n_0[2] ));
endmodule

