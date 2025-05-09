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


module avg_sum(clk,reset,operands,sumreg);
input clk,reset;
input [107:0] operands;       //9*12-bit

output [15:0] sumreg;
reg [15:0] sumreg;

always@(*)
begin
    if(reset==1'b0)
      sumreg<=16'b0;
   else
      sumreg<=(({4'b0,operands[11:0]}+operands[23:12])+(operands[35:24]+operands[47:36]))+((operands[59:48]+operands[71:60])+(operands[83:72]+operands[95:84]))+operands[107:96];
end








endmodule
