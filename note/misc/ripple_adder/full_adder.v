module full_adder(co, sum, a, b, ci);

  input a, b, ci;
  output sum, co;

  full_adder_sum U0(sum,a,b,ci);
  full_adder_co  U1(co,a,b,ci);

endmodule

module full_adder_sum(sum,a,b,ci);

  input a, b, ci;
  output sum;

  xor(sum, a, b ,ci);

endmodule

module full_adder_co(co,a,b,ci);

  input a, b, ci;
  output co;
  wire w1,w2,w3;

  and(w1, a, b);
  and(w2, a, ci);
  and(w3, b, ci);
  or(co, w1, w2, w3);

endmodule
