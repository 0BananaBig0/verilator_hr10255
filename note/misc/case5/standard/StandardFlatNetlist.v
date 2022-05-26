module top(a,b,c,d);
   input a;
   input b;
   inout c;
   output d;
  XOR2_X1_HVT U1 (.A(a), .B(b), .Z(c));
  XOR2_X1_HVT U2/U1 (.A(a), .B(c), .Z(d));
endmodule

