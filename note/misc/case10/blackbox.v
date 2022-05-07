/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : M-2016.12-SP5-1
// Date      : Tue May 26 11:57:01 2020
/////////////////////////////////////////////////////////////


module BBTOP ( a,b,c,d,e );
  input a,b,c;
  output d,e;
  XOR2_X2_HVT XOR2_X2_HVT_U1(d,a,b);
  XNOR2_X2_HVT XNOR2_X2_HVT_U2(e,b,c);
  blackbox blackbox_U1 (.a(),.b(),.c());
endmodule

module blackbox(a,b,c);
  input a;
  inout b;
  output c;
endmodule;
