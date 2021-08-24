`timescale 1ns / 1ps

module hazardControlDetection(
    input [4:0] IF_ID_Rs1,
    input [4:0] IF_ID_Rs2,
    input [4:0] ID_EX_Rs2,
    input [4:0] EX_MEM_Rs2,
    input [4:0] ID_EX_Rd,
    input [4:0] EX_MEM_Rd,
    input IF_ID_MemWrite, 
    input ID_EX_MemRead, 
    input EX_MEM_MemRead, 
    input ID_branch, 
    input ID_jump,
    input c_zero, 
    input ID_EX_RegWrite,
    output PCWrite,
    output IF_ID_Write,
    output ID_EX_Flush,
    output IF_Flush
);

wire PCHold; // if PCHold==1, hold PC and IF/ID

assign PCHold = ( ID_EX_MemRead && (~IF_ID_MemWrite || (ID_EX_Rd != IF_ID_Rs2)) ) // lw hazard
            || ( (ID_branch) && (ID_EX_MemRead) && (ID_EX_Rd == IF_ID_Rs1 || ID_EX_Rd == IF_ID_Rs2) ) // lw followed by branch
            || ( (ID_branch) && (EX_MEM_MemRead) && (EX_MEM_Rd == IF_ID_Rs1 || EX_MEM_Rd == IF_ID_Rs2) ) // lw followed by nop and then branch
            || ( (ID_branch) && (ID_EX_RegWrite) && (ID_EX_Rd != 5'b0) && (ID_EX_Rd == IF_ID_Rs1 || ID_EX_Rd == IF_ID_Rs2) ) // R-format followed by branch
            || ( (ID_branch) && (ID_EX_RegWrite) && (ID_EX_Rd == 5'b0) && (ID_EX_Rd == IF_ID_Rs1 || ID_EX_Rd == IF_ID_Rs2) ) ; // addi followed by branch
// note we leave out the case that R-format followed by a nop then a branch, because that is solved by forwarding path

assign PCWrite=~PCHold; // if PCWrite==0, don't write in new instruction, IM decode the current instruction again 

assign IF_ID_Write=~PCHold; // if IF_ID_Write==0, IF/ID register keeps the current instruction

assign ID_EX_Flush=PCHold; // if ID_EX_Flush=1, all control signals in ID/EX are 0 (implemented in ID/EX register later)
 
assign IF_Flush = (PCHold==0) && ( (ID_jump) || (ID_branch && c_zero) ); 

endmodule
