`ifndef MODULE_PAGE_TABLE
`define MODULE_PAGE_TABLE

`timescale 1ns / 1ps


module page_table( 
input clk,   
    //input write,  //we only read from page table
    input [7:0] VPN_in, //VPN 8 bit
    //input [63:0] write_data,
    output reg [5:0] PPN_out,  //PPN 6 bit
    output reg valid_out    // valid bit
    );
    reg  valid [255:0];
    reg [5:0] PPN [255:0]; //255=2^8-1
    integer i;
    integer PPN_curr;
    initial begin
    PPN_curr=256;
    for(i = 0; i < 256; i = i + 1) begin
        if(i<240)begin  // the condition when no page fault (valid =1)
            valid[i]=1'b1;
            PPN[i] = { i % 64 +1'b1 };// a map from 8 bit to 6 bit  
            
        end  else begin //when page fault (for certain index,no PPN on page table)
            valid[i]=1'b0;
            PPN[i] = { i % 64 +1'b1};// a map from 8 bit to 6 bit  
        end 
     //   $display("page_table :initial ,valid[0x%H]=0x%H,PPN[i]=i mod 64=0x%H",
        // i,valid[i],PPN[i]); 
     end   
    end
    
    always @(*) begin
        if(valid[VPN_in])begin //page hit  (when valid ==1)
            PPN_out=PPN[VPN_in];
            valid_out=valid[VPN_in];
         $display("page_table :valid=1,page_table PPN_out = 0x%H", page_table.PPN_out);
        end else begin //page fault (when valid ==0)
            PPN[VPN_in]=PPN_curr;// we give new value to PPN when page fault(simulate fetch from disk)
            valid[VPN_in]=1'b1;//now it's valid
            PPN_out=PPN[VPN_in];// output PPN_out
            
            $display("page_table: valid=0,page_table PPN_out = 0x%H", page_table.PPN_out);
            
            PPN_curr=PPN_curr+1;//PPN_curr++
        end
    end

    //assign PPN_out = PPN[i];
    
    
endmodule
`endif