`timescale 1ns / 1ps

`include "alu_control.v"
`include "alu.v"
`include "control.v"
`include "data_memory.v"
`include "immediate_generator.v"
`include "instru_memory.v"
`include "next_pc.v"
`include "program_counter.v"
`include "register.v"
`include "IF_ID.v"
`include "ID_EX.v"
`include "EX_MEM.v"
`include "MEM_WB.v"
`include "mux.v"

module main(input clk);

    wire [31:0] pc_in, pc_out,
                IF_ID_pc,
                ID_EX_pc,
                EX_MEM_pc;

    wire [6:0] im_funct7;
    wire [2:0] im_funct3;
    wire [6:0] im_opcode;

    wire [31:0] im_instru;
    wire [31:0] IF_ID_instru;

    wire c_Branch, c_MemRead, c_MemtoReg, c_MemWrite, c_ALUSrc, c_RegWrite, c_Jump,
         ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_RegWrite, ID_EX_Jump,
         EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_Jump,
         MEM_WB_RegWrite, MEM_WB_MemtoReg, MEM_WB_MemRead;

    wire [1:0] c_ALUOp;

    wire [3:0] c_ALUcontrol;
    wire [3:0] ID_EX_ALUcontrol;

    wire [63:0] r_wbdata,
                mem_data,
                MEM_WB_mem_data,
                r_read1,
                r_read2,
                ID_EX_Read1,
                ID_EX_Read2,
                EX_MEM_Read2;

    wire [4:0] ID_EX_Rs1,
               ID_EX_Rs2,
               ID_EX_Rd,
               EX_MEM_Rd,
               MEM_WB_Rd;
               
    wire [63:0] ALUin1, ALUin2;

    wire [63:0] MemWriteData;

    wire c_zero,
         EX_MEM_zero;

    wire [63:0] alu_result,
                EX_MEM_alu_result,
                MEM_WB_alu_result;

    wire [63:0] imme,
                ID_EX_imme,
                EX_MEM_imme;

    wire [63:0] zeros;

    wire [1:0] ForwardA, ForwardB; // for ALU
    wire MemSrc; // for load-store
    wire IF_Flush, ID_EX_Flush;
    wire ID_branch, RegWrite, ID_jump, PCWrite, IF_ID_Write;

    // wire ID_equal;
    wire [4:0] IF_ID_Rs1, IF_ID_Rs2, EX_MEM_Rs2;

    assign zeros = 64'b0;
    
    assign IF_ID_Rs1 = IF_ID_instru[19:15];
    assign IF_ID_Rs2 = IF_ID_instru[24:20];

/* IF */
program_counter asset_pc(clk, pc_in, pc_out);

instru_memory asset_im(pc_out, im_instru);

IF_ID asset_if_id(clk, IF_Flush, IF_ID_Write, pc_out, im_instru, IF_ID_pc, im_funct7, im_funct3, im_opcode, IF_ID_instru);

/* ID */
control asset_control(im_opcode, c_Branch, c_MemRead, c_MemtoReg, c_ALUOp, c_MemWrite, c_ALUSrc, c_RegWrite, c_Jump);

alu_control asset_aluct(clk, c_ALUOp, im_funct7, im_funct3, c_ALUcontrol);

ID_EX_control asset_id_ex_ctrl(clk, ID_EX_Flush, c_Branch, c_MemRead, c_MemtoReg, c_MemWrite, c_ALUSrc, c_RegWrite, c_Jump, c_ALUcontrol, 
ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_RegWrite, ID_EX_Jump, ID_EX_ALUcontrol);

immediate_generator asset_ig(clk, IF_ID_instru, im_opcode, imme);

ID_EX_imme asset_id_ex_imme(clk, ID_EX_Flush, imme, ID_EX_imme);

register asset_reg(clk, MEM_WB_RegWrite, c_Branch, c_Jump, IF_ID_pc, IF_ID_instru, MEM_WB_Rd, r_wbdata, r_read1, r_read2);

ID_EX asset_id_ex(clk, ID_EX_Flush, r_read1, r_read2, IF_ID_instru, ID_EX_Read1, ID_EX_Read2, ID_EX_Rs1, ID_EX_Rs2, ID_EX_Rd);

ID_EX_pc asset_ID_EX_pc(clk, ID_EX_Flush, IF_ID_pc, ID_EX_pc);

/* EX */

two_64bit_mux asset_alu_mux1(ForwardA, ID_EX_Read1, r_wbdata, EX_MEM_alu_result, zeros, ALUin1);

two_64bit_mux asset_alu_mux2(ForwardB, ID_EX_Read2, r_wbdata, EX_MEM_alu_result, zeros, ALUin2);

ForwardingUnit assert_forwarding_unit(ID_EX_Rs1, ID_EX_Rs2, EX_MEM_Rs2, EX_MEM_Rd, MEM_WB_Rd, EX_MEM_RegWrite, MEM_WB_RegWrite, EX_MEM_MemWrite, MEM_WB_MemRead, ForwardA, ForwardB, MemSrc);

alu asset_alu(ID_EX_ALUSrc, ID_EX_ALUcontrol, ALUin1, ALUin2, ID_EX_imme, c_zero, alu_result);

EX_MEM asset_ex_mem(clk, c_zero, alu_result, ALUin2, ID_EX_Rd, ID_EX_Rs2, EX_MEM_zero, EX_MEM_alu_result, EX_MEM_Read2, EX_MEM_Rd, EX_MEM_Rs2);

EX_MEM_control asset_ex_mem_ctrl(clk, ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_RegWrite,
ID_EX_Jump, EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_Jump);

EX_MEM_imme asset_ex_mem_imme(clk, ID_EX_imme, EX_MEM_imme);

EX_MEM_pc asset_EX_MEM_pc(clk, ID_EX_pc, EX_MEM_pc);

/* MEM */
next_pc asset_next_pc(clk, EX_MEM_Jump, EX_MEM_Branch, EX_MEM_zero, PCWrite, pc_out, EX_MEM_alu_result, EX_MEM_imme, pc_in);

one_64bit_mux asset_mem_wb_memsrc_mux(MemSrc, EX_MEM_Read2, mem_data, MemWriteData);

data_memory asset_dm(clk, EX_MEM_MemWrite, EX_MEM_MemRead, EX_MEM_alu_result, MemWriteData, mem_data);

MEM_WB asset_mem_wb(clk, mem_data, EX_MEM_alu_result, EX_MEM_Rd, MEM_WB_mem_data, MEM_WB_alu_result, MEM_WB_Rd);

MEM_WB_control asset_mem_wb_ctrl(clk, EX_MEM_MemtoReg, EX_MEM_RegWrite, EX_MEM_MemRead, MEM_WB_MemtoReg, MEM_WB_RegWrite, MEM_WB_MemRead);

one_64bit_mux asset_mem_wb_mux(MEM_WB_MemtoReg, MEM_WB_alu_result, MEM_WB_mem_data, r_wbdata);

/* Hazard Detection Unit */
hazardControlDetection asset_hazardControlDetection(IF_ID_Rs1, IF_ID_Rs2, ID_EX_Rs2, EX_MEM_Rs2, ID_EX_Rd, EX_MEM_Rd, c_MemWrite,
ID_EX_MemRead, EX_MEM_MemRead, ID_EX_Branch, ID_EX_Jump, c_zero, ID_EX_RegWrite, PCWrite, IF_ID_Write, ID_EX_Flush, IF_Flush);

endmodule
