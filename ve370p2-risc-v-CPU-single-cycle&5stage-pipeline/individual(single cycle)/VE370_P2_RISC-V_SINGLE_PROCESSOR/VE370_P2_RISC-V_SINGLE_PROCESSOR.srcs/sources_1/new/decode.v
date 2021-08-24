module decode #(
  parameter ADDRESS_BITS = 16  //parameters are constants, thus you cant change their value at runtime <- note 
) (
  // Inputs from Fetch
  input [ADDRESS_BITS-1:0] PC, //curent PC value
  input [31:0] instruction,   //the the 32 bit instruction we are decoding ig

  // Inputs from Execute/ALU    
  input [ADDRESS_BITS-1:0] JALR_target,  //target of JALR instruction 
  input branch,      //Result of a branch instruction, 1 means branch taken (true), 0 means not taken (false)

  // Outputs to Fetch
  output next_PC_select, //select (equivalent to PCsrc mux) 0 is PC+4, 1 is target_PC 
  output [ADDRESS_BITS-1:0] target_PC,   //selected if above is 1

  // Outputs to Reg File  - these are all inputs to Reg File
  output [4:0] read_sel1,  //read Address 1
  output [4:0] read_sel2,  //read address 2
  output [4:0] write_sel,  //write Addr
  output wEn,    //write enable

  // Outputs to Execute/ALU   - 
  output branch_op, // Tells ALU if this is a branch instruction (yes)
  //output [31:0] imm32,  //the immediate
  output [63:0] imm64,  //the immediate
  output [1:0] op_A_sel,  //Select for the ALU operand_A input (00 for read_data_1, 01 for PC, 10 for PC+4)
  output op_B_sel,  //Select for ALU operand_B input (0 for from read Data 2, 1 for Imm32)
  output [5:0] ALU_Control, //tells ALU operation

  // Outputs to Memory
  output mem_wEn, //write to memory

  // Outputs to Writeback
  output wb_sel //1 if writeback value is read from memory 0 if writeback value comes from ALU

);

localparam [6:0]R_TYPE  = 7'b0110011, //wEn  //data2
                I_TYPE  = 7'b0010011, //wEn  //imm32
                STORE   = 7'b0100011, //NO   //imm32  //memWrite
                LOAD    = 7'b0000011, //wEn  //imm32
                BRANCH  = 7'b1100011, //NO   //data2
                JALR    = 7'b1100111, //wEn  //imm32
                JAL     = 7'b1101111,  //wEn 
                AUIPC   = 7'b0010111, //wEn
                LUI     = 7'b0110111; //wEn


// Internal Wires
wire[6:0]  s_imm_msb;
wire[4:0]  s_imm_lsb;
wire[19:0] u_imm;
wire[11:0] i_imm_orig;
wire[11:0] s_imm_orig;
wire[12:0] b_imm_orig;
wire[19:0] lui_imm;

wire[31:0] b_imm_32;
wire[31:0] u_imm_32;
wire[31:0] i_imm_32;
wire[31:0] s_imm_32;
wire[31:0] uj_imm_32;
wire[31:0] lui_imm_32;

wire[63:0] b_imm_64;
wire[63:0] u_imm_64;
wire[63:0] i_imm_64;
wire[63:0] s_imm_64;
wire[63:0] uj_imm_64;
wire[63:0] lui_imm_64;

wire [6:0] opcode;
wire [6:0] funct7;
wire [2:0] funct3;
wire [1:0] extend_sel;
wire [ADDRESS_BITS-1:0] branch_target;
wire [ADDRESS_BITS-1:0] JAL_target;


// Read registers
assign read_sel2  = instruction[24:20];
assign read_sel1  = (opcode == LUI) ? 5'b0 : instruction[19:15]; //Adding x0 to upper instruction in ALU, in order to writeback the lui_imm_32

/* Instruction decoding */
assign opcode = instruction[6:0];
assign funct7 = instruction[31:25];
assign funct3 = instruction[14:12];

/* Write register */
assign write_sel = instruction[11:7];




//I-type imm's
assign i_imm_orig = instruction[31:20];
assign i_imm_32 = {{20{i_imm_orig[11]}},i_imm_orig};
assign i_imm_64 = {{52{i_imm_orig[11]}},i_imm_orig};
//S-type imm's
assign s_imm_msb = instruction[31:25];
assign s_imm_lsb = instruction[11:7];
assign s_imm_orig = {s_imm_msb, s_imm_lsb};
assign s_imm_32 = {{20{s_imm_orig[11]}},s_imm_orig};
assign s_imm_64 = {{52{s_imm_orig[11]}},s_imm_orig};
//U-type imm's
assign u_imm = instruction[31:12];
assign u_imm_32 = { {12{u_imm[19]}},u_imm };
assign u_imm_64 = { {44{u_imm[19]}},u_imm };
//Branch imm's
//Note: we have assumed that the immediate value provided for branch instructions only needs shifted left once.
assign b_imm_orig = { instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0 }; //shift left 1
assign b_imm_32 = { {19{b_imm_orig[11]}}, b_imm_orig }; 
assign b_imm_64 = { {51{b_imm_orig[11]}}, b_imm_orig }; 
//imm for JAL
assign uj_imm_32 = { {11{u_imm[19]}},{u_imm[19]},{u_imm[7:0]},{u_imm[8]},{u_imm[18:9]},1'b0 };
assign uj_imm_64 = { {43{u_imm[19]}},{u_imm[19]},{u_imm[7:0]},{u_imm[8]},{u_imm[18:9]},1'b0 };
//imm for LUI
assign lui_imm = instruction[31:12];
assign lui_imm_32 = { lui_imm, 12'b0 };
assign lui_imm_64 = {32'b0, lui_imm, 12'b0 };//?is it right? add 32'b0 to the left

assign next_PC_select = (branch===1) ? 1'b1:
                        (opcode===JAL) ? 1'b1:
                        (opcode===JALR) ? 1'b1:
                        1'b0;

assign wEn = (opcode === R_TYPE)? 1'b1:
             (opcode === I_TYPE)? 1'b1:
             (opcode === STORE) ? 1'b0:
             (opcode === LOAD) ? 1'b1:
             (opcode === BRANCH) ? 1'b0:
             (opcode === JAL) ? 1'b1:
             (opcode === JALR) ? 1'b1:
             (opcode === LUI) ? 1'b1:
             (opcode === AUIPC) ? 1'b1:
             1'b0;
             
assign op_B_sel= (opcode === R_TYPE)? 1'b0:
                 (opcode === I_TYPE)? 1'b1:
                 (opcode === STORE) ? 1'b1:
                 (opcode === LOAD) ? 1'b1:
                 (opcode === BRANCH) ? 1'b0:
                 (opcode === JAL) ? 1'b1:
                 (opcode === JALR) ? 1'b1:
                 (opcode === LUI) ? 1'b1:
                 (opcode === AUIPC) ? 1'b1:
                 1'b0;
                 
assign op_A_sel = (opcode === R_TYPE)? 2'b00:
                  (opcode === I_TYPE)? 2'b00:
                  (opcode === STORE) ? 2'b00:
                  (opcode === LOAD) ? 2'b00:
                  (opcode === BRANCH) ? 2'b00:
                  (opcode === JAL) ? 2'b10:      //put PC+4 in rd
                  (opcode === JALR) ? 2'b10:     //put PC+4 in rd
                  (opcode === LUI) ? 2'b00:      //Select x0
                  (opcode === AUIPC) ? 2'b01:
                  2'b00;
              
assign branch_op= (opcode === BRANCH) ? 1'b1: //tell ALU this is a branch instruction
             1'b0;
             
assign mem_wEn = (opcode === STORE) ? 1'b1: //only store to memory if mem_wEn is 1
             1'b0;
             
assign wb_sel = (opcode === LOAD) ? 1'b1: //only write back from memory if LOAD instruction
             1'b0;
  /*           
assign imm32 = (opcode == I_TYPE) ? i_imm_32:
               (opcode === STORE) ? s_imm_32:
               (opcode === LOAD) ?  i_imm_32:
               (opcode === JAL) ? uj_imm_32:
               (opcode === JALR) ? i_imm_32:
               (opcode === LUI) ? lui_imm_32:
               (opcode === AUIPC) ? lui_imm_32:
               (opcode == BRANCH) ? b_imm_32:
               32'b0;
               */
               

assign imm64 = (opcode == I_TYPE) ? i_imm_64:
               (opcode === STORE) ? s_imm_64:
               (opcode === LOAD) ?  i_imm_64:
               (opcode === JAL) ? uj_imm_64:
               (opcode === JALR) ? i_imm_64:
               (opcode === LUI) ? lui_imm_64:
               (opcode === AUIPC) ? lui_imm_64:
               (opcode == BRANCH) ? b_imm_64:
               64'b0;

    
assign ALU_Control = (opcode === R_TYPE & funct3 === 3'b000 & funct7 === 7'b0100000) ? 6'b001000: //SUB
                     (opcode === R_TYPE & funct3 === 3'b000 & funct7 === 7'b0000000) ? 6'b000000: //ADD
                     (opcode === R_TYPE & funct3 === 3'b111) ? 6'b000111:  //AND
                     (opcode === R_TYPE & funct3 === 3'b110) ? 6'b000110: //OR
                     (opcode === R_TYPE & funct3 === 3'b101) ? 6'b000101: //SRL
                     (opcode === R_TYPE & funct3 === 3'b100) ? 6'b000100: //XOR
                     (opcode === R_TYPE & funct3 === 3'b011) ? 6'b000010: //SLTU
                     (opcode === R_TYPE & funct3 === 3'b010) ? 6'b000010: // SLT
                     (opcode === I_TYPE & funct3 === 3'b000) ? 6'b000000: //ADDI
                     (opcode === I_TYPE & funct3 === 3'b111) ? 6'b000111: //ANDI
                     (opcode === I_TYPE & funct3 === 3'b110) ? 6'b000110: //ORI
                     (opcode === I_TYPE & funct3 === 3'b101) ? 6'b000101: // SRLI
                     (opcode === I_TYPE & funct3 === 3'b100) ? 6'b000100: //XORI
                     (opcode === I_TYPE & funct3 === 3'b011) ? 6'b000010: //SLTUI
                     (opcode === I_TYPE & funct3 === 3'b010) ? 6'b000010: //SLTI
                     (opcode === BRANCH & funct3 === 3'b000) ? 6'b010000: //BEQ
                     (opcode === BRANCH & funct3 === 3'b001) ? 6'b010001: //BNE
                     (opcode === BRANCH & funct3 === 3'b100) ? 6'b010100: //BLT
                     (opcode === BRANCH & funct3 === 3'b101) ? 6'b010101: //BGE
                     (opcode === BRANCH & funct3 === 3'b110) ? 6'b010110: //BLTU
                     (opcode === BRANCH & funct3 === 3'b111) ? 6'b010111: //BGEU
                     (opcode === I_TYPE & funct3 === 3'b001) ? 6'b000001: //**SLLI
                     (opcode === R_TYPE & funct3 === 3'b001) ? 6'b000001://**SLL
                     opcode === LOAD ? 6'b000000:   //load is just an add
                     opcode === STORE ? 6'b000000: //store is just an add
                     opcode === LUI ? 6'b000000:   //Load upper imm is just an add
                     opcode === AUIPC ? 6'b000000: //AUIPC is just an add
                     opcode === JALR ? 6'b111111:  //pass data A through
                     opcode === JAL ? 6'b011111:   //pass data A through
                     6'b000000;           

//assignment statement for TARGET_PC
/*
assign target_PC = (opcode == JALR) ? {{JALR_target[15:1]}, 1'b0}: //targetPC for JALR instructions (PC + RS1) 
                    (opcode == BRANCH) ? b_imm_32 + PC:
                    imm32 + (PC+4);
    */                
assign target_PC = (opcode == JALR) ? {{JALR_target[15:1]}, 1'b0}: //targetPC for JALR instructions (PC + RS1) 
                    (opcode == BRANCH) ? b_imm_64 + PC:
                    imm64 + (PC+4);
            
endmodule
