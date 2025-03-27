# Sequence Detector Verilog Project

## Project Overview 🚀

This project involves the design and testing of a **Sequence Detector** using Verilog HDL. The sequence detector identifies specific sequences of input data using flip-flops and combinational logic. Two different designs are implemented:

1. **Behavioral Model**: A high-level Verilog description that abstracts the hardware details.
2. **Structural Model**: A low-level Verilog description that explicitly defines the flip-flops and logic gates used.

Both models are tested using the same input sequence, and their outputs are compared to ensure functional correctness.

## Project Structure 📁

The project contains the following Verilog modules:

### 1. **SequenceDetector (Behavioral Model)** 🧩
This module is implemented using T-Flip Flops (T-FF) and combinational logic to detect a specific sequence in the input data. The behavior is described at a higher level, focusing on what the circuit should do rather than how it is implemented.

- **Inputs**:
  - `clk1`: Clock signal.
  - `reset1`: Asynchronous reset.
  - `data_in1`: Input data bit.
  
- **Output**:
  - `sequence_detected1`: A signal indicating if the desired sequence is detected.

### 2. **T_FF (T-Flip Flop)** 🔄
This module defines the behavior of a T-Flip Flop (T-FF), which toggles its output based on the input signal `T` and the clock.

- **Inputs**:
  - `T`: Toggle input.
  - `clk`: Clock signal.
  - `reset`: Reset signal.
  
- **Output**:
  - `Q`: Output of the flip-flop.

### 3. **AND2 (2-input AND Gate)** ⚙️
This module implements a simple 2-input AND gate used in the structural design.

- **Inputs**:
  - `A`, `B`: Input signals.
  
- **Output**:
  - `Y`: Output signal (A AND B).

### 4. **OR2 (2-input OR Gate)** 🌐
This module implements a simple 2-input OR gate used in the structural design.

- **Inputs**:
  - `A`, `B`: Input signals.
  
- **Output**:
  - `Y`: Output signal (A OR B).

### 5. **StructuralSequenceDetector (Structural Model)** 🏗️
This module is the low-level structural implementation of the sequence detector. It uses T-Flip Flops and logic gates to explicitly construct the detection circuit.

- **Inputs**:
  - `clk2`: Clock signal.
  - `reset2`: Asynchronous reset.
  - `data_in2`: Input data bit.
  
- **Output**:
  - `sequence_detected2`: A signal indicating if the desired sequence is detected.

### 6. **Testbenches (TB)** 🧪
Testbenches are written for both the behavioral and structural models, providing stimulus for the inputs and checking the correctness of the output.

- **SequenceDetector_TB**: Testbench for the behavioral model of the sequence detector.
- **SequenceDetector_TB2**: Testbench for the structural model of the sequence detector.
- **SequenceDetector_Compare_TB**: Testbench comparing the outputs of the behavioral and structural models to verify their equivalence.

## Design Flow 💡

1. **Module Definition**: Each Verilog module was created to perform specific functions, including the flip-flops, AND/OR gates, and the sequence detector.
2. **Testbenches**: Two separate testbenches were written to test both the behavioral and structural designs. The same input sequence is applied to both models, and the outputs are compared to check for functional correctness.
3. **Comparison**: The outputs from both models (behavioral and structural) are compared to ensure the designs are identical in functionality.

## Test Cases 📝

The following test cases were used to verify the functionality of the sequence detector:

- **Test Case 1**: Apply a sequence of `data_in` to check if the sequence detector detects the specific sequence.
- **Test Case 2**: Compare outputs from both behavioral and structural designs to verify that both models produce identical results for the same input sequence.

## Clock Generation ⏰

The clock signal for both the behavioral and structural models is generated with a 50% duty cycle, and each test case is applied for multiple clock cycles to observe the behavior over time.

## Simulation and Results 📊

The simulation results for both the **Behavioral Sequence Detector** and the **Structural Sequence Detector** are compared in the `SequenceDetector_Compare_TB` module. If any discrepancies are found, an error message is displayed, indicating a mismatch between the expected and actual outputs.

## Tools and Software 🛠️

- **Quartus**: Used for Verilog coding, synthesis, and simulation.
- **ModelSim**: Used to simulate the design and generate waveform outputs.

## Conclusion 🎉

This project demonstrates how a sequence detector can be designed and implemented in Verilog using both behavioral and structural models. The designs were tested and verified using simulation to ensure their correctness. Comparing the outputs of the two models further confirmed that both designs behave identically for the given inputs.

---

Thank you for reviewing this **Sequence Detector Verilog Project**! 😄
