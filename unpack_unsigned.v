module unpack_unsigned #(
  parameter N = 64
)
(
  input      [           0:M-1] in,
  output reg [         N-1:  0] out,
  output reg [$clog2(MB)-1:  0] len
);

  localparam MB = N/7+1;
  localparam M  = MB*8;

  integer i;
  reg [MB-1:0] gl, ub, ho;

  always @* begin
    for(i=0; i<=MB-1; i=i+1) begin
      gl [i       ] = in[i*8       ];  // Glue bits
      out[i*7 +: 7] = in[i*8+1 +: 7];  // Data chunks
    end

    // Used bytes
    ub[0] = 1;

    for(i=1; i<=MB-1; i=i+1)
      ub[i] = gl[i-1] & ub[i-1];  // Should use more optimus &gl[i-1:0] instead

    // Get high order byte
    for(i=0; i<=MB-2; i=i+1)
      ho[i] = !ub[i+1] & ub[i];

    ho[MB-1] = ub[MB-1];

    // Generate decoded number
    for(i=0; i<=MB-1; i=i+1)
      if(!ub[i])
        out[i*7 +: 7] = 7'b0;

    // Positional to binary
                len[0] = |(ho & 32'b01010101010101010101010101010101);
    if(N >   7) len[1] = |(ho & 32'b01100110011001100110011001100110);
    if(N >  21) len[2] = |(ho & 32'b01111000011110000111100001111000);
    if(N >  49) len[3] = |(ho & 32'b01111111100000000111111110000000);
    if(N > 105) len[4] = |(ho & 32'b01111111111111111000000000000000);
  end

endmodule
