`include "assert.vh"


module unpack_i64_tb ();

  reg  [79:0] in;
  wire [63:0] out;
  wire [ 3:0] len;

  unpack_i64 DUT(in, out, len);

  initial begin
    $dumpfile("unpack_i64_tb.vcd");
    $dumpvars(0, unpack_i64_tb);

    // Ignore unset bits after value
    in = 80'h01xxxxxxxxxxxxxxxxxx;
    #1
    `assert(out, 1);
    `assert(len, 1);

    // Decode negative numbers
    in = 80'hffffffffffffffffff01;
    #1
    `assert(out, -1);
    `assert(len, 10);

    // Ignore data after value
    in = 80'h808080800cbc0b000000;
//    in = 80'h808080800cdeadbeef00;
    #1
    `assert(out, 32'hc0000000);
    `assert(len, 5);

    $display("ok");
    $finish;
  end

endmodule // unpack_u64_tb
