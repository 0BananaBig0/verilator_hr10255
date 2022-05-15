module top(input_x,enable,output_x);
   input [4:0]input_x;
   input [4:0]enable;
   output [4:0]output_x;
   wire U1_n_0;
   wire U2_n_0;
   wire U0_n_3_0;
   wire U0_n_0;
  assign output_x[4] = output_x[3];
  INV_X1_LVT U1_i_1_0 (.A(enable[3]), .ZN(U1_n_0));
  TBUF_X1_LVT U1_i_0 (.A(input_x[3]), .EN(U1_n_0), .Z(output_x[3]));
  INV_X1_LVT U2_i_1_0 (.A(enable[4]), .ZN(U2_n_0));
  TBUF_X1_LVT U2_i_0 (.A(input_x[4]), .EN(U2_n_0), .Z(output_x[3]));
  OR3_X1_LVT U0_i_3_1_0 (.A1(enable[0]), .A2(enable[1]), .A3(enable[2]), .ZN(
      U0_n_3_0));
  INV_X1_LVT U0_i_3_0 (.A(U0_n_3_0), .ZN(U0_n_0));
  TBUF_X1_LVT U0_i_2 (.A(input_x[2]), .EN(U0_n_0), .Z(output_x[2]));
  TBUF_X1_LVT U0_i_1 (.A(input_x[1]), .EN(U0_n_0), .Z(output_x[1]));
  TBUF_X1_LVT U0_i_0 (.A(input_x[0]), .EN(U0_n_0), .Z(output_x[0]));
endmodule

