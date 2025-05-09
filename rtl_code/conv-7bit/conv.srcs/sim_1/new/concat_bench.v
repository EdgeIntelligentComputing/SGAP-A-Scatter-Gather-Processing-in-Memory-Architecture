`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 09:58:32
// Design Name: 
// Module Name: concat_bench
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


module concat_bench();
reg clk,reset;
reg [143:0] computeOut2;        //4-bit  *36
reg [71:0] computeOut3;        //6-bit   *12
reg [179:0] filterWeight2;     //5-bit
reg [59:0] filterWeight3;     //5-bit

wire [383:0] concatOut;
wire [383:0] nonconcatOut;

concat concat1(
     .clk(clk),
     .reset(reset),
     .computeOut2(computeOut2),
     .computeOut3(computeOut3),
     .filterWeight2(filterWeight2),
     .filterWeight3(filterWeight3),
     .concatOut(concatOut),
     .nonconcatOut(nonconcatOut)
);

initial clk=1'b1;
always #1 clk = ~clk;

initial
begin
    reset<=1'b0;   computeOut2<=144'b0110_0111_1010;      computeOut3<=72'b0001_0001_0011;      
                   filterWeight2<=180'b0000_0110_0010;    filterWeight3<=60'b0001_0000_0010;  
    #2  reset<=1'b1;
end






endmodule
