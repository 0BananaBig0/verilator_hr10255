module assign_connect_to_empty_signal(a,b,c,d);
   input a;
   input b;
   output c;
   output d;
   wire U1_c;
   wire U1_d;
  assign c = a;
  assign U1_c = a;
endmodule

