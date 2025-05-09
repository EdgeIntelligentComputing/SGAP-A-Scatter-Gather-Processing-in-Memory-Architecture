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
module main(clk,reset,ops,filterWeight2,filterOut2,operands,data,sum);
input clk,reset;
input [1:0] ops;

input [63:0] filterWeight2;     //4-bit
input [63:0] filterOut2;        //4-bit

input [71:0] operands;          //9*8-bit
input [63:0] data;      

output [7:0] sum;
reg [7:0] sum;

wire [63:0] computeOut2;        //4-bit

wire [16:0] addOut;
wire [7:0] maxOut;
wire [7:0] avgOut;

//computation
mul mul1(.clk(clk),.reset(reset),.filterOut2(filterOut2),.computeOut2(computeOut2));

//original_add original_add1(clk,reset,filterWeight2,filterWeight3,computeOut2,computeOut3,addOut);
concatAdd concatAdd1(.clk(clk),.reset(reset),.computeOut2(computeOut2),.filterWeight2(filterWeight2),.addOut(addOut));

//concat
//concat concat1(clk,reset,computeOut2,computeOut3,filterWeight2,filterWeight3,concatOut,nonconcatOut);

//Addition
//add  add1(clk,reset,concatOut,nonconcatOut,addOut);

//max pooling
maxpooling maxpooling1(.clk(clk),.reset(reset),.operands(operands),.maxOut(maxOut));

//average pooling
avgpooling avgpooling1(.clk(clk),.reset(reset),.operands(operands),.avgOut(avgOut));

always@(*)
begin
   case(ops)
      2'b00:  sum<=addOut[15:8];
      2'b01:  sum<=maxOut;
      2'b10:  sum<=avgOut;
      default:  sum<=data;
   endcase
end


endmodule
