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


module main(clk,reset,activation,weight,request,filterBit,filterWeight,filterOut,drop,op,rank_id,bg_id,addr,rank1_id,bg1_id,addr1,rank2_id,bg2_id,addr2,bgs,act_func);
input clk,reset;
input [9:0] activation,weight;
input [25:0] request;

output [24:0] filterBit;      
output [124:0] filterWeight;         
output [99:0] filterOut;
output [24:0] drop; 

output [2:0] op;
output [2:0] rank_id;
output [3:0] bg_id;
output [14:0] addr;

output [2:0] rank1_id;
output [3:0] bg1_id;
output [3:0] addr1;
output [2:0] rank2_id;
output [3:0] bg2_id;
output [3:0] addr2;

output bgs;
output [1:0] act_func;

wire [24:0] filterBit;      
wire [124:0] filterWeight;         
wire [99:0] filterOut;
wire [24:0] drop; 

wire [2:0] op;
wire [2:0] rank_id;
wire [3:0] bg_id;
wire [14:0] addr;

wire [2:0] rank1_id;
wire [3:0] bg1_id;
wire [3:0] addr1;
wire [2:0] rank2_id;
wire [3:0] bg2_id;
wire [3:0] addr2;

wire bgs;
wire [1:0] act_func;

//Division
wire [19:0] divisionWeightA,divisionWeightW;

//Filter


//Division
//division_unit division_unit_a(clk,reset,n,m,activation,divisionBitA,divisionWeightA,divisionOutA);
//division_unit division_unit_w(clk,reset,n,m,weight,divisionBitW,divisionWeightW,divisionOutW);
division_unit_op division_unit_op_a(clk,reset,divisionWeightA);
division_unit_op division_unit_op_w(clk,reset,divisionWeightW);

//Filter
//filter_matrix filter_matrix1(clk,reset,n,m,divisionBitA,divisionBitW,divisionWeightA,divisionWeightW,divisionOutA,divisionOutW,filterBit,filterWeight,filterOut,drop);
filter_matrix_op filter_matrix_op1(clk,reset,5'b00000,5'b00000,divisionWeightA,divisionWeightW,activation,weight,filterBit,filterWeight,filterOut,drop);

dram_controller dram_controller1(clk,reset,request,op,rank_id,bg_id,addr,rank1_id,bg1_id,addr1,rank2_id,bg2_id,addr2,bgs,act_func);

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