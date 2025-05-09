`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 15:18:39
// Design Name: 
// Module Name: maxpooling_bench
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


module maxpooling_bench();
reg clk,reset;
reg [107:0] operands;       //9*12-bit

wire [11:0] maxOut;

maxpooling maxpooling1(
    .clk(clk),
    .reset(reset),
    .operands(operands),
    .maxOut(maxOut)
);

initial clk=1'b1;
always #1 clk = ~clk;

initial
begin
    reset<=1'b0;        operands<=108'b000010001000_000000001111_001000000000;
    #2  reset<=1'b1;
end








endmodule
