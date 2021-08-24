`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/07/01 07:46:46
// Design Name: 
// Module Name: testbench
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

`include "top.v"

module testbench;
reg clock;
reg reset;

wire [31:0] result;

integer x;

top dut (
  .clock(clock),
  .reset(reset),
  .wb_data(result)
);
  integer currTime;
  integer x;
  task print_state;
  begin
    $display("Time:\t%0d", $time);
    for( x=0; x<32; x=x+1) begin
      $display("Register %d: %h", x, dut.regFile_inst.register_file[x]);
    end
    $display("--------------------------------------------------------------------------------");
    $display("\n\n");
  end
endtask

  initial begin
    #0
   // clock = 0;
    //currTime = -10;
    //uut.asset_pc.out = -4;
    clock = 1'b1;
    reset = 1'b1;
    $display("=========================================================");

    #988 $display("=========================================================");
    #989 $stop;
  end

  always @(posedge clock) begin
    // indicating a posedge clk triggered
    $display("---------------------------------------------------------");
    #1; // wait for writing back
    $display("Time: %d, CLK = %d, PC = 0x%H",currTime, clock, uut.fetch.PC/*uut.asset_pc.out*/);
    print_state();
    $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H",dut.regFile_inst.register_file[16],dut.regFile_inst.register_file[17],uut.asset_reg.RegData[18]);
    $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H",dut.regFile_inst.register_file[19],dut.regFile_inst.register_file[20],dut.regFile_inst.register_file[21]);
    $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H",dut.regFile_inst.register_file[22],dut.regFile_inst.register_file[23],dut.regFile_inst.register_file[8]);
    $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H",dut.regFile_inst.register_file[9],dut.regFile_inst.register_file[10],dut.regFile_inst.register_file[11]);
    $display("[$t4] = 0x%H, [$t5] = 0x%H, [$t6] = 0x%H",dut.regFile_inst.register_file[12],dut.regFile_inst.register_file[13],dut.regFile_inst.register_file[14]);
    $display("[$t7] = 0x%H, [$t8] = 0x%H, [$t9] = 0x%H",dut.regFile_inst.register_file[15],dut.regFile_inst.register_file[24],dut.regFile_inst.register_file[25]);
  end

  always #10 begin
    clock = ~clock;
    currTime = currTime + 10;
  end

endmodule

