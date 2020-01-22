/**
*	DFT_2 a simple 2-point DFT module
*
*	This module performs a 2-point DFT by using the precalculated
*	twiddle factors for a 2-point DFT 1 and -1 
**/
module DFT_2 #(parameter WORD_SZ = 8) (
	i_A,
	i_B,
	o_A,
	o_B
);

// Definition of ports
input wire [WORD_SZ-1:0] i_A, i_B;
output wire [WORD_SZ-1:0] o_A, o_B;

// Wires to separate inputs and outputs into real and complex parts
parameter midpoint = WORD_SZ/2;
// Inputs
wire [midpoint-1:0] i_A_real = i_A[WORD_SZ-1:midpoint];
wire [midpoint-1:0] i_A_imag = i_A[midpoint-1:0];
wire [midpoint-1:0] i_B_real = i_B[WORD_SZ-1:midpoint];
wire [midpoint-1:0] i_B_imag = i_B[midpoint-1:0];
//Outputs
wire [midpoint-1:0] o_A_real, o_A_imag;
wire [midpoint-1:0] o_B_real, o_B_imag;
assign o_A = {o_A_real, o_A_imag};
assign o_B = {o_B_real, o_B_imag};


// Combinational Logic for performing the actual DFT
assign o_A_real = i_A_real + i_B_real;
assign o_A_imag = i_A_imag + i_B_imag;
assign o_B_real = i_A_real - i_B_real;
assign o_B_imag = i_A_imag - i_B_imag;

endmodule
