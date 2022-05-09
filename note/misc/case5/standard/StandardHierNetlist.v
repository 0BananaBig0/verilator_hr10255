module top(a,b,c,d);
   input a;
   input b;
   inout c;
   output d;
  XOR2_X1_HVT U1 (.Z(c), .A(a), .B(b));
  submodule1 U2 (.a(a), .b(c), .c(d));
endmodule

module submodule1(a,b,c);
   input a;
   input b;
   output c;
  XOR2_X1_HVT U1 (.Z(c), .A(a), .B(b));
endmodule

