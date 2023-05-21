module assign_connect_to_empty_signal(a,b,c,d);
   input a;
   input b;
   output c;
   output d;
   wire U1/c;
   wire U1/d;
  assign c = a;
  assign U1/c = a;
endmodule

