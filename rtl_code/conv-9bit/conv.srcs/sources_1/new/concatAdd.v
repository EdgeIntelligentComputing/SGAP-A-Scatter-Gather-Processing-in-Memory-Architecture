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

input [63:0] computeOut2;        //4-bit   *16
input [23:0] computeOut3;        //6-bit   *4
input [63:0] filterWeight2;      //4-bit
input [15:0] filterWeight3;     //4-bit

output [18:0] addOut;
reg [18:0] addOut;

reg [107:0] concatOut;     //18*6
reg [143:0] nonconcatOut;      //18*8

wire [287:0] shiftOut2;     //18*16
wire [71:0] shiftOut3;     //18*4

//shift    
genvar i;
generate
    for (i = 0 ; i < 16; i=i+1)
       shifter4bit shifter4bit1(clk,reset,computeOut2[i*4+:4],filterWeight2[i*4+:4],shiftOut2[i*18+:18]);
    
    for (i = 0; i < 4; i=i+1)
       shifter6bit shifter6bit1(clk,reset,computeOut3[i*6+:6],filterWeight3[i*4+:4],shiftOut3[i*18+:18]);
endgenerate

//OR     36   12个可拼接，8个不可拼接
always@(*)
begin
  if(reset==1'b0)
  begin
    concatOut<=108'b0;
    nonconcatOut<=144'b0;
  end
  else
  begin
    nonconcatOut[17:0]<=shiftOut3[17:0];
    nonconcatOut[35:18]<=shiftOut2[17:0];
    concatOut[17:0]<=shiftOut2[35:18] | shiftOut2[53:36];
    concatOut[35:18]<=shiftOut2[71:54] | shiftOut2[89:72];
    concatOut[53:36]<=shiftOut2[107:90] | shiftOut2[125:108];
    nonconcatOut[53:36]<=shiftOut2[143:126];
    nonconcatOut[71:54]<=shiftOut3[35:18];
    
    nonconcatOut[89:72]<=shiftOut3[53:36];
    nonconcatOut[107:90]<=shiftOut2[161:144];
    concatOut[71:54]<=shiftOut2[179:162] | shiftOut2[197:180];
    concatOut[89:72]<=shiftOut2[215:198] | shiftOut2[233:216];
    concatOut[107:90]<=shiftOut2[251:234] | shiftOut2[269:252];
    nonconcatOut[125:108]<=shiftOut2[287:270];
    nonconcatOut[143:126]<=shiftOut3[71:54];
  end
end

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
      addOut<=19'b0;
   else
   begin
      addOut<=(((concatOut[17:0] + concatOut[35:18])+(concatOut[53:36] + concatOut[71:54]))+((concatOut[89:72] + concatOut[107:90])+(nonconcatOut[17:0] + nonconcatOut[35:18]))+((nonconcatOut[53:36] + nonconcatOut[71:54])+(nonconcatOut[89:72] + nonconcatOut[107:90])))+(nonconcatOut[125:108] + nonconcatOut[143:126]);
   end
end






endmodule
