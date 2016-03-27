# LEB128

Little Endian Base 128 ([LEB128](https://en.wikipedia.org/wiki/LEB128)) converters in Verilog.

`      10011000011101100101`  In raw binary
`     010011000011101100101`  Padded to a multiple of 7 bits
` 0100110  0001110  1100101`  Split into 7-bit groups
`00100110 10001110 11100101`  Add high 1 bits on all but last group to form bytes
`    0x26     0x8E     0xE5`  In hexadecimal
`0xE5 0x8E 0x26`              Output stream
```
