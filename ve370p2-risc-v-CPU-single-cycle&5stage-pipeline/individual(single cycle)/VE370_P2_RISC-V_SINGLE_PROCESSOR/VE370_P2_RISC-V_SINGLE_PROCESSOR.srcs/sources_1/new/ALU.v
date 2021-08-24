
module ALU (
  input [5:0]  ALU_Control,
  input [63:0] operand_A,
  input [63:0] operand_B,
  input branch_op,
  output ALU_branch,
  output [63:0] ALU_result
);


assign ALU_branch = (~branch_op) ? 1'b0:                                            //if not branch_op, branch = 0
            (ALU_Control == 6'b010100) ? $signed(operand_A) < $signed(operand_B):   //BLT
            (ALU_Control == 6'b010101) ? $signed(operand_A) >= $signed(operand_B):  //BGE
            (ALU_Control == 6'b010110) ? operand_A < operand_B:                     //BLTU
            (ALU_Control == 6'b010111) ? operand_A >= operand_B:                    //BGEU  
            (ALU_Control == 6'b010000) ? operand_A == operand_B:                    //BEQ 
            (ALU_Control == 6'b010001) ? operand_A != operand_B:                    //BNE
            0;                                                                      //default to not branching

assign ALU_result = (ALU_Control == 6'b000000) ? operand_A + operand_B:             //ADD
            (ALU_Control == 6'b001000) ? operand_A - operand_B:                     //SUB
            (ALU_Control == 6'b011111) ? operand_A:                                 //JAL pass operand_A
            (ALU_Control == 6'b111111) ? operand_A + operand_B:                      //**JALR pass operand_A + operand_B
            (ALU_Control == 6'b000010) ? $signed(operand_A) < $signed(operand_B):   //SLT, SLTI
            (ALU_Control == 6'b000011) ? operand_A < operand_B:                     //SLTIU, SLTU
            (ALU_Control == 6'b000100) ? operand_A ^ operand_B:                     //XOR, XORI
            (ALU_Control == 6'b000110) ? operand_A | operand_B:                     //ORI
            (ALU_Control == 6'b000111) ? operand_A & operand_B:                    //AND,ANDI
            (ALU_Control == 6'b000001) ? operand_A << operand_B:                    //SLLI, logical shift left Immediate
            (ALU_Control == 6'b000101) ? operand_A >> operand_B:                    //SRLI, Logical shift right immediate
            (ALU_Control == 6'b001101) ? operand_A >>> operand_B:                   //SRAI, Arithmetic shift right immediate
            64'hFFFFFFFF;                                                           //de facto error code

endmodule
