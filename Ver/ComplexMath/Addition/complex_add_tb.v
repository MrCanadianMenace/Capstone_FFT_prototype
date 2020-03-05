module complex_add_tb;

reg [15:0] A, B;
wire [15:0] sum;
wire [7:0] sum_real, sum_imag;

assign sum_real = sum[15:8];
assign sum_imag = sum[7:0];

complex_add TEST_UNIT (
    .i_A(A),
    .i_B(B),
    .o_sum(sum)
);

    initial begin
        $dumpfile("complex_add_test.vcd");
        $dumpvars(0, complex_add_tb);

        //#2
        // Real parts
        //A[15:8] = 8'd4;
        //B[15:8] = 8'd2;

        // Imaginary parts
        //A[7:0] = 8'd33;
        //B[7:0] = 8'd36;

        //#2
        // Real parts
        //A[15:8] = 8'b11111111;
        //B[15:8] = 8'b11111110;

        // Imaginary parts
        //A[7:0] = 8'b11111110;
        //B[7:0] = 8'd5;

        //#2
        // Real floating
        //A[15:8] = 8'b00001010; // 2.5
        //B[15:8] = 8'b00001101; // 3.25

        // Imaginary floating
        //A[7:0] = 8'b11101111; // -4.25
        //B[7:0] = 8'b00010110; //  5.5

        #2
        // Fixed point conversion check
        A = 16'd67;
        B = 16'd420;

        #2 $finish;
    end
endmodule
