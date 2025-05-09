`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/18 15:38:10
// Design Name: 
// Module Name: main_bench
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


module main_bench();
reg clk,reset;
reg [1:0] ops;

reg [63:0] filterWeight2;     //4-bit
reg [63:0] filterOut2;        //4-bit

reg [71:0] operands;          //9*8-bit
reg [63:0] data;      

wire [7:0] sum;

main main1(
    .clk(clk),
    .reset(reset),
    .ops(ops),
    .filterWeight2(filterWeight2),
    .filterOut2(filterOut2),
    .operands(operands),
    .data(data),
    .sum(sum)
);

initial clk=1'b1;
always #1 clk = ~clk;

initial
begin
    reset<=1'b0;            filterOut2<=64'b1101_1101;          ops=2'b00;
                            filterWeight2<=64'b1010_1010;        
                            operands<=72'b000010001000_000000001111_001000000000;          data<=64'b01;
    #2  reset<=1'b1;
end




endmodule
