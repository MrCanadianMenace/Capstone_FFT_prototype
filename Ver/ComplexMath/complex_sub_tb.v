module complex_sub_tb;

reg [15:0] A, B;
wire [15:0] diff;
wire [7:0] diff_real, diff_imag;

assign diff_real = diff[15:8];
assign diff_imag = diff[7:0];

complex_sub TEST_UNIT (
    .i_A(A),
    .i_B(B),
    .o_diff(diff)
);

    initial begin
        $dumpfile("complex_sub_test.vcd");
        $dumpvars(0, complex_sub_tb);

        #2
        // Real parts
        A[15:8] = 8'd4;
        B[15:8] = 8'd2;

        // Imaginary parts
        A[7:0] = 8'd33;
        B[7:0] = 8'd36;

        #2
        // Real parts
        A[15:8] = 8'b11111111;
        B[15:8] = 8'b11111110;

        // Imaginary parts
        A[7:0] = 8'b11111110;
        B[7:0] = 8'd5;

        #2 $finish;
    end
endmodule
