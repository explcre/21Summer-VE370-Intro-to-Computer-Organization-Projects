module ALU_tb();

reg [5:0] ctrl;
reg [63:0] opA, opB;
reg branch_op;
wire branch;
wire [63:0] result;

ALU dut (
  .ALU_Control(ctrl),
  .operand_A(opA),
  .operand_B(opB),
  .branch_op(branch_op),
  .ALU_branch(branch),
  .ALU_result(result)
);

initial begin

  branch_op = 0;
  //add 4 + 5
  ctrl = 6'b000000;
  opA = 4;
  opB = 5;
  #10
  $display("ALU Result 4 + 5: %d",result);
  #10
  
  //add 2 + -1 
  opA = 2;//32'd2;
  opB = -1;//32'hffffffff;
  ctrl = 6'b000000;
  #10
  $display("ALU Result 2 + -1: %d", result);
  
  //sub 2 - (-1)
  ctrl = 6'b001000;
  opA = 2;
  opB = -1;
  #10
  $display("ALU Result 2 - (-1) %d", result);
  
  //slt(unsigned) 4 < 5
  ctrl = 6'b000011;
  opA = 4;
  opB = 5;
  #10
  $display("ALU Result 4 < 5: %d",result);
  
  //slt 4 < -1
  ctrl = 6'b000010;
  #10
  opA = 4;
  opB = -1;//32'hffffffff;
  #10
  $display("ALU Result 4 < -1: %d",result);  
  
  //XOR
  ctrl = 6'b000100;
  opA = 32'b011;
  opB = 32'b110;
  #10
  $display("xor(0x011,0x110) = %d",result);//should be 5 (0x101)
  
  //AND
  ctrl = 6'b000111;
  opA = -1; //all ones
  opB = 1; //0x1
  #10
  $display("and(1,-1) = %d",result); //should be 1
  
  //bne 
  ctrl = 6'b010001;
  branch_op = 1;
  opA = 4;
  opB = 0;
  #10
  $display("(bne 4,0) -> branch = %d",branch); //should be 1
  
  //bge (signed)
  ctrl = 6'b010101;
  opA = -17;
  opB = 10;
  #10
  $display("(bge -17,10) -> branch = %d", branch); //should be 0
  branch_op = 0; //done with branch tests
  
  //SLLI
  ctrl = 6'b000001;
  opA = 4;
  opB = 2; //shift amount
  #10
  $display("Logical shift 4 << 2 = %d",result); //result should be 16
  
  //JALR
  ctrl = 6'b111111; 
  opA = 20;
  opB = 13;
  #10
  $display("Jump and Link. ALU_result = %d", result); //should be 33 (our JALR adds opA + opB, where opB is the 12-bit signed immediate)

  
  
end

endmodule
