module bit_flip_tb;

reg [7:0] in [3:0] = '{ 8'd0, 8'd0, 8'd0, 8'd0};
wire [7:0] out [3:0]; 

bit_flip #(.INDEX(4), .M(8)) TEST_UNIT (
    .out (out),
    .in (in)
);

initial begin
    $dumpfile("bit_flip_test.vcd");
    $dumpvars(0, bit_flip_tb);

    $monitor(in, out);

    // Wait 5 nanoseconds
    #5
    in = '{ 8'd1, 8'd2, 8'd3, 8'd4};

    //#5
    //in = 4'b0101;

    // Wait 5 more seconds before ending simulation
    #5 $finish;
end
endmodule
