module Comp_Equality_3bit (
    input wire [2:0] A,
    input wire [2:0] B,
    output wire y
);
   
    wire xor2, xor1, xor0;
   
    wire eq2, eq1, eq0;

    // Bit 2 Comparison
    xor (xor2, A[2], B[2]);
    not (eq2, xor2);

    // Bit 1 Comparison
    xor (xor1, A[1], B[1]);
    not (eq1, xor1);

    // Bit 0 Comparison
    xor (xor0, A[0], B[0]);
    not (eq0, xor0);

    // Final result
    and (y, eq2, eq1, eq0);

endmodule
