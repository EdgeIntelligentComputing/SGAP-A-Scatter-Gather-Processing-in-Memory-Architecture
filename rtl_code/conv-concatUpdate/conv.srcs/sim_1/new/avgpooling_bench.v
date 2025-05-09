`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 15:41:23
// Design Name: 
// Module Name: avgpooling_bench
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


module avgpooling_bench();
reg clk,reset;
reg [107:0] operands;       //9*12-bit

wire [11:0] avgOut;

avgpooling avgpooling1(
    .clk(clk),
    .reset(reset),
    .operands(operands),
    .avgOut(avgOut)
);

initial clk=1'b1;
always #1 clk = ~clk;

initial
begin
    reset<=1'b0;        operands<=108'b000000001000_000000000011_000000000000;
    #2  reset<=1'b1;
end



endmodule
