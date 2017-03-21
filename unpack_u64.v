module unpack_u64 (
  input      [ 7:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9,
  output reg [63:0] o,
  output reg [ 3:0] len
);

// i = $.wire()
reg [9:0] gl, ub, ho;
reg [6:0] c0, c1, c2, c3, c4, c5, c6, c7, c8, c9;
reg [6:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9;

always @* begin
  // gl = i.msb() // glue bits
  gl[0] = i0[7];
  gl[1] = i1[7];
  gl[2] = i2[7];
  gl[3] = i3[7];
  gl[4] = i4[7];
  gl[5] = i5[7];
  gl[6] = i6[7];
  gl[7] = i7[7];
  gl[8] = i8[7];
  gl[9] = i9[7];
  // c = i.lsb(7) // chunks
  c0 = i0[6:0];
  c1 = i1[6:0];
  c2 = i2[6:0];
  c3 = i3[6:0];
  c4 = i4[6:0];
  c5 = i5[6:0];
  c6 = i6[6:0];
  c7 = i7[6:0];
  c8 = i8[6:0];
  c9 = i9[6:0];

  // Used bytes
  ub[0] = 1;
  ub[1] =  gl[  0];
  ub[2] = &gl[1:0];
  ub[3] = &gl[2:0];
  ub[4] = &gl[3:0];
  ub[5] = &gl[4:0];
  ub[6] = &gl[5:0];
  ub[7] = &gl[6:0];
  ub[8] = &gl[7:0];
  ub[9] = &gl[8:0];

  // k = c.overwrite(dc, 0)
  k1 = ub[1] ? c1 : 7'b0;
  k2 = ub[2] ? c2 : 7'b0;
  k3 = ub[3] ? c3 : 7'b0;
  k4 = ub[4] ? c4 : 7'b0;
  k5 = ub[5] ? c5 : 7'b0;
  k6 = ub[6] ? c6 : 7'b0;
  k7 = ub[7] ? c7 : 7'b0;
  k8 = ub[8] ? c8 : 7'b0;
  k9 = ub[9] ? c9 : 7'b0;
  // o = k.glue()
  o = {k9, k8, k7, k6, k5, k4, k3, k2, k1, c0};

  // Get high order byte
  ho[0] = !ub[1] & ub[0];
  ho[1] = !ub[2] & ub[1];
  ho[2] = !ub[3] & ub[2];
  ho[3] = !ub[4] & ub[3];
  ho[4] = !ub[5] & ub[4];
  ho[5] = !ub[6] & ub[5];
  ho[6] = !ub[7] & ub[6];
  ho[7] = !ub[8] & ub[7];
  ho[8] = !ub[9] & ub[8];
  ho[9] =          ub[9];

  len[0] = ho[0] |         ho[2] |         ho[4]         | ho[6]         | ho[8];
  len[1] =         ho[1] | ho[2]                 | ho[5] | ho[6]                 | ho[9];
  len[2] =                         ho[3] | ho[4] | ho[5] | ho[6];
  len[3] =                                                         ho[7] | ho[8] | ho[9];
end

endmodule
