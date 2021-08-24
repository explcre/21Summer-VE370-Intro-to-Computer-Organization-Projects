`timescale 1ns / 1ps

module program_counter(
  input clk,
  input [31:0] in,
  output reg [31:0] out
);
  
  initial begin
    out = -4;
  end

  always @(negedge clk) begin
    out = in;
  end

endmodule
