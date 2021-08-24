`timescale 1ns / 1ps

module alu(
  input ALUSrc,
  input [3:0] ALUcontrol,
  input [63:0] data1,
  input [63:0] read2,
  input [63:0] imme,
  output reg zero,
  output reg [63:0] ALUresult
);

  reg [63:0] data2;
  
  always @(*) begin
    if (ALUSrc == 0) begin
      data2 = read2;
    end else begin
      data2 = imme;
    end
  end

  always @(*) begin
    case (ALUcontrol)
      4'b0000: // AND
        ALUresult = data1 & data2;
      4'b0001: // OR  
        ALUresult = data1 | data2;
      4'b0010: // ADD
        ALUresult = data1 + data2;
      4'b0011: // NEQ
        ALUresult = (data1 == data2) ? 1 : 0;
      4'b0100: // SLL
        ALUresult = data1 << data2;
      4'b0110: // SUB
        ALUresult = data1 - data2;
      4'b0111: // SLT
        ALUresult = (data1 < data2) ? 1 : 0;
      4'b1000: // SGE
        ALUresult = (data1 < data2) ? 0 : 1;
      4'b1001: // XOR
        ALUresult = data1 ^ data2;
      4'b1100: // NOR
        ALUresult = data1 |~ data2;
      default:
        ALUresult = 64'b0;
    endcase

    if (ALUresult == 0) begin
      zero = 1;
    end else begin
      zero = 0;
    end

    // $display("ALUSrc: 0x%H", ALUSrc);
    // $display("ALUcontrol: 0x%H", ALUcontrol);
    // $display("data1: 0x%H", data1);
    // $display("data2: 0x%H", data2);
    // $display("ALUresult: 0x%H", ALUresult);
    // $display("Zero: 0x%H", zero);
  end

endmodule
