module top_tb();

reg clock;
reg reset;

wire [63:0] result;

integer x;
integer i;

top dut (
  .clock(clock),
  .reset(reset),
  .wb_data(result)
);

always #5 clock = ~clock;

task print_state;
  begin
    $display("Time:\t%0d  , PC=%h", $time,dut.PC);
    for( x=0; x<32; x=x+4) begin
      $display("Reg[%d]: %h ,Reg[%d]: %h ,Reg[%d]: %h ,Reg[%d]: %h "
       ,x, dut.regFile_inst.register_file[x],x+1, dut.regFile_inst.register_file[x+1]
       ,x+2, dut.regFile_inst.register_file[x+2],x+3, dut.regFile_inst.register_file[x+3]);
    end
    $display("--------------------------------------------------------------------------------");
    $display("\n\n");
  end
endtask

initial begin
  clock = 1'b1;
  reset = 1'b1;

    print_state();

  // Make sure the .vmh file is in the same directory that you launched the
  // simulation from.
  
  //used to use this following line
  //$readmemb("E:/JI/3 JUNIOR/2021 summer/ve370/7-5p2inst-test22.txt", dut.inst_memory.inst_mem);
  
  $readmemh("E:/JI/3 JUNIOR/2021 summer/ve370/7-5alutest.txt", dut.inst_memory.inst_mem);
  //$readmemh("F:/Users/ASUS/VE370_P2_RISC-V_SINGLE_PROCESSOR/VE370_P2_RISC-V_SINGLE_PROCESSOR.srcs/sim_1/new/fibonacci.vmh", dut.inst_memory.inst_mem); // Should put 0x00000015 in register x9
  //$readmemb("F:/Users/ASUS/VE370_P2_RISC-V_SINGLE_PROCESSOR/VE370_P2_RISC-V_SINGLE_PROCESSOR.srcs/testcases/testcase.txt",dut.inst_memory.inst_mem);
    
  //$readmemh("F:/Users/ASUS/VE370_P2_RISC-V_SINGLE_PROCESSOR/VE370_P2_RISC-V_SINGLE_PROCESSOR.srcs/sim_1/new/gcd.vmh", dut.main_memory.ram); // Should put 0x00000010 in register x9

  for( x=0; x<32; x=x+1) begin
    dut.regFile_inst.register_file[x] = 64'b0;
  end
 
 
 

  #1
  #20
  reset = 1'b0; //PC now at 0, should begin executing instructions
  print_state();

for( i=0; i<100; i=i+1) begin
#10
       print_state();
end
  #800
  print_state();
 
   #100
    $display("done!\n");
  $stop();

end
/*
always @(posedge clock)
begin

  #20
 
  print_state();
end
*/
endmodule

