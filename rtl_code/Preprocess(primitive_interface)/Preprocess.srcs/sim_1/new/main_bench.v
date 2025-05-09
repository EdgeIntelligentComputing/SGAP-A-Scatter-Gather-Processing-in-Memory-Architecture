`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 15:31:13
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
reg [3:0] n,m;
reg [11:0] activation,weight;

wire [11:0] featureMap;

main main1(
    .clk(clk),
    .reset(reset),
    .n(n),
    .m(m),
    .activation(activation),
    .weight(weight),
    .featureMap(featureMap)
);

initial clk=1;
always #1 clk<=~clk;

initial
begin 
     reset<=1'b0;    weight<=12'b1011_0110_1101;     activation<=12'b0100_1001_1111;    n<=4'b1000;   m<=4'b0000;
     #2  reset<=1'b1;
end

endmodule
