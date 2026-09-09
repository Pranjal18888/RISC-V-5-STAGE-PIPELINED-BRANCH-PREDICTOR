reg [31:0] pc_f;

wire [31:0] pc_plus4_f;
wire [31:0] pc_next_f;

reg [31:0] imem [0:255];

wire [31:0] instr_f;

assign pc_plus4_f = pc_f + 32'd4;

assign instr_f = imem[pc_f[9:2]];

always @(posedge clk or posedge rst) begin

    if (rst)
        pc_f <= 32'd0;

    else if (!stall_f)
        pc_f <= pc_next_f;

end
