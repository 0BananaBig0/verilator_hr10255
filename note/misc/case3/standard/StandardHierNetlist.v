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
  XOR2_X2_HVT XOR2_X2_HVT_U1 (.Z(d), .A(a), .B(b));
  XNOR2_X2_HVT XNOR2_X2_HVT_U2 (.ZN(e), .A(b), .B(c));
  blackbox blackbox_U1 (.a(), .b(), .c());
  full_adder_co full_adder_co_U1 (.co(), .a(), .b(), .ci());
  assign_only assign_only_U1 (.a(), .b());
endmodule

module full_adder_co(co,a,b,ci);
   output co;
   input a;
   input b;
   input ci;
   wire \n_0[0] ;
   wire \n_0[1] ;
   wire \n_0[2] ;
   wire d;
  assign d = 1'b0;
  INV_X1_LVT i_0_0 (.ZN(\n_0[0] ), .A(a));
  INV_X1_LVT i_0_1 (.ZN(\n_0[1] ), .A(b));
  INV_X1_LVT i_0_2 (.ZN(\n_0[2] ), .A(ci));
  OAI222_X1_LVT i_0_3 (.ZN(co), .A1(\n_0[0] ), .A2(\n_0[1] ), .B1(\n_0[1] ), .B2(
      \n_0[2] ), .C1(\n_0[0] ), .C2(\n_0[2] ));
endmodule

module assign_only(a,b);
   input a;
   output b;
  assign b = a;
endmodule

