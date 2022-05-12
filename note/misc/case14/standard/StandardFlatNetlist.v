module has_notempty(a,b,c,d);
   input a;
   input b;
   output c;
   output d;
  XOR2_X1_HVT U1_U3 (.A(a), .B(b), .Z(c));
  XOR2_X1_HVT U3 (.A(b), .B(c), .Z(d));
endmodule

