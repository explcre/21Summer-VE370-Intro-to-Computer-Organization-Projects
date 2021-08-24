`timescale 1ns / 1ps
`ifndef MODULE_MAIN_MEMORY
`define MODULE_MAIN_MEMORY

module main_memory(
    input write,
    input [9:0] address,
    input [63:0] write_data,
    output reg [63:0] read_data
    );
    reg [31:0] memory [255:0];
    integer i;
    
    initial begin
    for(i = 0; i < 256; i = i + 1)
        memory[i] = 32'b0;
    end
    
    always @(write) begin
        if (write) begin
            memory[{address[9:3],1'b1}] = write_data[63:32];
            memory[{address[9:3],1'b0}] = write_data[31:0];
            read_data = 0;
        end
        else begin
            read_data = {memory[{address[9:3],1'b1}], memory[{address[9:3],1'b0}]};
        end
        $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
     end
    
endmodule
`endif