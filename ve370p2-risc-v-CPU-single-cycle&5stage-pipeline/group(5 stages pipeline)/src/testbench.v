`timescale 1ns / 1ps

`include "main.v"

module testbench;
  integer currTime;
  reg clk;

  main uut(
    .clk (clk)
  );
 
  initial begin
    #0
    clk = 0;
    currTime = -10;
    uut.asset_pc.out = -4;
    $display("=========================================================");

    #2000 $display("=========================================================");
    #2000 $stop;
  end

  always @(posedge clk) begin
    // indicating a posedge clk triggered
    $display("---------------------------------------------------------");
    #1; // wait for writing back
    $display("Time: %d, CLK = %d, PC = 0x%H", currTime, clk, uut.asset_pc.out);
    $display("[x0] = 0x%H", uut.asset_reg.RegData[0]);
    $display("[x1] = 0x%H", uut.asset_reg.RegData[1]);
    $display("[x2] = 0x%H", uut.asset_reg.RegData[2]);
    $display("[x3] = 0x%H", uut.asset_reg.RegData[3]);
    $display("[x4] = 0x%H", uut.asset_reg.RegData[4]);
    $display("[x5] = 0x%H", uut.asset_reg.RegData[5]);
    $display("[x6] = 0x%H", uut.asset_reg.RegData[6]);
    $display("[x7] = 0x%H", uut.asset_reg.RegData[7]);
    $display("[x8] = 0x%H", uut.asset_reg.RegData[8]);
    $display("[x9] = 0x%H", uut.asset_reg.RegData[9]);
    $display("[x10] = 0x%H", uut.asset_reg.RegData[10]);
    $display("[x11] = 0x%H", uut.asset_reg.RegData[11]);
    $display("[x12] = 0x%H", uut.asset_reg.RegData[12]);
    $display("[x13] = 0x%H", uut.asset_reg.RegData[13]);
    $display("[x14] = 0x%H", uut.asset_reg.RegData[14]);
    $display("[x15] = 0x%H", uut.asset_reg.RegData[15]);
    $display("[x16] = 0x%H", uut.asset_reg.RegData[16]);
    $display("[x17] = 0x%H", uut.asset_reg.RegData[17]);
    $display("[x18] = 0x%H", uut.asset_reg.RegData[18]);
    $display("[x19] = 0x%H", uut.asset_reg.RegData[19]);
    $display("[x20] = 0x%H", uut.asset_reg.RegData[20]);
    $display("[x21] = 0x%H", uut.asset_reg.RegData[21]);
    $display("[x22] = 0x%H", uut.asset_reg.RegData[22]);
    $display("[x23] = 0x%H", uut.asset_reg.RegData[23]);
    $display("[x24] = 0x%H", uut.asset_reg.RegData[24]);
    $display("[x25] = 0x%H", uut.asset_reg.RegData[25]);
    $display("[x26] = 0x%H", uut.asset_reg.RegData[26]);
    $display("[x27] = 0x%H", uut.asset_reg.RegData[27]);
    $display("[x28] = 0x%H", uut.asset_reg.RegData[28]);
    $display("[x29] = 0x%H", uut.asset_reg.RegData[29]);
    $display("[x30] = 0x%H", uut.asset_reg.RegData[30]);
    $display("[x31] = 0x%H", uut.asset_reg.RegData[31]);
  end

  always #10 begin
    clk = ~clk;
    currTime = currTime + 10;
  end

endmodule
