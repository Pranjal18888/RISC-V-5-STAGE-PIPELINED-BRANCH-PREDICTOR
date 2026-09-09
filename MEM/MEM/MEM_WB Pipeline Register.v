reg reg_write_w_r;

reg [1:0] result_src_w_r;

reg [31:0] alu_result_w_r;
reg [31:0] mem_data_w_r;
reg [31:0] pc_plus4_w_r;

reg [4:0] rd_w_r;

reg valid_w;

always @(posedge clk or posedge rst) begin

    if (rst) begin

        reg_write_w_r <= 0;
        result_src_w_r <= 0;

        alu_result_w_r <= 0;
        mem_data_w_r   <= 0;
        pc_plus4_w_r   <= 0;

        rd_w_r <= 0;
        valid_w <= 0;

    end

    else begin

        reg_write_w_r <= reg_write_m_r;
        result_src_w_r <= result_src_m_r;

        alu_result_w_r <= alu_result_m_r;
        mem_data_w_r   <= mem_read_data_m;
        pc_plus4_w_r   <= pc_plus4_m_r;

        rd_w_r <= rd_m_r;

        valid_w <= valid_m;

    end

end
