`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/18 15:34:14
// Design Name: 
// Module Name: mul
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


module mul(clk,filterOut2,computeOut2);
input clk;
input [63:0] filterOut2;        //4-bit

output [63:0] computeOut2;        //4-bit
reg [63:0] computeOut2;        //4-bit

//genvar i;
//generate
//    //2*2
//    for (i = 0; i < 16; i=i+1)
//       mul_2bit mul_2bit1(clk,reset,filterOut2[i*4+:2],filterOut2[(i*4+2)+:2],computeOut2[i*4+:4]);

//always@(*)
//begin
//   computeOut2<=0;
//end


//POWER2 1.077
//POWER3 2.194
endmodule
