
module regFile_tb();

reg clock, reset;

/******************************************************************************
*                      Start Your Code Here
******************************************************************************/

reg wEn;
reg [63:0] write_data;
reg [4:0] read_sel1;
reg [4:0] read_sel2;
reg [4:0] write_sel;
wire [63:0] read_data1;
wire [63:0] read_data2;

// Fill in port connections
regFile uut (
  .clock(clock),
  .reset(reset),
  .wEn(wEn), // Write Enable
  .write_data(write_data),
  .read_sel1(read_sel1),
  .read_sel2(read_sel2),
  .write_sel(write_sel),
  .read_data1(read_data1),
  .read_data2(read_data2)
);


always begin
    #5 clock = ~clock;
end
/*
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
*/

initial begin
  clock = 1'b1;
  reset = 1'b1;
  
  //write first
  #20;
  reset = 1'b0;
  wEn = 1'b1;
  write_sel = 5'b00001;
  read_sel1 = 5'b1; //read same value as write, get old value
  write_data = 32'h000F;
  #10
  write_sel = 5'b00010;
  write_data = 32'h0001;
  #10
  write_sel = 5'b00011;
  write_data = 32'h0002;
  #10
  write_sel = 5'b00100;
  write_data = 32'hFFFFFFFF;
  #10
  wEn = 1'b0;
  #10
  read_sel1 = 5'b00010; //should be 0001
  read_sel2 = 5'b00100; //should be all 1's (hex: FFFFFFFF)
  #20
  //try writing to reg 0
  write_sel = 5'b00000;
  wEn = 1'b1;
  write_data = 32'hDEADBEEF;
  read_sel1 = 5'b00000;
  #10
  wEn = 1'b0;
  #10
  read_sel1 = 5'b00000; //should be 0
  read_sel2 = 5'b00000; //should be 0
  
end

  // Test reads and writes to the register file here
always begin
    #15
    write_data <= write_data + 1'b1;
    //print_state();
end



endmodule
