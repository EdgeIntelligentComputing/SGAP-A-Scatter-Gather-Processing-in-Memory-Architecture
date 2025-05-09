`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/13 11:34:29
// Design Name: 
// Module Name: filter_unit_reduct
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

module filter_unit_reduct(clk,a,b,bit,weight,drop,c,weight_out,c_b,drop_out);
input clk;
input [1:0] a,b;
input bit;
input [3:0] weight;
input drop;

output [3:0] c;
output c_b; 
output [3:0] weight_out;
output drop_out;

reg [3:0] c;
reg c_b; 
reg [3:0] weight_out;
reg drop_out;

always@(posedge clk)
begin
   c_b=bit;
end

always@(posedge clk)
begin
   drop_out=drop;
end

always@(posedge clk)
begin
   weight_out=weight;
end

always@(posedge clk)
begin
   if(drop==1'b0)
     begin
         c<={b,a};
     end
   else
     begin
         c<=6'b0;
     end
end

endmodule
