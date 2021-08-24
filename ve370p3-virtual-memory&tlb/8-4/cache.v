`ifndef MODULE_CACHE
`define MODULE_CACHE
`include "main_memory.v"
`timescale 1ns / 1ps

module cache(
input clk,
    input cpu_write,
    input [9:0] cpu_address, //1024bytes
    input [31:0] cpu_write_data,
	input cache_en,
    output reg [31:0] cpu_read_data,
    output reg cpu_hit
    );
    
    reg [31:0] caches [7:0][1:0];
    reg valid [7:0];
    reg [3:0] tag [7:0];
    reg least_used [3:0] ;
    reg dirty [7:0];
    reg [2:0] index0;
	reg [2:0] index1;
	reg [2:0] readindex;
    reg mem_write;
    reg [9:0] mem_address;
    reg [63:0] mem_write_data;
    wire [63:0] mem_read_data;
    
    main_memory mainMemory(mem_write, mem_address, mem_write_data, mem_read_data);
    
    integer i, j;
    initial begin
        for(i = 0; i < 8; i = i + 1) begin
            for(j = 0; j < 2; j = j +1) begin
                caches[i][j]=32'b0;
            end
            valid[i]=1'b0;
            tag[i] = 4'b0;
            dirty[i] = 1'b0;
			
        end
		for(j = 0; j < 4; j = j +1) begin
            least_used[j] = 0;
        end
    end
    
    always @(*) begin
		if(cache_en) begin
	$display("cache_en:%d",cache_en);
	$display("cache Start");
	$display("cpu_write:%H",cpu_write);
	$display("cpu_address:%H",cpu_address);
	$display("cpu_write_data:%H",cpu_write_data);
			index0 = {cpu_address[5:4],1'b0};//two-way association
			index1 = {cpu_address[5:4],1'b1};
			readindex = {cpu_address[5:4], least_used[cpu_address[5:4]]};
			cpu_hit =  (valid[index0] && tag[index0] == {cpu_address[9:6]})
			|| (valid[index1] && tag[index1] == {cpu_address[9:6]});
	$display("hit_miss: %B",cpu_hit);
	$display("Check: Dirty: %H",dirty[readindex]);
	$display("readindex: %d",readindex);	
	$display("tag[index0]: %B",tag[index0]);
	$display("tag[index1]: %B",tag[index1]);		
	
			if(cpu_hit)
				if (cpu_write) begin
					if(tag[index0] == {cpu_address[9:6]}) begin // block 0
						least_used[cpu_address[5:4]] = 1;
						dirty[index0] = 1;
						caches[index0][cpu_address[2]] = cpu_write_data;
					end
					else begin // block 1
						least_used[cpu_address[5:4]] = 0;
						dirty[index1] = 1;
						caches[index1][cpu_address[2]] = cpu_write_data;
					end
				end
				else begin // read from cache
					if(tag[index0] == {cpu_address[9:6]}) begin // block 0
						 least_used[cpu_address[5:4]] = 1;
						 cpu_read_data = caches[index0][cpu_address[2]];
					end
					else begin // block 1
						 least_used[cpu_address[5:4]] = 0;
						 cpu_read_data = caches[index1][cpu_address[2]];
					end

				end
			else begin // miss
				if (dirty[readindex]) begin//write back
					mem_address ={tag[readindex],readindex,3'b000};
					mem_write_data = {caches[readindex][1],caches[readindex][0]};
					mem_write = 1; 
					$display("memWritedata! : %H",mem_write_data);
				end
				#1 begin
					valid[readindex] = 1;
					dirty[readindex] = 1'b0;
					tag[readindex] = {cpu_address[9:6]};
					mem_write = 0;
					mem_address = cpu_address;
					
				end
				#1 begin
				
					caches[readindex][1] = mem_read_data[63:32];
					caches[readindex][0] = mem_read_data[31:0];
					least_used[cpu_address[5:4]] = ~least_used[cpu_address[5:4]];
					$display("memreaddata! : %H", mem_read_data);
				end
			end
			$display("==================================================",);
			$display("read_write= %B; read_data= %B; address=%B; write_data=%H",cpu_write,cpu_read_data,mem_address,mem_write_data);
			$display("readindex: %d",readindex);

			for(i = 0; i < 8; i = i + 1) begin
				for(j = 0; j < 2; j = j +1) begin
					$display("caches[%d][%d]: %B,tag:%B",i,j,caches[i][j],tag[i]);
				    $display("dirty[%d]: %B",i,dirty[i]);	
				end
				
			end
			
			
			
			$display("==================================================",);
			$display("\n",);
			$display("cache end");
		end	
    end
endmodule
`endif