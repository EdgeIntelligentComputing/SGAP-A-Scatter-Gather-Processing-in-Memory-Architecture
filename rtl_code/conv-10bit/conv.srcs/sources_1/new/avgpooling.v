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
input [89:0] operands;       //9*10-bit

output [9:0] avgOut;
reg [9:0] avgOut;

always@(*)
begin
    if(reset==1'b0)
      avgOut<=10'b0;
   else
      avgOut<=((({4'b0,operands[9:0]}+operands[19:10])+(operands[29:20]+operands[39:30]))+((operands[49:40]+operands[59:50])+(operands[69:60]+operands[79:70]))+operands[89:80])/9;
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