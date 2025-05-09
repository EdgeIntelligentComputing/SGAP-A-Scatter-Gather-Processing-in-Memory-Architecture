`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 15:29:19
// Design Name: 
// Module Name: main
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


module main(clk,reset,n,m,activation,weight,featureMap);
input clk,reset;
input [3:0] n,m;
input [11:0] activation,weight;

output [11:0] featureMap;
reg [11:0] featureMap;

//Division
wire [5:0] divisionBitA,divisionBitW;
wire [23:0] divisionWeightA,divisionWeightW;
wire [17:0] divisionOutA,divisionOutW;

//Filter
wire [35:0] filterBit;        //1-bit
wire [179:0] filterWeight;    //5-bit
wire [215:0] filterOut;       //6-bit
wire [35:0] drop;             //1-bit

//Division
division_unit division_unit_a(clk,reset,n,m,activation,divisionBitA,divisionWeightA,divisionOutA);
division_unit division_unit_w(clk,reset,n,m,weight,divisionBitW,divisionWeightW,divisionOutW);

//Filter
filter_matrix filter_matrix1(clk,reset,n,m,divisionBitA,divisionBitW,divisionWeightA,divisionWeightW,divisionOutA,divisionOutW,filterBit,filterWeight,filterOut,drop);

always@(posedge clk)
begin
   featureMap<=12'b0;
end


//Multiplication


//Concat


//Addition




endmodule
