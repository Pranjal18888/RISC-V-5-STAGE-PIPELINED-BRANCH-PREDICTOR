reg reg_write_e;
reg alu_src_e;
reg mem_write_e;
reg mem_read_e;
reg branch_e;
reg jump_e;

reg [1:0] result_src_e;
reg [3:0] alu_ctrl_e;
reg [2:0] funct3_e;

reg [31:0] rd1_e;
reg [31:0] rd2_e;
reg [31:0] imm_ext_e;

reg [31:0] pc_e;
reg [31:0] pc_plus4_e;

reg [4:0] rs1_e;
reg [4:0] rs2_e;
reg [4:0] rd_e;

reg valid_e;
reg predict_taken_e;

always @(posedge clk or posedge rst) begin

    if (rst || flush_e) begin

        reg_write_e <= 0;
        alu_src_e   <= 0;
        mem_write_e <= 0;
        mem_read_e  <= 0;
        branch_e    <= 0;
        jump_e      <= 0;

        result_src_e <= 0;
        alu_ctrl_e   <= 0;
        funct3_e     <= 0;

        rd1_e <= 0;
        rd2_e <= 0;
        imm_ext_e <= 0;

        pc_e <= 0;
        pc_plus4_e <= 0;

        rs1_e <= 0;
        rs2_e <= 0;
        rd_e  <= 0;

        valid_e <= 0;
        predict_taken_e <= 0;

    end

    else begin

        reg_write_e <= reg_write_d;
        alu_src_e   <= alu_src_d;
        mem_write_e <= mem_write_d;
        mem_read_e  <= mem_read_d;
        branch_e    <= branch_d;
        jump_e      <= jump_d;

        result_src_e <= result_src_d;
        alu_ctrl_e   <= alu_ctrl_d;

        funct3_e <= funct3_d;

        rd1_e <= rd1_d;
        rd2_e <= rd2_d;

        imm_ext_e <= imm_ext_d;

        pc_e <= pc_d;
        pc_plus4_e <= pc_plus4_d;

        rs1_e <= rs1_d;
        rs2_e <= rs2_d;
        rd_e  <= rd_d;

        valid_e <= valid_d;

        predict_taken_e <= predict_taken_d;

    end

end
