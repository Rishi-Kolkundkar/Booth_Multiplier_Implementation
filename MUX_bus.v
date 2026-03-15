// Gate-level 4-to-1 multiplexer
module mux_4_to_1 #(parameter WIDTH = 4) (
    input  wire [WIDTH-1:0] In0,
    input  wire [WIDTH-1:0] In1,
    input  wire [WIDTH-1:0] In2,
    input  wire [WIDTH-1:0] In3,
    input  wire [1:0]       Sel,
    output wire [WIDTH-1:0] Out
);

    wire S0, S1, S2, S3;
    assign S0 = ~Sel[1] & ~Sel[0];
    assign S1 = ~Sel[1] &  Sel[0];
    assign S2 =  Sel[1] & ~Sel[0];
    assign S3 =  Sel[1] &  Sel[0];

    genvar i;
    generate
        for (i=0; i<WIDTH; i=i+1) begin : gen_mux
            wire a, b, c, d;
            and u_and0(a, In0[i], S0);
            and u_and1(b, In1[i], S1);
            and u_and2(c, In2[i], S2);
            and u_and3(d, In3[i], S3);
            or  u_or(Out[i], a, b, c, d);
        end
    endgenerate

endmodule
