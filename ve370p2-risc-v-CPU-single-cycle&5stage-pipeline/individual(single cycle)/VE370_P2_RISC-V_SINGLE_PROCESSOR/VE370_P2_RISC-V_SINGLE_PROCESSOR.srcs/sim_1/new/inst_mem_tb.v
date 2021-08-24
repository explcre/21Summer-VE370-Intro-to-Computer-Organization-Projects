`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 15:31:14
// Design Name: 
// Module Name: inst_mem_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module inst_mem_tb();

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 16;

reg  clock;

// Instruction Port
reg  [ADDR_WIDTH-1:0] i_address;
wire [DATA_WIDTH-1:0] i_read_data;

/*
// Data Port
reg  wEn;
reg  [ADDR_WIDTH-1:0] d_address;
reg  [DATA_WIDTH-1:0] d_write_data;
wire [DATA_WIDTH-1:0] d_read_data;
*/
integer x;
integer i;
inst_mem #(
  .DATA_WIDTH(DATA_WIDTH),
  .ADDR_WIDTH(ADDR_WIDTH)
) uut (
  .clock(clock),

  // Instruction Port
  .i_address(i_address),
  .i_read_data(i_read_data)/*,

  // Data Port
  .wEn(wEn),
  .d_address(d_address),
  .d_write_data(d_write_data),
  .d_read_data(d_read_data)*/
);

always #5 clock = ~clock;


initial begin
  clock = 1'b1;
  /*
  d_address = 64'b0;
  d_write_data = 64'b0;
  wEn = 1'b0;

  #10
  wEn = 1'b1;
  #10
  $display("Data Address %d: %h", d_address, d_read_data); //Data Address     0: 00000000
  d_write_data = 1;
  d_address = 4;
  #10
  $display("Data Address %d: %h", d_address, d_read_data); //Data Address     4: 00000001
  d_write_data = 2;
  d_address = 8;
  #10
  $display("Data Address %d: %h", d_address, d_read_data); //Data Address     8: 00000002
*/

  /***************************
  * Add more test cases here *
  ***************************/
  $readmemb("E:/JI/3 JUNIOR/2021 summer/ve370/7-5p2inst-test22.txt", uut.inst_mem);
  //$readmemh("F:/Users/ASUS/VE370_P2_RISC-V_SINGLE_PROCESSOR/VE370_P2_RISC-V_SINGLE_PROCESSOR.srcs/sim_1/new/fibonacci.vmh", uut.inst_mem); // Should put 0x00000015 in register x9
  //$readmemh("F:/Users/ASUS/VE370_P2_RISC-V_SINGLE_PROCESSOR/VE370_P2_RISC-V_SINGLE_PROCESSOR.srcs/sim_1/new/gcd.vmh", uut.ram); // Should put 0x00000010 in register x9
  
  #400
  i_address = 0;
  $display("Instruction Address %d: %b", i_address, i_read_data);
  
  for(i=1;i<126;i=i+1)begin
   i_address = i;
  #10
  $display("Instruction Address %d: %b", i_address, i_read_data);
  end
  /*
  i_address = 1;
  #10
  $display("Instruction Address %d: %h", i_address, i_read_data);
  
    i_address = 2;
    #10
    $display("Instruction Address %d: %h", i_address, i_read_data);
  
     i_address = 3;
     #10
     $display("Instruction Address %d: %h", i_address, i_read_data);
      
     i_address = 4;
     #10
     $display("Instruction Address %d: %h", i_address, i_read_data);

     i_address = 5;
     #10
     $display("Instruction Address %d: %h", i_address, i_read_data);
          
     i_address = 6;
     #10
     $display("Instruction Address %d: %h", i_address, i_read_data);
  */    
      
  #1000
  $stop();

end

endmodule



