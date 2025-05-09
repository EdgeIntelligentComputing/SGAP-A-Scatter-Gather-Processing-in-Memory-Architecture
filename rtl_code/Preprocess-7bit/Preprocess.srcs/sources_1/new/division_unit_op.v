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
input [6:0] beforeDivision;

output [8:0] divisionWeight;
output [8:0] divisionOut;
reg [8:0] divisionWeight;
reg [8:0] divisionOut;

//reg [2:0] divisionLUT;

reg [1:0] i=2'b00;
reg [2:0] j=3'b000;

//always@(negedge reset)
//begin
//    divisionLUT<=3'b010;   //7-bit
//end

always@(posedge clk or negedge reset)
begin
    if(reset==1'b0)
      begin
         divisionOut<=9'b0;
         divisionWeight<=9'b0;
      end
    else
      begin
         if(j!=7)
         begin
         if(i==1)
           begin 
              divisionWeight[i*3+:3]<=j;
              divisionOut[i*3+:3]<={beforeDivision[j+2],beforeDivision[j+1],beforeDivision[j]};
              j<=j+3;
              i<=i+1;
           end
         else
           begin
              divisionWeight[i*3+:3]<=j;
              divisionOut[i*3+:3]<={1'b0,beforeDivision[j+1],beforeDivision[j]};
              j<=j+2;
              i<=i+1;
           end
         end
         else
         begin
             i<=2'b00;
             j<=3'b000;
         end
      end
end
endmodule