`timescale 1ns / 1ps
`include "cache.v"
module testbench;
	integer i,j,k;
	reg 		read_write;
	reg	[31:0] 	write_data;
	reg	[9:0]	address;
	reg clk;
	reg tlb_end;
	wire [31:0] read_data;
	wire hit_miss;
	cache uut(
		.cpu_write			(read_write),
		.cpu_address	   	(address),
		.cpu_write_data		(write_data),
		.tlb_end			(1),
		.cpu_read_data      (read_data),
		.cpu_hit		    (hit_miss)
	);
	initial begin
		$dumpfile("bench.vcd");
		$dumpvars(1, uut);
		#0 address = 10'b0000000000; read_write = 0; //should miss
					$display("1: address = 10'b0000000000; read_write = 0;",);
		#10 read_write = 1; address = 10'b0000000000; write_data = 8'b11111111; //should hit
					$display("2:read_write = 1; address = 10'b0000000000; write_data = 8'b11111111;",);
		#10 read_write = 0; address = 10'b0000000000; //should hit and read out 0xff
		//here check main memory content,
		//the first byte should remain 0x00 if it is write-back,
		//should change to 0xff if it is write-through.
					$display("3:read_write = 0; address = 10'b0000000000;",);
		
		
		#10 for(i = 0 ; i < 1 ; i = i + 2) begin
			$display("memory[%1D]= 0x%H, memory[%1D]= 0x%H ",i,uut.mainMemory.memory[i],i+1,uut.mainMemory.memory[i+1]);
		end
		$display("\n\n",);
		#10 read_write = 0; address = 10'b1000000000; //should miss
					$display("4:read_write = 0; address = 10'b1000000000",);
		#10 for(i = 0 ; i < 1 ; i = i + 2) begin
			$display("memory[%D]= 0x%H, memory[%D]= 0x%H",i,uut.mainMemory.memory[i],i+1,uut.mainMemory.memory[i+1]);
		end
		$display("\n\n",);

		#10 read_write = 0; address = 10'b0000000000; //should hit for 2-way associative, should miss for directly mapped
					$display("5:read_write = 0; address = 10'b0000000000",);
		#10 for(i = 0 ; i < 1 ; i = i + 2) begin
			$display("memory[%D]= 0x%H, memory[%D]= 0x%H ",i,uut.mainMemory.memory[i],i+1,uut.mainMemory.memory[i+1]);
		end
		$display("\n\n",);
		#10 read_write = 0; address = 10'b1100000000; //should miss
					$display("6:read_write = 0; address = 10'b1100000000",);
		#10 for(i = 0 ; i < 1 ; i = i + 2) begin
			$display("memory[%D]= 0x%H, memory[%D]= 0x%H ",i,uut.mainMemory.memory[i],i+1,uut.mainMemory.memory[i+1]);
		end
		$display("\n\n",);
		#10 read_write = 0; address = 10'b1000000000; //should miss both for directly mapped and for 2-way associative (Least-Recently-Used policy)
					$display("7:read_write = 0; address = 10'b1000000000",);
		#10 for(i = 0 ; i < 1 ; i = i + 2) begin
			$display("memory[%D]= 0x%H, memory[%D]= 0x%H ",i,uut.mainMemory.memory[i],i+1,uut.mainMemory.memory[i+1]);
		end
		$display("\n\n",);
		//$display("$$$$$$$$$$$$$$$$$$$$$$$",);
		#500 $stop;
	end
endmodule