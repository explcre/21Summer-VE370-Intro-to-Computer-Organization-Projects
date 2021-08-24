`timescale 1ns / 1ps

module MEM_WB(
    input clock,
    input [63:0] MemoryDataIn,
    input [63:0] AluResultIn,
    input [4:0] RegisterRd,
    output reg [63:0] MemoryDataOut,
    output reg [63:0] AluResultOut,
    output reg [4:0] Rd
);

initial
begin
    MemoryDataOut <= 0;
    AluResultOut <= 0;
    Rd <= 0;
end

always @(posedge clock)
begin
    MemoryDataOut = MemoryDataIn;
    AluResultOut = AluResultIn;
    Rd = RegisterRd;
end

endmodule


module MEM_WB_control(
    input clock,
    input i_MemtoReg,
    input i_RegWrite,
    input i_MemRead,
    output reg o_MemtoReg,
    output reg o_RegWrite,
    output reg o_MemRead
);

initial
begin
    o_MemtoReg <= 0;
    o_RegWrite <= 0;
    o_MemRead <= 0;
end

always @(posedge clock)
begin
    o_MemtoReg <= i_MemtoReg;
    o_RegWrite <= i_RegWrite;
    o_MemRead <= i_MemRead;
    
    // $display("MEM_WB_RegWrite: 0x%H", o_RegWrite);
    // $display("MEM_WB_MemRead: 0x%H", o_MemRead);
end

endmodule
