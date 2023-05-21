module AOTOP(a,b,c,d,e);
   input a;
   input b;
   input c;
   output d;
   output e;
  assign_only assign_only_U1 (.a(a), .b(d));
endmodule

module assign_only(a,b);
   input a;
   output b;
  assign b = a;
endmodule

