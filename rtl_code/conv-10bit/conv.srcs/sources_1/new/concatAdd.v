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


module concatAdd(clk,reset,computeOut2,filterWeight2,addOut);
input clk,reset;

input [63:0] computeOut2;        //4-bit   *16
input [79:0] filterWeight2;     //5-bit

output [20:0] addOut;
reg [20:0] addOut;

wire [319:0] shiftOut2;     //20*16

reg [99:0] concatOut;     //20*5
reg [119:0] nonconcatOut;      //20*6

//shift    
genvar i;
generate
    for (i = 0 ; i < 16; i=i+1)
       shifter4bit shifter4bit1(clk,reset,computeOut2[i*4+:4],filterWeight2[i*5+:5],shiftOut2[i*20+:20]);
endgenerate

//OR     16   10个可拼接，6个不可拼接
always@(*)
begin
  if(reset==1'b0)
  begin
    concatOut<=200'b0;
    nonconcatOut<=120'b0;
  end
  else
  begin
    nonconcatOut[19:0]<=shiftOut2[19:0];
    nonconcatOut[39:20]<=shiftOut2[39:20];
    concatOut[19:0]<=shiftOut2[59:40] | shiftOut2[79:60];
    concatOut[39:20]<=shiftOut2[99:80] | shiftOut2[119:100];
    concatOut[59:40]<=shiftOut2[139:120] | shiftOut2[159:140];
    nonconcatOut[59:40]<=shiftOut2[179:160];
    nonconcatOut[79:60]<=shiftOut2[199:180];
    
    nonconcatOut[99:80]<=shiftOut2[219:200];
    nonconcatOut[119:100]<=shiftOut2[239:220];
    concatOut[79:60]<=shiftOut2[259:240] | shiftOut2[279:260];
    concatOut[99:80]<=shiftOut2[299:280] | shiftOut2[319:300];
  end
end

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
      addOut<=17'b0;
   else
   begin
      addOut<=((concatOut[19:0] +concatOut[39:20])+(concatOut[59:40] + concatOut[79:60]))+concatOut[99:80]+((nonconcatOut[19:0] + nonconcatOut[39:20])+(nonconcatOut[59:40] + nonconcatOut[79:60]))+(nonconcatOut[99:80] + nonconcatOut[119:100]);
   end
end

endmodule
