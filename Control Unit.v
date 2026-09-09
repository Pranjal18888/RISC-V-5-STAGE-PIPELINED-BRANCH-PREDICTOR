module control_unit (
    input  [6:0] opcode,
    input  [2:0] funct3,
    input  [6:0] funct7,

    output reg       reg_write,
    output reg       alu_src,
    output reg       mem_write,
    output reg       mem_read,
    output reg       branch,
    output reg       jump,

    output reg [1:0] result_src,
    output reg [2:0] imm_src,
    output reg [3:0] alu_ctrl
);

    localparam OP_RTYPE = 7'b0110011;
    localparam OP_ITYPE = 7'b0010011;
    localparam OP_LOAD  = 7'b0000011;
    localparam OP_STORE = 7'b0100011;
    localparam OP_BRANCH= 7'b1100011;
    localparam OP_JAL   = 7'b1101111;

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

        reg_write  = 0;
        alu_src    = 0;
        mem_write  = 0;
        mem_read   = 0;
        branch     = 0;
        jump       = 0;
        result_src = 2'b00;
        imm_src    = 3'b000;
        alu_ctrl   = ADD;

        case(opcode)

            OP_RTYPE: begin
                reg_write = 1;

                case(funct3)
                    3'b000: alu_ctrl = funct7[5] ? SUB : ADD;
                    3'b001: alu_ctrl = SLL_OP;
                    3'b010: alu_ctrl = SLT_OP;
                    3'b100: alu_ctrl = XOR_OP;
                    3'b101: alu_ctrl = funct7[5] ? SRA_OP : SRL_OP;
                    3'b110: alu_ctrl = OR_OP;
                    3'b111: alu_ctrl = AND_OP;
                endcase
            end

            OP_ITYPE: begin
                reg_write = 1;
                alu_src   = 1;

                case(funct3)
                    3'b000: alu_ctrl = ADD;
                    3'b001: alu_ctrl = SLL_OP;
                    3'b010: alu_ctrl = SLT_OP;
                    3'b100: alu_ctrl = XOR_OP;
                    3'b101: alu_ctrl = funct7[5] ? SRA_OP : SRL_OP;
                    3'b110: alu_ctrl = OR_OP;
                    3'b111: alu_ctrl = AND_OP;
                endcase
            end

            OP_LOAD: begin
                reg_write  = 1;
                alu_src    = 1;
                mem_read   = 1;
                result_src = 2'b01;
                imm_src    = 3'b000;
                alu_ctrl   = ADD;
            end

            OP_STORE: begin
                alu_src   = 1;
                mem_write = 1;
                imm_src   = 3'b001;
                alu_ctrl  = ADD;
            end

            OP_BRANCH: begin
                branch   = 1;
                imm_src  = 3'b010;
                alu_ctrl = SUB;
            end

            OP_JAL: begin
                reg_write  = 1;
                jump       = 1;
                result_src = 2'b10;
                imm_src    = 3'b011;
            end

        endcase
    end

endmodule
