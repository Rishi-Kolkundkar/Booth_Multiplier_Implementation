module booth_multiplier_4bit (
    input  wire [3:0] M,   // multiplicand
    input  wire [3:0] Q,   // multiplier
    input  wire       CLK,
    input  wire       AR,  // async reset
    output wire [7:0] Product
);

    // --- State Control ---
    wire [2:0] cnt_res;
    wire is_start; 

    Counter_3bit_up comp_cnt(
        .CLK(CLK),
        .AR(AR),
        .CNT(cnt_res)
    );
    
    // If counter is 0, we are in the initialization phase.
    
    Comp_Equality_3bit startcomp (
        .A(cnt_res),
        .B(3'b000),
        .y(is_start)
    );

    // --- Internal Wires ---
    wire [3:0] Mval, Accval, Qval;
    wire q_1val;
    wire [3:0] alu_out, shifted_acc, shifted_q;


    

    //wire [3:0] acc_next   = is_start ? 4'b0000 : shifted_acc;

    wire [3:0] acc_next, q_next;
    wire q_1_next;

    mux_2_to_1 acc_sel(
        .In0(shifted_acc),
        .In1(4'b0000),
        .Sel(is_start),
        .Out(acc_next)
    );

    //wire [3:0] q_next     = is_start ? Q       : shifted_q;

    mux_2_to_1 q_sel (
        .In0(shifted_q),
        .In1(Q),
        .Sel(is_start),
        .Out(q_next)
    );


    //wire       q_1_next   = is_start ? 1'b0    : Qval[0];

    MUX_2 q_1_sel (
        .S(is_start),
        .Y(q_1_next),
        .A({1'b0, Qval[0]})    
    );

    // Registers 
    four_bit_register M_value(
        .D(M),            // M never changes
        .AR(AR),
        .CLK(CLK),
        .EN(is_start),    // Only load M at the very beginning
        .Q(Mval)
    );

    four_bit_register Acc(
        .D(acc_next),     // Fed by the Acc MUX
        .AR(AR),
        .CLK(CLK),
        .EN(1'b1),        // Always enabled, MUX decides what it loads
        .Q(Accval)
    );

    four_bit_register Q_value(
        .D(q_next),       // Fed by the Q MUX
        .AR(AR),
        .CLK(CLK),
        .EN(1'b1),
        .Q(Qval)
    );

    d_flip_flop_en Q_1(
        .D(q_1_next),     // Fed by the Q-1 MUX
        .AR(AR),
        .CLK(CLK),
        .EN(1'b1),
        .Q(q_1val)
    );

    // Arithmetic Logic Unit (ALU) 
    wire [3:0] add_res, sub_res;
    
    radder4 A1 (
        .A(Accval),
        .B(Mval),
        .Y(add_res)
    );

    sub A2 (
        .A(Accval),
        .B(Mval),
        .Y(sub_res)
    );

    // MUX selects Add, Sub, or Hold based on Booth's rules
    mux_4_to_1 alu_mux(
        .In0(Accval),     // 00: Hold
        .In1(add_res),    // 01: Add
        .In2(sub_res),    // 10: Sub
        .In3(Accval),     // 11: Hold
        .Sel({Qval[0], q_1val}),
        .Out(alu_out)
    );

   
    //assign shifted_acc = {alu_out[3], alu_out[3:1]};
    shift_right_arithmetic shift_acc_val (
        .A(alu_out),
        .Y(shifted_acc)
    );
    
    // (pull LSB from ALU out into MSB of Q)
    assign shifted_q   = {alu_out[0], Qval[3:1]};

  
    assign Product = {Accval, Qval};

endmodule
