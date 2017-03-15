module unpack_i64 (
  input [7:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9,
  output logic [63:0] o,
  output wire  [ 3:0] len
);

  wire[63:0] u64_output;

  logic [9:0] gl, ub, ho, sb;
  logic [6:0] l0, l1, l2, l3, l4, l5, l6, l7, l8, l9;

  unpack_u64 u64(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, u64_output, len);

  always @* begin
    // Glue bits
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

    // Used bytes
    ub[0] = 1;
    ub[1] = gl[0];
    ub[2] = gl[1];
    ub[3] = gl[2];
    ub[4] = gl[3];
    ub[5] = gl[4];
    ub[6] = gl[5];
    ub[7] = gl[6];
    ub[8] = gl[7];
    ub[9] = gl[8];

    // Get high order byte
    ho[0] = !gl[0] & ub[0];
    ho[1] = !gl[1] & ub[1];
    ho[2] = !gl[2] & ub[2];
    ho[3] = !gl[3] & ub[3];
    ho[4] = !gl[4] & ub[4];
    ho[5] = !gl[5] & ub[5];
    ho[6] = !gl[6] & ub[6];
    ho[7] = !gl[7] & ub[7];
    ho[8] = !gl[8] & ub[8];
    ho[9] = !gl[9] & ub[9];

    // Get sign bit from high order byte
    sb[0] = ho[0] & i0[6];
    sb[1] = ho[1] & i1[6];
    sb[2] = ho[2] & i2[6];
    sb[3] = ho[3] & i3[6];
    sb[4] = ho[4] & i4[6];
    sb[5] = ho[5] & i5[6];
    sb[6] = ho[6] & i6[6];
    sb[7] = ho[7] & i7[6];
    sb[8] = ho[8] & i8[6];
    sb[9] = ho[9] & i9[6];

    // If number is negative, extend sign to left
    if(|sb) begin
      l0 = ub[0] ? i0[6:0] : ~0;
      l1 = ub[1] ? i1[6:0] : ~0;
      l2 = ub[2] ? i2[6:0] : ~0;
      l3 = ub[3] ? i3[6:0] : ~0;
      l4 = ub[4] ? i4[6:0] : ~0;
      l5 = ub[5] ? i5[6:0] : ~0;
      l6 = ub[6] ? i6[6:0] : ~0;
      l7 = ub[7] ? i7[6:0] : ~0;
      l8 = ub[8] ? i8[6:0] : ~0;
      l9 = ub[9] ? i9[6:0] : ~0;

      o = {l9, l8, l7, l6, l5, l4, l3, l2, l1, l0};
    end
    else
      o = u64_output;
  end

endmodule
