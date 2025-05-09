`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/20 11:19:46
// Design Name: 
// Module Name: mul3bit_bench
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


module mul3bit_bench();
reg clk,reset;
reg [2:0] A,B;
//reg [3:0] A_w,B_w;

wire [5:0] result;
//wire [4:0] result_w;

mul_3bit mul_3bit1(
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
//    .A_w(A_w),
//    .B_w(B_w),
    .result(result)
//    .result_w(result_w)
);

initial clk = 1;
always #1 clk <= ~clk;

initial
begin
    reset<=1'b0;     A<=3'b101;  B<=3'b110;   //A_w<=4'b1001;   B_w<=4'b0101;
    #2 reset<=1'b1;

end









endmodule
