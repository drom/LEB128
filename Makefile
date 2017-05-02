SRC   = .
BUILD = build

IVERILOG = iverilog -I $(SRC) -y $(SRC)
VVP      = vvp -N


.PHONY: all clean


all:

clean:
	rm -rf $(BUILD) *~

test: test/unpack_i32 test/unpack_i64 test/unpack_u32


#
# Auxiliar objectives
#
$(BUILD):
	mkdir -p $(BUILD)


#
# Test and view rules
#
test/unpack_i32: $(BUILD)/unpack_i32_tb.vcd
test/unpack_i64: $(BUILD)/unpack_i64_tb.vcd
test/unpack_u32: $(BUILD)/unpack_u32_tb.vcd

$(BUILD)/%.vcd: $(BUILD)/% $(BUILD)
	(cd $(BUILD) && $(VVP) ../$<) || (rm $< && exit 1)

$(BUILD)/%_tb: $(SRC)/unpack_signed.v $(SRC)/unpack_unsigned.v test/assert.vh test/%_tb.v
	$(IVERILOG) -I test test/$(@F).v $< -o $@

view/%: $(BUILD)/%_tb.vcd test/%
	gtkwave $<
