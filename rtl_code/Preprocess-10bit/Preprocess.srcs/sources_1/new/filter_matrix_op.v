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
input [4:0] divisionBitA,divisionBitW;
input [19:0] divisionWeightA,divisionWeightW;
input [9:0] divisionOutA,divisionOutW;

output [24:0] filterBit;         //1-bit
output [124:0] filterWeight;    //5-bit
output [99:0] filterOut;      //4-bit
output [24:0] drop;            //1-bit
wire [24:0] filterBit;         
wire [124:0] filterWeight;    
wire [99:0] filterOut;      
wire [24:0] drop;        


//i=0
filter_unit filter_unit1(clk,divisionOutA[1:0],divisionOutW[1:0],divisionWeightA[3:0],divisionWeightW[3:0],divisionBitA[0],divisionBitW[0],filterOut[3:0],filterWeight[4:0],filterBit[0],drop[0]);
filter_unit filter_unit2(clk,divisionOutA[1:0],divisionOutW[3:2],divisionWeightA[3:0],divisionWeightW[7:4],divisionBitA[0],divisionBitW[1],filterOut[7:4],filterWeight[9:5],filterBit[1],drop[1]);
filter_unit filter_unit3(clk,divisionOutA[1:0],divisionOutW[5:4],divisionWeightA[3:0],divisionWeightW[11:8],divisionBitA[0],divisionBitW[2],filterOut[11:8],filterWeight[14:10],filterBit[2],drop[2]);
filter_unit filter_unit4(clk,divisionOutA[1:0],divisionOutW[7:6],divisionWeightA[3:0],divisionWeightW[15:12],divisionBitA[0],divisionBitW[3],filterOut[15:12],filterWeight[19:15],filterBit[3],drop[3]);
filter_unit filter_unit5(clk,divisionOutA[1:0],divisionOutW[9:8],divisionWeightA[3:0],divisionWeightW[19:16],divisionBitA[0],divisionBitW[4],filterOut[19:16],filterWeight[24:20],filterBit[4],drop[4]);
                           
//i=1              
filter_unit_reduct filter_unit_reduct1(clk,divisionOutA[3:2],divisionOutW[1:0],filterBit[1],filterWeight[9:5],drop[1],filterOut[23:20],filterWeight[29:25],filterBit[5],drop[5]);
filter_unit filter_unit6(clk,divisionOutA[3:2],divisionOutW[3:2],divisionWeightA[7:4],divisionWeightW[7:4],divisionBitA[1],divisionBitW[1],filterOut[27:24],filterWeight[34:30],filterBit[6],drop[6]);
filter_unit filter_unit7(clk,divisionOutA[3:2],divisionOutW[5:4],divisionWeightA[7:4],divisionWeightW[11:8],divisionBitA[1],divisionBitW[2],filterOut[31:28],filterWeight[39:35],filterBit[7],drop[7]);
filter_unit filter_unit8(clk,divisionOutA[3:2],divisionOutW[7:6],divisionWeightA[7:4],divisionWeightW[15:12],divisionBitA[1],divisionBitW[3],filterOut[35:32],filterWeight[44:40],filterBit[8],drop[8]);
filter_unit filter_unit9(clk,divisionOutA[3:2],divisionOutW[9:8],divisionWeightA[7:4],divisionWeightW[19:16],divisionBitA[1],divisionBitW[4],filterOut[39:36],filterWeight[49:45],filterBit[9],drop[9]);

//i=2                                   (clk,a,b,bit,weight,drop,c,weight_out,c_b,drop_out);
filter_unit_reduct filter_unit_reduct2(clk,divisionOutA[5:4],divisionOutW[1:0],filterBit[2],filterWeight[14:10],drop[2],filterOut[43:40],filterWeight[54:50],filterBit[10],drop[10]);
filter_unit_reduct filter_unit_reduct3(clk,divisionOutA[5:4],divisionOutW[3:2],filterBit[6],filterWeight[34:30],drop[6],filterOut[47:44],filterWeight[59:55],filterBit[11],drop[11]);
filter_unit filter_unit10(clk,divisionOutA[5:4],divisionOutW[5:4],divisionWeightA[11:8],divisionWeightW[11:8],divisionBitA[2],divisionBitW[2],filterOut[51:48],filterWeight[64:60],filterBit[12],drop[12]);
filter_unit filter_unit11(clk,divisionOutA[5:4],divisionOutW[7:6],divisionWeightA[11:8],divisionWeightW[15:12],divisionBitA[2],divisionBitW[3],filterOut[55:52],filterWeight[69:65],filterBit[13],drop[13]);
filter_unit filter_unit12(clk,divisionOutA[5:4],divisionOutW[9:8],divisionWeightA[11:8],divisionWeightW[19:16],divisionBitA[2],divisionBitW[4],filterOut[59:56],filterWeight[74:70],filterBit[14],drop[14]);

//i=3
filter_unit_reduct filter_unit_reduct4(clk,divisionOutA[7:6],divisionOutW[1:0],filterBit[3],filterWeight[19:15],drop[3],filterOut[63:60],filterWeight[79:75],filterBit[15],drop[15]);
filter_unit_reduct filter_unit_reduct5(clk,divisionOutA[7:6],divisionOutW[3:2],filterBit[8],filterWeight[44:40],drop[8],filterOut[67:64],filterWeight[84:80],filterBit[16],drop[16]);
filter_unit_reduct filter_unit_reduct6(clk,divisionOutA[7:6],divisionOutW[5:4],filterBit[13],filterWeight[69:65],drop[13],filterOut[71:68],filterWeight[89:85],filterBit[17],drop[17]);
filter_unit filter_unit13(clk,divisionOutA[7:6],divisionOutW[7:6],divisionWeightA[15:12],divisionWeightW[15:12],divisionBitA[3],divisionBitW[3],filterOut[75:72],filterWeight[94:90],filterBit[18],drop[18]);
filter_unit filter_unit14(clk,divisionOutA[7:6],divisionOutW[9:8],divisionWeightA[15:12],divisionWeightW[19:16],divisionBitA[3],divisionBitW[4],filterOut[79:76],filterWeight[99:95],filterBit[19],drop[19]);

//i=4
filter_unit_reduct filter_unit_reduct7(clk,divisionOutA[9:8],divisionOutW[1:0],filterBit[4],filterWeight[24:20],drop[4],filterOut[83:80],filterWeight[104:100],filterBit[20],drop[20]);
filter_unit_reduct filter_unit_reduct8(clk,divisionOutA[9:8],divisionOutW[3:2],filterBit[9],filterWeight[49:45],drop[9],filterOut[87:84],filterWeight[109:105],filterBit[21],drop[21]);
filter_unit_reduct filter_unit_reduct9(clk,divisionOutA[9:8],divisionOutW[5:4],filterBit[14],filterWeight[74:70],drop[14],filterOut[91:88],filterWeight[114:110],filterBit[22],drop[22]);
filter_unit_reduct filter_unit_reduct10(clk,divisionOutA[9:8],divisionOutW[7:6],filterBit[19],filterWeight[99:95],drop[19],filterOut[95:92],filterWeight[119:115],filterBit[23],drop[23]);
filter_unit filter_unit15(clk,divisionOutA[9:8],divisionOutW[9:8],divisionWeightA[19:16],divisionWeightW[19:16],divisionBitA[3],divisionBitW[4],filterOut[99:96],filterWeight[124:120],filterBit[24],drop[24]);


//操作数为0,直接过滤一行或一列

endmodule
