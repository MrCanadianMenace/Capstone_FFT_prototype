.PHONY: clean
clean:
    rm *.{vcd,out}

add_tb:
    iverilog -o add.out complex_add_tb.v complex_add.v

add_waveform: add_tb
    vvp add.out
    gtkwave complex_add_test.vcd &

add_verilator:
    verilator -Wall -cc complex_add.v
    # Invoke sub make in obj_dir generate by Verilator
    g++ -I./obj_dir -I/usr/share/verilator/include VTest.cpp /usr/share/verilator/include/verilated.cpp *.h *.o -o Vcomplex_add_sim
