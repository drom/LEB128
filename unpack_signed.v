module unpack_signed #(
  parameter N = 64
)
(
  input       [           0:M-1] in,
  output reg  [         N-1:  0] out,
  output wire [$clog2(MB)-1:  0] len
);

  localparam MB = N/7+1;
  localparam M  = MB*8;

  wire[N-1:0] unsigned_output;

  integer i;
  reg [MB-1:0] gl, ub, ho, sb;

  unpack_unsigned #(.N(N)) u64(in, unsigned_output, len);

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

    // Get sign bit from high order byte
    for(i=0; i<=MB-1; i=i+1)
      sb[i] = ho[i] & in[i*8+1];

    // If number is negative, extend sign to left
    if(|sb) begin
      for(i=0; i<=MB-1; i=i+1)
        if(!ub[i])
          out[i*7 +: 7] = 7'b1111111;
    end

    // Number is positive
    else
      out = unsigned_output;
  end

endmodule
