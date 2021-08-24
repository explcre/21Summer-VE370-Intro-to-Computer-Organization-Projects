module fetch #(
  parameter ADDRESS_BITS = 16
) (
  input  clock,
  input  reset,
  input  next_PC_select,
  input  [ADDRESS_BITS-1:0] target_PC,
  output [ADDRESS_BITS-1:0] PC
);

reg [ADDRESS_BITS-1:0] PC_reg;

assign PC = PC_reg;


always @(posedge clock)
begin
    if(reset)
    begin
        PC_reg <= 16'b0; //not sure what should happen if reset = 0, just set PC to 16'b0.
    end
    else if(next_PC_select)
    begin
        PC_reg <= target_PC; 
    end
    else
    begin
        PC_reg <= PC + 4;
    end
end

endmodule
