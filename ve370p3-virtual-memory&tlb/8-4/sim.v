`timescale 1ns / 1ps
`include "tlb.v"
`include "cache.v"
module sim();
    reg clk;
	reg tlb_en;
	reg cache_en;
    reg read_write;
	reg [31:0] cpu_write_data;
	wire [31:0] cpu_read_data;
    wire tlb_hit;
    wire cpu_hit;
	wire tlb_end;
    reg c_clear_refer;
    reg [11:0] virtual_address;
    wire [9:0]c_physical_address;
	integer time_curr=0;
    
    TLB tlb(clk,
	tlb_en,
    read_write,
	c_clear_refer,
	virtual_address,//virtual address
	c_physical_address,//PYHSICAL ADDRESS
	//input 			[16:0]  PT_DATA,//page table data,17bit= 3+8(VPN)+6(PPN)
	tlb_hit
    );

    cache cache(
		clk,
        read_write,
        c_physical_address, //10 bit
        cpu_write_data,
		cache_en,
        cpu_read_data,
        cpu_hit
    );
always #5 clk = ~clk;
always #5 tlb_en = ~tlb_en;
always #5 cache_en = ~cache_en;
always #5 time_curr =time_curr+5;
    initial 
    begin
    clk=1'b1;
	tlb_en=1'b1;
	cache_en=1'b0;
    c_clear_refer=1'b0;
    assign c_clear_refer= (time_curr /(16*10))%2;
	   #0  read_write = 0; virtual_address = 12'b000000000000;  //should miss
	   $display("1: address = %B; read_write = 0;",virtual_address);
	   #10 read_write = 1; virtual_address = 12'b000000000000; cpu_write_data = 8'b11111111; //should hit
	   $display("2:read_write = 1; virtual address = %B; write_data = 8'b11111111;",virtual_address);
	   #10 read_write = 0; virtual_address = 12'b000000000000; //should hit and read out 0xff
	   $display("3:read_write = 0; virtual address = %B",virtual_address);
	   //here check main memory content, 
	   //the first byte should remain 0x00 if it is write-back, 
	   //should change to 0xff if it is write-through.
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	
	   #10 read_write = 0; virtual_address = 12'b001000000000; //should miss
	   $display("4:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b000000000000; //should hit for 2-way associative, should miss for directly mapped
	   $display("5:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b001100000000; //should miss
	   $display("6:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b001000000000; //should miss both for directly mapped and for 2-way associative (Least-Recently-Used policy)
	   $display("7:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   //here check main memory content, 
	   //the first byte should be 0xff
	   #10 $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   
	   
	    #10  read_write = 0; virtual_address = 12'b000000010000;  //should miss
	   $display("8: address = %B; read_write = 0;",virtual_address);
	   #10 read_write = 1; virtual_address = 12'b000000100000; cpu_write_data = 8'b11111111; //should hit
	   $display("9:read_write = 1; virtual address = %B; write_data = 8'b11111111;",virtual_address);
	   #10 read_write = 0; virtual_address = 12'b000000110000; //should hit and read out 0xff
	   $display("10:read_write = 0; virtual address = %B",virtual_address);
	   //here check main memory content, 
	   //the first byte should remain 0x00 if it is write-back, 
	   //should change to 0xff if it is write-through.
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	
	   #10 read_write = 0; virtual_address = 12'b001001000000; //should miss
	   $display("11:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b000001010000; //should hit for 2-way associative, should miss for directly mapped
	   $display("12:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b001101100000; //should miss
	   $display("13:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b001001110000; //should miss both for directly mapped and for 2-way associative (Least-Recently-Used policy)
	   $display("14:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   //here check main memory content, 
	   //the first byte should be 0xff
	   #10 $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   
	    #10  read_write = 0; virtual_address = 12'b000010000000;  //should miss
	   $display("15: address = %B; read_write = 0;",virtual_address);
	   #10 read_write = 1; virtual_address = 12'b000010010000; cpu_write_data = 8'b11111111; //should hit
	   $display("16:read_write = 1; virtual address = %B; write_data = 8'b11111111;",virtual_address);
	   #10 read_write = 0; virtual_address = 12'b000010100000; //should hit and read out 0xff
	   $display("17:read_write = 0; virtual address = %B",virtual_address);
	   //here check main memory content, 
	   //the first byte should remain 0x00 if it is write-back, 
	   //should change to 0xff if it is write-through.
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	
	   #10 read_write = 0; virtual_address = 12'b001010110000; //should miss
	   $display("18:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b000011000000; //should hit for 2-way associative, should miss for directly mapped
	   $display("19:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b001111010000; //should miss
	   $display("20:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b001011100000; //should miss both for directly mapped and for 2-way associative (Least-Recently-Used policy)
	   $display("21:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   //here check main memory content, 
	   //the first byte should be 0xff
	   #10 $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	    #10  read_write = 0; virtual_address = 12'b000011110000;  //should miss
	   $display("22: address = %B; read_write = 0;",virtual_address);
	   #10 read_write = 1; virtual_address = 12'b000100000000; cpu_write_data = 8'b11111111; //should hit
	   $display("23:read_write = 1; virtual address = %B; write_data = 8'b11111111;",virtual_address);
	   #10 read_write = 0; virtual_address = 12'b000100010000; //should hit and read out 0xff
	   $display("24:read_write = 0; virtual address = %B",virtual_address);
	   //here check main memory content, 
	   //the first byte should remain 0x00 if it is write-back, 
	   //should change to 0xff if it is write-through.
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	
	   #10 read_write = 0; virtual_address = 12'b001000000000; //should miss
	   $display("25:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b000000000000; //should hit for 2-way associative, should miss for directly mapped
	   $display("26:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b001100000000; //should miss
	   $display("27:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   #10 read_write = 0; virtual_address = 12'b001000000000; //should miss both for directly mapped and for 2-way associative (Least-Recently-Used policy)
	   $display("28:read_write = 0; virtual address = %B",virtual_address);
	   $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   //here check main memory content, 
	   //the first byte should be 0xff
	   #10 $display("First word in main memory = 0x%H", cache.mainMemory.memory[0]);
	   $stop;

end

endmodule