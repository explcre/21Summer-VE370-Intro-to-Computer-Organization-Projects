`timescale 1ns / 1ps

module EX_MEM(
    input clock,
    input Zero,
    input [63:0] ALUresultIn,
    input [63:0] ReadData2In,
    input [4:0] RegisterRd,
    input [4:0] RegisterRs2,
    output reg ZeroOut,
    output reg [63:0] ALUresultOut,
    output reg [63:0] ReadData2Out,
    output reg [4:0] Rd,
    output reg [4:0] Rs2
);

initial
begin
    ZeroOut <= 0;
    ALUresultOut <= 0;
    ReadData2Out <= 0;
    Rd <= 0;
    Rs2 <= 0;
end

always @(posedge clock)
begin
    ZeroOut <= Zero;
    ALUresultOut <= ALUresultIn;
    ReadData2Out <= ReadData2In;
    Rd <= RegisterRd;
    Rs2 <= RegisterRs2;
    
    // $display("Zero = 0x%H", ZeroOut);
    // $display("ALUresult = 0x%H", ALUresultOut);
    // $display("ReadData2 = 0x%H", ReadData2Out);
    // $display("Rd = 0x%H", Rd);
    // $display("RegisterRs2 = 0x%H", Rs2);
end

endmodule


module EX_MEM_control(
    input clock,
    input i_Branch,
    input i_MemRead,
    input i_MemtoReg,
    input i_MemWrite,
    input i_RegWrite,
    input i_Jump,
    output reg o_Branch,
    output reg o_MemRead,
    output reg o_MemtoReg,
    output reg o_MemWrite,
    output reg o_RegWrite,
    output reg o_Jump
);

initial
begin
    o_Branch <= 0;
    o_MemRead <= 0;
    o_MemtoReg <= 0;
    o_MemWrite <= 0;
    o_RegWrite <= 0;
    o_Jump <= 0;
end

always @(posedge clock)
begin
    o_Branch <= i_Branch;
    o_MemRead <= i_MemRead;
    o_MemtoReg <= i_MemtoReg;
    o_MemWrite <= i_MemWrite;
    o_RegWrite <= i_RegWrite;
    o_Jump <= i_Jump;
end

endmodule


module EX_MEM_imme(
    input clock,
    input [63:0] immediate,
    output reg [63:0] immediate_out
);

initial
begin
    immediate_out <= 0;
end

always @(posedge clock)
begin
    immediate_out <= immediate;
end

endmodule

module EX_MEM_pc(
    input clock,
    input [31:0] pc,
    output reg [31:0] pc_next
);

initial
begin
    pc_next <= 0;
end

always @(posedge clock)
begin
    pc_next <= pc;
end

endmodule
