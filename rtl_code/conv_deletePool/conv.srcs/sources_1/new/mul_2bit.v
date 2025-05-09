`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/20 10:11:14
// Design Name: 
// Module Name: mul_2bit
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

//假设每一个都是过滤后的结果
module mul_2bit(clk,reset,A,B,result);

input clk,reset;
input [1:0] A,B;
//input [3:0] A_w,B_w;

output [3:0] result;
//output [4:0] result_w;
reg [3:0] result;
//reg [4:0] result_w;

//always@(posedge clk or negedge reset)
//begin
//  if(reset==1'b0)
//      result_w<=5'b0;
//  else
//      result_w<=A_w+B_w;
//end

always@(posedge clk or negedge reset)
begin
  if(reset == 1'b0)
    result <= 4'b0;
  else
   begin
      result[3] <= A[1] & A[0] & B[1] & B[0];
      result[2] <= A[1] & (~A[0]) & B[1] | A[1] & B[1] & (~B[0]);
      result[1] <= A[1] & (~B[1]) & B[0] | A[1] & (~A[0]) & B[0] | (~A[1]) & A[0] & B[1] | A[0] & B[1] & (~B[0]);
      result[0] <= A[0] & B[0];
   end
end
endmodule

