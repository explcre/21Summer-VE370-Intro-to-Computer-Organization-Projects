`timescale 1ns / 1ps

module IF_ID(
    input clock,
    input IF_flush,
    input IF_ID_Write,
    input [31:0] pc,
    input [31:0] in,
    output reg [31:0] pc_next,
    output reg [6:0]  funct7, // [31-25]
    output reg [2:0]  funct3, // [14-12]
    output reg [6:0]  opcode, // [6-0]
    output reg [31:0] instru  // [31-0]
);

initial
begin
    pc_next <= 0;
    instru <= 0;
    funct7 <= 0;
    funct3 <= 0;
    opcode <= 0;
end

always @(posedge clock)
begin
    if (IF_flush == 1) begin
        pc_next <= 0;
        instru <= 0;
        funct7 <= 0;
        funct3 <= 0;
        opcode <= 0;
    end else if (IF_ID_Write == 1) begin
        pc_next <= pc;
        instru <= in;
        funct7 <= in[31:25];
        funct3 <= in[14:12];
        opcode <= in[6:0];
    end else begin
        pc_next <= pc_next;
        instru <= instru;
        funct7 <= funct7;
        funct3 <= funct3;
        opcode <= opcode;
    end

    // $display("funct7 = 0x%H", funct7);
    // $display("funct3 = 0x%H", funct3);
    // $display("opcode = 0x%H", opcode);
end

endmodule
