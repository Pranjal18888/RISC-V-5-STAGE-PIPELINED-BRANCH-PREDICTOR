module alu (
    input  [31:0] a,
    input  [31:0] b,
    input  [3:0]  alu_ctrl,
    output reg [31:0] result,
    output        zero
);

    localparam ADD=4'b0000,
               SUB=4'b0001,
               AND_OP=4'b0010,
               OR_OP =4'b0011,
               XOR_OP=4'b0100,
               SLL_OP=4'b0101,
               SRL_OP=4'b0110,
               SRA_OP=4'b0111,
               SLT_OP=4'b1000;

    always @(*) begin
        case (alu_ctrl)
            ADD    : result = a + b;
            SUB    : result = a - b;
            AND_OP : result = a & b;
            OR_OP  : result = a | b;
            XOR_OP : result = a ^ b;
            SLL_OP : result = a << b[4:0];
            SRL_OP : result = a >> b[4:0];
            SRA_OP : result = $signed(a) >>> b[4:0];
            SLT_OP : result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            default: result = 32'd0;
        endcase
    end

    assign zero = (result == 32'd0);

endmodule
