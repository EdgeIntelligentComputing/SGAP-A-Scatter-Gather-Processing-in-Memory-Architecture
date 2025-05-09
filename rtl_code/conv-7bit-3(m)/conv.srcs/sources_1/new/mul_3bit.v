`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/20 10:11:32
// Design Name: 
// Module Name: mul_3bit
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


module mul_3bit(clk,reset,A,B,result);
input clk,reset;
input [2:0] A,B;
//input [3:0] A_w,B_w;

output [5:0] result;
//output [4:0] result_w;
reg [5:0] result;
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
  if(reset==0)
    result <= 6'b0;
  else
   begin
        case(A)
          3'b000: result <= 6'b0;
          3'b001: result <= B;
          3'b010: result <= {B,1'b0};
          3'b011: result <= {B,1'b0}+B;
          3'b100: result <= {B,2'b0};
          3'b101: result <= {B,2'b0}+B;
          3'b110: result <= {B,2'b0}+{B,1'b0}; 
          default:  result <= {B,3'b0} + (~B + 1);
        endcase
   end
end

endmodule
