`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/20 10:57:48
// Design Name: 
// Module Name: mul2bit_bench
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


module mul2bit_bench();
reg clk,reset;
reg [1:0] A,B;
reg [3:0] A_w,B_w;

wire [3:0] result;
wire [4:0] result_w;

mul_2bit mul_2bit1(
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .A_w(A_w),
    .B_w(B_w),
    .result(result),
    .result_w(result_w)
);

initial clk = 1;
always #1 clk <= ~clk;

initial
begin
    reset<=1'b0;     A<=2'b11;  B<=2'b11;   A_w<=4'b1000;   B_w<=4'b0011;
    #2 reset<=1'b1;

end



endmodule
