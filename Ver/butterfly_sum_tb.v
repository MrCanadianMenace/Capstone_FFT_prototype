module butterfly_sum_tb;

parameter word_size = 8;
parameter half_word = word_size / 2;

reg CLK, RESET;
reg [7:0] in1, in2;
wire [7:0] out1, out2;

butterfly_sum #(.WORD_SZ(word_size)) TEST_UNIT 
    (
        .i_CLK (CLK),
        .i_RESET (RESET),
        .in1 (in1),
        .in2 (in2),
        .out1 (out1),
        .out2 (out2)
    );

always
    #1 CLK = !CLK;

initial begin
    $dumpfile("butterfly_sum_test.vcd");
    $dumpvars(0, butterfly_sum_tb);

    // Start simulation
    RESET = 1'b0;
    CLK = 1'b0;

    #3
    in1[word_size-1:half_word] = 4'd3;
    in1[half_word-1:0] = 4'd1;

    in2[word_size-1:half_word] = 4'd2;
    in2[half_word-1:0] = 4'd1;

    #3 $finish; // Done
end
endmodule

