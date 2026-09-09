wire [31:0] src_a_e;

wire [31:0] fwd_rd2_e;

wire [31:0] src_b_e;

assign src_a_e =
    (forward_a == 2'b10) ? alu_result_m :
    (forward_a == 2'b01) ? result_w :
                           rd1_e;

assign fwd_rd2_e =
    (forward_b == 2'b10) ? alu_result_m :
    (forward_b == 2'b01) ? result_w :
                           rd2_e;

assign src_b_e =
    alu_src_e ? imm_ext_e : fwd_rd2_e;

wire [31:0] alu_out_e;
wire alu_zero_e;

alu u_alu (
    .a(src_a_e),
    .b(src_b_e),
    .alu_ctrl(alu_ctrl_e),
    .result(alu_out_e),
    .zero(alu_zero_e)
);
