module unpack_u64 #(
  parameter N = 64
)
(
  input      [  0:79] in,
  output reg [N-1: 0] out,
  output reg [  3: 0] len
);

  integer i;
  reg [9:0] gl, ub, ho;

  always @* begin
    for(i=0; i<=9; i=i+1) begin
      gl [i       ] = in[i*8       ];  // Glue bits
      out[i*7 +: 7] = in[i*8+1 +: 7];  // Data chunks
    end

    // Used bytes
    ub[0] = 1;

    for(i=1; i<=9; i=i+1)
      ub[i] = gl[i-1] & ub[i-1];  // Should use more optimus &gl[i-1:0] instead

    // Get high order byte
    for(i=0; i<=8; i=i+1)
      ho[i] = !ub[i+1] & ub[i];

    ho[9] = ub[9];

    // Generate decoded number
    for(i=0; i<=9; i=i+1)
      if(!ub[i])
        out[i*7 +: 7] = 7'b0;

    // Positional to binary
    len[0] = ho[0] |         ho[2] |         ho[4]         | ho[6]         | ho[8];
    len[1] =         ho[1] | ho[2]                 | ho[5] | ho[6]                 | ho[9];
    len[2] =                         ho[3] | ho[4] | ho[5] | ho[6];
    len[3] =                                                         ho[7] | ho[8] | ho[9];
  end

endmodule
