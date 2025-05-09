`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/18 15:34:57
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
input [63:0] filterWeight2;     //4-bit

output [16:0] addOut;
reg [16:0] addOut;

reg [79:0] concatOut;     //16*5
reg [95:0] nonconcatOut;      //16*6

wire [255:0] shiftOut2;     //16*16

//shift    
genvar i;
generate
    for (i = 0 ; i < 16; i=i+1)
       shifter4bit shifter4bit1(clk,reset,computeOut2[i*4+:4],filterWeight2[i*4+:4],shiftOut2[i*16+:16]);
endgenerate

//OR     16   10个可拼接，6个不可拼接
always@(*)
begin
  if(reset==1'b0)
  begin
    concatOut<=140'b0;
    nonconcatOut<=84'b0;
  end
  else
  begin
    nonconcatOut[15:0]<=shiftOut2[15:0];
    nonconcatOut[31:16]<=shiftOut2[31:16];
    concatOut[15:0]<=shiftOut2[47:32] | shiftOut2[63:48];
    concatOut[31:16]<=shiftOut2[79:64] | shiftOut2[95:80];
    concatOut[47:32]<=shiftOut2[111:96] | shiftOut2[127:112];
    nonconcatOut[47:32]<=shiftOut2[143:128];
    nonconcatOut[63:48]<=shiftOut2[159:144];
    
    nonconcatOut[79:64]<=shiftOut2[175:160];
    nonconcatOut[95:80]<=shiftOut2[191:176];
    concatOut[63:48]<=shiftOut2[207:192] | shiftOut2[223:208];
    concatOut[79:64]<=shiftOut2[239:224] | shiftOut2[255:240];
    
  end
end

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
      addOut<=17'b0;
   else
   begin
      addOut<=((concatOut[15:0] +concatOut[31:16])+(concatOut[47:32] + concatOut[63:48]))+concatOut[79:64]+((nonconcatOut[15:0] + nonconcatOut[31:16])+(nonconcatOut[47:32] + nonconcatOut[63:48]))+(nonconcatOut[79:64] + nonconcatOut[95:80]);
   end
end

endmodule
