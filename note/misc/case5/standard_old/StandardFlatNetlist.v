module top(c,a,b,d);
   inout c;
   input a;
   input b;
   output d;
  XOR2_X1_HVT U1 (.A(a), .B(b), .Z(c));
  XOR2_X1_HVT U2/U1 (.A(a), .B(c), .Z(d));
endmodule

