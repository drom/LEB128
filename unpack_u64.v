module unpack_u64 (
  input [7:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9,
  output logic [63:0] o,
  output logic [ 3:0] len
);

// i = $.wire()
logic [9:0] gl, ho;
logic [9:1] dc;
logic [6:0] c0, c1, c2, c3, c4, c5, c6, c7, c8, c9;
logic [6:0] k0, k1, k2, k3, k4, k5, k6, k7, k8, k9;

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
  // dc = gl.expand.up()
  dc[1] = gl[0];
  dc[2] = gl[0] | gl[1];
  dc[3] = gl[0] | gl[1] | gl[2];
  dc[4] = gl[0] | gl[1] | gl[2] | gl[3];
  dc[5] = gl[0] | gl[1] | gl[2] | gl[3] | gl[4];
  dc[6] = gl[0] | gl[1] | gl[2] | gl[3] | gl[4] | gl[5];
  dc[7] = gl[0] | gl[1] | gl[2] | gl[3] | gl[4] | gl[5] | gl[6];
  dc[8] = gl[0] | gl[1] | gl[2] | gl[3] | gl[4] | gl[5] | gl[6] | gl[7];
  dc[9] = gl[0] | gl[1] | gl[2] | gl[3] | gl[4] | gl[5] | gl[6] | gl[7] | gl[8];
  // k = c.overwrite(dc, 0)
  k1 = dc[1] ? c1 : 7'b0;
  k2 = dc[2] ? c2 : 7'b0;
  k3 = dc[3] ? c3 : 7'b0;
  k4 = dc[4] ? c4 : 7'b0;
  k5 = dc[5] ? c5 : 7'b0;
  k6 = dc[6] ? c6 : 7'b0;
  k7 = dc[7] ? c7 : 7'b0;
  k8 = dc[8] ? c8 : 7'b0;
  k9 = dc[9] ? c9 : 7'b0;
  // o = k.glue()
  o = {k9, k8, k7, k6, k5, k4, k3, k2, k1, c0};

  // Get high order byte
  ho[0] = !gl[0];
  ho[1] = !gl[1] & gl[0];
  ho[2] = !gl[2] & gl[1];
  ho[3] = !gl[3] & gl[2];
  ho[4] = !gl[4] & gl[3];
  ho[5] = !gl[5] & gl[4];
  ho[6] = !gl[6] & gl[5];
  ho[7] = !gl[7] & gl[6];
  ho[8] = !gl[8] & gl[7];
  ho[9] = !gl[9] & gl[8];

  len[0] = ho[0] |         ho[2] |         ho[4]         | ho[6]         | ho[8];
  len[1] =         ho[1] | ho[2]                 | ho[5] | ho[6]                 | ho[9];
  len[2] =                         ho[3] | ho[4] | ho[5] | ho[6];
  len[3] =                                                         ho[7] | ho[8] | ho[9];
end

endmodule
