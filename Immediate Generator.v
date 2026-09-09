module imm_gen (
    input  [31:0] instr,
    input  [2:0]  imm_src,
    output reg [31:0] imm_ext
);

    always @(*) begin
        case (imm_src)

            3'b000:
                imm_ext = {{20{instr[31]}},
                           instr[31:20]};

            3'b001:
                imm_ext = {{20{instr[31]}},
                           instr[31:25],
                           instr[11:7]};

            3'b010:
                imm_ext = {{19{instr[31]}},
                           instr[31],
                           instr[7],
                           instr[30:25],
                           instr[11:8],
                           1'b0};

            3'b011:
                imm_ext = {{11{instr[31]}},
                           instr[31],
                           instr[19:12],
                           instr[20],
                           instr[30:21],
                           1'b0};

            default:
                imm_ext = 32'd0;
        endcase
    end

endmodule
