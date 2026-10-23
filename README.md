# 5-Stage Pipelined RISC-V Processor | COA-Based RTL Design

A 32-bit **RV32I** RISC-V processor with a classic 5-stage pipeline, written in Verilog HDL. It includes data forwarding, hazard detection, and a 2-bit dynamic branch predictor to reduce branch penalties and improve CPI.

## Features

- 32-bit RV32I base integer ISA
- 5-stage pipeline: **IF → ID → EX → MEM → WB**
- Data forwarding (EX/MEM and MEM/WB to EX)
- Load-use hazard detection with pipeline stalling
- Branch / jump flushing
- 2-bit dynamic branch predictor with **BTB** (Branch Target Buffer)
- **BTFNT** (Backward Taken, Forward Not Taken) prediction for cold-start
- Verilog testbench for instruction, hazard and performance verification

## Pipeline Overview

```
 ┌────┐   ┌────┐   ┌────┐   ┌─────┐   ┌────┐
 │ IF │ → │ ID │ → │ EX │ → │ MEM │ → │ WB │
 └────┘   └────┘   └────┘   └─────┘   └────┘
   ▲                  │
   │   Branch Predictor (BTB + 2-bit counters)
   └──────────────────┘ flush on misprediction
```

| Stage | Function |
|---|---|
| **IF** | Fetch instruction, PC update, branch prediction lookup |
| **ID** | Decode, register file read, immediate generation, hazard detection |
| **EX** | ALU operations, branch resolution, forwarding muxes |
| **MEM** | Data memory load/store |
| **WB** | Write result back to register file |

## Hazard Handling

| Hazard | Solution |
|---|---|
| RAW (ALU → ALU) | Data forwarding |
| Load-use | 1-cycle stall + forwarding |
| Control (branch/jump) | Branch prediction + pipeline flush on mispredict |

## Branch Prediction

- **2-bit saturating counter** per BTB entry (Strongly/Weakly Taken / Not Taken)
- **BTB** stores branch target addresses
- **BTFNT** used when no BTB entry exists (cold start): backward branches predicted taken, forward branches predicted not taken
- Misprediction is detected in EX and the wrongly fetched instructions are flushed


## Verification

The Verilog testbench checks:

- Correct execution of RV32I instructions
- Forwarding paths
- Load-use stall behavior
- Branch/jump flushing
- Memory load/store operations
- CPI and branch prediction performance

## Performance

| Metric | Value |
|---|---|
| CPI | X.XX |
| IPC | X.XX |
| Branch prediction accuracy | XX % |

## Tools

- Verilog HDL
- EDA Playground

## Key Concepts

`5-Stage Pipelining` · `Data Forwarding` · `Hazard Handling` · `Branch Prediction` · `CPI/IPC` · `RISC-V ISA`

