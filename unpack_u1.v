module unpack_u1 (
  input [7:0] i0,
  output logic [0:0] o
);

// i = $.wire()
logic [0:0] gl;
logic [0:0] dc;
logic [0:0] c0;
logic [0:0] k0;

always @* begin
  // gl = i.msb() // glue bits
  gl[0] = i0[7];
  // c = i.lsb(7) // chunks
  c0 = i0[0:0];
  // dc = gl.expand.up()
  dc[0] = gl[0];
  // k = c.overwrite(dc, 0)
  k0 = dc[0] ? c0 : 1'b0;
  // o = k.glue()
  o = {k0};
end

endmodule
