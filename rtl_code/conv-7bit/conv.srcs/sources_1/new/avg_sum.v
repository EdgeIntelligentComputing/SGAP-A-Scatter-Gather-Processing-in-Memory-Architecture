`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/28 14:25:36
// Design Name: 
// Module Name: avg_sum
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


module avg_sum(clk,reset,operands,avgOut);
input clk,reset;
input [62:0] operands;       //9*7-bit

output [6:0] avgOut;
reg [6:0] avgOut;

always@(*)
begin
    if(reset==1'b0)
      avgOut<=7'b0;
   else
      avgOut<=((({4'b0,operands[6:0]}+operands[13:7])+(operands[22:14]+operands[29:23]))+((operands[36:30]+operands[43:37])+(operands[50:44]+operands[57:51]))+operands[64:58])/9;
end


endmodule

//input clk,reset;
//input [62:0] operands;       //9*7-bit

//output [6:0] sumreg;
//reg [6:0] sumreg;

//always@(*)
//begin
//    if(reset==1'b0)
//      sumreg<=7'b0;
//   else
//      sumreg<=((({4'b0,operands[6:0]}+operands[13:7])+(operands[22:14]+operands[29:23]))+((operands[36:30]+operands[43:37])+(operands[50:44]+operands[57:51]))+operands[64:58])/9;
//end
