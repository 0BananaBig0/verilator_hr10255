module test(a, b);
  input[1:4] a;
  output[3:0] b;
  wire[0:3] c;
  wire[4:1] c1;
  wire[3:1] c2;
  assign c = a;
  assign c1 = a;
  assign c2 = a[1:3];
  test2 U0({3'b000,c2[3:2],3'b000,a[1],a[2],a[4],a[3],c[0],c[1]},{b[1:0],b[2],b[3],c[3],c[2],c1[1],c1[2],c1[4:3],c2});
endmodule
module test2(a, b);
  input[0:13] a;
  output[12:0] b;
  assign b[12:0] = a[0:12];
endmodule
