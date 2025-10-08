# 5-Bit Signed Multiplier using Booth's Algorithm in Verilog

This repository contains the RTL design and verification environment for a multi-cycle 5-bit signed multiplier. The architecture implements Booth's algorithm to efficiently handle two's complement multiplication of both positive and negative numbers.

The design is partitioned into a datapath and a control path, where a Finite-State Machine (FSM) sequences the necessary add, subtract, and shift operations.

---

## Key Features

- **Booth's Algorithm:** Implements the efficient Booth's algorithm for 2's complement signed multiplication.
- **Multi-Cycle Architecture:** The multiplication is performed over multiple clock cycles, optimizing for resource usage.
- **FSM-Based Controller:** A synthesizable Finite-State Machine (FSM) manages the state transitions and generates control signals for the datapath.
- **Modular Datapath:** The datapath is built from distinct components, including an ALU (adder/subtractor), shift registers for the accumulator (A) and multiplier (Q), and a counter.
- **Parameterized Design:** The bit-width can be easily scaled by adjusting parameters.

---

## Algorithm and Architecture

The design is based on the standard datapath-controller model. Booth's algorithm iteratively inspects the two least significant bits of the multiplier (`Q[0]` and an auxiliary bit `Q[-1]`) to decide whether to add the multiplicand, subtract it, or do nothing before arithmetically shifting the partial product.

### State Diagram

The FSM controller implements the following state diagram to sequence the operations over several states, from initialization to completion.

![Booth's Algorithm FSM]

### Hardware Architecture

-   **Control Path:** A Moore FSM that takes the counter status (`eqz`), `Q[0]`, and `Q[-1]` as inputs to determine the next state and generate control signals (`ldA`, `shift`, `addsub`, `count`, etc.).
-   **Datapath:** Contains the main hardware units:
    -   **Register A (Accumulator):** A 5-bit shift register that holds the upper half of the partial product.
    -   **Register Q (Multiplier):** A 5-bit shift register that initially holds the multiplier.
    -   **Register M (Multiplicand):** A 5-bit register to hold the multiplicand.
    -   **ALU:** A combinational block that performs `A+M` or `A-M`.
    -   **Counter:** A down-counter to track the number of iterations.

---

## How to Run the Simulation

1.  **Setup:** Place all the Verilog source files from the `rtl` and `verification` directories into a new project in your Verilog simulator (e.g., Xilinx Vivado, ModelSim).

2.  **Run Simulation:** Set the `testbench.v` file as the top module and run the behavioral simulation.

3.  **Analyze Results:** The testbench is configured to multiply **-10** (multiplicand) by **13** (multiplier). You can observe the state transitions, register values (`A`, `Q`), and control signals in the waveform viewer to trace the algorithm's execution step-by-step. The final 10-bit result will be the concatenated value of registers `{A, Q}`.

---

## Verification

The functionality of the multiplier was verified using a self-checking Verilog testbench. The verification process included tests for all four quadrant multiplications to ensure correctness for all sign combinations:
-   Positive x Positive
-   Positive x Negative
-   Negative x Positive
-   Negative x Negative
