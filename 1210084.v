module SequenceDetector (
  input wire clk1,         // Clock input
  input wire reset1,       // Asynchronous reset input
  input wire data_in1,     // Data input
  output wire sequence_detected1  // Output indicating sequence detection
);

reg t1, t2, t3, t4;  // T-Flip Flops

always @(posedge clk1 or posedge reset1) begin
  if (reset1) begin
    t1 <= 1'b0;
    t2 <= 1'b0;
    t3 <= 1'b0;
    t4 <= 1'b0;
  end else begin
    // T-Flip Flop logic
    t1 <= data_in1 ^ t4;
    t2 <= t1 ^ t4;
    t3 <= t2 ^ t4;
    t4 <= t3 ^ t4;
  end
end

assign sequence_detected1 = (t4 == 1'b1);

endmodule


			

module T_FF (input T, input clk, input reset, output reg Q);
  always @(posedge clk or posedge reset) begin
    if (reset)
      Q <= 1'b0;
    else
      Q <= T ^ Q;
  end
endmodule

module AND2 (input A, input B, output Y);
  assign Y = A & B;
endmodule

module OR2 (input A, input B, output Y);
  assign Y = A | B;
endmodule

module StructuralSequenceDetector (
  input wire clk2,         // Clock input
  input wire reset2,       // Asynchronous reset input
  input wire data_in2,     // Data input
  output wire sequence_detected2 // Output indicating sequence detection
);

wire t1, t2, t3, t4;

T_FF ff1 (.T(data_in2), .clk(clk2), .reset(reset2), .Q(t1));
T_FF ff2 (.T(t1), .clk(clk2), .reset(reset2), .Q(t2));
T_FF ff3 (.T(t2), .clk(clk2), .reset(reset2), .Q(t3));
T_FF ff4 (.T(t3), .clk(clk2), .reset(reset2), .Q(t4));

AND2 and1 (.A(t1), .B(t2), .Y(sequence_detected2));
OR2 or1 (.A(sequence_detected2), .B(t3), .Y(sequence_detected2));

endmodule


module SequenceDetector_TB;

  // Inputs
  reg clk;
  reg reset;
  reg data_in;

  // Outputs
  wire sequence_detected;

  // Instantiate the SequenceDetector module
 SequenceDetector UUT1 (
    .clk1(clk),
    .reset1(reset),
    .data_in1(data_in),
    .sequence_detected1(sequence_detected)
  );

  // Clock generation
  always begin
    clk = ~clk; // Generate a clock signal with 50% duty cycle
    #5; // Half of the clock period
  end

  // Initial values
  initial begin
    clk = 0;
    reset = 0;
    data_in = 0;
    
    // Reset the circuit
    reset = 1;
    #10; // Hold reset for a few clock cycles
    reset = 0;
  end

  // Stimulus generation
  initial begin
    // Test with a sequence of data
    data_in = 0;
    #10;
    data_in = 1;
    #10;
    data_in = 0;
    #10;
    data_in = 1;
    #10;
    data_in = 1; // This should trigger the sequence_detected signal
    #10;
    data_in = 0;
    #10;
    data_in = 1;
    #10;
    data_in = 1;
    #10;
    data_in = 0; // Reset the sequence_detected signal
    #10;
    data_in = 1;
    #10;
    data_in = 0;
    #10;
    data_in = 0;
    $finish;
  end

endmodule	  


module SequenceDetector_TB2;

  // Inputs
  reg clk;
  reg reset;
  reg data_in;

  // Outputs
  wire sequence_detected;

  // Instantiate the SequenceDetector module
  StructuralSequenceDetector UUT (
    .clk2(clk),
    .reset2(reset),
    .data_in2(data_in),
    .sequence_detected2(sequence_detected)
  );

  // Clock generation
  always begin
    clk = ~clk; // Generate a clock signal with 50% duty cycle
    #5; // Half of the clock period
  end

  // Initial values
  initial begin
    clk = 0;
    reset = 0;
    data_in = 0;
    
    // Reset the circuit
    reset = 1;
    #10; // Hold reset for a few clock cycles
    reset = 0;
  end

  // Stimulus generation
  initial begin
    // Test with a sequence of data
    data_in = 0;
    #10;
    data_in = 1;
    #10;
    data_in = 0;
    #10;
    data_in = 1;
    #10;
    data_in = 1; // This should trigger the sequence_detected signal
    #10;
    data_in = 0;
    #10;
    data_in = 1;
    #10;
    data_in = 1;
    #10;
    data_in = 0; // Reset the sequence_detected signal
    #10;
    data_in = 1;
    #10;
    data_in = 0;
    #10;
    data_in = 0;
    $finish;
  end

endmodule	  


module SequenceDetector_Compare_TB;

  // Inputs for Behavioral SequenceDetector
  reg b_clk;
  reg b_reset;
  reg b_data_in;

  // Inputs for Structural SequenceDetector
  reg s_clk;
  reg s_reset;
  reg s_data_in;

  // Outputs for Behavioral SequenceDetector
  wire b_sequence_detected;

  // Outputs for Structural SequenceDetector
  wire s_sequence_detected;

  // Instantiate the Behavioral SequenceDetector
  SequenceDetector b_DUT (
    .clk1(b_clk),
    .reset1(b_reset),
    .data_in1(b_data_in),
    .sequence_detected1(b_sequence_detected)
  );

  // Instantiate the Structural SequenceDetector
  StructuralSequenceDetector s_DUT (
    .clk2(s_clk),
    .reset2(s_reset),
    .data_in2(s_data_in),
    .sequence_detected2(s_sequence_detected)
  );

  // Clock generation for both designs
  always begin
    b_clk = ~b_clk; // Generate a clock signal for Behavioral SequenceDetector
    s_clk = ~s_clk; // Generate a clock signal for Structural SequenceDetector
    #5; // Half of the clock period
  end

  // Initial values for both designs
  initial begin
    b_clk = 0;
    s_clk = 0;
    b_reset = 0;
    s_reset = 0;
    b_data_in = 0;
    s_data_in = 0;
    
    // Reset both designs
    b_reset = 1;
    s_reset = 1;
    #10; // Hold reset for a few clock cycles
    b_reset = 0;
    s_reset = 0;
  end

  // Stimulus generation and comparison
  initial begin
    // Test with a sequence of data
    integer errors;
    errors = 0;																							   

    // Apply the same input sequence to both designs
    repeat (5) begin
      b_data_in = $random;
      s_data_in = b_data_in;

      #10; // Wait for one clock cycle

      // Compare the outputs
      if (b_sequence_detected !== s_sequence_detected) begin
        $display("Error: Behavioral SequenceDetector detected = %b, Structural SequenceDetector detected = %b", b_sequence_detected, s_sequence_detected);
        errors = errors + 1;
      end
    end

    // Check for errors
    if (errors == 0) begin
      $display("No errors detected.");
    end else begin
      $display("Total errors detected: %d", errors);
    end

    $finish;
  end

endmodule		   

