.PHONY: clean
clean:
	rm *.{vcd,out}
	rm dsn

bit_flip_tb:
	iverilog -o bit_flip.out bit_flip_tb.v bit_flip.v

bit_flip_waveform: bit_flip_tb
	vvp bit_flip.out
	gtkwave bit_flip_test.vcd &

butterfly_sum_tb:
	iverilog -o butterfly_sum.out butterfly_sum_tb.v butterfly_sum.v

butterfly_sum_waveform: butterfly_sum_tb
	vvp butterfly_sum.out
	gtkwave butterfly_sum_test.vcd &
