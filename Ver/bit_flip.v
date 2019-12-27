module bit_flip 
    // INDEX: Signal Vector index register, used to swap signal entries
    // M: Signal entry word size
    #(parameter INDEX = 4, M = 8) (
        out,
        in
    );

    //input in;
    //output out; 

    // Define input and output as vectors of M size
    input wire [M-1:0] in [INDEX-1:0];
    output reg [M-1:0] out [INDEX-1:0];

    integer i;
    always @(*) begin
    
        // Don't swap outer values
        out[0] <= in[0];
        out[INDEX-1] <= in[INDEX-1];

        // Swap all middle values
        for (i=1; i<INDEX/2; i=i+1) begin
            out[i] <= in[INDEX-1-i];
            out[INDEX-1-i] <= in[i];
        end
    end

endmodule
