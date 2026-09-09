reg [31:0] result_w_mux;

always @(*) begin

    case(result_src_w_r)

        2'b00:
            result_w_mux = alu_result_w_r;

        2'b01:
            result_w_mux = mem_data_w_r;

        2'b10:
            result_w_mux = pc_plus4_w_r;

        default:
            result_w_mux = alu_result_w_r;

    endcase

end

assign result_w = result_w_mux;

assign reg_write_w = reg_write_w_r;
assign rd_w = rd_w_r;
