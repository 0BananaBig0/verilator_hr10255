/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : M-2016.12-SP5-1
// Date      : Tue May 26 11:57:01 2020
/////////////////////////////////////////////////////////////


module AOTOP (a,b,c,d,e);
  input a,b,c;
  output d,e;
  assign_only assign_only_U1(.a(a),.b(d));
endmodule

module assign_only(a,b);
  input a;
  output b;
  assign b = a;
endmodule
