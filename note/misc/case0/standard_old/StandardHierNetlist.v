module top(cco,A,B,ci,co,SUM);
   inout cco;
   input [23:0]A;
   input [23:0]B;
   input ci;
   output co;
   output [29:0]SUM;
   wire [9:0]C;
   wire [12:0]con;
   wire [3:0]con0;
   wire [3:0]con1;
   wire [3:0]con2;
   wire [3:0]con3;
   wire cci;
   wire ccco;
   wire cc;
   wire [63:0]slongv;
   wire [127:0]longv;
   wire [255:0]llongv;
   wire zn;
   wire xn;
  assign C[0] = 1'b0;
  assign C[2] = 1'b1;
  assign C[3] = ci;
  assign C[4] = 1'b0;
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
  assign con[9] = 1'b0;
  assign con[8] = 1'b0;
  assign con[7] = 1'b1;
  assign con[6] = 1'b1;
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
  assign con3[3] = 1'b1;
  assign con3[2] = con[8];
  assign con3[1] = con[7];
  assign con3[0] = con[6];
  assign zn = 1'bz;
  assign xn = 1'bx;
  assign cc = 1'b1;
  assign slongv[63] = 1'b0;
  assign slongv[62] = 1'b0;
  assign slongv[61] = 1'b0;
  assign slongv[60] = 1'b0;
  assign slongv[59] = 1'b0;
  assign slongv[58] = 1'b0;
  assign slongv[57] = 1'b0;
  assign slongv[56] = 1'b0;
  assign slongv[55] = 1'b0;
  assign slongv[54] = 1'b0;
  assign slongv[53] = 1'b0;
  assign slongv[52] = 1'b0;
  assign slongv[51] = 1'b0;
  assign slongv[50] = 1'b0;
  assign slongv[49] = 1'b0;
  assign slongv[48] = 1'b0;
  assign slongv[47] = 1'b0;
  assign slongv[46] = 1'b0;
  assign slongv[45] = 1'b0;
  assign slongv[44] = 1'b0;
  assign slongv[43] = 1'b0;
  assign slongv[42] = 1'b0;
  assign slongv[41] = 1'b0;
  assign slongv[40] = 1'b0;
  assign slongv[39] = 1'b0;
  assign slongv[38] = 1'b0;
  assign slongv[37] = 1'b0;
  assign slongv[36] = 1'b0;
  assign slongv[35] = 1'b0;
  assign slongv[34] = 1'b0;
  assign slongv[33] = 1'b1;
  assign slongv[32] = 1'b0;
  assign slongv[31] = 1'b0;
  assign slongv[30] = 1'b0;
  assign slongv[29] = 1'b0;
  assign slongv[28] = 1'b0;
  assign slongv[27] = 1'b0;
  assign slongv[26] = 1'b0;
  assign slongv[25] = 1'b0;
  assign slongv[24] = 1'b0;
  assign slongv[23] = 1'b0;
  assign slongv[22] = 1'b0;
  assign slongv[21] = 1'b0;
  assign slongv[20] = 1'b0;
  assign slongv[19] = 1'b0;
  assign slongv[18] = 1'b0;
  assign slongv[17] = 1'b0;
  assign slongv[16] = 1'b0;
  assign slongv[15] = 1'b0;
  assign slongv[14] = 1'b0;
  assign slongv[13] = 1'b0;
  assign slongv[12] = 1'b0;
  assign slongv[11] = 1'b0;
  assign slongv[10] = 1'b0;
  assign slongv[9] = 1'b0;
  assign slongv[8] = 1'b0;
  assign slongv[7] = 1'b0;
  assign slongv[6] = 1'b0;
  assign slongv[5] = 1'b0;
  assign slongv[4] = 1'b0;
  assign slongv[3] = 1'b0;
  assign slongv[2] = 1'b0;
  assign slongv[1] = 1'b0;
  assign slongv[0] = 1'b1;
  assign longv[127] = 1'b0;
  assign longv[126] = 1'b0;
  assign longv[125] = 1'b0;
  assign longv[124] = 1'b0;
  assign longv[123] = 1'b0;
  assign longv[122] = 1'b0;
  assign longv[121] = 1'b0;
  assign longv[120] = 1'b0;
  assign longv[119] = 1'b0;
  assign longv[118] = 1'b0;
  assign longv[117] = 1'b0;
  assign longv[116] = 1'b0;
  assign longv[115] = 1'b0;
  assign longv[114] = 1'b0;
  assign longv[113] = 1'b0;
  assign longv[112] = 1'b0;
  assign longv[111] = 1'b0;
  assign longv[110] = 1'b0;
  assign longv[109] = 1'b0;
  assign longv[108] = 1'b0;
  assign longv[107] = 1'b0;
  assign longv[106] = 1'b0;
  assign longv[105] = 1'b0;
  assign longv[104] = 1'b0;
  assign longv[103] = 1'b0;
  assign longv[102] = 1'b0;
  assign longv[101] = 1'b0;
  assign longv[100] = 1'b0;
  assign longv[99] = 1'b0;
  assign longv[98] = 1'b0;
  assign longv[97] = 1'b1;
  assign longv[96] = 1'b0;
  assign longv[95] = 1'b0;
  assign longv[94] = 1'b0;
  assign longv[93] = 1'b0;
  assign longv[92] = 1'b0;
  assign longv[91] = 1'b0;
  assign longv[90] = 1'b0;
  assign longv[89] = 1'b0;
  assign longv[88] = 1'b0;
  assign longv[87] = 1'b0;
  assign longv[86] = 1'b0;
  assign longv[85] = 1'b0;
  assign longv[84] = 1'b0;
  assign longv[83] = 1'b0;
  assign longv[82] = 1'b0;
  assign longv[81] = 1'b0;
  assign longv[80] = 1'b0;
  assign longv[79] = 1'b0;
  assign longv[78] = 1'b0;
  assign longv[77] = 1'b0;
  assign longv[76] = 1'b0;
  assign longv[75] = 1'b0;
  assign longv[74] = 1'b0;
  assign longv[73] = 1'b0;
  assign longv[72] = 1'b0;
  assign longv[71] = 1'b0;
  assign longv[70] = 1'b0;
  assign longv[69] = 1'b0;
  assign longv[68] = 1'b0;
  assign longv[67] = 1'b0;
  assign longv[66] = 1'b0;
  assign longv[65] = 1'b1;
  assign longv[64] = 1'b0;
  assign longv[63] = 1'b0;
  assign longv[62] = 1'b0;
  assign longv[61] = 1'b0;
  assign longv[60] = 1'b0;
  assign longv[59] = 1'b0;
  assign longv[58] = 1'b0;
  assign longv[57] = 1'b0;
  assign longv[56] = 1'b0;
  assign longv[55] = 1'b0;
  assign longv[54] = 1'b0;
  assign longv[53] = 1'b0;
  assign longv[52] = 1'b0;
  assign longv[51] = 1'b0;
  assign longv[50] = 1'b0;
  assign longv[49] = 1'b0;
  assign longv[48] = 1'b0;
  assign longv[47] = 1'b0;
  assign longv[46] = 1'b0;
  assign longv[45] = 1'b0;
  assign longv[44] = 1'b0;
  assign longv[43] = 1'b0;
  assign longv[42] = 1'b0;
  assign longv[41] = 1'b0;
  assign longv[40] = 1'b0;
  assign longv[39] = 1'b0;
  assign longv[38] = 1'b0;
  assign longv[37] = 1'b0;
  assign longv[36] = 1'b0;
  assign longv[35] = 1'b0;
  assign longv[34] = 1'b0;
  assign longv[33] = 1'b1;
  assign longv[32] = 1'b0;
  assign longv[31] = 1'b0;
  assign longv[30] = 1'b0;
  assign longv[29] = 1'b0;
  assign longv[28] = 1'b0;
  assign longv[27] = 1'b0;
  assign longv[26] = 1'b0;
  assign longv[25] = 1'b0;
  assign longv[24] = 1'b0;
  assign longv[23] = 1'b0;
  assign longv[22] = 1'b0;
  assign longv[21] = 1'b0;
  assign longv[20] = 1'b0;
  assign longv[19] = 1'b0;
  assign longv[18] = 1'b0;
  assign longv[17] = 1'b0;
  assign longv[16] = 1'b0;
  assign longv[15] = 1'b0;
  assign longv[14] = 1'b0;
  assign longv[13] = 1'b0;
  assign longv[12] = 1'b0;
  assign longv[11] = 1'b0;
  assign longv[10] = 1'b0;
  assign longv[9] = 1'b0;
  assign longv[8] = 1'b0;
  assign longv[7] = 1'b0;
  assign longv[6] = 1'b0;
  assign longv[5] = 1'b0;
  assign longv[4] = 1'b0;
  assign longv[3] = 1'b0;
  assign longv[2] = 1'b0;
  assign longv[1] = 1'b0;
  assign longv[0] = 1'b1;
  assign llongv[255] = 1'b0;
  assign llongv[254] = 1'b0;
  assign llongv[253] = 1'b0;
  assign llongv[252] = 1'b0;
  assign llongv[251] = 1'b0;
  assign llongv[250] = 1'b0;
  assign llongv[249] = 1'b0;
  assign llongv[248] = 1'b0;
  assign llongv[247] = 1'b0;
  assign llongv[246] = 1'b0;
  assign llongv[245] = 1'b0;
  assign llongv[244] = 1'b0;
  assign llongv[243] = 1'b0;
  assign llongv[242] = 1'b0;
  assign llongv[241] = 1'b0;
  assign llongv[240] = 1'b0;
  assign llongv[239] = 1'b0;
  assign llongv[238] = 1'b0;
  assign llongv[237] = 1'b0;
  assign llongv[236] = 1'b0;
  assign llongv[235] = 1'b0;
  assign llongv[234] = 1'b0;
  assign llongv[233] = 1'b0;
  assign llongv[232] = 1'b0;
  assign llongv[231] = 1'b0;
  assign llongv[230] = 1'b0;
  assign llongv[229] = 1'b0;
  assign llongv[228] = 1'b0;
  assign llongv[227] = 1'b0;
  assign llongv[226] = 1'b0;
  assign llongv[225] = 1'b1;
  assign llongv[224] = 1'b0;
  assign llongv[223] = 1'b0;
  assign llongv[222] = 1'b0;
  assign llongv[221] = 1'b0;
  assign llongv[220] = 1'b0;
  assign llongv[219] = 1'b0;
  assign llongv[218] = 1'b0;
  assign llongv[217] = 1'b0;
  assign llongv[216] = 1'b0;
  assign llongv[215] = 1'b0;
  assign llongv[214] = 1'b0;
  assign llongv[213] = 1'b0;
  assign llongv[212] = 1'b0;
  assign llongv[211] = 1'b0;
  assign llongv[210] = 1'b0;
  assign llongv[209] = 1'b0;
  assign llongv[208] = 1'b0;
  assign llongv[207] = 1'b0;
  assign llongv[206] = 1'b0;
  assign llongv[205] = 1'b0;
  assign llongv[204] = 1'b0;
  assign llongv[203] = 1'b0;
  assign llongv[202] = 1'b0;
  assign llongv[201] = 1'b0;
  assign llongv[200] = 1'b0;
  assign llongv[199] = 1'b0;
  assign llongv[198] = 1'b0;
  assign llongv[197] = 1'b0;
  assign llongv[196] = 1'b0;
  assign llongv[195] = 1'b0;
  assign llongv[194] = 1'b0;
  assign llongv[193] = 1'b0;
  assign llongv[192] = 1'b1;
  assign llongv[191] = 1'b0;
  assign llongv[190] = 1'b0;
  assign llongv[189] = 1'b0;
  assign llongv[188] = 1'b0;
  assign llongv[187] = 1'b0;
  assign llongv[186] = 1'b0;
  assign llongv[185] = 1'b0;
  assign llongv[184] = 1'b0;
  assign llongv[183] = 1'b0;
  assign llongv[182] = 1'b0;
  assign llongv[181] = 1'b0;
  assign llongv[180] = 1'b0;
  assign llongv[179] = 1'b0;
  assign llongv[178] = 1'b0;
  assign llongv[177] = 1'b0;
  assign llongv[176] = 1'b0;
  assign llongv[175] = 1'b0;
  assign llongv[174] = 1'b0;
  assign llongv[173] = 1'b0;
  assign llongv[172] = 1'b0;
  assign llongv[171] = 1'b0;
  assign llongv[170] = 1'b0;
  assign llongv[169] = 1'b0;
  assign llongv[168] = 1'b0;
  assign llongv[167] = 1'b0;
  assign llongv[166] = 1'b0;
  assign llongv[165] = 1'b0;
  assign llongv[164] = 1'b0;
  assign llongv[163] = 1'b0;
  assign llongv[162] = 1'b0;
  assign llongv[161] = 1'b1;
  assign llongv[160] = 1'b0;
  assign llongv[159] = 1'b0;
  assign llongv[158] = 1'b0;
  assign llongv[157] = 1'b0;
  assign llongv[156] = 1'b0;
  assign llongv[155] = 1'b0;
  assign llongv[154] = 1'b0;
  assign llongv[153] = 1'b0;
  assign llongv[152] = 1'b0;
  assign llongv[151] = 1'b0;
  assign llongv[150] = 1'b0;
  assign llongv[149] = 1'b0;
  assign llongv[148] = 1'b0;
  assign llongv[147] = 1'b0;
  assign llongv[146] = 1'b0;
  assign llongv[145] = 1'b0;
  assign llongv[144] = 1'b0;
  assign llongv[143] = 1'b0;
  assign llongv[142] = 1'b0;
  assign llongv[141] = 1'b0;
  assign llongv[140] = 1'b0;
  assign llongv[139] = 1'b0;
  assign llongv[138] = 1'b0;
  assign llongv[137] = 1'b0;
  assign llongv[136] = 1'b0;
  assign llongv[135] = 1'b0;
  assign llongv[134] = 1'b0;
  assign llongv[133] = 1'b0;
  assign llongv[132] = 1'b0;
  assign llongv[131] = 1'b0;
  assign llongv[130] = 1'b0;
  assign llongv[129] = 1'b1;
  assign llongv[128] = 1'b0;
  assign llongv[127] = 1'b0;
  assign llongv[126] = 1'b0;
  assign llongv[125] = 1'b0;
  assign llongv[124] = 1'b0;
  assign llongv[123] = 1'b0;
  assign llongv[122] = 1'b0;
  assign llongv[121] = 1'b0;
  assign llongv[120] = 1'b0;
  assign llongv[119] = 1'b0;
  assign llongv[118] = 1'b0;
  assign llongv[117] = 1'b0;
  assign llongv[116] = 1'b0;
  assign llongv[115] = 1'b0;
  assign llongv[114] = 1'b0;
  assign llongv[113] = 1'b0;
  assign llongv[112] = 1'b0;
  assign llongv[111] = 1'b0;
  assign llongv[110] = 1'b0;
  assign llongv[109] = 1'b0;
  assign llongv[108] = 1'b0;
  assign llongv[107] = 1'b0;
  assign llongv[106] = 1'b0;
  assign llongv[105] = 1'b0;
  assign llongv[104] = 1'b0;
  assign llongv[103] = 1'b0;
  assign llongv[102] = 1'b0;
  assign llongv[101] = 1'b0;
  assign llongv[100] = 1'b0;
  assign llongv[99] = 1'b0;
  assign llongv[98] = 1'b0;
  assign llongv[97] = 1'b1;
  assign llongv[96] = 1'b0;
  assign llongv[95] = 1'b0;
  assign llongv[94] = 1'b0;
  assign llongv[93] = 1'b0;
  assign llongv[92] = 1'b0;
  assign llongv[91] = 1'b0;
  assign llongv[90] = 1'b0;
  assign llongv[89] = 1'b0;
  assign llongv[88] = 1'b0;
  assign llongv[87] = 1'b0;
  assign llongv[86] = 1'b0;
  assign llongv[85] = 1'b0;
  assign llongv[84] = 1'b0;
  assign llongv[83] = 1'b0;
  assign llongv[82] = 1'b0;
  assign llongv[81] = 1'b0;
  assign llongv[80] = 1'b0;
  assign llongv[79] = 1'b0;
  assign llongv[78] = 1'b0;
  assign llongv[77] = 1'b0;
  assign llongv[76] = 1'b0;
  assign llongv[75] = 1'b0;
  assign llongv[74] = 1'b0;
  assign llongv[73] = 1'b0;
  assign llongv[72] = 1'b0;
  assign llongv[71] = 1'b0;
  assign llongv[70] = 1'b0;
  assign llongv[69] = 1'b0;
  assign llongv[68] = 1'b0;
  assign llongv[67] = 1'b0;
  assign llongv[66] = 1'b0;
  assign llongv[65] = 1'b0;
  assign llongv[64] = 1'b1;
  assign llongv[63] = 1'b0;
  assign llongv[62] = 1'b0;
  assign llongv[61] = 1'b0;
  assign llongv[60] = 1'b0;
  assign llongv[59] = 1'b0;
  assign llongv[58] = 1'b0;
  assign llongv[57] = 1'b0;
  assign llongv[56] = 1'b0;
  assign llongv[55] = 1'b0;
  assign llongv[54] = 1'b0;
  assign llongv[53] = 1'b0;
  assign llongv[52] = 1'b0;
  assign llongv[51] = 1'b0;
  assign llongv[50] = 1'b0;
  assign llongv[49] = 1'b0;
  assign llongv[48] = 1'b0;
  assign llongv[47] = 1'b0;
  assign llongv[46] = 1'b0;
  assign llongv[45] = 1'b0;
  assign llongv[44] = 1'b0;
  assign llongv[43] = 1'b0;
  assign llongv[42] = 1'b0;
  assign llongv[41] = 1'b0;
  assign llongv[40] = 1'b0;
  assign llongv[39] = 1'b0;
  assign llongv[38] = 1'b0;
  assign llongv[37] = 1'b0;
  assign llongv[36] = 1'b0;
  assign llongv[35] = 1'b0;
  assign llongv[34] = 1'b0;
  assign llongv[33] = 1'b1;
  assign llongv[32] = 1'b0;
  assign llongv[31] = 1'b0;
  assign llongv[30] = 1'b0;
  assign llongv[29] = 1'b0;
  assign llongv[28] = 1'b0;
  assign llongv[27] = 1'b0;
  assign llongv[26] = 1'b0;
  assign llongv[25] = 1'b0;
  assign llongv[24] = 1'b0;
  assign llongv[23] = 1'b0;
  assign llongv[22] = 1'b0;
  assign llongv[21] = 1'b0;
  assign llongv[20] = 1'b0;
  assign llongv[19] = 1'b0;
  assign llongv[18] = 1'b0;
  assign llongv[17] = 1'b0;
  assign llongv[16] = 1'b0;
  assign llongv[15] = 1'b0;
  assign llongv[14] = 1'b0;
  assign llongv[13] = 1'b0;
  assign llongv[12] = 1'b0;
  assign llongv[11] = 1'b0;
  assign llongv[10] = 1'b0;
  assign llongv[9] = 1'b0;
  assign llongv[8] = 1'b0;
  assign llongv[7] = 1'b0;
  assign llongv[6] = 1'b0;
  assign llongv[5] = 1'b0;
  assign llongv[4] = 1'b0;
  assign llongv[3] = 1'b0;
  assign llongv[2] = 1'b0;
  assign llongv[1] = 1'b0;
  assign llongv[0] = 1'b1;
  ripple_adder_twelve U1 (.A({1'b0,1'b1,1'b0,1'b1,A[1],A[3],1'b0,A[8],A[7],A[6],
      A[5],A[4]}), .B({1'b0,1'b0,1'b1,1'b1,B[0],B[11],B[10],B[9],B[22],B[21],
      B[20],B[19]}), .ci(C[9]), .co(C[5]), .SUM({SUM[13],SUM[12],SUM[11],SUM[10],
      SUM[9],SUM[8],SUM[7],SUM[6],SUM[5],SUM[4],SUM[3],SUM[2]}));
  ripple_adder_twelve U2 (.A({A[0],A[2],A[18],A[17],A[16],A[15],A[14],A[13],A[12],
      A[11],A[10],A[9]}), .B({B[8],B[7],B[6],B[5],B[4],B[18],B[17],B[16],B[15],
      B[14],B[13],B[12]}), .ci(C[5]), .co(C[6]), .SUM({SUM[25],SUM[24],SUM[23],
      SUM[22],SUM[21],SUM[20],SUM[19],SUM[18],SUM[17],SUM[16],SUM[15],SUM[14]}));
  full_adder U3 (.a(1'b1), .b(1'b0), .ci(C[2]), .co(C[1]), .sum(SUM[0]));
  full_adder U4 (.a(C[0]), .b(C[3]), .ci(C[1]), .co(C[9]), .sum(SUM[1]));
  full_adder_co U5 (.a(A[23]), .b(B[23]), .ci(cci), .co(C[7]));
  ripple_adder U6 (.A({A[22],A[21],A[20],A[19]}), .B({B[3],B[2],B[1],1'b1}), .ci(
      C[0]), .co(C[8]), .SUM({SUM[29],SUM[28],SUM[27],SUM[26]}));
  SDFF_X1_LVT U7 (.CK(1'b1), .D(), .SE(1'b0), .SI(1'b1), .Q(), .QN());
  ripple_adder U8 (.A({1'b0,1'b0,ci,1'b0}), .B({1'b0,ci,1'b1,1'b1}), .ci(), .co(), 
      .SUM());
  ripple_adder_twelve U9 (.A({1'b0,1'b0,ci,ci,1'b0,1'b0,ci,ci,1'b0,1'b0,ci,ci}), 
      .B({1'b0,1'bz,ci,1'bx,1'b0,1'b1,1'bx,1'bz,1'b1,1'bx,1'b0,1'bz}), .ci(1'bz), 
      .co(), .SUM());
endmodule

module ripple_adder_twelve(A,B,ci,co,SUM);
   input [11:0]A;
   input [11:0]B;
   input ci;
   output co;
   output [11:0]SUM;
   wire [2:0]C;
   wire c_no_defined;
  assign C[0] = ci;
  assign co = c_no_defined;
  ripple_adder U0 (.A({A[3],A[2],A[1],A[0]}), .B({B[3],B[2],B[1],B[0]}), .ci(C[0]), 
      .co(C[1]), .SUM({SUM[3],SUM[2],SUM[1],SUM[0]}));
  ripple_adder U1 (.A({A[7],A[6],A[5],A[4]}), .B({B[7],B[6],B[5],B[4]}), .ci(
      C[1]), .co(C[2]), .SUM({SUM[7],SUM[6],SUM[5],SUM[4]}));
  ripple_adder U2 (.A({A[11],A[10],A[9],A[8]}), .B({B[11],B[10],B[9],B[8]}), .ci(
      C[2]), .co(c_no_defined), .SUM({SUM[11],SUM[10],SUM[9],SUM[8]}));
endmodule

module ripple_adder(A,B,ci,co,SUM);
   input [3:0]A;
   input [3:0]B;
   input ci;
   output co;
   output [3:0]SUM;
   wire [4:0]C;
   wire d;
  assign d = 1'b0;
  full_adder U0 (.a(A[0]), .b(B[0]), .ci(ci), .co(C[1]), .sum(SUM[0]));
  full_adder U1 (.a(A[1]), .b(B[1]), .ci(C[1]), .co(C[2]), .sum(SUM[1]));
  full_adder U2 (.a(A[2]), .b(B[2]), .ci(C[2]), .co(C[3]), .sum(SUM[2]));
  full_adder U3 (.a(A[3]), .b(B[3]), .ci(C[3]), .co(co), .sum(SUM[3]));
endmodule

module full_adder(a,b,ci,co,sum);
   input a;
   input b;
   input ci;
   output co;
   output sum;
   wire d;
  assign d = 1'b0;
  full_adder_co U1 (.a(a), .b(b), .ci(ci), .co(co));
  full_adder_sum U0 (.a(a), .b(b), .ci(ci), .sum(sum));
endmodule

module full_adder_co(a,b,ci,co);
   input a;
   input b;
   input ci;
   output co;
   wire \n_0[0] ;
   wire \n_0[1] ;
   wire \n_0[2] ;
   wire d;
  assign d = 1'b0;
  INV_X1_LVT i_0_0 (.A(a), .ZN(\n_0[0] ));
  INV_X1_LVT i_0_1 (.A(b), .ZN(\n_0[1] ));
  INV_X1_LVT i_0_2 (.A(ci), .ZN(\n_0[2] ));
  OAI222_X1_LVT i_0_3 (.A1(\n_0[0] ), .A2(\n_0[1] ), .B1(\n_0[1] ), .B2(\n_0[2] ), 
      .C1(\n_0[0] ), .C2(\n_0[2] ), .ZN(co));
endmodule

module full_adder_sum(a,b,ci,sum);
   input a;
   input b;
   input ci;
   output sum;
   wire [15:0]\DC_output[2] ;
   wire [15:0]\DC_output[1] ;
  assign \DC_output[2] [14] = 1'b0;
  XNOR2_X1_LVT i_0_0 (.A(a), .B(ci), .ZN(\DC_output[1] [15]));
  XNOR2_X1_LVT i_0_1 (.A(\DC_output[1] [15]), .B(b), .ZN(sum));
endmodule
