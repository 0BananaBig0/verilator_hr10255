module has_notempty(a,b,c,d);
   input a;
   input b;
   output c;
   output d;
  submodule U1 (.a(a), .b(b), .c(c));
  XOR2_X1_HVT U3 (.A(b), .B(c), .Z(d));
endmodule

module submodule(a,b,c);
   input a;
   input b;
   output c;
  XOR2_X1_HVT U3 (.A(a), .B(b), .Z(c));
endmodule

