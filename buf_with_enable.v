module buf_with_enable (
    input  wire [3:0] in,
    input  wire       en,   // control signal
    output wire [3:0] out
);
    bufif0 u_buf0(out[0], in[0], en);  // buffer active when en=0
    bufif0 u_buf1(out[1], in[1], en);
    bufif0 u_buf2(out[2], in[2], en);
    bufif0 u_buf3(out[3], in[3], en);
endmodule
