module unpack_i32 (
  input        [7:0] i0, i1, i2, i3, i4,
  output reg  [31:0] o,
  output wire  [2:0] len
);

  wire[31:0] u32_output;

  reg [4:0] gl, ub, ho, sb;
  reg [6:0] l0, l1, l2, l3, l4;

  unpack_u32 u32(i0, i1, i2, i3, i4, u32_output, len);

  always @* begin
    // Glue bits
    gl[0] = i0[7];
    gl[1] = i1[7];
    gl[2] = i2[7];
    gl[3] = i3[7];
    gl[4] = i4[7];

    // Used bytes
    ub[0] = 1;
    ub[1] = gl[0];
    ub[2] = gl[1];
    ub[3] = gl[2];
    ub[4] = gl[3];

    // Get high order byte
    ho[0] = !gl[0] & ub[0];
    ho[1] = !gl[1] & ub[1];
    ho[2] = !gl[2] & ub[2];
    ho[3] = !gl[3] & ub[3];
    ho[4] = !gl[4] & ub[4];

    // Get sign bit from high order byte
    sb[0] = ho[0] & i0[6];
    sb[1] = ho[1] & i1[6];
    sb[2] = ho[2] & i2[6];
    sb[3] = ho[3] & i3[6];
    sb[4] = ho[4] & i4[6];

    // If number is negative, extend sign to left
    if(|sb) begin
      l0 = ub[0] ? i0[6:0] : 7'b1111111;
      l1 = ub[1] ? i1[6:0] : 7'b1111111;
      l2 = ub[2] ? i2[6:0] : 7'b1111111;
      l3 = ub[3] ? i3[6:0] : 7'b1111111;
      l4 = ub[4] ? i4[6:0] : 7'b1111111;

      o = {l4, l3, l2, l1, l0};
    end
    else
      o = u32_output;
  end

endmodule
