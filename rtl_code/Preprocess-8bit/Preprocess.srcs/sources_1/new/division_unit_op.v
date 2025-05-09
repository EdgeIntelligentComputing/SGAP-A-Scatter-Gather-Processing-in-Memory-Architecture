`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/13 15:45:54
// Design Name: 
// Module Name: division_unit_op
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


module division_unit_op(clk,reset,divisionWeight);
input clk,reset;

output [11:0] divisionWeight;
reg [11:0] divisionWeight;

reg [1:0] i=2'b0;
reg [3:0] j=4'b0;

always@(posedge clk or negedge reset)
begin
    if(reset==1'b0)
      begin
         divisionWeight<=0;
      end
    else
      begin
         if(j!=8)
         begin
              divisionWeight[i*3+:3]<=j;
              j<=j+2;
              i<=i+1;
         end
         else
         begin
             i<=2'b00;
             j<=4'b000;
         end
      end
end
endmodule