`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/20 20:43:56
// Design Name: 
// Module Name: mul_bench
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


module mul_bench();
reg clk,reset;
reg [35:0] filterBit;         //1-bit
reg [179:0] filterWeight2;     //5-bit
reg [59:0] filterWeight3;     //5-bit
reg [215:0] filterOut2;        //6-bit
reg [71:0] filterOut3;        //6-bit
reg [35:0] drop;              //1-bit


wire [143:0] computeOut2;        //6-bit
wire [71:0] computeOut3;        //6-bit

mul mul1(
    .clk(clk),
    .reset(reset),
    .filterBit(filterBit),
    .filterWeight2(filterWeight2),
    .filterWeight3(filterWeight3),
    .filterOut2(filterOut2),
    .filterOut3(filterOut3),
    .drop(drop),
    .computeOut2(computeOut2),
    .computeOut3(computeOut3)
);

initial clk=1;
always #1 clk = ~clk;

initial
begin
     reset<=1'b0;   filterBit<=36'b0;  filterWeight2<=180'b0;   filterWeight3<=180'b0;  filterOut2<=216'b010101_111111;   filterOut3<=216'b010101_111111;  drop<=36'b0;
     #2 reset<=1'b1;

end





endmodule
