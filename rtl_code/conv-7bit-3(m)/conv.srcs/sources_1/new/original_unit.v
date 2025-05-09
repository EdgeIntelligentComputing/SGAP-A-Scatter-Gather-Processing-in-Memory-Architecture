`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/03 16:52:37
// Design Name: 
// Module Name: original_unit
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


module original_unit(clk,reset,shiftOut2,shiftOut3,additionOut);
input clk,reset;
input [383:0] shiftOut2;     //24*16
input [143:0] shiftOut3;     //24*6

output [27:0] additionOut;
reg [27:0] additionOut;

reg [4:0] i;
reg [24:0] partialSum21 [7:0];
reg [25:0] partialSum22 [3:0];
reg [26:0] partialSum23 [1:0];

reg [24:0] partialSum31 [2:0];

always@(*)
begin
    for (i = 0 ; i < 16; i=i+2)
       partialSum21[i/2]<=shiftOut2[i*4+:4]+shiftOut2[(i+1)*4+:4];
    for (i = 0 ; i < 8; i=i+2)
       partialSum22[i/2]<= partialSum21[i]+partialSum21[i+1];
    for (i = 0 ; i < 4; i=i+2)
       partialSum23[i/2]<= partialSum22[i]+partialSum22[i+1];
    
    for (i = 0 ; i < 6; i=i+2)
       partialSum31[i/2]<= shiftOut3[i*6+:6]+shiftOut3[(i+1)*6+:6];
    
    additionOut<=partialSum23[0]+partialSum23[1]+partialSum31[0]+partialSum31[1]+partialSum31[2];
end




endmodule
