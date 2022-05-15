module assign_connect_to_empty_signal(a,b,c,d);
   input a;
   input b;
   output c;
   output d;
  submodule U1 (.a(a), .b(), .e(c), .f());
endmodule

module submodule(a,b,e,f);
   input a;
   input b;
   output e;
   output f;
   wire c;
   wire d;
  assign e = a;
  assign e = b;
  assign f = a;
  assign f = b;
  assign c = a;
  assign d = b;
endmodule

