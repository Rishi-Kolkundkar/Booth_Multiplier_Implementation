module Counter_3bit_up (
    output wire [2:0] CNT,
    input wire CLK,
    input wire AR
);
    wire [2:0] a1,a2;                     
    NSL nextstategen(
        .Q(a1),
        .D(a2)
    );


    three_bit_register cntreg(
        .CLK(CLK),
        .AR(AR),
        .EN(1'b1),
        .Q(a1),
        .D(a2)
    );
    assign CNT = a1;

     
endmodule