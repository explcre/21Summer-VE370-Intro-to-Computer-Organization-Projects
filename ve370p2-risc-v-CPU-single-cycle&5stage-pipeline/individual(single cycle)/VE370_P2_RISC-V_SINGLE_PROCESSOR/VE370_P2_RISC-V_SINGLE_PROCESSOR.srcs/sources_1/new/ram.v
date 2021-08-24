module ram #(
  parameter DATA_WIDTH = 64,
  parameter ADDR_WIDTH = 16
) (
  input  clock,
/*
  // Instruction Port
  input  [ADDR_WIDTH-1:0] i_address,
  output [DATA_WIDTH-1:0] i_read_data,
*/
  // Data Port
  input  wEn,
  input  [ADDR_WIDTH-1:0] d_address,
  input  [DATA_WIDTH-1:0] d_write_data,
  output [DATA_WIDTH-1:0] d_read_data

);

localparam RAM_DEPTH = 1 << ADDR_WIDTH; // right shifts 1 by 16 places. Thus there are 2^16 addresses

reg [DATA_WIDTH-1:0] ram [0:RAM_DEPTH-1];


//combinational read instruction
//assign i_read_data = ram[i_address];

assign d_read_data = ram[d_address];

  integer n;
  initial begin
  
    for(n=0;n<RAM_DEPTH;n=n+1) begin
      ram[n] = 64'b0;
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
//sequential write data
always @(posedge clock)
begin
    if(wEn)
    begin
        ram[d_address] <= d_write_data;
    end

end


endmodule
