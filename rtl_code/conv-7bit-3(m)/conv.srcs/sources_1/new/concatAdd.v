`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/03 19:06:54
// Design Name: 
// Module Name: concatAdd
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


module concatAdd(clk,reset,computeOut2,computeOut3,filterWeight2,filterWeight3,addOut);
input clk,reset;

input [7:0] computeOut2;        //4-bit   *5
input [35:0] computeOut3;        //6-bit   *6
input [7:0] filterWeight2;     //4-bit
input [23:0] filterWeight3;     //4-bit

output [13:0] addOut;
reg [13:0] addOut;

reg [27:0] concatOut;     //14*2
reg [55:0] nonconcatOut;      //14*4

wire [27:0] shiftOut2;     //14*2
wire [83:0] shiftOut3;     //14*6

//shift    
genvar i;
generate
    for (i = 0 ; i < 2; i=i+1)
       shifter4bit shifter4bit1(clk,reset,computeOut2[i*4+:4],filterWeight2[i*4+:4],shiftOut2[i*14+:14]);
    
    for (i = 0; i < 6; i=i+1)
       shifter6bit shifter6bit1(clk,reset,computeOut3[i*6+:6],filterWeight3[i*4+:4],shiftOut3[i*14+:14]);
endgenerate

//OR     36   4个可拼接，4个不可拼接
always@(*)
begin
  if(reset==1'b0)
  begin
    concatOut<=28'b0;
    nonconcatOut<=56'b0;
  end
  else
  begin
    nonconcatOut[13:0]<=shiftOut3[13:0];
    concatOut[13:0]<=shiftOut3[27:14] | shiftOut2[13:0];
    nonconcatOut[27:14]<=shiftOut3[41:28];
    
    nonconcatOut[41:28]<=shiftOut3[55:42];
    concatOut[27:14]<=shiftOut3[69:56] | shiftOut2[27:14];
    nonconcatOut[55:42]<=shiftOut3[83:70];
  end
end

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
      addOut<=17'b0;
   else
   begin
      addOut<=((concatOut[13:0] + concatOut[27:14])+(nonconcatOut[13:0] + nonconcatOut[27:14]))+(nonconcatOut[41:28] + nonconcatOut[55:42]);
   end
end






endmodule
