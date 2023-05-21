module typical_example(inout0,inout1,inout2,input3,input4,input5,input6,
  input7,input8,input9,input10,input11,output12,
  output13,output14,output15,output16,output17,
  output18);
   inout inout0;
   inout inout1;
   inout [4:0] inout2;
   input input3;
   input input4;
   input input5;
   input input6;
   input input7;
   input input8;
   input input9;
   input [4:0]input10;
   input [4:0]input11;
   output output12;
   output output13;
   output output14;
   output output15;
   output output16;
   output output17;
   output [10:0]output18;
   wire [13:0]wire19;
  // Top port is input connecting to an ins inout: the ins inout is used as
  // input.
  // PADBID PADBID_U1 (.PAD(input10[0]), .I(a), .OEN(input4), .C(wire19[1]));

  // Top port is output connecting to an ins inout: the ins inout is used as
  // output.
  PADBID PADBID_U0 (.PAD(output18[5]), .I(input3), .OEN(input4), .C(wire19[0]));

  // Top port is inout connecting to an ins inout and an ins input: the ins
  // inout and top inout are both used as inout.
  PADBID PADBID_U1 (.PAD(inout1), .I(), .OEN(inout1), .C());
  // Top port is inout connecting to an ins inout: the ins inout and top
  // inout are both used as inout.
  PADBID PADBID_U2 (.PAD(inout0), .I(input3), .OEN(input4), .C(wire19[2]));
  // Top port is inout connecting to multiple ins inouts: all inouts
  // including top inout are used as input.
  PADBID PADBID_U3 (.PAD(inout2[1]), .I(input3), .OEN(input4), .C());
  PADBID PADBID_U4 (.PAD(inout2[1]), .I(input3), .OEN(input4), .C());
  PADBID PADBID_U5 (.PAD(inout2[1]), .I(input3), .OEN(input4), .C());
  // Top port is inout connecting to an ins inout and an ins output: the ins
  // inout is used as input and the top inout is used as inout.
  PADBID PADBID_U6 (.PAD(), .I(input3), .OEN(input4), .C(inout2[3]));
  PADBID PADBID_U7 (.PAD(inout2[3]), .I(input3), .OEN(input4), .C());

  // Top port is wire connection to an ins inout and an ins input: the ins
  // inout is used as output.
  PADBID PADBID_U8 (.PAD(wire19[6]), .I(input3), .OEN(input4), .C(wire19[5]));
  PADBID PADBID_U9 (.PAD(), .I(wire19[6]), .OEN(input4), .C(wire19[4]));
  // Top port is wire connecting to an ins inout and an ins output: the ins
  // inout is used as input.
  PADBID PADBID_U10 (.PAD(), .I(input3), .OEN(input4), .C(wire19[3]));
  PADBID PADBID_U11 (.PAD(wire19[3]), .I(input3), .OEN(input4), .C(wire19[8]));
  // Top port is wire connecting to two ins inouts: both ins
  // inouts are used as inout.
  PADBID PADBID_U12 (.PAD(wire19[9]), .I(input3), .OEN(input4), .C(wire19[13]));
  PADBID PADBID_U13 (.PAD(wire19[9]), .I(input3), .OEN(input4), .C(wire19[13]));
  // Top port is wire connecting to an ins inout: the ins inout is used as
  // inout
  PADBID PADBID_U14 (.PAD(wire19[10]), .I(input3), .OEN(input4), .C(wire19[13]));
  DFFRS_X1 DFFRS_X1_U15 (.CK(input6), .D(input7), .RN(input8), .SN(input9), .Q(output14), .QN(output15));
  FA_X1 FA_X1_U16 (.A(input3), .B(input4), .CI(input5), .CO(output16), .S(output17));
  AON_BUF_X1 AON_BUF_X1_U17 (.A(output18[3]), .Z(output18[4]));
  INV_X1_LVT INV_X1_LVT_U18 (.A(input11[3]), .ZN(wire20));
  TBUF_X1_LVT TBUF_X1_LVT_U19 (.A(input10[3]), .EN(wire20), .Z(output18[3]));
  INV_X1_LVT INV_X1_LVT_U20 (.A(input11[4]), .ZN(wire21));
  TBUF_X1_LVT TBUF_X1_LVT_U21 (.A(input10[4]), .EN(wire21), .Z(output18[3]));
  OR3_X1_LVT OR3_X1_LVT_U22 (.A1(input11[0]), .A2(input11[1]), .A3(input11[2]), .ZN(
      wire22));
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
  assign wire32 = 1'b0;
  assign wire33 = 1'b1;
  assign wire34 = input3;
  assign wire35 = 1'bx;
  assign wire36 = 1'bz;
  assign inout2[4] = 1'b1;
endmodule
