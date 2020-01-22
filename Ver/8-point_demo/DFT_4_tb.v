module DFT_4_tb;

parameter word_size = 16;
parameter half_word = word_size / 2;

// Registers and wires to help separate inputs and outputs into real and imaginary parts
reg [half_word-1:0] it_A_real, it_A_imag, it_B_real, it_B_imag, it_C_real, it_C_imag, it_D_real, it_D_imag; 
wire [half_word-1:0] ot_A_real, ot_A_imag, ot_B_real, ot_B_imag, ot_C_real, ot_C_imag, ot_D_real, ot_D_imag;

// Wires to combine the inputs and outputs of the module into singular
// variables
// Inputs
wire [word_size-1:0] it_A = {it_A_real, it_A_imag};
wire [word_size-1:0] it_B = {it_B_real, it_B_imag};
wire [word_size-1:0] it_C = {it_C_real, it_C_imag};
wire [word_size-1:0] it_D = {it_D_real, it_D_imag};
// Outputs
wire [word_size-1:0] ot_A = {ot_A_real, ot_A_imag};
wire [word_size-1:0] ot_B = {ot_B_real, ot_B_imag};
wire [word_size-1:0] ot_C = {ot_C_real, ot_C_imag};
wire [word_size-1:0] ot_D = {ot_D_real, ot_D_imag};

DFT_4 #(.WORD_SZ(word_size)) TEST_UNIT
	(
		.i_A (it_A),
		.i_B (it_B),
		.i_C (it_C),
		.i_D (it_D),
		.o_A (ot_A),
		.o_B (ot_B),
		.o_C (ot_C),
		.o_D (ot_D)
	);

	initial begin
		$dumpfile("DFT_4_test.vcd");
		$dumpvars(0, DFT_4_tb);

		// Start simulation
		#1

		it_A_real = 8'd2;
		it_A_imag = 8'd3;

		it_B_real = 8'd4;
		it_B_imag = 8'd1;
		
		it_C_real = 8'd1;
		it_C_imag = 8'd4;

		it_D_real = 8'd5;
		it_D_imag = 8'd2;

		#1 $finish;
	end
endmodule
