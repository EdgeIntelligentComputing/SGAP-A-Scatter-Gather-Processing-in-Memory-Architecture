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
input [63:0] computeOut2;        //4-bit  *36
input [35:0] computeOut3;        //6-bit   *12
input [89:0] filterWeight2;     //5-bit
input [29:0] filterWeight3;     //5-bit

output [27:0] addOut;
reg [27:0] addOut;

reg [191:0] concatOut;
reg [71:0] nonconcatOut;    

wire [383:0] shiftOut2;     //24*16
wire [143:0] shiftOut3;     //24*6

//wire [239:0] regOut;     //24*10


//shift     36 = 10 10 10  6       
genvar i;
generate
    for (i = 0 ; i < 16; i=i+1)
       shifter4bit shifter4bit1(clk,reset,computeOut2[i*4+:4],filterWeight2[i*5+:5],shiftOut2[i*24+:24]);
    
    for (i = 0; i < 6; i=i+1)
       shifter6bit shifter6bit1(clk,reset,computeOut3[i*6+:6],filterWeight3[i*5+:5],shiftOut3[i*24+:24]);
endgenerate

//OR     36   5个可拼接，4个不可拼接
always@(*)
begin
  if(reset==1'b0)
  begin
    concatOut<=168'b0;
    nonconcatOut<=192'b0;
  end
  else
  begin
    nonconcatOut[23:0]<=shiftOut2[23:0];
    concatOut[23:0]<=shiftOut2[47:24] | shiftOut2[71:48];
    concatOut[47:24]<=shiftOut2[95:72] | shiftOut3[23:0];
    concatOut[71:48]<=shiftOut3[47:24] | shiftOut3[71:48] | shiftOut2[119:96];
    concatOut[95:72]<=shiftOut2[143:120] | shiftOut2[167:144] | shiftOut3[95:72];
    concatOut[119:96]<=shiftOut2[191:168] | shiftOut3[119:96] | shiftOut3[143:120];
    concatOut[143:120]<=shiftOut2[215:192] | shiftOut2[239:216];
    concatOut[167:144]<=shiftOut2[287:264] | shiftOut2[263:240];
    nonconcatOut[47:24]<=shiftOut2[311:288];
    
    concatOut[191:168]<=shiftOut2[335:312] | shiftOut2[359:336];
    nonconcatOut[71:48]<=shiftOut2[383:360];
  end
end

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
      addOut<=28'b0;
   else
   begin
      addOut<=((concatOut[167:144]+concatOut[143:120])+(concatOut[119:96]+concatOut[95:72]))+((concatOut[71:48]+concatOut[47:24]) + (concatOut[23:0]+nonconcatOut[23:0]))+((nonconcatOut[47:24]+nonconcatOut[71:48])+ concatOut[191:168]);
   end
end

endmodule



//nonconcatOut[23:0]<=shiftOut2[23:0];
//    nonconcatOut[47:24]<=shiftOut2[47:24];
//    concatOut[23:0]<=shiftOut2[71:48] | shiftOut3[23:0];
//    concatOut[47:24]<=shiftOut2[95:72] | shiftOut3[47:24];
//    concatOut[71:48]<=shiftOut2[143:120] | shiftOut2[119:96];
//    concatOut[95:72]<=shiftOut2[167:144] | shiftOut3[71:48];
//    concatOut[119:96]<=shiftOut2[191:168] | shiftOut3[95:72];
//    nonconcatOut[71:48]<=shiftOut2[215:192];
//    nonconcatOut[95:72]<=shiftOut2[239:216];
    
//    nonconcatOut[119:96]<=shiftOut2[263:240];
//    nonconcatOut[143:120]<=shiftOut2[287:264];
//    concatOut[143:120]<=shiftOut2[311:288] | shiftOut3[119:96];
//    concatOut[167:144]<=shiftOut2[335:312] | shiftOut3[143:120];
//    nonconcatOut[167:144]<=shiftOut2[359:336];
//    nonconcatOut[191:168]<=shiftOut2[383:360];