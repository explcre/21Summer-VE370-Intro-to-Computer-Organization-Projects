`timescale 1ns / 1ps

module immediate_generator(
  input clock,
  input [31:0] instru,
  input [6:0] opcode,
  output reg [63:0] immediate
);

  parameter NEG = 64'b1111111111111111111111111111111111111111111111111111111111111111;

  initial begin
    immediate = 64'b0;
  end

  always @(negedge clock) begin
    case (opcode)
      7'b0000011: begin // Load
        if (instru[31] == 1) begin
          immediate = {NEG[51:0], instru[31:20]};
        end else begin
          immediate = {52'b0, instru[31:20]};
        end
      end
      7'b0010011: begin // immediate
        if (instru[31] == 1) begin
          immediate = {NEG[51:0], instru[31:20]};
        end else begin
          immediate = {52'b0, instru[31:20]};
        end
      end
      7'b0100011: begin // S-type
        if (instru[31] == 1) begin
          immediate = {NEG[51:0], instru[31:25], instru[11:7]};
        end else begin
          immediate = {52'b0, instru[31:25], instru[11:7]};
        end
      end
      7'b1100111: begin // jalr
        if (instru[31] == 1) begin
          immediate = {NEG[51:0], instru[31:20]};
        end else begin
          immediate = {52'b0, instru[31:20]};
        end
      end
      7'b1100011: begin // SB-type
        if (instru[31] == 1) begin
          immediate = {NEG[50:0], instru[31], instru[7], instru[30:25], instru[11:8], 1'b0};
        end else begin
          immediate = {51'b0, instru[31], instru[7], instru[30:25], instru[11:8], 1'b0};
        end
      end
      7'b1101111: begin // UJ-type
        if (instru[31] == 1) begin
          immediate = {NEG[42:0], instru[31], instru[19:12], instru[20], instru[30:21], 1'b0};
        end else begin
          immediate = {43'b0, instru[31], instru[19:12], instru[20], instru[30:21], 1'b0};
        end
      end
      default:
        immediate = 64'b0;
    endcase

    $display("immediate: 0x%H", immediate[63:0]);
  end

endmodule
