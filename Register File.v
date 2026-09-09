module reg_file (
    input         clk,
    input         we3,
    input  [4:0]  ra1,
    input  [4:0]  ra2,
    input  [4:0]  wa3,
    input  [31:0] wd3,
    output [31:0] rd1,
    output [31:0] rd2
);

    reg [31:0] regs [0:31];
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            regs[i] = 32'd0;
    end

    always @(posedge clk) begin
        if (we3 && (wa3 != 5'd0))
            regs[wa3] <= wd3;
    end

    assign rd1 = (ra1 == 5'd0) ? 32'd0 :
                 (we3 && (wa3 == ra1)) ? wd3 :
                 regs[ra1];

    assign rd2 = (ra2 == 5'd0) ? 32'd0 :
                 (we3 && (wa3 == ra2)) ? wd3 :
                 regs[ra2];

endmodule
