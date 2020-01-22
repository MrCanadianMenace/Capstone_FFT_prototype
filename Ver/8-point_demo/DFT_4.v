/**
*	DFT_4 a simple 4-point DFT module
*
*	This module performs a 4-point DFT by using the precalculated
*	twiddle factors which will be hardcoded constants.  In theory
*	they should be synthesized as latches/registers.  This is 
*	not a good way to handle these constants so future iterations
*	will place these important values in on-chip memory.
**/
module DFT_4 #(parameter WORD_SZ = 8) (
	i_A,
	i_B,
	i_C,
	i_D,
	o_A,
	o_B,
	o_C,
	o_D
);

// Definition of ports
input wire [WORD_SZ-1:0] i_A, i_B, i_C, i_D;
output wire [WORD_SZ-1:0] o_A, o_B, o_C, o_D;

// Wires to separate inputs and outputs into real and complex parts
parameter midpoint = WORD_SZ/2;
// Inputs
wire [midpoint-1:0] i_A_real = i_A[WORD_SZ-1:midpoint];
wire [midpoint-1:0] i_A_imag = i_A[midpoint-1:0];
wire [midpoint-1:0] i_B_real = i_B[WORD_SZ-1:midpoint];
wire [midpoint-1:0] i_B_imag = i_B[midpoint-1:0];
wire [midpoint-1:0] i_C_real = i_C[WORD_SZ-1:midpoint];
wire [midpoint-1:0] i_C_imag = i_C[midpoint-1:0];
wire [midpoint-1:0] i_D_real = i_D[WORD_SZ-1:midpoint];
wire [midpoint-1:0] i_D_imag = i_D[midpoint-1:0];
//Outputs
wire [midpoint-1:0] o_A_real, o_A_imag;
wire [midpoint-1:0] o_B_real, o_B_imag;
wire [midpoint-1:0] o_C_real, o_C_imag;
wire [midpoint-1:0] o_D_real, o_D_imag;
assign o_A = {o_A_real, o_A_imag};
assign o_B = {o_B_real, o_B_imag};
assign o_C = {o_C_real, o_C_imag};
assign o_D = {o_D_real, o_D_imag};
// Combinational Logic for performing the actual DFT
// First Butterfly Sum
// Twiddle factor = 1
assign o_A_real = i_A_real + i_C_real;
assign o_A_imag = i_A_imag + i_C_imag;

// Twiddle factor = -1
assign o_C_real = i_A_real - i_C_real;
assign o_C_imag = i_A_imag - i_C_imag;


// Second Butterfly Sum
// Twiddle factor = -i
assign o_B_real = i_B_real + i_D_imag;
assign o_B_imag = i_B_imag - i_D_real;

// Twiddle factor = i
assign o_D_real = i_B_real - i_D_imag;
assign o_D_imag = i_B_imag + i_D_real;

endmodule
