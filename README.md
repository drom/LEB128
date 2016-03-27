# LEB128

Little Endian Base 128 ([LEB128](https://en.wikipedia.org/wiki/LEB128)) converters in JavaScript and Verilog.

### Usage

```js
var leb = require('leb128');
var x = 0x1234;
var xx = leb(x);
console.log(xx);
```
