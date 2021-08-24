`timescale 1ns / 1ps

module one_64bit_mux(
  input source,
  input [63:0] input0,
  input [63:0] input1,
  output reg [63:0] out
);

initial begin
    out <= 64'b0;
end

always @(*) begin
    case (source) 
        1'b0:
            out = input0;
        1'b1:
            out = input1;
    endcase
end

endmodule

module two_64bit_mux(
  input [1:0] source,
  input [63:0] input0,
  input [63:0] input1,
  input [63:0] input2,
  input [63:0] input3,
  output reg [63:0] out
);

initial begin
    out <= 64'b0;
end

always @(*) begin
    case (source) 
        2'b00:
            out = input0;
        2'b01:
            out = input1;
        2'b10:
            out = input2;
        2'b11:
            out = input3;
    endcase
end

endmodule
