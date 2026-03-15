# 4-Bit Structural Booth Multiplier

A gate-level Verilog implementation of **Booth's Multiplication Algorithm**. This project demonstrates a hardware-centric approach to signed binary multiplication using a sequential datapath.

## Purpose
The multiplier is designed to perform signed multiplication using Two's Complement arithmetic. Unlike standard unsigned multipliers, this implementation handles negative numbers natively by evaluating bit pairs and performing arithmetic shifts.

## Numerical Range
The module supports 4-bit signed inputs and provides an 8-bit signed product:
* **Input Range:** -7 to 8
* **Output Range:** -56 to +64

> **Technical Note:** In 4-bit Two's Complement, -8 is a unique edge case. This multiplier is designed to handle the "most negative number" through sequential arithmetic shifts.

---

## Architecture
The design is strictly structural (gate-level), avoiding behavioral operators where possible. Key components include:
* **Sequential Control:** 3-bit UP-counter and equality comparators to manage the 4-cycle multiplication process.
* **Datapath:** 4-bit Ripple Carry Adder (RCA) and Subtractor.
* **Storage:** 4-bit registers with asynchronous reset for $M$, $Q$, and $Accumulator$.
* **Shifter:** Combinational Arithmetic Shift Right (ASR) logic to maintain sign extension.

---

## Getting Started

### Prerequisites
* **Icarus Verilog:** Compiler and simulator.
* **GTKWave:** (Optional) To view waveform output (`.vcd` files).

### Compilation and Execution
To compile the source files and run the testbench, use the following commands in your terminal:

```bash
# Compile the design and testbench
iverilog -o tb_booth.vvp *.v

# Run the simulation
vvp tb_booth.vvp
