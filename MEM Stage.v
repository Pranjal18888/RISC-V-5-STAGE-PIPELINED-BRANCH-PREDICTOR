reg [31:0] dmem [0:255];

wire [31:0] mem_read_data_m;

assign mem_read_data_m =
    dmem[alu_result_m_r[9:2]];

always @(posedge clk) begin

    if (mem_write_m_r)
        dmem[alu_result_m_r[9:2]]
            <= write_data_m_r;

end
