`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/20 10:10:56
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

//7-bit
module main(clk,reset,ops,filterWeight2,filterWeight3,filterOut2,filterOut3,operands,data,sum);
input clk,reset;
input [1:0] ops;

input [63:0] filterWeight2;     //4-bit
input [15:0] filterWeight3;     //4-bit
input [63:0] filterOut2;        //4-bit
input [23:0] filterOut3;        //6-bit

input [80:0] operands;          //9*9-bit
input [63:0] data;      

output [8:0] sum;
reg [8:0] sum;

wire [63:0] computeOut2;        //4-bit
wire [23:0] computeOut3;        //6-bit

wire [18:0] addOut;
wire [8:0] maxOut;
wire [8:0] avgOut;

//computation
mul mul1(clk,reset,filterOut2,filterOut3,computeOut2,computeOut3);

//original_add original_add1(clk,reset,filterWeight2,filterWeight3,computeOut2,computeOut3,addOut);
concatAdd concatAdd1(clk,reset,computeOut2,computeOut3,filterWeight2,filterWeight3,addOut);

//concat
//concat concat1(clk,reset,computeOut2,computeOut3,filterWeight2,filterWeight3,concatOut,nonconcatOut);

//Addition
//add  add1(clk,reset,concatOut,nonconcatOut,addOut);

//max pooling
maxpooling maxpooling1(clk,reset,operands,maxOut);

//average pooling
avgpooling avgpooling1(clk,reset,operands,avgOut);

always@(*)
begin
   case(ops)
      2'b00:  sum<=addOut[17:9];
      2'b01:  sum<=maxOut;
      2'b10:  sum<=avgOut;
      default:  sum<=data;
   endcase
end


endmodule
