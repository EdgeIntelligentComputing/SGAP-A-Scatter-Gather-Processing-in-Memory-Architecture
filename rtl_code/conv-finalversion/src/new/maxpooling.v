`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/27 14:57:08
// Design Name: 
// Module Name: maxpooling
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


module maxpooling(clk,reset,operands,maxOut);
input clk,reset;
input [107:0] operands;       //9*12-bit

output [11:0] maxOut;
reg [11:0] maxOut;

//reg [11:0] maxreg;
reg [3:0] i;

always@(*)
begin 
   if(reset==1'b0)
      maxOut<=12'b0;
   else
   begin
    for (i=0; i<9; i=i+1)
    begin
        if(operands[i*12+:12] > maxOut) 
           maxOut<=operands[i*12+:12]; 
    end
   end
end 

//always@(*)
//begin
//    maxOut<=maxreg;
//end



endmodule
