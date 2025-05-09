`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 15:29:19
// Design Name: 
// Module Name: main
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


module main(clk,reset,n,m,activation,weight,filterBit,filterWeight,filterOut,drop);
input clk,reset;
input [3:0] n,m;
input [11:0] activation,weight;

output [35:0] filterBit;      
output [179:0] filterWeight;         
output [215:0] filterOut;
output [35:0] drop; 
wire [35:0] filterBit;      
wire [179:0] filterWeight;         
wire [215:0] filterOut;
wire [35:0] drop; 

//Filter
//output [35:0] filterBit;             //1-bit
//output [179:0] filterWeight;    //5-bit
//output [215:0] filterOut;       //6-bit
//reg [35:0] filterBit;      
//reg [179:0] filterWeight;         
//reg [215:0] filterOut;               

//Division
wire [5:0] divisionBitA,divisionBitW;
wire [23:0] divisionWeightA,divisionWeightW;
wire [17:0] divisionOutA,divisionOutW;

//Filter


//Division
division_unit division_unit_a(clk,reset,n,m,activation,divisionBitA,divisionWeightA,divisionOutA);
division_unit division_unit_w(clk,reset,n,m,weight,divisionBitW,divisionWeightW,divisionOutW);

//Filter
filter_matrix filter_matrix1(clk,reset,n,m,divisionBitA,divisionBitW,divisionWeightA,divisionWeightW,divisionOutA,divisionOutW,filterBit,filterWeight,filterOut,drop);

//always@(*)
//begin
//    if(reset==1'b0)
//    begin
//        filterBit<=1'b0;
//        filterWeight<=5'b0;
//        filterOut<=6'b0;
//    end
//    else
//    begin
//        i=0;
//        for(j=0;j<36;j=j+1)
//        begin
//            if(drop[j]==1'b0)
//            begin
//               filterBit[i]<=filterBitSum[j];
//               filterWeight[i*5+:5]<=filterWeightSum[j*5+:5];
//               filterOut[i*6+:6]<=filterOutSum[j*6+:6];
//               i=i+1;
//            end
//        end
//    end
//end

endmodule



//module main(clk,reset,n,m,activation,weight,filterBit,filterWeight,filterOut);
//input clk,reset;
//input [3:0] n,m;
//input [11:0] activation,weight;

////Filter
//output filterBit;             //1-bit
//output [4:0] filterWeight;    //5-bit
//output [5:0] filterOut;       //6-bit
//reg filterBit;      
//reg [4:0] filterWeight;         
//reg [5:0] filterOut;               

////Division
//wire [5:0] divisionBitA,divisionBitW;
//wire [23:0] divisionWeightA,divisionWeightW;
//wire [17:0] divisionOutA,divisionOutW;

////Filter
//wire [35:0] filterBitSum;      
//wire [179:0] filterWeightSum;         
//wire [215:0] filterOutSum;    
//wire [35:0] drop; 
//reg [6:0] i=0;

////Division
//division_unit division_unit_a(clk,reset,n,m,activation,divisionBitA,divisionWeightA,divisionOutA);
//division_unit division_unit_w(clk,reset,n,m,weight,divisionBitW,divisionWeightW,divisionOutW);

////Filter
//filter_matrix filter_matrix1(clk,reset,n,m,divisionBitA,divisionBitW,divisionWeightA,divisionWeightW,divisionOutA,divisionOutW,filterBitSum,filterWeightSum,filterOutSum,drop);



//always@(posedge clk or negedge reset)
//begin
//    if(reset==1'b0)
//    begin
//        filterBit<=1'b0;
//        filterWeight<=5'b0;
//        filterOut<=6'b0;
//    end
//    else
//    begin
//        if(i>=36)
//            i=0;
//        else
//        begin
//            filterBit<=filterBitSum[i];
//            filterWeight<=filterWeightSum[i*5+:5];
//            filterOut<=filterOutSum[i*6+:6];
//            i<=i+1;
//        end
//    end
//end


////always@(posedge clk)
////begin
////   featureMap<=12'b0;
////end

//endmodule