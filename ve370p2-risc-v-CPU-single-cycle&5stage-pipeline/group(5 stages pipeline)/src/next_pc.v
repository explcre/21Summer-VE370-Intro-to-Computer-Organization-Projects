`timescale 1ns / 1ps

module next_pc(
  input clock,
  input Jump,
  input Branch,
  input Zero,
  input PCWrite,
  input [31:0] old,
  input [63:0] alu_result,
  input [63:0] immediate,
  output reg [31:0] next
);

  reg [31:0] new;
  reg [63:0] origin;
  reg [63:0] jump;

  initial begin
    next = 32'b0;
    origin = 64'b0;
  end

  always @(old) begin
    new = old + 4;
    origin = {32'b0, old[31:0]};
  end

  always @(immediate, origin) begin
  if(Branch & ~Jump)begin
    jump = origin + (immediate)-64'hc;
    end else if(Branch & Jump) begin
    jump = origin + (immediate-64'hc);
    end
  end

  always @(posedge clock) begin
    // assign next program counter value
    if (PCWrite == 1) begin
      if (Branch == 1 & (Zero == 1 | Jump == 1)) begin
        next = jump[31:0];
      end else begin
        next = new;
      end
      if (Jump == 1 & Branch == 0) begin
        next = alu_result[31:0];
      end
    end else begin
      next = next;
    end
    //$display("next_pc immediate = 0x%H", immediate);
    // $display("Jump = 0x%H", Jump);
    // $display("Branch = 0x%H", Branch);
    // $display("Zero = 0x%H", Zero);
    // $display("PCWrite = 0x%H", PCWrite);
    // $display("old = 0x%H", old);
    //$display("next_pc origin = 0x%H", origin);
    //$display("next_pc jump = 0x%H", jump);
    // $display("new = 0x%H", new);
     //$display("next_pc next = 0x%H", next);
  end

endmodule
