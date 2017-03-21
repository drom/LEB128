`include "assert.vh"


module unpack_i64_tb ();

  reg  [ 7:0] i0, i1, i2, i3, i4, i5, i6, i7, i8, i9;
  wire [63:0] o;
  wire [ 3:0] len;

  unpack_i64 DUT(i0, i1, i2, i3, i4, i5, i6, i7, i8, i9, o, len);

  initial begin
    $dumpfile("unpack_i64_tb.vcd");
    $dumpvars(0, unpack_i64_tb);

    i0 = 8'hff;
    i1 = 8'hff;
    i2 = 8'hff;
    i3 = 8'hff;
    i4 = 8'hff;
    i5 = 8'hff;
    i6 = 8'hff;
    i7 = 8'hff;
    i8 = 8'hff;
    i9 = 8'h01;
    #1
    `assert(o  , -1);
    `assert(len, 10);

    i0 = 8'h80;
    i1 = 8'h80;
    i2 = 8'h80;
    i3 = 8'h80;
    i4 = 8'h0c;
    i5 = 8'hbc;
    i6 = 8'h0b;
    i7 = 8'h00;
    i8 = 8'h00;
    i9 = 8'h00;
    #1
    `assert(o  , 32'hc0000000);
    `assert(len, 5);

    $display("ok");
    $finish;
  end

endmodule // unpack_u64_tb
