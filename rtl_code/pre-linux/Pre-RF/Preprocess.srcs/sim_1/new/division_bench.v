`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 16:58:37
// Design Name: 
// Module Name: division_bench
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


module division_bench();
reg clk,reset;
reg [3:0] n,m;
reg [11:0] beforeDivision;

wire [5:0] divisionBit;
wire [23:0] divisionWeight;
wire [17:0] divisionOut;

division_unit division_unit1(
    .clk(clk),
    .reset(reset),
    .n(n),
    .m(m),
    .beforeDivision(beforeDivision),
    .divisionBit(divisionBit),
    .divisionWeight(divisionWeight),
    .divisionOut(divisionOut)
);


initial clk=1;
always #1 clk<=~clk;

initial
begin 
     reset<=1'b0;  n<=4'b0111;  m<=4'b0101;   beforeDivision<=12'b0000_0100_1101;
     #2 reset<=1'b1; 
     #6  beforeDivision<=12'b0111_0111_1111;
     
end



endmodule
