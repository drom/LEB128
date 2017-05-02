`include "assert.vh"


module unpack_i64_tb ();

  reg  [79:0] in;
  wire [63:0] out;
  wire [ 3:0] len;

  unpack_signed #(.N(64)) DUT(in, out, len);

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

    in = 80'h80808080800c00808080;
    #1
    `assert(out, 64'h6000000000);
    `assert(len, 6);

    in = 80'h8080808080800c008080;
    #1
    `assert(out, 64'h300000000000);
    `assert(len, 7);

    in = 80'h808080808080800c0080;
    #1
    `assert(out, 64'h18000000000000);
    `assert(len, 8);

    in = 80'h80808080808080800c00;
    #1
    `assert(out, 64'h0c00000000000000);
    `assert(len, 9);

    in = 80'h8080808080808080c001;
    #1
    `assert(out, 64'hc000000000000000);
    `assert(len, 10);

    $display("ok");
    $finish;
  end

endmodule // unpack_u64_tb
