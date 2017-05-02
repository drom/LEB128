module unpack_i64 #(
  parameter N = 64
)
(
  input       [  0:79] in,
  output reg  [N-1: 0] out,
  output wire [  3: 0] len
);

  wire[N-1:0] u64_output;

  integer i;
  reg [9:0] gl, ub, ho, sb;

  unpack_u64 #(.N(N)) u64(in, u64_output, len);

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

    // Get sign bit from high order byte
    for(i=0; i<=9; i=i+1)
      sb[i] = ho[i] & in[i*8+1];

    // If number is negative, extend sign to left
    if(|sb) begin
      for(i=0; i<=9; i=i+1)
        if(!ub[i])
          out[i*7 +: 7] = 7'b1111111;
    end

    // Number is positive
    else
      out = u64_output;
  end

endmodule
