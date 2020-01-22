module DFT_2_tb;

parameter word_size = 16;
parameter half_word = word_size / 2;

// Registers and wires to help separate inputs and outputs into real and imaginary parts
reg [half_word-1:0] it_A_real, it_A_imag, it_B_real, it_B_imag; 
wire [half_word-1:0] ot_A_real, ot_A_imag, ot_B_real, ot_B_imag;

// Wires to combine the inputs and outputs of the module into singular
// variables
wire [word_size-1:0] it_A = {it_A_real, it_A_imag};
wire [word_size-1:0] it_B = {it_B_real, it_B_imag};
wire [word_size-1:0] ot_A = {ot_A_real, ot_A_imag};
wire [word_size-1:0] ot_B = {ot_B_real, ot_B_imag};

DFT_2 #(.WORD_SZ(word_size)) TEST_UNIT
	(
		.i_A (it_A),
		.i_B (it_B),
		.o_A (ot_A),
		.o_B (ot_B)
	);

	initial begin
		$dumpfile("DFT_2_test.vcd");
		$dumpvars(0, DFT_2_tb);

		// Start simulation
		#1

		it_A_real = 8'd2;
		it_A_imag = 8'd3;

		it_B_real = 8'd4;
		it_B_imag = 8'd1;

		#1 $finish;
	end
endmodule
