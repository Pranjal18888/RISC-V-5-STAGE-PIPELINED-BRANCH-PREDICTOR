reg [31:0] pc_d;
reg [31:0] pc_plus4_d;
reg [31:0] instr_d;

reg valid_d;
reg predict_taken_d;

always @(posedge clk or posedge rst) begin

    if (rst || flush_d) begin

        pc_d          <= 0;
        pc_plus4_d    <= 0;
        instr_d       <= 0;
        valid_d       <= 0;
        predict_taken_d <= 0;

    end

    else if (!stall_f) begin

        pc_d       <= pc_f;
        pc_plus4_d <= pc_plus4_f;
        instr_d    <= instr_f;

        valid_d <= (instr_f != 32'd0);

        predict_taken_d <= predict_taken_f;

    end

end
