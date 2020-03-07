module complex_add (
    i_A,
    i_B,
    o_sum
);

input wire [7:0] i_A, i_B;
output wire [15:0] o_sum;

// Intermediate wires
//wire [7:0] a_real = i_A[15:8];

//wire [7:0] b_real = i_B[15:8];

// Simple complex addition
//assign o_sum[15:8] = a_real * b_real;
assign o_sum = i_A * i_B;

endmodule
