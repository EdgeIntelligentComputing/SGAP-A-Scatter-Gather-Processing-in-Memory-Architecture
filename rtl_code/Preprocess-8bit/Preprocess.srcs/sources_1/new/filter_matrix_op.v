`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/03 16:24:41
// Design Name: 
// Module Name: filter_matrix_op
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


module filter_matrix_op(clk,reset,divisionBitA,divisionBitW,divisionWeightA,divisionWeightW,divisionOutA,divisionOutW,filterBit,filterWeight,filterOut,drop);
input clk,reset;
input [3:0] divisionBitA,divisionBitW;
input [11:0] divisionWeightA,divisionWeightW;
input [7:0] divisionOutA,divisionOutW;

output [15:0] filterBit;       //1-bit
output [63:0] filterWeight;    //4-bit
output [63:0] filterOut;       //4-bit
output [15:0] drop;            //1-bit
wire [15:0] filterBit;         
wire [63:0] filterWeight;    
wire [63:0] filterOut;      
wire [15:0] drop;        


//i=0
filter_unit filter_unit1(clk,divisionOutA[1:0],divisionOutW[1:0],divisionWeightA[2:0],divisionWeightW[2:0],divisionBitA[0],divisionBitW[0],filterOut[3:0],filterWeight[3:0],filterBit[0],drop[0]);
filter_unit filter_unit2(clk,divisionOutA[1:0],divisionOutW[3:2],divisionWeightA[2:0],divisionWeightW[5:3],divisionBitA[0],divisionBitW[1],filterOut[7:4],filterWeight[7:4],filterBit[1],drop[1]);
filter_unit filter_unit3(clk,divisionOutA[1:0],divisionOutW[5:4],divisionWeightA[2:0],divisionWeightW[8:6],divisionBitA[0],divisionBitW[2],filterOut[11:8],filterWeight[11:8],filterBit[2],drop[2]);
filter_unit filter_unit4(clk,divisionOutA[1:0],divisionOutW[7:6],divisionWeightA[2:0],divisionWeightW[11:9],divisionBitA[0],divisionBitW[3],filterOut[15:12],filterWeight[15:12],filterBit[3],drop[3]);
                            
//i=1              
filter_unit_reduct filter_unit_reduct1(clk,divisionOutA[3:2],divisionOutW[1:0],filterBit[1],filterWeight[7:4],drop[1],filterOut[19:16],filterWeight[19:16],filterBit[4],drop[4]);
filter_unit filter_unit5(clk,divisionOutA[3:2],divisionOutW[3:2],divisionWeightA[5:3],divisionWeightW[5:3],divisionBitA[1],divisionBitW[1],filterOut[23:20],filterWeight[23:20],filterBit[5],drop[5]);
filter_unit filter_unit6(clk,divisionOutA[3:2],divisionOutW[5:4],divisionWeightA[5:3],divisionWeightW[8:6],divisionBitA[1],divisionBitW[2],filterOut[27:24],filterWeight[27:24],filterBit[6],drop[6]);
filter_unit filter_unit7(clk,divisionOutA[3:2],divisionOutW[7:6],divisionWeightA[5:3],divisionWeightW[11:9],divisionBitA[1],divisionBitW[3],filterOut[31:28],filterWeight[31:28],filterBit[7],drop[7]);

//i=2                                   (clk,a,b,bit,weight,drop,c,weight_out,c_b,drop_out);
filter_unit_reduct filter_unit_reduct2(clk,divisionOutA[5:4],divisionOutW[1:0],filterBit[2],filterWeight[11:8],drop[2],filterOut[35:32],filterWeight[35:32],filterBit[8],drop[8]);
filter_unit_reduct filter_unit_reduct3(clk,divisionOutA[5:4],divisionOutW[3:2],filterBit[6],filterWeight[27:24],drop[6],filterOut[39:36],filterWeight[39:36],filterBit[9],drop[9]);
filter_unit filter_unit8(clk,divisionOutA[5:4],divisionOutW[5:4],divisionWeightA[8:6],divisionWeightW[8:6],divisionBitA[2],divisionBitW[2],filterOut[43:40],filterWeight[43:40],filterBit[10],drop[10]);
filter_unit filter_unit9(clk,divisionOutA[5:4],divisionOutW[7:6],divisionWeightA[8:6],divisionWeightW[11:9],divisionBitA[2],divisionBitW[3],filterOut[47:44],filterWeight[47:44],filterBit[11],drop[11]);

//i=3
filter_unit_reduct filter_unit_reduct4(clk,divisionOutA[7:6],divisionOutW[1:0],filterBit[3],filterWeight[15:12],drop[3],filterOut[51:48],filterWeight[51:48],filterBit[12],drop[12]);
filter_unit_reduct filter_unit_reduct5(clk,divisionOutA[7:6],divisionOutW[3:2],filterBit[7],filterWeight[31:28],drop[7],filterOut[55:52],filterWeight[55:52],filterBit[13],drop[13]);
filter_unit_reduct filter_unit_reduct6(clk,divisionOutA[7:6],divisionOutW[5:4],filterBit[11],filterWeight[47:44],drop[11],filterOut[59:56],filterWeight[59:56],filterBit[14],drop[14]);
filter_unit filter_unit10(clk,divisionOutA[7:6],divisionOutW[7:6],divisionWeightA[11:9],divisionWeightW[11:9],divisionBitA[3],divisionBitW[3],filterOut[63:60],filterWeight[63:60],filterBit[15],drop[15]);


//操作数为0,直接过滤一行或一列

endmodule
