/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 21.1-p005 on Sun May 15 20:17:23 2022
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 237159021 */

module tristate_buffer_one(input_x, enable, output_x);
   input input_x;
   input enable;
   output output_x;

   INV_X1_LVT i_1_0 (.A(enable), .ZN(n_0));
   TBUF_X1_LVT i_0 (.A(input_x), .EN(n_0), .Z(output_x));
endmodule

module tristate_buffer_one__0_0(input_x, enable, output_x);
   input input_x;
   input enable;
   output output_x;

   INV_X1_LVT i_1_0 (.A(enable), .ZN(n_0));
   TBUF_X1_LVT i_0 (.A(input_x), .EN(n_0), .Z(output_x));
endmodule

module submodule(a, b);
   input a;
   output b;

   assign b = a;

endmodule

module tristate_buffer(input_x, enable, output_x);
   input [2:0]input_x;
   input [2:0]enable;
   output [2:0]output_x;

   wire n_3_0;

   OR3_X1_LVT i_3_1_0 (.A1(enable[0]), .A2(enable[1]), .A3(enable[2]), .ZN(n_3_0));
   INV_X1_LVT i_3_0 (.A(n_3_0), .ZN(n_0));
   TBUF_X1_LVT i_2 (.A(input_x[2]), .EN(n_0), .Z(output_x[2]));
   TBUF_X1_LVT i_1 (.A(input_x[1]), .EN(n_0), .Z(output_x[1]));
   TBUF_X1_LVT i_0 (.A(input_x[0]), .EN(n_0), .Z(output_x[0]));
endmodule

module top(input_x, enable, output_x);
   input [4:0]input_x;
   input [4:0]enable;
   output [4:0]output_x;

   tristate_buffer_one U1 (.input_x(input_x[3]), .enable(enable[3]), .output_x(
      output_x[3]));
   tristate_buffer_one__0_0 U2 (.input_x(input_x[4]), .enable(enable[4]), 
      .output_x(output_x[3]));
   submodule U3 (.a(output_x[3]), .b(output_x[4]));
   tristate_buffer U0 (.input_x({input_x[2], input_x[1], input_x[0]}), .enable({
      enable[2], enable[1], enable[0]}), .output_x({output_x[2], output_x[1], 
      output_x[0]}));
endmodule
