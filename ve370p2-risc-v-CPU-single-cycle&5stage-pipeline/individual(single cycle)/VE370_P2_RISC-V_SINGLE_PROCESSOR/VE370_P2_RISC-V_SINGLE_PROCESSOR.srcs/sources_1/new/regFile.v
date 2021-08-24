module regFile (
  input clock,
  input reset,
  input wEn,      // Write Enable
  input [63:0] write_data,
  input [4:0] read_sel1,
  input [4:0] read_sel2,
  input [4:0] write_sel,
  output [63:0] read_data1,
  output [63:0] read_data2
);

reg   [63:0] register_file[0:31];


assign read_data1 = register_file[read_sel1];
assign read_data2 = register_file[read_sel2];
integer i; //for the for-loop

always @(posedge clock)
begin
    if(reset)
    begin
        for(i=0; i<32; i=i+1) begin
            register_file[i] <= 64'b0;
        end
    end
    else if( (wEn == 1) && (write_sel != 5'b0))
    begin
        register_file[write_sel] <= write_data;
    end
    
end

endmodule
