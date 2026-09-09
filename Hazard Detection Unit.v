module hazard_unit (
    input        mem_read_ex,
    input  [4:0] rd_ex,
    input  [4:0] rs1_id,
    input  [4:0] rs2_id,
    output       stall
);

    assign stall =
        mem_read_ex &&
        (rd_ex != 5'd0) &&
        ((rd_ex == rs1_id) ||
         (rd_ex == rs2_id));

endmodule
