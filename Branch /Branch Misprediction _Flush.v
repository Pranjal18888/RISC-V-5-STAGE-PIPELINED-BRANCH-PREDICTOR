wire [31:0] pc_target_e;

assign pc_target_e =
    pc_e + imm_ext_e;

wire branch_cond_e;

assign branch_cond_e =
    (funct3_e == 3'b001) ?
    ~alu_zero_e :
    alu_zero_e;

wire actual_taken_e;

assign actual_taken_e =
    (branch_e & branch_cond_e) |
    jump_e;

wire pc_src_e;

assign pc_src_e =
    valid_e &&
    (branch_e || jump_e) &&
    (actual_taken_e != predict_taken_e);

wire [31:0] pc_correct_e;

assign pc_correct_e =
    actual_taken_e ?
    pc_target_e :
    pc_plus4_e;

assign pc_next_f =
    pc_src_e ?
    pc_correct_e :
    predict_taken_f ?
    predict_target_f :
    pc_plus4_f;

assign flush_d = pc_src_e;

wire flush_e = pc_src_e || stall_d;
