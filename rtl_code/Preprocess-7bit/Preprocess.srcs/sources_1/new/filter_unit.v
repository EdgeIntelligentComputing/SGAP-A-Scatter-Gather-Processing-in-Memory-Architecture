`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/19 15:39:10
// Design Name: 
// Module Name: filter_unit
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


module filter_unit(clk,a,b,a_w,b_w,a_b,b_b,c,c_w,c_b,drop);
input clk;
input [2:0] a,b;
input [2:0] a_w,b_w;
input a_b,b_b;

output [5:0] c;
output [3:0] c_w;
output c_b; 
output drop;

reg [5:0] c;
reg [3:0] c_w;
reg c_b; 
reg drop;

always@(posedge clk)
begin
   c_b=a_b | b_b;
end

always@(posedge clk)
begin
   c_w<=a_w+b_w;
end

always@(posedge clk)
begin
   if((c_b==1'b1 && c_w+6>9) || (c_b==1'b0 && c_w+4>9))
     begin
         drop<=1'b0;
     end
   else
     begin
         drop<=1'b1;
     end
end

always@(posedge clk)
begin
   if((c_b==1'b1 && c_w+6>9) || (c_b==1'b0 && c_w+4>9))
     begin
         c<={b,a};
     end
   else
     begin
         c<=6'b0;
     end
end

endmodule

//always@(*)
//begin
//   if(c_b)
//     begin
//        c_w<=a_w+b_w;
//        if(c_w+6>m)
//          begin
//             drop<=1'b0;
//             c<={b,a};
//          end
//        else
//          begin
//             drop<=1'b1;
//             c<=6'b0;
//          end
//     end
//   else
//     begin
//        c_w<=a_w+b_w;
//        if(c_w+4>m)
//          begin
//             drop<=1'b0;
//             c<={b,a};
//          end
//        else
//          begin
//             drop<=1'b1;
//             c<=6'b0;
//          end
//     end
//end


//task filter_unit;
//input [2:0] a,b;
//input [3:0] a_w,b_w;
//input a_b,b_b;

//output [5:0] c;
//output [4:0] c_w;
//output c_b; 
//output drop;

//begin
//   c_b=a_b | b_b;
//   if(c_b)
//     begin
//        c_w<=a_w+b_w;
//        if(c_w+6>m)
//          begin
//             drop<=1'b0;
//             c<={b,a};
//          end
//        else
//          begin
//             drop<=1'b1;
//             c<=6'b0;
//          end
//     end
//   else
//     begin
//        c_w<=a_w+b_w;
//        if(c_w+4>m)
//          begin
//             drop<=1'b0;
//             c<={b,a};
//             //c<=6'b101110;
//          end
//        else
//          begin
//             drop<=1'b1;
//             c<=6'b0;
//          end
//     end
   
//end

//endtask
