module pack_u32 (
  input [31:0] idata,
  output logic [7:0] o0, o1, o2, o3, o4,
  output logic [2:0] len
);

logic [6:0] c0, c1, c2, c3, c4; // 7-bit chunks
logic z1, z2, z3, z4; // zero flags

// idata = $.wire()
always_comb begin
  // c = idata.chop(7, {pad:0})
  {c4, c3, c2, c1, c0} = idata;
  // z = $.map(c, e => e.or())
  z1 = (|c1);
  z2 = (|c2);
  z3 = (|c3);
  z3 = (|c4);
  // len =
  len = z4 ? 5 : (z3 ? 4 : (z2 ? 3 : (z1 ? 2 : 1)));
  // o = $.map(c, (e, i) => z.high(i).or().glue(e))
  o0 = {(z4 | z3 | z2 | z1), c0};
  o1 = {(z4 | z3 | z2),      c1};
  o2 = {(z4 | z3),           c2};
  o3 = {z4,                  c3};
  o4 = {1'b0,                c4};
end

endmodule
