`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/02 15:09:43
// Design Name: 
// Module Name: inst_mem
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
module inst_mem #(
  parameter DATA_WIDTH = 32,
  parameter ADDR_WIDTH = 16
) (
  input  clock,

  // Instruction Port
  input  [ADDR_WIDTH-1:0] i_address,
  output [DATA_WIDTH-1:0] i_read_data


);

localparam RAM_DEPTH = 1 << ADDR_WIDTH; // right shifts 1 by 64 places. Thus there are 2^64 addresses

reg [DATA_WIDTH-1:0] inst_mem [0:RAM_DEPTH-1];


//combinational read instruction
assign i_read_data = inst_mem[i_address];

//assign d_read_data = inst_mem[d_address];

  integer n;
  initial begin
  
    for(n=0;n<RAM_DEPTH;n=n+1) begin
      inst_mem[n] = 32'b0;
    end
    //$readmemb("F:/Users/ASUS/VE370_P2_RISC-V_SINGLE_PROCESSOR/VE370_P2_RISC-V_SINGLE_PROCESSOR.srcs/testcases/testcase.txt",ram);
    
    //$readmemb("../../../../../testcases/testcase.txt",mem);//original
    //F:\Users\ASUS\VE370_P2_RISC-V_SINGLE_PROCESSOR\VE370_P2_RISC-V_SINGLE_PROCESSOR.srcs\testcases
    // FIXME: adjust the path to fit your need; or use absolute path instead.
    // $readmemb("../../../../../testcases/testcase.txt",mem); // simulation
    // $readmemb("../../../testcases/testcase.txt",mem); // bitstream
    
    // for(n=0;n<SIZE_IM;n=n+1) begin
    //   $display("[%d] 0x%H",n,mem[n]);
    // end
    
    //////instru = 32'b0;//used to be here
  end


endmodule



