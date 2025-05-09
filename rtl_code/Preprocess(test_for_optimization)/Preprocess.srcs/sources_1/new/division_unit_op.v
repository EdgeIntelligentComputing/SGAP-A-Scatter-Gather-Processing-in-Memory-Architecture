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


module division_unit_op(clk,reset,n,m,beforeDivision,divisionBit,divisionWeight,divisionOut);
input clk,reset;
input [3:0] n,m;
input [11:0] beforeDivision;

output [5:0] divisionBit;
output [23:0] divisionWeight;
output [17:0] divisionOut;
reg [5:0] divisionBit;
reg [23:0] divisionWeight;
reg [17:0] divisionOut;

reg [5:0] divisionLUT [0:7];
//reg [3:0] divisionWarray [0:5];
//reg [2:0] divisionArray [0:5];

reg [2:0] i=3'b000;
reg [3:0] j=4'b0000;

always@(negedge reset)
begin
    divisionLUT[0]<=6'b0000_01;   //5-bit    1表示3位操作数
    divisionLUT[1]<=6'b000_000;   //6-bit
    divisionLUT[2]<=6'b000_010;   //7-bit
    divisionLUT[3]<=6'b00_0000;   //8-bit
    divisionLUT[4]<=6'b00_0001;   //9-bit
    divisionLUT[5]<=6'b0_00000;   //10-bit
    divisionLUT[6]<=6'b0_00001;   //11-bit
    divisionLUT[7]<=6'b000000;    //12-bit
end

always@(posedge clk or negedge reset)
begin
    if(reset==1'b0)
      begin
         divisionBit<=6'b0;
         divisionOut<=18'b0;
         divisionWeight<=24'b0;
      end
    else
      begin
         if(j!=n)
         begin
         if(divisionLUT[n-5][i])
           begin 
              divisionBit[i]<=1'b1;
              divisionWeight[i*4+:4]<=j;
              divisionOut[i*3+:3]<={beforeDivision[j+2],beforeDivision[j+1],beforeDivision[j]};
              j<=j+3;
              i<=i+1;
           end
         else
           begin
              divisionBit[i]<=1'b0;
              divisionWeight[i*4+:4]<=j;
              divisionOut[i*3+:3]<={1'b0,beforeDivision[j+1],beforeDivision[j]};
              j<=j+2;
              i<=i+1;
           end
         end
         else
         begin
             i<=3'b000;
             j<=4'b0000;
         end
      end
end
endmodule