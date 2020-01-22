.PHONY: clean
clean:
	rm *.{vcd,out}

dft_2_tb:
	iverilog -o DFT_2.out DFT_2_tb.v DFT_2.v
	vvp DFT_2.out

dft_2_wave: dft_2_tb
	gtkwave DFT_2_test.vcd &

dft_4_tb:
	iverilog -o DFT_4.out DFT_4_tb.v DFT_4.v
	vvp DFT_4.out

dft_4_wave: dft_4_tb
	gtkwave DFT_4_test.vcd &

dft_net_tb:
	iverilog -o DFT_Network.out DFT_Network_tb.v DFT_Network.v DFT_2.v DFT_4.v
	vvp DFT_Network.out

dft_net_wave: dft_net_tb
	gtkwave DFT_Network_test.vcd &
