`include "assert.vh"


module unpack_i32_tb ();

  reg [7:0] i0, i1, i2, i3, i4;
  wire [31:0] o;
  wire [ 2:0] len;

  unpack_i32 DUT(i0, i1, i2, i3, i4, o, len);

  initial begin
    $dumpfile("unpack_i32_tb.vcd");
    $dumpvars(0, unpack_i32_tb);

    i0 = 0;
    i1 = 0;
    i2 = 0;
    i3 = 0;
    i4 = 0;
    #1
    `assert(o  , 0);
    `assert(len, 1);

    i0 = 8'h9b;
    i1 = 8'hf1;
    i2 = 8'h59;
    i3 = 0;
    i4 = 0;
    #1
    `assert(o  , -624485);
    `assert(len, 3);

    $display("ok");
    $finish;
  end

endmodule // unpack_u32_tb
