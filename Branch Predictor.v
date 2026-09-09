localparam BTB_BITS = 6;

reg [31:0] btb_target [0:63];
reg [1:0]  bht        [0:63];
reg        btb_valid  [0:63];

integer i;

initial begin
    for (i = 0; i < 64; i = i + 1) begin
        btb_valid[i]  = 0;
        bht[i]        = 2'b00;
        btb_target[i] = 0;
    end
end

wire [5:0] btb_idx_f = pc_f[7:2];

wire is_branch_f =
    (instr_f[6:0] == 7'b1100011);

wire is_jal_f =
    (instr_f[6:0] == 7'b1101111);

wire [31:0] imm_b_f =
    {{19{instr_f[31]}},
     instr_f[31],
     instr_f[7],
     instr_f[30:25],
     instr_f[11:8],
     1'b0};

wire [31:0] imm_j_f =
    {{11{instr_f[31]}},
     instr_f[31],
     instr_f[19:12],
     instr_f[20],
     instr_f[30:21],
     1'b0};

wire backward_branch_f =
    is_branch_f && instr_f[31];

wire cold_predict_taken_f =
    backward_branch_f || is_jal_f;

wire predict_taken_f =
    btb_valid[btb_idx_f] ?
    bht[btb_idx_f][1] :
    cold_predict_taken_f;

wire [31:0] early_target_f =
    is_jal_f ?
    pc_f + imm_j_f :
    pc_f + imm_b_f;

wire [31:0] predict_target_f =
    btb_valid[btb_idx_f] ?
    btb_target[btb_idx_f] :
    early_target_f;
