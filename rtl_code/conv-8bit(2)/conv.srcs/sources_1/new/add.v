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
input [167:0] concatOut;         //7¸ö24-bit
input [191:0] nonconcatOut;      //8¸ö24-bit

output [27:0] addOut;
reg [27:0] addOut;

//reg [29:0] temporaryReg;

//genvar i;
//generate
//    for (i = 0 ; i < 32; i=i+1)
//    begin
//       //addOut[29:0] = addOut[29:0] + {6'b0,concatOut[i*24+:24]};
//    end
//       //temporaryReg[i]<=
//endgenerate

//reg [4:0] i;
//reg [24:0] partialSumC4 [3:0];
//reg [24:0] partialSumNC4 [3:0];
//reg [25:0] partialSumC2 [1:0];
//reg [25:0] partialSumNC2 [1:0];

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
      addOut<=28'b0;
   else
   begin
//      for (i = 0 ; i < 6; i=i+2)
//      begin
//         partialSumC4[i/2]<=concatOut[i*24+:24]+concatOut[(i+1)*24+:24];
//         partialSumNC4[i/2]<=nonconcatOut[i*24+:24]+nonconcatOut[(i+1)*24+:24];
//      end
//      partialSumC4[3]<=concatOut[167:144];
//      partialSumNC4[3]<=nonconcatOut[167:144]+nonconcatOut[191:168];
//      for (i = 0 ; i < 4; i=i+2)
//      begin
//         partialSumC2[i/2]<=partialSumC4[i]+partialSumC4[i+1];
//         partialSumNC2[i/2]<=partialSumNC4[i]+partialSumNC4[i+1];
//      end
//      addOut<=partialSumC2[0]+partialSumC2[1]+partialSumNC2[0]+partialSumNC2[1];
      addOut<=((concatOut[167:144]+concatOut[143:120])+(concatOut[119:96]+concatOut[95:72]))+((concatOut[71:48]+concatOut[47:24]) + (concatOut[23:0]+nonconcatOut[119:96]))+((nonconcatOut[95:72]+nonconcatOut[71:48])+(nonconcatOut[47:24]+nonconcatOut[23:0]));
   end
end



endmodule
