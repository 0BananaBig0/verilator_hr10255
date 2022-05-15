/*************************************************************************
  > File Name: assign_connect_to_empty_signal.v
  > Author: 16hxliang3
  > Mail: 16hxliang3@stu.edu.cn 
  > Created Time: Mon 09 May 2022 03:31:11 PM CST
 ************************************************************************/
module assign_connect_to_empty_signal(a,b,c,d);
  input a,b;
  output c,d;
  submodule U1(.a(a),.b(),.e(c),.f());
endmodule

module submodule(a,b,e,f);
   input a,b;
   output e,f;
   assign e = a; // a and e not connect to a empty signal;
   assign e = b; // e not connect to a empty signal but b connect to;
   assign f = a; // a not connect to a empty signal but f connect to;
   assign f = b; // b and f both connect to a empty signal;
   assign c = a; // a not connect to a empty signal and c is a wire;
   assign d = b; // b connect to a empty signal and d is a wire;
endmodule
