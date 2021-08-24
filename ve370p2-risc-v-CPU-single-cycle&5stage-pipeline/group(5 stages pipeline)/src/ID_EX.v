`timescale 1ns / 1ps

module ID_EX(
    input clock, 
    input ID_flush,
    input [63:0] ReadDataIn1, 
    input [63:0] ReadDataIn2,
    input [31:0] instru,
    output reg [63:0] ReadDataOut1,
    output reg [63:0] ReadDataOut2,
    output reg [4:0] Rs1,
    output reg [4:0] Rs2,
    output reg [4:0] Rd
);

initial
begin
    ReadDataOut1 = 0;
    ReadDataOut2 = 0;
    Rs1 = 0;
    Rs2 = 0;
    Rd = 0;
end

always @(posedge clock)
begin
    if (ID_flush == 1) begin
        ReadDataOut1 = 0;
        ReadDataOut2 = 0;
        Rs1 = 0;
        Rs2 = 0;
        Rd = 0;
    end else begin
        ReadDataOut1 = ReadDataIn1;
        ReadDataOut2 = ReadDataIn2;
        Rs1 = instru[19:15];
        Rs2 = instru[24:20];
        Rd = instru[11:7];
    end

    // $display("ID_flush = 0x%H", ID_flush);
    // $display("ReadDataOut1 = 0x%H", ReadDataOut1);
    // $display("ReadDataOut2 = 0x%H", ReadDataOut2);
    // $display("Rs1 = 0x%H", Rs1);
    // $display("Rs2 = 0x%H", Rs2);
    // $display("Rd = 0x%H", Rd);
end

endmodule

module ID_EX_control(
    input clock,
    input ID_flush,
    input i_Branch,
    input i_MemRead,
    input i_MemtoReg,
    input i_MemWrite,
    input i_ALUSrc,
    input i_RegWrite,
    input i_Jump,
    input [3:0] i_ALUcontrol,
    output reg o_Branch,
    output reg o_MemRead,
    output reg o_MemtoReg,
    output reg o_MemWrite,
    output reg o_ALUSrc,
    output reg o_RegWrite,
    output reg o_Jump,
    output reg [3:0] o_ALUcontrol
);

    initial
    begin
        o_Branch = 0;
        o_MemRead = 0;
        o_MemtoReg = 0;
        o_MemWrite = 0;
        o_ALUSrc = 0;
        o_RegWrite = 0;
        o_Jump = 0;
        o_ALUcontrol = 0;
    end

    always @(posedge clock)
    begin
        if (ID_flush == 0) begin
            o_Branch = i_Branch;
            o_MemRead = i_MemRead;
            o_MemtoReg = i_MemtoReg;
            o_MemWrite = i_MemWrite;
            o_ALUSrc = i_ALUSrc;
            o_RegWrite = i_RegWrite;
            o_Jump = i_Jump;
            o_ALUcontrol = i_ALUcontrol;
        end else begin
            o_Branch = 0;
            o_MemRead = 0;
            o_MemtoReg = 0;
            o_MemWrite = 0;
            o_ALUSrc = 0;
            o_RegWrite = 0;
            o_Jump = 0;
            o_ALUcontrol = 0;
        end
    end

endmodule


module ID_EX_imme(
    input clock,
    input ID_flush,
    input [63:0] immediate,
    output reg [63:0] immediate_out
);

    initial
    begin
        immediate_out = 0;
    end

    always @(posedge clock)
    begin
        if (ID_flush == 0) begin
            immediate_out = immediate;
        end else begin
            immediate_out = 0;
        end

        // $display("ID_flush: 0x%H", ID_flush);
        // $display("immediate: 0x%H", immediate);
        // $display("immediate_out: 0x%H", immediate_out);
    end

endmodule


module ID_EX_pc(
    input clock,
    input ID_flush,
    input [31:0] pc,
    output reg [31:0] pc_next
);

initial
begin
    pc_next = 0;
end

always @(posedge clock)
begin
    if (ID_flush == 0) begin
        pc_next = pc;
    end else begin
        pc_next = 0;
    end
end

endmodule

