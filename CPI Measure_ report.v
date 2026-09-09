reg [31:0] cycle_count;
reg [31:0] instr_count;

reg [31:0] last_retire_cycle;

real cpi;

reg [31:0] branch_total_count;
reg [31:0] branch_mispredict_count;

always @(posedge clk or posedge rst) begin

    if (rst) begin

        cycle_count <= 0;
        instr_count <= 0;

        last_retire_cycle <= 0;

        branch_total_count <= 0;
        branch_mispredict_count <= 0;

    end

    else begin

        cycle_count <= cycle_count + 1;

        if (valid_w) begin

            instr_count <= instr_count + 1;

            last_retire_cycle <=
                cycle_count + 1;

        end

        if (valid_e &&
            (branch_e || jump_e)) begin

            branch_total_count <=
                branch_total_count + 1;

            if (pc_src_e)
                branch_mispredict_count <=
                    branch_mispredict_count + 1;

        end

    end

end

always @(*) begin

    cpi =
        (instr_count == 0) ?
        0.0 :
        (last_retire_cycle * 1.0) /
        instr_count;

end


task print_cpi_report;
begin

    $display("=====================================");

    $display("Total Clock Cycles : %0d",
             cycle_count);

    $display("Cycles until last instruction retired : %0d",
             last_retire_cycle);

    $display("Total Instructions : %0d",
             instr_count);

    $display("CPI : %0.3f",
             cpi);

    $display("IPC : %0.3f",
             (instr_count == 0) ?
             0.0 : (1.0/cpi));

    $display("-------------------------------------");

    $display("Branch/Jump Instructions : %0d",
             branch_total_count);

    $display("Mispredictions : %0d",
             branch_mispredict_count);

    $display("Predictor Accuracy : %0.1f %%",
             (branch_total_count == 0) ?
             100.0 :
             (100.0 *
             (branch_total_count -
              branch_mispredict_count)) /
             branch_total_count);

    $display("=====================================");

end
endtask
