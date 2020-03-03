.PHONY: clean
clean:
	rm -f *.{vcd,out}
	rm -rf obj_dir
	rm -f Vcomplex_add_sim

add_tb:
	iverilog -o add.out complex_add_tb.v complex_add.v

add_waveform: add_tb
	vvp add.out
	gtkwave complex_add_test.vcd &

add_verilator:
	echo "Generating Verilator files"
	verilator -Wall -cc complex_add.v
	echo "Building Verilator Test Libs"
	$(MAKE) -C obj_dir -f Vcomplex_add.mk
	echo "Building Verilator Testbench"
	g++ -I./obj_dir -I/usr/share/verilator/include /usr/share/verilator/include/verilated.cpp obj_dir/*.h obj_dir/*.o VTest.cpp -o Vcomplex_add_sim
