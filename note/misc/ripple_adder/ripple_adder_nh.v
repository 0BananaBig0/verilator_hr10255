module ripple_adder(co, SUM, A, B, ci);
  parameter n = 4;
  input ci;
  input[n-1:0] A, B;
  output co;
  wire c1, c2, c3;
  output[n-1:0] SUM;
  wire[n:0] C;
  assign C[0]=ci;
  assign co=C[4];
  assign c1=C[1];
  assign c2=C[2];
  assign c3=C[3];
  wire[n-1:0] w1,w2,w3;

 
  xor(SUM[0], A[0], B[0] ,C[0]);
  and(w1[0], A[0], B[0]);
  and(w2[0], A[0], C[0]);
  and(w3[0], B[0], C[0]);
  or(C[1], w1[0], w2[0], w3[0]);
  // full_adder U1(C[2], SUM[1], A[1], B[1], C[1]);
  xor(SUM[1], A[1], B[1] ,C[1]);
  and(w1[1], A[1], B[1]);
  and(w2[1], A[1], C[1]);
  and(w3[1], B[1], C[1]);
  or(C[2], w1[1], w2[1], w3[1]);
  //full_adder U2(C[3], SUM[2], A[2], B[2], C[2]);
  xor(SUM[2], A[2], B[2] ,C[2]);
  and(w1[2], A[2], B[2]);
  and(w2[2], A[2], C[2]);
  and(w3[2], B[2], C[2]);
  or(C[3], w1[2], w2[2], w3[2]); 
  //full_adder U3(C[4], SUM[3], A[3], B[3], C[3]);
  xor(SUM[3], A[3], B[3] ,C[3]);
  and(w1[3], A[3], B[3]);
  and(w2[3], A[3], C[3]);
  and(w3[3], B[3], C[3]);
  or(C[4], w1[3], w2[3], w3[3]);

endmodule
