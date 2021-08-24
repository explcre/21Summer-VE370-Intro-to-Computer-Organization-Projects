`timescale 1ns / 1ps

module data_memory(
  input clk,
  input MemWrite,
  input MemRead,
  input [63:0] ALUresult,
  input [63:0] writeData,
  output reg [63:0] readData
);

  parameter NONE = 64'b0;
  parameter SIZE = 128;
  reg [63:0] mem [SIZE - 1:0];

  // initially set default data to 0
  integer i;
  initial begin
    for (i = 0; i < SIZE; i = i + 1) begin
      mem[i] = NONE;
    end
  end

  // Write back Data Memory
  always @(*) begin
    if (MemRead == 1) begin
      readData = mem[ALUresult];
    end
  end

  // Write memory
  always @(negedge clk) begin
    if (MemWrite == 1) begin
      mem[ALUresult] = writeData;
    end
  end

endmodule
