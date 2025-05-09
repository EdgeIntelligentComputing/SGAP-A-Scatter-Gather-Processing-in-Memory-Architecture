`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/03 16:29:22
// Design Name: 
// Module Name: original_add
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


module original_add(clk,reset,filterWeight2,filterWeight3,computeOut2,computeOut3,addOut);
input clk,reset;
input [89:0] filterWeight2;     //5-bit
input [29:0] filterWeight3;      //5-bit
input [63:0] computeOut2;        //6-bit*16
input [35:0] computeOut3;        //6-bit*6

output [27:0] addOut;
wire [27:0] addOut;

wire [383:0] shiftOut2;     //24*16
wire [143:0] shiftOut3;     //24*6

genvar i;
generate
    for (i = 0 ; i < 16; i=i+1)
       shifter4bit shifter4bit1(clk,reset,computeOut2[i*4+:4],filterWeight2[i*5+:5],shiftOut2[i*24+:24]);
    
    for (i = 0; i < 6; i=i+1)
       shifter6bit shifter6bit1(clk,reset,computeOut3[i*6+:6],filterWeight3[i*5+:5],shiftOut3[i*24+:24]);
       
    original_unit original_unit1(clk,reset,shiftOut2,shiftOut3,addOut);
endgenerate




endmodule
