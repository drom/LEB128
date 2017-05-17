`include "assert.vh"


module unpack_u32_tb ();

  reg  [0:39] in;
  wire [31:0] out;
  wire [ 2:0] len;

  unpack_unsigned #(.N(32)) DUT(in, out, len);

  initial begin
    $dumpfile("unpack_u32_tb.vcd");
    $dumpvars(0, unpack_u32_tb);

    in = 0;
    #1
    `assert(out, 0);
    `assert(len, 1);

    in = 40'h2a00000000;
    #1
    `assert(out, 42);
    `assert(len, 1);

    in = 40'he58e260000;
    #1
    `assert(out, 624485);
    `assert(len, 3);

    in = 40'hffffffff0f;
    #1
    `assert(out, 32'hffffffff);
    `assert(len, 5);

    $display("ok");
    $finish;
  end

endmodule // unpack_u32_tb
