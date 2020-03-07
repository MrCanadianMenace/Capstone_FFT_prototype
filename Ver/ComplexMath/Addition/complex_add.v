module complex_add (
    i_A,
    i_B,
    o_sum
);

input wire [7:0] i_A, i_B;
output wire [15:0] o_sum;

// Simple multiplication
assign o_sum = i_A * i_B;

endmodule
