/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : M-2016.12-SP5-1
// Date      : Tue May 26 11:57:01 2020
/////////////////////////////////////////////////////////////


module s27 ( VDD, CK, G0, G1, G17, G2, G3 );
  input VDD, CK, G0, G1, G2, G3;
  output G17;
  wire   G5, G10, G6, G11, G7, G13, G14, G8, G15, G12, G16, G9;

  DFFHQX1 DFF_0_I1_Q_reg ( .D(G10), .CK(CK), .Q(G5) );
  DFFHQX1 DFF_1_I1_Q_reg ( .D(G11), .CK(CK), .Q(G6) );
  DFFHQX1 DFF_2_I1_Q_reg ( .D(G13), .CK(CK), .Q(G7) );

  DFFHQX1 DFF_3_I1_Q_reg ( .D(G5), .CK(CK), .Q() );

  // DFFHQX1 DFF_3_I1_Q_reg ( .D(G10), .CK(CK), .Q() );
  // DFFHQX1 DFF_4_I1_Q_reg ( .D(G11), .CK(CK), .Q() );
  // DFFHQX1 DFF_5_I1_Q_reg ( .D(G13), .CK(CK), .Q() );
  
  // DFFHQX1 DFF_6_I1_Q_reg ( .D(G10), .CK(CK), .Q() );
  // DFFHQX1 DFF_7_I1_Q_reg ( .D(G11), .CK(CK), .Q() );
  // DFFHQX1 DFF_8_I1_Q_reg ( .D(G13), .CK(CK), .Q() );
  
  INVX1 NOT_0_U1 ( .A(G0), .Y(G14) );
  INVX1 NOT_1_U1 ( .A(G11), .Y(G17) );
  AND2X1 AND2_0_U1 ( .A(G6), .B(G14), .Y(G8) );
  OR2X1 OR2_0_U1 ( .A(G12), .B(G8), .Y(G15) );
  OR2X1 OR2_1_U1 ( .A(G3), .B(G8), .Y(G16) );
  NAND2X1 NAND2_0_U1 ( .A(G15), .B(G16), .Y(G9) );
  NOR2X1 NOR2_0_U1 ( .A(G11), .B(G14), .Y(G10) );
  NOR2X1 NOR2_1_U1 ( .A(G9), .B(G5), .Y(G11) );
  NOR2X1 NOR2_2_U1 ( .A(G7), .B(G1), .Y(G12) );
  NOR2X1 NOR2_3_U1 ( .A(G12), .B(G2), .Y(G13) );
endmodule

