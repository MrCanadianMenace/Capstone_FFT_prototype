.PHONY: clean
clean:
	rm *.{vcd,out}

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
