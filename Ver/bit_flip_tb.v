module bit_flip_tb;

reg [15:0] in = 16'b0000_0000_0000_0000;
wire [15:0] out; 

bit_flip #(.INDEX(16)) TEST_UNIT (
    .out (out),
    .in (in)
);

initial begin
    $dumpfile("bit_flip_test.vcd");
    $dumpvars(0, bit_flip_tb);

    $monitor(in, out);

    // Wait 5 nanoseconds
    #5
    in = 16'b1111_1111_0000_0000;

    //#5
    //in = 4'b0101;

    // Wait 5 more seconds before ending simulation
    #5 $finish;
end
endmodule
