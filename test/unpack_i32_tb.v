`include "assert.vh"


module unpack_i32_tb ();

  reg  [0:39] in;
  wire [31:0] out;
  wire [ 2:0] len;

  unpack_signed #(.N(32)) DUT(in, out, len);

  initial begin
    $dumpfile("unpack_i32_tb.vcd");
    $dumpvars(0, unpack_i32_tb);

    in = 40'h2axxxxxxxx;
    #1
    `assert(out, 42);
    `assert(len, 1);

    in = 0;
    #1
    `assert(out, 0);
    `assert(len, 1);

    in = 40'h9bf1590000;
    #1
    `assert(out, -624485);
    `assert(len, 3);

    in = 40'hffffffff0f;
    #1
    `assert(out, -1);
    `assert(len, 5);

    $display("ok");
    $finish;
  end

endmodule // unpack_i32_tb
