module radder4 (
    input wire [3:0] A,
    input wire [3:0] B,
    output wire [3:0] Y
    
);

    wire a1,a2,a3,a4;
    
    FA add1(
        .A(A[0]),
        .B(B[0]),
        .Cin(1'b0),
        .S(Y[0]),
        .Cout(a1)
    );

     FA add2(
        .A(A[1]),
        .B(B[1]),
        .Cin(a1),
        .S(Y[1]),
        .Cout(a2)
    );

     FA add3(
        .A(A[2]),
        .B(B[2]),
        .Cin(a2),
        .S(Y[2]),
        .Cout(a3)
    );

     FA add4(
        .A(A[3]),
        .B(B[3]),
        .Cin(a3),
        .S(Y[3]),
        .Cout(a4)
    );

   


endmodule