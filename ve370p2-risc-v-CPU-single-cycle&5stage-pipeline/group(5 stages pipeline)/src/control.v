`timescale 1ns / 1ps

module control(
  input [6:0] opcode,
  output reg Branch,
  output reg MemRead,
  output reg MemtoReg,
  output reg [1:0] ALUOp,
  output reg MemWrite,
  output reg ALUSrc,
  output reg RegWrite,
  output reg Jump
);

  initial begin
    Branch = 0;
    MemRead = 0;
    MemtoReg = 0;
    ALUOp = 2'b00;
    MemWrite = 0;
    ALUSrc = 0;
    RegWrite = 0;
    Jump = 0;
  end

  always @(*) begin
    case (opcode)
      7'b0110011: begin // R-type
        Branch = 0;
        MemRead = 0;
        MemtoReg = 0;
        ALUOp = 2'b10;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 1;
        Jump = 0;
      end
      7'b0000011: begin // Load
        Branch = 0;
        MemRead = 1;
        MemtoReg = 1;
        ALUOp = 2'b00;
        MemWrite = 0;
        ALUSrc = 1;
        RegWrite = 1;
        Jump = 0;
      end
      7'b0010011: begin // immediate
        Branch = 0;
        MemRead = 0;
        MemtoReg = 0;
        ALUOp = 2'b10;
        MemWrite = 0;
        ALUSrc = 1;
        RegWrite = 1;
        Jump = 0;
      end
      7'b0100011: begin // S-type
        Branch = 0;
        MemRead = 0;
        MemtoReg = 0;
        ALUOp = 2'b00;
        MemWrite = 1;
        ALUSrc = 1;
        RegWrite = 0;
        Jump = 0;
      end
      7'b1100111: begin // jalr
        Branch = 0;
        MemRead = 0;
        MemtoReg = 0;
        ALUOp = 2'b11;
        MemWrite = 0;
        ALUSrc = 1;
        RegWrite = 1;
        Jump = 1;
      end
      7'b1100011: begin // SB-type
        Branch = 1;
        MemRead = 0;
        MemtoReg = 0;
        ALUOp = 2'b01;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
        Jump = 0;
      end
      7'b1101111: begin // UJ-type
        Branch = 1;
        MemRead = 0;
        MemtoReg = 0;
        ALUOp = 2'b11;
        MemWrite = 0;
        ALUSrc = 0;
        RegWrite = 0;
        Jump = 1;
      end
      default:
        ;
    endcase
    
    // $display("Branch = %H;MemRead = %H;MemtoReg = %H;ALUOp = %H;MemWrite = %H;ALUSrc = %H;RegWrite = %H;Jump = %H;", 
        // Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite, Jump);
  end

endmodule
