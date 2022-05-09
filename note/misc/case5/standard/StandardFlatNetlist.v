module top(a,b,c,d);
   input a;
   input b;
   inout c;
   output d;
  XOR2_X1_HVT U1 (.Z(c), .A(a), .B(b));
  XOR2_X1_HVT U2_U1 (.Z(d), .A(a), .B(c));
endmodule

