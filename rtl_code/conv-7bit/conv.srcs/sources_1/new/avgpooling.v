`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 15:37:19
// Design Name: 
// Module Name: avgpooling
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


module avgpooling(clk,reset,operands,avgOut);
input clk,reset;
input [62:0] operands;       //9*7-bit

output [6:0] avgOut;
reg [6:0] avgOut;

always@(*)
begin
    if(reset==1'b0)
      avgOut<=7'b0;
   else
      avgOut<=((({4'b0,operands[6:0]}+operands[13:7])+(operands[20:14]+operands[27:21]))+((operands[34:28]+operands[41:35])+(operands[48:42]+operands[55:49]))+operands[62:56])/9;
end

endmodule


//input clk,reset;
//input [62:0] operands;       //9*7-bit

//output [6:0] avgOut;
//reg [6:0] avgOut;

//wire [10:0] sumreg;

//avg_sum avg_sum1(clk,reset,operands,sumreg);

//always@(*)
//begin 
//   if(reset==1'b0)
//      avgOut<=7'b0;
//   else
//      avgOut<=sumreg/9;
//end 