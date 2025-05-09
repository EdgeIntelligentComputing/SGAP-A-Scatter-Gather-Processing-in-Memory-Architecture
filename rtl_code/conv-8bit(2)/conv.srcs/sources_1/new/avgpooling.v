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
input [71:0] operands;       //9*7-bit

output [7:0] avgOut;
reg [7:0] avgOut;

always@(*)
begin
    if(reset==1'b0)
      avgOut<=8'b0;
   else
      avgOut<=((({4'b0,operands[7:0]}+operands[15:8])+(operands[23:16]+operands[31:24]))+((operands[39:32]+operands[47:40])+(operands[55:48]+operands[63:56]))+operands[71:64])/9;
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