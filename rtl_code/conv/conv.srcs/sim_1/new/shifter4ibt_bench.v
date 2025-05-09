`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 09:34:49
// Design Name: 
// Module Name: shifter4ibt_bench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shifter4bit_bench();
reg clk,reset;
reg [3:0] a;
reg [4:0] shift_bits;

wire [23:0] shiftOut;

shifter4bit shifter4bit1(
     .clk(clk),
     .reset(reset),
     .a(a),
     .shift_bits(shift_bits),
     .shiftOut(shiftOut)
);

initial clk = 1;
always #1 clk = ~clk;

initial
begin
    reset<=1'b0;   a<=4'b0101;   shift_bits<=5'b0_1111;
    #2 reset<=1'b1;
end



endmodule
