module unpack_u32 (
  input [7:0] i0, i1, i2, i3, i4,
  output logic [31:0] o,
  output logic [ 2:0] len  // TODO make zero-based index instead of off-by-one
);

// i = $.wire()
logic [4:0] gl, dc, ho;
logic [6:0] c0, c1, c2, c3, c4;
logic [6:0] k0, k1, k2, k3, k4;

always @* begin
  // gl = i.msb() // glue bits
  gl[0] = i0[7];
  gl[1] = i1[7];
  gl[2] = i2[7];
  gl[3] = i3[7];
  gl[4] = i4[7];
  // c = i.lsb(7) // chunks
  c0 = i0[6:0];
  c1 = i1[6:0];
  c2 = i2[6:0];
  c3 = i3[6:0];
  c4 = i4[6:0];
  // dc = gl.expand.up()
  dc[0] = gl[0];
  dc[1] = gl[0] | gl[1];
  dc[2] = gl[0] | gl[1] | gl[2];
  dc[3] = gl[0] | gl[1] | gl[2] | gl[3];
  dc[4] = gl[0] | gl[1] | gl[2] | gl[3] | gl[4];
  // k = c.overwrite(dc, 0)
  k0 = dc[0] ? c0 : 7'b0;
  k1 = dc[1] ? c1 : 7'b0;
  k2 = dc[2] ? c2 : 7'b0;
  k3 = dc[3] ? c3 : 7'b0;
  k4 = dc[4] ? c4 : 7'b0;
  // o = k.glue()
  o = {k4, k3, k2, k1, k0};

  // Get high order byte
  ho[0] = !gl[0];
  ho[1] = !gl[1] & gl[0];
  ho[2] = !gl[2] & gl[1];
  ho[3] = !gl[3] & gl[2];
  ho[4] = !gl[4] & gl[3];

  len[0] = ho[0] |         ho[2] |         ho[4];
  len[1] =         ho[1] | ho[2]                ;
  len[2] =                         ho[3] | ho[4];
end

endmodule
