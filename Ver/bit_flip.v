module bit_flip 
    #(parameter REG_LENGTH = 4) (
    out,
    in
);


input wire [REG_LENGTH-1:0] in;
output wire [REG_LENGTH-1:0] out;

// Swap outer values
assign out[0] = in[0];
assign out[REG_LENGTH-1] = in[REG_LENGTH-1];

// Swap all middle values
generate
genvar i;
    for (i=1; i<REG_LENGTH/2; i=i+1) begin
        assign out[i] = in[REG_LENGTH-1-i];
        assign out[REG_LENGTH-1-i] = in[i];
    end
endgenerate

endmodule
