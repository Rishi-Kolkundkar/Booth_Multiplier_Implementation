module shift_right_arithmetic (
    input  wire [3:0] A,
    output wire [3:0] Y
);
    
    assign Y = {A[3], A[3], A[2], A[1]};

endmodule
