`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 21:33:47
// Design Name: 
// Module Name: filter_bench
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


module filter_bench();
reg clk,reset;
reg [3:0] n,m;
reg [5:0] divisionBitA,divisionBitW;
reg [23:0] divisionWeightA,divisionWeightW;
reg [17:0] divisionOutA,divisionOutW;

wire [35:0] filterBit;         //1-bit
wire [179:0] filterWeight;    //5-bit
wire [215:0] filterOut;      //6-bit
wire [35:0] drop;            //1-bit

filter_matrix filter_matrix1(
    .clk(clk),
    .reset(reset),
    .n(n),
    .m(m),
    .divisionBitA(divisionBitA),
    .divisionBitW(divisionBitW),
    .divisionWeightA(divisionWeightA),
    .divisionWeightW(divisionWeightW),
    .divisionOutA(divisionOutA),
    .divisionOutW(divisionOutW),
    .filterBit(filterBit),
    .filterWeight(filterWeight),
    .filterOut(filterOut),
    .drop(drop)
);


initial clk=1;
always #1 clk<=~clk;

initial
begin 
     //8-bit
     //A: 01001110          B: 10110110
     reset<=1'b0;  n<=4'b0111;  m<=4'b0111;   
     divisionBitA<=6'b0000_00;     divisionWeightA<=24'b0000_0000_0110_0100_0010_0000;     divisionOutA<=18'b000_000_001_000_011_010;
     divisionBitW<=6'b000_000;     divisionWeightW<=24'b0000_0000_0110_0100_0010_0000;     divisionOutW<=18'b000_000_010_011_001_011;
     #2 reset<=1'b1; 
     
end



endmodule
