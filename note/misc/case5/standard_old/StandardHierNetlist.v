module top(c,a,b,d);
   inout c;
   input a;
   input b;
   output d;
  XOR2_X1_HVT U1 (.A(a), .B(b), .Z(c));
  submodule1 U2 (.a(a), .b(c), .c(d));
endmodule

module submodule1(a,b,c);
   input a;
   input b;
   output c;
  XOR2_X1_HVT U1 (.A(a), .B(b), .Z(c));
endmodule

