module complex_mul_tb;

reg [15:0] A, B;
wire [15:0] prod;
wire [7:0] prod_real, prod_imag;

assign prod_real = prod[15:8];
assign prod_imag = prod[7:0];

complex_mul TEST_UNIT (
    .i_A(A),
    .i_B(B),
    .o_prod(prod)
);

    initial begin
        $dumpfile("complex_mul_test.vcd");
        $dumpvars(0, complex_mul_tb);

        #2
        // Real parts
        A[15:8] = 8'd4;
        B[15:8] = 8'd2;

        // Imaginary parts
        A[7:0] = 8'd2;
        B[7:0] = 8'b11111111;

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
