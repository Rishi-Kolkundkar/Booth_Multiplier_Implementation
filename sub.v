module sub (
    input wire [3:0] A,
    input wire [3:0] B,
    output wire [3:0] Y
);
    wire [3:0] B_not;
    wire [3:0] sum;

    // Invert B bit by bit
    not (B_not[0], B[0]);
    not (B_not[1], B[1]);
    not (B_not[2], B[2]);
    not (B_not[3], B[3]);

    
    radder4 add_stage (
        .A(A),
        .B(B_not),
        .Y(sum)
    );

    
    radder4 add_one (
        .A(sum),
        .B(4'b0001),
        .Y(Y)
    );

endmodule