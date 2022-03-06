module full_adder_co(co,a,b,ci);
	 output co;
	 input a;
	 input b;
	 input ci;

	 wire w1;
	 wire w2;
	 wire w3;


endmodule

module ripple_adder(co,SUM,ci,A,B);
	 output co;
	 output [3:0]SUM;
	 input ci;
	 input [3:0]A;
	 input [3:0]B;

	 wire [31:0]n;
	 wire c1;
	 wire c2;
	 wire c3;
	 wire [4:0]C;
	 wire U0_U1_w1;
	 wire U0_U1_w2;
	 wire U0_U1_w3;
	 wire U1_U1_w1;
	 wire U1_U1_w2;
	 wire U1_U1_w3;
	 wire U2_U1_w1;
	 wire U2_U1_w2;
	 wire U2_U1_w3;
	 wire U3_U1_w1;
	 wire U3_U1_w2;
	 wire U3_U1_w3;

	assign C[0] = ci;

endmodule

module full_adder_sum(sum,a,b,ci);
	 output sum;
	 input a;
	 input b;
	 input ci;



endmodule

module full_adder(sum,co,a,b,ci);
	 output sum;
	 output co;
	 input a;
	 input b;
	 input ci;

	 wire U1_w1;
	 wire U1_w2;
	 wire U1_w3;


endmodule

