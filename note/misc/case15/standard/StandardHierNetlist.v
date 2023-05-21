module blackbox(a,b,c);
   input a;
   input b;
   output c;
endmodule

module BBTOP(a,b,c);
   input a;
   input b;
   output c;
  blackbox blackbox_U1 (.a(a), .b(b), .c(c));
endmodule

