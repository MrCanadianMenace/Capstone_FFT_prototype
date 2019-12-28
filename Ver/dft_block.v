module dft_block #(parameter N = 2, WORD_SZ = 8)
    (
            i_CLK,
            i_RESET,
            in,
            out
    );

    input wire i_CLK, i_RESET;
    input wire [N * WORD_SZ - 1] in;
    output reg [N * WORD_SZ - 1] out;

    // Wire vector for connecting input with proper butterfly sum
    wire [WORD_SZ-1:0] w_input_sig [N-1:0];

    generate
    genvar i;
        for (i=0; i<N; i=i+1) begin
            assign w_input_sig[i] = in[(i+1)*WORD_SZ-1 : i*WORD_SZ];
        end
    endgenerate

    always @ (posedge i_CLK) begin
        integer i, word_start, word_end;
            for (i=0; i<N/2; i=i+1) begin
                word_start = (i+1) * WORD_SZ - 1; 
                word_end = i * WORD_SZ;
                conj_word_start = (N-i) * WORD_SZ - 1; 
                conj_word_end = (N-1-i) * WORD_SZ;

                out[word_start:word_end] <= w_input_sig[N-1-i]; // Needs twiddle factor multiplication
                out[conj_word_start:conj_word_end] <= w_input_sig[i]; // Needs twiddle factor multiplication
        end
    end
endmodule
