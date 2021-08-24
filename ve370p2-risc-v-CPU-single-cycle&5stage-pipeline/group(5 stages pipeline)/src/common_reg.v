`timescale 1ns / 1ps

module common_reg(
    input clock,
    input in,
    output reg out
);

initial
begin
    out <= 0;
end

always @(posedge clock)
begin
    out <= in;
end
endmodule
