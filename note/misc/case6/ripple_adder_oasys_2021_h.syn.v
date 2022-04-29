/*
 * Created by 
   ../bin/Linux-x86_64-O/oasysGui 21.1-p005 on Sun Dec  5 15:24:30 2021
 * (C) Mentor Graphics Corporation
 */
/* CheckSum: 3136148508 */

module full_adder_co(co, a, b, ci);
   output co;
   input a;
   input b;
   input ci;

   wire \n_0[0] ;
   wire \n_0[1] ;
   wire \n_0[2] ;
   wire d;
   assign d = 1'b0;

   INV_X1_LVT i_0_0 (.A(a), .ZN(\n_0[0] ));
   INV_X1_LVT i_0_1 (.A(b), .ZN(\n_0[1] ));
   INV_X1_LVT i_0_2 (.A(ci), .ZN(\n_0[2] ));
   OAI222_X1_LVT i_0_3 (.A1(\n_0[0] ), .A2(\n_0[1] ), .B1(\n_0[1] ), .B2(\n_0[2] ), .C1(
      \n_0[0] ), .C2(\n_0[2] ), .ZN(co));
endmodule

module full_adder_sum(sum, a, b, ci);
   output sum;
   input a;
   input b;
   input ci;

   wire [15:0]\DC_output[2] ;
   wire [15:0]\DC_output[1] ;
   assign \DC_output[2] [14] = 1'b0;

   XNOR2_X1_LVT i_0_0 (.A(a), .B(ci), .ZN(\DC_output[1] [15]));
   XNOR2_X1_LVT i_0_1 (.A(\DC_output[1] [15]), .B(b), .ZN(sum));
endmodule

module full_adder(co, sum, a, b, ci);
   output co;
   output sum;
   input a;
   input b;
   input ci;
   wire d;
   assign d = 1'b0;

   full_adder_co U1 (.co(co), .a(a), .b(b), .ci(ci));
   full_adder_sum U0 (.sum(sum), .a(a), .b(b), .ci(ci));
endmodule

module ripple_adder(co, SUM, A, B, ci);
   output co;
   output [3:0]SUM;
   input [3:0]A;
   input [3:0]B;
   input ci;

   wire [4:0]C;
   wire d;
   assign d = 1'b0;

   full_adder U0 (.co(C[1]), .sum(SUM[0]), .a(A[0]), .b(B[0]), .ci(ci));
   full_adder U1 (.co(C[2]), .sum(SUM[1]), .a(A[1]), .b(B[1]), .ci(C[1]));
   full_adder U2 (.co(C[3]), .sum(SUM[2]), .a(A[2]), .b(B[2]), .ci(C[2]));
   full_adder U3 (.co(co), .sum(SUM[3]), .a(A[3]), .b(B[3]), .ci(C[3]));
endmodule

module ripple_adder_twelve(co, SUM, A, B, ci);
   parameter n = 12;
   output co;
   output [n-1:0]SUM;
   input [n-1:0]A;
   input [n-1:0]B;
   input ci;

   wire [2:0]C;

   assign C[0] = ci;
   assign co = c_no_defined;

   ripple_adder U0(.co(C[1]), .SUM(SUM[3:0]), .A(A[3:0]), .B(B[3:0]), .ci(C[0]));
   ripple_adder U1(.co(C[2]), .SUM(SUM[7:4]), .A(A[7:4]), .B(B[7:4]), .ci(C[1]));
   ripple_adder U2(.co(c_no_defined), .SUM(SUM[11:8]), .A(A[11:8]), .B(B[11:8]), .ci(C[2]));
endmodule

module top(co, cco, SUM, A, B, ci);
   parameter n = 24;
   output co;
   inout cco;
   output [n+5:0]SUM;
   input [n-1:0]A;
   input [n-1:0]B;
   input ci;

   wire[9:0]C;
   wire[12:0]con;
   wire[3:0]con0;
   wire[3:0]con1;
   wire[3:0]con2;
   wire[3:0]con3;
   wire cci;
   wire ccco;
   wire cc;
   assign C[0] = 1'b0;
   assign C[2] = 1'b1;
   assign C[3] = ci;
   assign C[4] = 1'b0;
   assign cc = 1'b1;
   assign co = C[6];
   assign cci = ci;
   assign ccco = C[5];
   assign cco = ccco;
   assign con[0] = cci;
   assign con[1] = 1'b1;
   assign con[2] = 1'b1;
   assign con[3] = cco;
   assign con[4] = 1'b0;
   assign con[5] = ci;
   assign con[9:6] = 4'd3;
   assign con[10] = 1'b0;
   assign con[11] = 1'b0;
   assign con[12] = 1'b1;
   assign con0[0] = 1'b0;
   assign con0[3] = 1'b1;
   assign con0[1] = 1'b1;
   assign con0[2] = cco;
   assign con1[0] = 1'b0;
   assign con1[1] = 1'b0;
   assign con1[3] = 1'b1;
   assign con1[2] = cco;
   assign con2[0] = 1'b0;
   assign con2[1] = 1'b0;
   assign con2[2] = cco;
   assign con2[3] = 1'b1;
   assign con3[3:0] = {1'b1,con[8:6]};

  ripple_adder_twelve U1(.co(C[5]), .SUM(SUM[13:2]), .A({1'b0,1'b1,1'b0,1'b1,A[1],A[3],1'b0,A[8:4]}), .B({2'b00,2'b11,B[0],B[11:9],B[22:19]}),.ci(C[9]));
  ripple_adder_twelve U2(.co(C[6]), .SUM(SUM[25:14]), .A({A[0],A[2],A[18:9]}), .B({B[8:4],B[18:12]}),.ci(C[5]));
  full_adder U3(.co(C[1]), .sum(SUM[0]), .a(1'b1), .b(1'b0), .ci(C[2]));
  full_adder U4(.co(C[9]), .sum(SUM[1]), .a(C[0]), .b(C[3]), .ci(C[1]));
  full_adder_co U5(C[7], A[23], B[23], cci);
  ripple_adder U6(.co(C[8]), .SUM(SUM[29:26]), .A(A[22:19]), .B({B[3],B[2],B[1],cc}), .ci(C[0]));
  SDFF_X1_LVT U7(.D(), .SE(1'b0), .SI(1'b1), .CK(1'b1), .QN(), .Q());
  ripple_adder U8(.co(), .SUM(), .A({2'b0,ci,1'b0}), .B({1'b0,ci,1'b1,1'b1}), .ci());
  ripple_adder_twelve U9(.co(), .SUM(), .A({2'b00,ci,ci,2'b00,ci,ci,2'b00,ci,ci}), .B({1'b0,1'bz,ci,1'bx,8'b01xz1x0z}),.ci(1'bz));

  assign zn = 1'bz;
  assign xn = 1'bx;
  wire[63:0] slongv;
  wire[127:0] longv;
  wire[255:0] llongv;
  assign slongv = 64'd8589934593;
  assign longv = {slongv+1,slongv};
  assign llongv = {slongv,longv,slongv};
endmodule
