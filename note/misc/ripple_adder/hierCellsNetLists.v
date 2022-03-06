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

	assign C[0] = ci;

	full_adder U0 (.__pinNumber1(C[1]),.__pinNumber2(SUM[0]),.__pinNumber3(A[0]),.__pinNumber4(B[0]),.__pinNumber5(C[0]));
	full_adder U1 (.__pinNumber1(C[2]),.__pinNumber2(SUM[1]),.__pinNumber3(A[1]),.__pinNumber4(B[1]),.__pinNumber5(C[1]));
	full_adder U2 (.__pinNumber1(C[3]),.__pinNumber2(SUM[2]),.__pinNumber3(A[2]),.__pinNumber4(B[2]),.__pinNumber5(C[2]));
	full_adder U3 (.__pinNumber1(C[4]),.__pinNumber2(SUM[3]),.__pinNumber3(A[3]),.__pinNumber4(B[3]),.__pinNumber5(C[3]));
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



	full_adder_sum U0 (.__pinNumber1(sum),.__pinNumber2(a),.__pinNumber3(b),.__pinNumber4(ci));
	full_adder_co U1 (.__pinNumber1(co),.__pinNumber2(a),.__pinNumber3(b),.__pinNumber4(ci));
endmodule

