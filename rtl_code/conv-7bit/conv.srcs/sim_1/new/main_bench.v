`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 16:46:56
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

reg [7:0] filterWeight2;     //4-bit
reg [23:0] filterWeight3;     //4-bit
reg [7:0] filterOut2;        //4-bit
reg [35:0] filterOut3;        //6-bit

reg [62:0] operands;          //9*12-bit
reg [63:0] data;      

wire [6:0] sum;

main main1(
    .clk(clk),
    .reset(reset),
    .ops(ops),
    .filterWeight2(filterWeight2),
    .filterWeight3(filterWeight3),
    .filterOut2(filterOut2),
    .filterOut3(filterOut3),
    .operands(operands),
    .data(data),
    .sum(sum)
);

initial clk=1'b1;
always #1 clk = ~clk;

initial
begin
    reset<=1'b0;            filterOut2<=8'b1101_1101;          filterOut3<=36'b100100_000100_010011;       ops=2'b00;
                            filterWeight2<=8'b1010_1010;       filterWeight3<=24'b0111_0100_0111;  
                            operands<=63'b000010001000_000000001111_001000000000;          data<=64'b01;
    #2  reset<=1'b1;
end




endmodule
