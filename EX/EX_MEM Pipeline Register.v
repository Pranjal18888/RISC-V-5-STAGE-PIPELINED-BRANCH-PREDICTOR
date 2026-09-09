reg reg_write_m_r;
reg mem_write_m_r;
reg mem_read_m_r;

reg [1:0] result_src_m_r;

reg [31:0] alu_result_m_r;
reg [31:0] write_data_m_r;
reg [31:0] pc_plus4_m_r;

reg [4:0] rd_m_r;

reg valid_m;

always @(posedge clk or posedge rst) begin

    if (rst) begin

        reg_write_m_r <= 0;
        mem_write_m_r <= 0;
        mem_read_m_r  <= 0;

        result_src_m_r <= 0;

        alu_result_m_r <= 0;
        write_data_m_r <= 0;
        pc_plus4_m_r   <= 0;

        rd_m_r <= 0;
        valid_m <= 0;

    end

    else begin

        reg_write_m_r <= reg_write_e;
        mem_write_m_r <= mem_write_e;
        mem_read_m_r  <= mem_read_e;

        result_src_m_r <= result_src_e;

        alu_result_m_r <= alu_out_e;
        write_data_m_r <= fwd_rd2_e;
        pc_plus4_m_r   <= pc_plus4_e;

        rd_m_r <= rd_e;

        valid_m <= valid_e;

    end

end

assign reg_write_m = reg_write_m_r;
assign rd_m = rd_m_r;
assign alu_result_m = alu_result_m_r;
