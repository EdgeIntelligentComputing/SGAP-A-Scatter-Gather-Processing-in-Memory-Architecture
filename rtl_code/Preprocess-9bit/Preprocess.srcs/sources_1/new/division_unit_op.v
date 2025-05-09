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


module division_unit_op(clk,reset,beforeDivision,divisionWeight,divisionOut);
input clk,reset;
input [8:0] beforeDivision;

output [11:0] divisionWeight;
output [11:0] divisionOut;
reg [11:0] divisionWeight;
reg [11:0] divisionOut;

reg [2:0] i=3'b00;
reg [3:0] j=4'b0000;

always@(posedge clk or negedge reset)
begin
    if(reset==1'b0)
      begin
         divisionOut<=0;
         divisionWeight<=0;
         i<=0;
         j<=0;
      end
    else
      begin
         if(j!=9)
         begin
         if(i==0)
           begin 
              divisionWeight[i*3+:3]<=j;
              divisionOut[i*3+:3]<={beforeDivision[j+2],beforeDivision[j+1],beforeDivision[j]};
              //j<=3;
              j<=j+3;
              i<=i+1;
           end
         else
           begin
              divisionWeight[i*3+:3]<=j;
              divisionOut[i*3+:3]<={1'b0,beforeDivision[j+1],beforeDivision[j]};
              //j<=2;
              j<=j+2;
              i<=i+1;
           end
         end
         else
         begin
             i<=3'b00;
             j<=4'b1001;
         end
      end
end
endmodule