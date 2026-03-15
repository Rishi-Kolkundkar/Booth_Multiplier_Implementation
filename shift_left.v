module shift_left (
    input  wire [7:0] In,
    output wire [7:0] Out
);
    
    assign Out = { In[6:0], 1'b0 };
endmodule