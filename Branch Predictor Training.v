wire [5:0] btb_idx_e =
    pc_e[7:2];

always @(posedge clk) begin

    if (valid_e && (branch_e || jump_e)) begin

        btb_valid[btb_idx_e]  <= 1'b1;
        btb_target[btb_idx_e] <= pc_target_e;

        if (actual_taken_e) begin

            if (bht[btb_idx_e] != 2'b11)
                bht[btb_idx_e] <=
                    bht[btb_idx_e] + 1'b1;

        end

        else begin

            if (bht[btb_idx_e] != 2'b00)
                bht[btb_idx_e] <=
                    bht[btb_idx_e] - 1'b1;

        end

    end

end
