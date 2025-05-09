`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 17:18:52
// Design Name: 
// Module Name: add
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


module add(clk,reset,concatOut,nonconcatOut,addOut);
input clk,reset;
input [383:0] concatOut;         //16¸ö24-bit
input [383:0] nonconcatOut;      //16¸ö24-bit

output [29:0] addOut;
reg [29:0] addOut;

//reg [29:0] temporaryReg;

//genvar i;
//generate
//    for (i = 0 ; i < 32; i=i+1)
//    begin
//       //addOut[29:0] = addOut[29:0] + {6'b0,concatOut[i*24+:24]};
//    end
//       //temporaryReg[i]<=
//endgenerate

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
      addOut<=30'b0;
   else
   begin
      addOut<=concatOut[383:360]+concatOut[359:336]+concatOut[335:312]+concatOut[311:288]+concatOut[287:264]+concatOut[263:240]+concatOut[239:216]+concatOut[215:192]+concatOut[191:168]+concatOut[167:144]+concatOut[143:120]+concatOut[119:96]+concatOut[95:72]+concatOut[71:48]+concatOut[47:24] + concatOut[23:0]+nonconcatOut[383:360]+nonconcatOut[359:336]+nonconcatOut[335:312]+nonconcatOut[311:288]+nonconcatOut[287:264]+nonconcatOut[263:240]+nonconcatOut[239:216]+nonconcatOut[215:192]+nonconcatOut[191:168]+nonconcatOut[167:144]+nonconcatOut[143:120]+nonconcatOut[119:96]+nonconcatOut[95:72]+nonconcatOut[71:48]+nonconcatOut[47:24]+nonconcatOut[23:0];
   end
end



endmodule
