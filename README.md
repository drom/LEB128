# LEB128

Little Endian Base 128 ([LEB128](https://en.wikipedia.org/wiki/LEB128)) converters in Verilog.

### Unsigned

```
                             624485
                            0x98765  HEX
00000000_00001001_10000111_01100101  binary
            0100110_0001110_1100101  shrunk to a multiple of 7 bits
         00100110 10001110 11100101  Add high 1 bits on all but last group to form bytes
             0x26     0x8E     0xE5  In hexadecimal
0xE5 0x8E 0x26                       Output stream
```

### Signed

```
                            -624485
                         0xFFF6789b  HEX
11111111_11110110_01111000_10011011  two's complement binary
            1011001_1110001_0011011  shrunk to a multiple of 7 bits
         01011001 11110001 10011011  Add high 1 bits on all but last group to form bytes
             0x59     0xf1     0x9b  In hexadecimal
0x9b 0xf1 0x59                       Output stream
```
