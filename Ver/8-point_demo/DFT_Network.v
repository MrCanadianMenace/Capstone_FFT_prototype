module DFT_Network #(parameter WORD_SZ = 16) (
	i_A,
	i_B,
	i_C,
	i_D,
	o_net_A,
	o_net_B,
	o_net_C,
	o_net_D
);

// Definition of ports
input wire [WORD_SZ-1:0] i_A, i_B, i_C, i_D;
output wire [WORD_SZ-1:0] o_net_A, o_net_B, o_net_C, o_net_D;

// Parameters
parameter word_size = 16;


// First layer of 2-point DFT's

// Wires for connecting outputs of current layer
// to inputs of next layer
wire [WORD_SZ-1:0] w_A_2, w_B_2, w_C_2, w_D_2;

DFT_2 #(.WORD_SZ(word_size)) DFT_2_1 (
	.i_A (i_A),
	.i_B (i_C),
	.o_A (w_A_2),
	.o_B (w_C_2)
);

DFT_2 #(.WORD_SZ(word_size)) DFT_2_2 (
	.i_A (i_B),
	.i_B (i_D),
	.o_A (w_B_2),
	.o_B (w_D_2)
);

// Second layer of 4-point DFT's
DFT_4 #(.WORD_SZ(word_size)) DFT_4_1 (
	.i_A (w_A_2),
	.i_B (w_C_2),
	.i_C (w_B_2),
	.i_D (w_D_2),
	.o_A (o_net_A),
	.o_B (o_net_B),
	.o_C (o_net_C),
	.o_D (o_net_D)
);

endmodule
