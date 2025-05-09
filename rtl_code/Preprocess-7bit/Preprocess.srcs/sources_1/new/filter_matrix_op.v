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
input [2:0] divisionBitA,divisionBitW;
input [8:0] divisionWeightA,divisionWeightW;
input [8:0] divisionOutA,divisionOutW;

output [8:0] filterBit;         //1-bit
output [35:0] filterWeight;    //4-bit
output [53:0] filterOut;      //6-bit
output [8:0] drop;            //1-bit
wire [8:0] filterBit;         
wire [35:0] filterWeight;    
wire [53:0] filterOut;      
wire [8:0] drop;        


//i=0
filter_unit filter_unit1(clk,divisionOutA[2:0],divisionOutW[2:0],divisionWeightA[2:0],divisionWeightW[2:0],divisionBitA[0],divisionBitW[0],filterOut[5:0],filterWeight[3:0],filterBit[0],drop[0]);
filter_unit filter_unit2(clk,divisionOutA[2:0],divisionOutW[5:3],divisionWeightA[2:0],divisionWeightW[5:3],divisionBitA[0],divisionBitW[1],filterOut[11:6],filterWeight[7:4],filterBit[1],drop[1]);
filter_unit filter_unit3(clk,divisionOutA[2:0],divisionOutW[8:6],divisionWeightA[2:0],divisionWeightW[8:6],divisionBitA[0],divisionBitW[2],filterOut[17:12],filterWeight[11:8],filterBit[2],drop[2]);

                            
//i=1              
filter_unit_reduct filter_unit_reduct1(clk,divisionOutA[5:3],divisionOutW[2:0],filterBit[1],filterWeight[7:4],drop[1],filterOut[23:18],filterWeight[15:12],filterBit[3],drop[3]);
filter_unit filter_unit4(clk,divisionOutA[5:3],divisionOutW[5:3],divisionWeightA[5:3],divisionWeightW[5:3],divisionBitA[1],divisionBitW[1],filterOut[29:24],filterWeight[19:16],filterBit[4],drop[4]);
filter_unit filter_unit5(clk,divisionOutA[5:3],divisionOutW[8:6],divisionWeightA[5:3],divisionWeightW[8:6],divisionBitA[1],divisionBitW[2],filterOut[35:30],filterWeight[23:20],filterBit[5],drop[5]);

//i=2                                   (clk,a,b,bit,weight,drop,c,weight_out,c_b,drop_out);
filter_unit_reduct filter_unit_reduct2(clk,divisionOutA[8:6],divisionOutW[2:0],filterBit[2],filterWeight[11:8],drop[2],filterOut[41:36],filterWeight[27:24],filterBit[6],drop[6]);
filter_unit_reduct filter_unit_reduct3(clk,divisionOutA[8:6],divisionOutW[5:3],filterBit[5],filterWeight[23:20],drop[5],filterOut[47:42],filterWeight[31:28],filterBit[7],drop[7]);
filter_unit filter_unit6(clk,divisionOutA[8:6],divisionOutW[8:6],divisionWeightA[8:6],divisionWeightW[8:6],divisionBitA[2],divisionBitW[2],filterOut[53:48],filterWeight[35:32],filterBit[8],drop[8]);


//操作数为0,直接过滤一行或一列

endmodule
