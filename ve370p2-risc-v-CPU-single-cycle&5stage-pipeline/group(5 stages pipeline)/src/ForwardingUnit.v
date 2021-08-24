`timescale 1ns / 1ps

module ForwardingUnit(
    input [4:0] ID_EX_Rs1,
    input [4:0] ID_EX_Rs2,
    input [4:0] EX_MEM_Rs2,
    input [4:0] EX_MEM_Rd,
    input [4:0] MEM_WB_Rd,
    input EX_MEM_RegWrite,
    input MEM_WB_RegWrite,
    input EX_MEM_MemWrite,
    input MEM_WB_MemRead,
    output reg [1:0] ForwardA, // for ALU
    output reg [1:0] ForwardB, // for ALU
    output reg MemSrc // for load-store
);

initial begin
    ForwardA <= 2'b00;
    ForwardB <= 2'b00;
    MemSrc <= 1'b0;
end

// ForwardA
always @(*) begin
    if (EX_MEM_RegWrite == 1 && EX_MEM_Rd != 0 && EX_MEM_Rd == ID_EX_Rs1) ForwardA <= 2'b10;//EX
    else if (MEM_WB_RegWrite == 1 && MEM_WB_Rd != 0 && MEM_WB_Rd == ID_EX_Rs1) ForwardA <= 2'b01;//MEM
    else ForwardA <= 2'b00;
end

// ForwardB
always @(*) begin
    if (EX_MEM_RegWrite == 1 && EX_MEM_Rd != 0 && EX_MEM_Rd == ID_EX_Rs2) ForwardB <= 2'b10;//EX
    else if (MEM_WB_RegWrite == 1 && MEM_WB_Rd != 0 && MEM_WB_Rd == ID_EX_Rs2) ForwardB <= 2'b01;//MEM
    else ForwardB <= 2'b00;
end

// MemSrc
always @(*) begin
    if (EX_MEM_MemWrite == 1 && MEM_WB_MemRead == 1 && MEM_WB_Rd != 0 && (MEM_WB_Rd == EX_MEM_Rs2)) MemSrc <= 1'b1;
    else MemSrc <= 1'b0;

    // $display("ForwardA: 0x%H", ForwardA);
    // $display("ForwardB: 0x%H", ForwardB);
    $display("MemSrc: 0x%H", MemSrc);
end

endmodule
