`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/03 16:40:54
// Design Name: 
// Module Name: original_add_bench
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


module original_add_bench();
reg clk,reset;
reg [89:0] filterWeight2;     //5-bit
reg [29:0] filterWeight3;      //5-bit
reg [63:0] computeOut2;        //6-bit*16
reg [35:0] computeOut3;        //6-bit*6

wire [27:0] addOut;



original_add original_add1(clk,reset,filterWeight2,filterWeight3,computeOut2,computeOut3,addOut);

initial clk=1'b1;
always #1 clk = ~clk;

initial
begin
    reset<=1'b0;   computeOut2<=144'b0000_0001_0010;      computeOut3<=72'b0000_0000_0011;      
                   filterWeight2<=180'b0000_010_0001;    filterWeight3<=60'b0000_0000_0010; 
    #2  reset<=1'b1;
end






endmodule
