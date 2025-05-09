`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 16:46:56
// Design Name: 
// Module Name: main_bench
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


module main_bench();
reg clk,reset;
//reg [35:0] filterBit;         //1-bit
reg [179:0] filterWeight2;     //5-bit
reg [59:0] filterWeight3;     //5-bit
reg [215:0] filterOut2;        //6-bit
reg [71:0] filterOut3;        //6-bit

wire [29:0] sum;

main main1(
    .clk(clk),
    .reset(reset),
    .filterWeight2(filterWeight2),
    .filterWeight3(filterWeight3),
    .filterOut2(filterOut2),
    .filterOut3(filterOut3),
    .sum(sum)
);

initial clk=1'b1;
always #1 clk = ~clk;

initial
begin
    reset<=1'b0;            filterOut2<=216'b011001_011010;          filterOut3<=72'b000100_010011;     
                            filterWeight2<=180'b00011_00010;       filterWeight3<=60'b00010_00001;  
    #2  reset<=1'b1;
end




endmodule
