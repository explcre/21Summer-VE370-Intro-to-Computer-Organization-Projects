`ifndef MODULE_TLB
`define MODULE_TLB
`include "page_table.v"
`timescale 1ns / 1ps
module TLB (
input clk,
input tlb_en,
	input write,
	input clear_refer,
	input			[11:0]	VA,//virtual address
	output 	reg		[9:0] 	PA,//PYHSICAL ADDRESS
	//input 			[16:0]  PT_DATA,//page table data,17bit= 3+8(VPN)+6(PPN)
	output reg	tlb_hit
);
	reg	[5:0] PPN [15:0]; //16 entries
	reg [7:0] VPN [15:0]; 
	reg refer [15:0];
	reg valid [15:0];
	reg dirty [15:0];
	integer i;
	reg [3:0] visit_entry;
	
	wire [5:0] page_table_PPN_out;
	wire  page_table_valid_out;
	page_table pt(clk,VA[11:4],page_table_PPN_out,page_table_valid_out);
	
	initial begin
		for(i = 0; i < 16; i = i + 1) begin
			PPN[i]		=	6'b0;
			VPN[i]		=	8'b0;
			refer[i]	=	1'b0;
			valid[i]	=	1'b0;
			dirty[i]	=	1'b0;
		end
		tlb_hit = 1'b0;
		visit_entry = 4'b0;
		
	end
	always @(*) begin
		if(tlb_en) begin
			$display("TLB Start");
			if(clear_refer) begin
			$display("TLB: clear_refer==1");
				for(i = 0 ;i < 16; i = i + 1) begin
					refer[i]	=	1'b0;
				end
			end
			begin:find
				for(i = 0 ;i < 16; i = i + 1) begin  
						if (VA[11:4]==VPN[i] && valid[i]) begin
								tlb_hit = 1;
								visit_entry = i;
								$display("TLB: i=%d,  VA[11:4]==VPN[i ]=0x%H && valid[i], tlb_hit=1",
								i,VA[11:4]);
								disable find;
						end
				end
				tlb_hit = 0;
			end
			$display("tlb_hit: %H",tlb_hit);
			if (tlb_hit) begin //hit
				PA = {PPN[visit_entry],VA[3:0]};
				refer[visit_entry] = 1;
				$display("TLB: hit, PA=0x%H,refer[0x%H]=1",PA,visit_entry);
				if(write)begin
					dirty[visit_entry] = 1;
					$display("TLB: hit,write,dirty[0x%H]=1",visit_entry);
				end
			end
			
			else begin //miss
			//$display("TLB: miss");
				#1 begin
					begin:loop
						for(i = 0 ;i < 16; i = i + 1) begin
							if(refer[i]==0) begin
								visit_entry = i;	
								disable loop;		
							end
						end
						
						
					end
					$display("TLB: miss,visit_entry=0x%H",visit_entry);
					valid[visit_entry]	=	page_table_valid_out;
					PPN[visit_entry]=page_table_PPN_out[5:0];
					VPN[visit_entry]=VA[11:4];
					$display("TLB: miss,valid[visit_entry]=0x%H,PPN[visit_entry]=0x%H",
					page_table_valid_out,page_table_PPN_out[5:0]);

				end
				#1 begin
					PA = {PPN[visit_entry],VA[3:0]};
					refer[visit_entry] = 1;
					$display("TLB: miss, PA=0x%H,refer[0x%H]=1",PA,visit_entry);
				end
				
			end	
			for(i = 0 ;i < 16; i = i + 1) begin
				$display("TLB[%B],refer:%d",i,refer[i]);
				$display("dirty:%d",dirty[i]);
				$display("VPN:%d",VPN[i]);
				$display("PPN:%d",PPN[i]);
			end
			$display("TLB end");
		end
	end



endmodule
`endif