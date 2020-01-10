.PHONY: clean
clean:
	rm *.{vcd,out}

add_tb:
	iverilog -o add.out complex_add_tb.v complex_add.v

add_waveform: add_tb
	vvp add.out
	gtkwave complex_add_test.vcd &

sub_tb:
	iverilog -o sub.out complex_sub_tb.v complex_sub.v

sub_waveform: sub_tb
	vvp sub.out
	gtkwave complex_sub_test.vcd &

mul_tb:
	iverilog -o mul.out complex_mul_tb.v complex_mul.v

mul_waveform: mul_tb
	vvp mul.out
	gtkwave complex_mul_test.vcd &
