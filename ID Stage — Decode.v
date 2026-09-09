wire [6:0] opcode_d = instr_d[6:0];
wire [2:0] funct3_d = instr_d[14:12];
wire [6:0] funct7_d = instr_d[31:25];

wire [4:0] rs1_d = instr_d[19:15];
wire [4:0] rs2_d = instr_d[24:20];
wire [4:0] rd_d  = instr_d[11:7];

wire [31:0] rd1_d;
wire [31:0] rd2_d;

wire [31:0] imm_ext_d;

control_unit u_control (
    .opcode(opcode_d),
    .funct3(funct3_d),
    .funct7(funct7_d),

    .reg_write(reg_write_d),
    .alu_src(alu_src_d),
    .mem_write(mem_write_d),
    .mem_read(mem_read_d),
    .branch(branch_d),
    .jump(jump_d),

    .result_src(result_src_d),
    .imm_src(imm_src_d),
    .alu_ctrl(alu_ctrl_d)
);

imm_gen u_immgen (
    .instr(instr_d),
    .imm_src(imm_src_d),
    .imm_ext(imm_ext_d)
);

reg_file u_regfile (
    .clk(clk),
    .we3(reg_write_w),
    .ra1(rs1_d),
    .ra2(rs2_d),
    .wa3(rd_w),
    .wd3(result_w),
    .rd1(rd1_d),
    .rd2(rd2_d)
);
