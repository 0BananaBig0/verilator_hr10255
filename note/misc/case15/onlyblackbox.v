module BBTOP (a,b,c);
  input a,b;
  output c;
  blackbox blackbox_U1 (.a(a),.b(b),.c(c));
endmodule

module blackbox(a,b,c);
  input a;
  input b;
  output c;
endmodule
