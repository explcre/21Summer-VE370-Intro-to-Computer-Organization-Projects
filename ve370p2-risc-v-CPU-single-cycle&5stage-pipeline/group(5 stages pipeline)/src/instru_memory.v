`timescale 1ns / 1ps

module instru_memory(
  input [31:0] addr,
  output reg [31:0] instru  // [31-0]
);

  parameter NOP = 32'b00000000000000000000000000010011;
  parameter SIZE = 128;
  reg [31:0] mem [SIZE - 1:0];

  // initially set instruction to nop
  integer n;
  initial begin
    for (n = 0; n < SIZE; n = n + 1) begin
      mem[n] = NOP;
    end
    $readmemh("D:/Study/SJTU/Junior/2021SU/VE370/Project/p2/group/test/case.txt", mem);
    //  $readmemh("E:/JI/3 JUNIOR/2021 summer/ve370/7-14hazardtest4.txt", mem);
    instru = NOP;
  end

  always @(addr) begin
    if (addr != -4) begin
      instru = mem[addr >> 2];
    end

    $display("instruction = 0x%H", instru);
  end

endmodule
