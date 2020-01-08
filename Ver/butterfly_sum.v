module butterfly_sum #(parameter WORD_SZ = 8)
    (
            i_CLK,
            i_RESET,
            in1,
            in2,
            out1,
            out2
    );

    // Declaration of port types
    input wire i_CLK, i_RESET;
    input wire [WORD_SZ-1:0] in1; 
    input wire [WORD_SZ-1:0] in2; 
    output reg [WORD_SZ-1:0] out1;
    output reg [WORD_SZ-1:0] out2;

    // Useful constant for splitting registers in half
    parameter midpoint = WORD_SZ/2;

    // Internal wires for aiding in complex math
    wire [WORD_SZ/2-1:0] in_real1 = in1[WORD_SZ-1:midpoint];
    wire [WORD_SZ/2-1:0] in_real2 = in2[WORD_SZ-1:midpoint];
    wire [WORD_SZ/2-1:0] in_imag1 = in1[midpoint-1:0];
    wire [WORD_SZ/2-1:0] in_imag2 = in2[midpoint-1:0];

    always @ (posedge i_CLK) begin
        out1[WORD_SZ-1:midpoint] <= in_real1 + in_real2;    // Real part of output
        out1[midpoint-1:0] <= in_imag1 + in_imag2;          // Imaginary part of first output

        out2[WORD_SZ-1:midpoint] <= in_real1 - in_real2;    // Real part of output
        out2[midpoint-1:0] <= in_imag1 - in_imag2;          // Imaginary part of first output
    end
endmodule
