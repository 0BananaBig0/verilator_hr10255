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
  XOR2_X2_HVT XOR2_X2_HVT_U1 (.A(a), .B(b), .Z(d));
  XNOR2_X2_HVT XNOR2_X2_HVT_U2 (.A(b), .B(c), .ZN(e));
  blackbox blackbox_U1 (.a(), .b(), .c());
  full_adder_co full_adder_co_U1 (.a(), .b(), .ci(), .co());
  assign_only assign_only_U1 (.a(), .b());
endmodule

module full_adder_co(a,b,ci,co);
   input a;
   input b;
   input ci;
   output co;
   wire \n_0[0] ;
   wire \n_0[1] ;
   wire \n_0[2] ;
   wire d;
  assign d = 1'b0;
  INV_X1_LVT i_0_0 (.A(a), .ZN(\n_0[0] ));
  INV_X1_LVT i_0_1 (.A(b), .ZN(\n_0[1] ));
  INV_X1_LVT i_0_2 (.A(ci), .ZN(\n_0[2] ));
  OAI222_X1_LVT i_0_3 (.A1(\n_0[0] ), .A2(\n_0[1] ), .B1(\n_0[1] ), .B2(\n_0[2] ), 
      .C1(\n_0[0] ), .C2(\n_0[2] ), .ZN(co));
endmodule

module assign_only(a,b);
   input a;
   output b;
  assign b = a;
endmodule

