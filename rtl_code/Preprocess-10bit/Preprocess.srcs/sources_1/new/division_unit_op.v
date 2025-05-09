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

output [19:0] divisionWeight;
reg [19:0] divisionWeight;

reg [2:0] i=3'b0;
reg [3:0] j=4'b0;

//always@(negedge reset)
//begin
//    divisionLUT<=4'b0000;   //8-bit
////    divisionLUT<=4'b0001;   //9-bit
////    divisionLUT[5]<=6'b0_00000;   //10-bit
////    divisionLUT[6]<=6'b0_00001;   //11-bit
////    divisionLUT[7]<=6'b000000;    //12-bit
//end

always@(posedge clk or negedge reset)
begin
    if(reset==1'b0)
      begin
         divisionWeight<=0;
      end
    else
      begin
         if(j!=10)
         begin
              divisionWeight[i*4+:4]<=j;
              j<=j+2;
              i<=i+1;
         end
         else
         begin
             i<=3'b0;
             j<=4'b0;
         end
      end
end
endmodule