module NSL (
    input wire [2:0] Q,
    output wire [2:0] D
);
    wire nQ0;
    wire t1, t2;

    not (nQ0, Q[0]);

    and (D[2], Q[1], Q[0]);
    xor (D[1], Q[1], Q[0]);
    


    
    assign D[0] = nQ0;
    
    
endmodule