# RISC-V-5-STAGE-PIPELINED-BRANCH-PREDICTOR
Riscv_5_stage_pipelined_processor_branch_predictor



5-Stage Pipelined RISC-V Processor

A 32-bit 5-stage pipelined RISC-V processor designed in Verilog HDL.

Pipeline

IF → ID → EX → MEM → WB

Features

- RV32I subset: R-type, I-type, LW, SW, BEQ, BNE, JAL
- Data forwarding
- Load-use hazard detection & stall
- Branch/Jump handling with pipeline flush
- 2-bit Branch Predictor + BTB
- BTFNT cold-start prediction
- CPI, IPC & branch prediction accuracy measurement

Main Modules

ALU
Register File
Immediate Generator
Control Unit
Hazard Detection Unit
Forwarding Unit
Branch Predictor
Instruction Memory
Data Memory
Pipeline Registers
CPI Counter


Project Flow

Instruction Fetch
       ↓
Instruction Decode
       ↓
Execute + Forwarding
       ↓
Memory Access
       ↓
Write Back

Project: 5-Stage Pipelined RISC-V Processor with Branch Prediction & CPI Measurement
