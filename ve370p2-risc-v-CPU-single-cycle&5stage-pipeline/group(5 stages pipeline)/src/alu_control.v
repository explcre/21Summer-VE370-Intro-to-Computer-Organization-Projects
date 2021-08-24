`timescale 1ns / 1ps

module alu_control(
  input clock,
  input [1:0] ALUOp,
  input [6:0] funct7,
  input [2:0] funct3,
  output reg [3:0] ALUcontrol
);

  always @(negedge clock) begin
    case (ALUOp) 
      2'b00: // add
        ALUcontrol = 4'b0010;
      2'b01: begin
        case (funct3)
          3'b000: // beq sub
            ALUcontrol = 4'b0110;
          3'b001: // bne
            ALUcontrol = 4'b0011;
          3'b100: // blt
            ALUcontrol = 4'b1000;
          3'b101: // bge
            ALUcontrol = 4'b0111;
          default: // ADD
            ALUcontrol = 4'b0010;
        endcase
      end
      2'b10: begin
        case (funct3)
          3'b000: begin // add
            case (funct7)
              7'b0000000: // add
                ALUcontrol = 4'b0010;
              7'b0100000: // sub
                ALUcontrol = 4'b0110;
              default: // add
                ALUcontrol = 4'b0010;
            endcase 
          end
          3'b001: // sll
            ALUcontrol = 4'b0100;
          3'b010: // slt
            ALUcontrol = 4'b0111;
          3'b100: // or
            ALUcontrol = 4'b1001;
          3'b110: // or
            ALUcontrol = 4'b0001;
          3'b111: // and
            ALUcontrol = 4'b0000;
          default: begin
            case (funct7)
              7'b1101111: // add
                ALUcontrol = 4'b0010;
              default:
                ALUcontrol = ALUcontrol;
            endcase
          end
        endcase
      end
      2'b11: // ADD
        ALUcontrol = 4'b0010;
    endcase
    
    $display("ALUcontrol: 0x%H", ALUcontrol);
  end

endmodule
