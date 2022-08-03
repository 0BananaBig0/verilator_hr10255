module vector_order(a,b);
   input [3:0]a;
   output [3:0]b;
   wire [3:0]c;
   wire [3:0]c1;
   wire [2:0]c2;
  assign c[3] = a[3];
  assign c[2] = a[2];
  assign c[1] = a[1];
  assign c[0] = a[0];
  assign c1[3] = a[3];
  assign c1[2] = a[2];
  assign c1[1] = a[1];
  assign c1[0] = a[0];
  assign c2[2] = a[3];
  assign c2[1] = a[2];
  assign c2[0] = a[1];
  vector_order_sub U0 (.a({1'b0,1'b0,1'b0,c2[2],c2[1],1'b0,1'b0,1'b0,a[3],a[2],
      a[0],a[1],c[3],c[2]}), .b({b[1],b[0],b[2],b[3],c[0],c[1],c1[0],c1[1],c1[3],
      c1[2],c2[2],c2[1],c2[0]}));
endmodule

module vector_order_sub(a,b);
   input [13:0]a;
   output [12:0]b;
  assign b[12] = a[13];
  assign b[11] = a[12];
  assign b[10] = a[11];
  assign b[9] = a[10];
  assign b[8] = a[9];
  assign b[7] = a[8];
  assign b[6] = a[7];
  assign b[5] = a[6];
  assign b[4] = a[5];
  assign b[3] = a[4];
  assign b[2] = a[3];
  assign b[1] = a[2];
  assign b[0] = a[1];
endmodule

