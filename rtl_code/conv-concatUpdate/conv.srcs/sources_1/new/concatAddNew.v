`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/08/03 09:43:15
// Design Name: 
// Module Name: concatAddNew
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


module concatAddNew(clk,reset,computeOut2,computeOut3,filterWeight2,filterWeight3,addOut);
input clk,reset;
input [63:0] computeOut2;        //4-bit  *36
input [35:0] computeOut3;        //6-bit   *12
input [89:0] filterWeight2;     //5-bit
input [29:0] filterWeight3;     //5-bit

output [27:0] addOut;
reg [27:0] addOut;

reg [191:0] concatOut;
wire [71:0] nonconcatOut;    




//shift     36 = 10 10 10  6       
genvar i;
generate
    for (i = 0 ; i < 3; i=i+1)
       shifter4bit shifter4bit1(clk,reset,computeOut2[i*4+:4],filterWeight2[i*5+:5],nonconcatOut[i*24+:24]);
endgenerate

always@(*)
begin
   if(reset==1'b0)
   begin
      concatOut<=0;
   end
   else
   begin
      concatOut[3:0]<=computeOut2[15:12];
      concatOut[7:4]<=computeOut2[19:16];
      
      concatOut[27:24]<=computeOut2[23:20];
      concatOut[31:28]<=computeOut2[27:24];
      
      concatOut[51:48]<=computeOut2[31:28];
      concatOut[55:52]<=computeOut3[5:0];
      concatOut[59:56]<=computeOut3[11:6];
      
      concatOut[75:72]<=computeOut2[35:32];
      concatOut[79:76]<=computeOut2[39:36];
      concatOut[83:80]<=computeOut3[17:12];
      
      concatOut[99:96]<=computeOut2[43:40];
      concatOut[103:100]<=computeOut3[23:18];
      concatOut[107:104]<=computeOut3[29:24];
      
      concatOut[123:120]<=computeOut2[47:44];
      concatOut[127:124]<=computeOut3[35:30];
      
      concatOut[147:144]<=computeOut2[51:48];
      concatOut[151:148]<=computeOut2[55:52];
      
      concatOut[171:168]<=computeOut2[59:56];
      concatOut[175:172]<=computeOut2[63:60];
   end
end

//OR     36   5个可拼接，4个不可拼接
//always@(*)
//begin
//  if(reset==1'b0)
//  begin
//    concatOut<=168'b0;
//    nonconcatOut<=192'b0;
//  end
//  else
//  begin
//    nonconcatOut[23:0]<=shiftOut2[23:0];
//    concatOut[23:0]<=shiftOut2[47:24] | shiftOut2[71:48];
//    concatOut[47:24]<=shiftOut2[95:72] | shiftOut3[23:0];
//    concatOut[71:48]<=shiftOut3[47:24] | shiftOut3[71:48] | shiftOut2[119:96];
//    concatOut[95:72]<=shiftOut2[143:120] | shiftOut2[167:144] | shiftOut3[95:72];
//    concatOut[119:96]<=shiftOut2[191:168] | shiftOut3[119:96] | shiftOut3[143:120];
//    concatOut[143:120]<=shiftOut2[215:192] | shiftOut2[239:216];
//    concatOut[167:144]<=shiftOut2[287:264] | shiftOut2[263:240];
//    nonconcatOut[47:24]<=shiftOut2[311:288];
    
//    concatOut[191:168]<=shiftOut2[335:312] | shiftOut2[359:336];
//    nonconcatOut[71:48]<=shiftOut2[383:360];
//  end
//end

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
