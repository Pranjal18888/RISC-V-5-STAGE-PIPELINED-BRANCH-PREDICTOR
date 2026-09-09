//=====================================================================
// Testbench for riscv_top -- COMBINED test
// (original hazard/forwarding/flush demo + a repeating loop so the
//  branch predictor actually gets a chance to learn)
//
// Program (RV32I), word-indexed addresses (address = index * 4):
//   0 : addi x1, x0, 5        x1 = 5
//   1 : addi x2, x0, 10       x2 = 10
//   2 : addi x12,x0, 6        x12 = 6   (NEW loop counter)
//   3 : LOOP: add x3, x1, x2  x3 = 15   (tests EX/MEM forwarding)   <-- branch target
//   4 : sub  x4, x2, x1       x4 = 5
//   5 : sw   x3, 0(x0)        mem[0] = 15
//   6 : lw   x5, 0(x0)        x5 = 15
//   7 : add  x6, x5, x1       x6 = 20   (load-use hazard -> 1 stall, every iteration)
//   8 : addi x12,x12,-1       x12 -= 1
//   9 : bne  x12, x0, LOOP    loop back while x12 != 0   (offset -24)
//  10 : addi x8, x0, 7        x8 = 7    (reached once, after loop)
//  11 : jal  x9, +8           x9 = 48 (link), jumps to addr 52
//  12 : addi x10,x0, 55       FLUSHED (should never write x10)
//  13 : addi x11,x0, 11       x11 = 11  <END>
//
// The bne at word 9 executes 6 TIMES (same branch, repeated):
//   iterations 1-5 -> taken   (loop back to word 3)
//   iteration  6    -> NOT taken (falls through to word 10)
// This gives the branch predictor real repetition to learn the
// "taken" pattern, unlike a branch that only ever runs once.
//
// Expected final register values:
//   x1=5  x2=10 x3=15 x4=5 x5=15 x6=20 x8=7
//   x9=48 (JAL link) x10=0(untouched) x11=11 ; mem[0]=15
//   x12=0 (loop counter, ends at 0)
//=====================================================================

module testbench;

    reg clk;
    reg rst;

    riscv_top dut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Load the combined demo+loop program into instruction memory
    initial begin
        dut.imem[0]  = 32'h00500093; // addi x1,x0,5
        dut.imem[1]  = 32'h00A00113; // addi x2,x0,10
        dut.imem[2]  = 32'h00600613; // addi x12,x0,6      (loop counter)
        dut.imem[3]  = 32'h002081B3; // LOOP: add x3,x1,x2
        dut.imem[4]  = 32'h40110233; // sub  x4,x2,x1
        dut.imem[5]  = 32'h00302023; // sw   x3,0(x0)
        dut.imem[6]  = 32'h00002283; // lw   x5,0(x0)
        dut.imem[7]  = 32'h00128333; // add  x6,x5,x1      (load-use hazard)
        dut.imem[8]  = 32'hFFF60613; // addi x12,x12,-1
        dut.imem[9]  = 32'hFE0614E3; // bne  x12,x0,LOOP   (offset -24 -> word3)
        dut.imem[10] = 32'h00700413; // addi x8,x0,7
        dut.imem[11] = 32'h008004EF; // jal  x9,+8
        dut.imem[12] = 32'h03700513; // addi x10,x0,55     (flushed)
        dut.imem[13] = 32'h00B00593; // addi x11,x0,11
    end

    // Reset sequence
    initial begin
        rst = 1;
        #12;
        rst = 0;
    end

    // Run long enough for all 6 loop iterations + rest of program.
    initial begin
        #600;
        $display("\n========== FINAL REGISTER VALUES ==========");
        $display("x1  = %0d (expected 5)",  dut.u_regfile.regs[1]);
        $display("x2  = %0d (expected 10)", dut.u_regfile.regs[2]);
        $display("x3  = %0d (expected 15)", dut.u_regfile.regs[3]);
        $display("x4  = %0d (expected 5)",  dut.u_regfile.regs[4]);
        $display("x5  = %0d (expected 15)", dut.u_regfile.regs[5]);
        $display("x6  = %0d (expected 20)", dut.u_regfile.regs[6]);
        $display("x8  = %0d (expected 7)",  dut.u_regfile.regs[8]);
        $display("x9  = %0d (expected 48, JAL link)", dut.u_regfile.regs[9]);
        $display("x10 = %0d (expected 0, must stay untouched)", dut.u_regfile.regs[10]);
        $display("x11 = %0d (expected 11)", dut.u_regfile.regs[11]);
        $display("x12 = %0d (expected 0, loop counter)", dut.u_regfile.regs[12]);
        $display("mem[0] = %0d (expected 15)", dut.dmem[0]);
        $display("=============================================\n");

        dut.print_cpi_report;

        $finish;
    end

    // Optional cycle-by-cycle waveform trace
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, testbench);
    end

    // Live monitor of writeback stage
    always @(posedge clk) begin
        if (dut.reg_write_w && (dut.rd_w != 0))
            $display("t=%0t  WB: x%0d <= %0d", $time, dut.rd_w, dut.result_w);
    end

endmodule
