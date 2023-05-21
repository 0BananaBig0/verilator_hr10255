module typical_example(input3,input4,input5,input6,input7,input8,input9,input10,
      input11,inout0,inout1,inout2,output12,output13,output14,output15,output16,
      output17,output18);
   input input3;
   input input4;
   input input5;
   input input6;
   input input7;
   input input8;
   input input9;
   input [4:0]input10;
   input [4:0]input11;
   inout inout0;
   inout inout1;
   inout [4:0]inout2;
   output output12;
   output output13;
   output output14;
   output output15;
   output output16;
   output output17;
   output [10:0]output18;
   wire [13:0]wire19;
   wire wire20;
   wire wire21;
   wire wire22;
   wire wire23;
   wire wire24;
   wire wire25;
   wire wire26;
   wire wire27;
   wire wire28;
   wire wire29;
   wire wire30x;
   wire wire31z;
   wire wire32;
   wire wire33;
   wire wire34;
   wire wire35;
   wire wire36;
  assign wire34 = input3;
  assign wire35 = 1'bx;
  assign wire36 = 1'bz;
  assign inout2[4] = 1'b1;
  assign wire32 = 1'b0;
  assign wire33 = 1'b1;
  PADBID PADBID_U0 (.I(input3), .OEN(input4), .PAD(output18[5]), .C(wire19[0]));
  PADBID PADBID_U1 (.I(), .OEN(inout1), .PAD(inout1), .C());
  PADBID PADBID_U2 (.I(input3), .OEN(input4), .PAD(inout0), .C(wire19[2]));
  PADBID PADBID_U3 (.I(input3), .OEN(input4), .PAD(inout2[1]), .C());
  PADBID PADBID_U4 (.I(input3), .OEN(input4), .PAD(inout2[1]), .C());
  PADBID PADBID_U5 (.I(input3), .OEN(input4), .PAD(inout2[1]), .C());
  PADBID PADBID_U6 (.I(input3), .OEN(input4), .PAD(), .C(inout2[3]));
  PADBID PADBID_U7 (.I(input3), .OEN(input4), .PAD(inout2[3]), .C());
  PADBID PADBID_U8 (.I(input3), .OEN(input4), .PAD(wire19[6]), .C(wire19[5]));
  PADBID PADBID_U9 (.I(wire19[6]), .OEN(input4), .PAD(), .C(wire19[4]));
  PADBID PADBID_U10 (.I(input3), .OEN(input4), .PAD(), .C(wire19[3]));
  PADBID PADBID_U11 (.I(input3), .OEN(input4), .PAD(wire19[3]), .C(wire19[8]));
  PADBID PADBID_U12 (.I(input3), .OEN(input4), .PAD(wire19[9]), .C(wire19[13]));
  PADBID PADBID_U13 (.I(input3), .OEN(input4), .PAD(wire19[9]), .C(wire19[13]));
  PADBID PADBID_U14 (.I(input3), .OEN(input4), .PAD(wire19[10]), .C(wire19[13]));
  DFFRS_X1 DFFRS_X1_U15 (.CK(input6), .D(input7), .RN(input8), .SN(input9), .Q(
      output14), .QN(output15));
  FA_X1 FA_X1_U16 (.A(input3), .B(input4), .CI(input5), .CO(output16), .S(
      output17));
  AON_BUF_X1 AON_BUF_X1_U17 (.A(output18[3]), .Z(output18[4]));
  INV_X1_LVT INV_X1_LVT_U18 (.A(input11[3]), .ZN(wire20));
  TBUF_X1_LVT TBUF_X1_LVT_U19 (.A(input10[3]), .EN(wire20), .Z(output18[3]));
  INV_X1_LVT INV_X1_LVT_U20 (.A(input11[4]), .ZN(wire21));
  TBUF_X1_LVT TBUF_X1_LVT_U21 (.A(input10[4]), .EN(wire21), .Z(output18[3]));
  OR3_X1_LVT OR3_X1_LVT_U22 (.A1(input11[0]), .A2(input11[1]), .A3(input11[2]), 
      .ZN(wire22));
  INV_X1_LVT INV_X1_LVT_U23 (.A(wire22), .ZN(wire23));
  TBUF_X1_LVT TBUF_X1_LVT_U24 (.A(input10[2]), .EN(wire23), .Z(output18[2]));
  TBUF_X1_LVT TBUF_X1_LVT_U25 (.A(input10[1]), .EN(wire23), .Z(output18[1]));
  TBUF_X1_LVT TBUF_X1_LVT_U26 (.A(input10[0]), .EN(wire23), .Z(output18[0]));
  INV_X1_LVT INV_X1_LVT_U27 (.A(input3), .ZN(wire24));
  INV_X1_LVT INV_X1_LVT_U28 (.A(input5), .ZN(wire25));
  OAI222_X1_LVT OAI222_X1_LVT_U29 (.A1(wire24), .A2(wire26), .B1(wire26), .B2(
      wire25), .C1(wire24), .C2(wire25), .ZN(output12));
  XNOR2_X1_LVT XNOR2_X1_LVT_U30 (.A(input3), .B(input5), .ZN(wire27));
  XNOR2_X1_LVT XNOR2_X1_LVT_U31 (.A(wire27), .B(input4), .ZN(output13));
  INV_X1_LVT INV_X1_LVT_U32 (.A(1'b0), .ZN(wire28));
  INV_X1_LVT INV_X1_LVT_U33 (.A(1'b1), .ZN(wire29));
  INV_X1_LVT INV_X1_LVT_U34 (.A(1'bx), .ZN(wire30x));
  INV_X1_LVT INV_X1_LVT_U35 (.A(1'bz), .ZN(wire31z));
endmodule

