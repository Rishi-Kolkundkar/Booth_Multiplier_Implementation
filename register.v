module four_bit_register(
    input wire AR,   // Asynchronous Reset input (active-high)
    input wire[3:0] D,    // Data input
    input wire CLK,  // Clock input
    input wire EN,   //Enable
    output wire [3:0] Q    // Output
);


    //LSB FF
    d_flip_flop_en d0(
        .D(D[0]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[0])
    );

    
    d_flip_flop_en d1(
        .D(D[1]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[1])
    );


    d_flip_flop_en d2(
        .D(D[2]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[2])
    );

    d_flip_flop_en d3(
        .D(D[3]),
        .CLK(CLK),
        .EN(EN),
        .AR(AR),
        .Q(Q[3])
    );

  

endmodule