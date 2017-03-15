module unpack_u7 (
  input      [7:0] i0,
  output reg [6:0] o
);

// i = $.wire()
reg [0:0] gl;
reg [0:0] dc;
reg [6:0] c0;
reg [6:0] k0;

always @* begin
  // gl = i.msb() // glue bits
  gl[0] = i0[7];
  // c = i.lsb(7) // chunks
  c0 = i0[6:0];
  // dc = gl.expand.up()
  dc[0] = gl[0];
  // k = c.overwrite(dc, 0)
  k0 = dc[0] ? c0 : 7'b0;
  // o = k.glue()
  o = {k0};
end

endmodule
