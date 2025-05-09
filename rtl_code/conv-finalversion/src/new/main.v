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


module main(clk,reset,ops,filterWeight2,filterWeight3,filterOut2,filterOut3,operands,data,sum);
input clk,reset;
input [1:0] ops;
//input [35:0] filterBit;        //1-bit
input [179:0] filterWeight2;     //5-bit
input [59:0] filterWeight3;      //5-bit
input [215:0] filterOut2;        //6-bit
input [71:0] filterOut3;         //6-bit
input [107:0] operands;          //9*12-bit
input [63:0] data;      

output [29:0] sum;
reg [29:0] sum;

wire [143:0] computeOut2;        //6-bit
wire [71:0] computeOut3;        //6-bit
wire [383:0] concatOut;         //16¸ö24-bit
wire [383:0] nonconcatOut;      //16¸ö24-bit

wire [29:0] addOut;
wire [11:0] maxOut;
wire [11:0] avgOut;

//computation
mul mul1(clk,reset,filterWeight2,filterWeight3,filterOut2,filterOut3,computeOut2,computeOut3);

//concat
concat concat1(clk,reset,computeOut2,computeOut3,filterWeight2,filterWeight3,concatOut,nonconcatOut);

//Addition
add  add1(clk,reset,concatOut,nonconcatOut,addOut);

//max pooling
maxpooling maxpooling1(clk,reset,operands,maxOut);

//average pooling
avgpooling avgpooling1(clk,reset,operands,avgOut);

always@(*)
begin
   case(ops)
      2'b00:  sum<=addOut;
      2'b01:  sum<=maxOut;
      2'b10:  sum<=avgOut;
      default:  sum<=data;
   endcase
end


endmodule
