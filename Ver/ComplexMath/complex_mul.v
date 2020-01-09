module complex_mul (
    i_A,
    i_B,
    o_prod
);

input wire [15:0] i_A, i_B;
output wire [15:0] o_prod;

// Intermediate wires
wire [7:0] a_real = i_A[15:8];
wire [7:0] a_imag = i_A[7:0];

wire [7:0] b_real = i_B[15:8];
wire [7:0] b_imag = i_B[7:0];

// Simple complex multiplication
assign o_prod[15:8] = (a_real * b_real) - (a_imag * b_imag);
assign o_prod[7:0] = (a_real * b_imag) + (a_imag * b_real);

endmodule
