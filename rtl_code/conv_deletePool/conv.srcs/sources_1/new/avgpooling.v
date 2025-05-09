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
input [107:0] operands;       //9*12-bit

output [11:0] avgOut;
reg [11:0] avgOut;

wire [15:0] sumreg;
reg [3:0] i;

avg_sum(clk,reset,operands,sumreg);

always@(*)
begin 
   if(reset==1'b0)
      avgOut<=12'b0;
   else
      avgOut<=sumreg/9;
//   begin
//    for (i=0; i<9; i=i+1)
//        sumreg=sumreg+operands[i*12+:12];
//   end
end 

//always@(*)
//begin
//    avgOut<=sumreg/9;
//end


endmodule
