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
input [80:0] operands;       //9*9-bit

output [8:0] avgOut;
reg [8:0] avgOut;

always@(*)
begin
    if(reset==1'b0)
      avgOut<=9'b0;
   else
      avgOut<=((({4'b0,operands[8:0]}+operands[17:9])+(operands[26:18]+operands[35:27]))+((operands[44:36]+operands[53:45])+(operands[62:54]+operands[71:63]))+operands[80:72])/9;
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