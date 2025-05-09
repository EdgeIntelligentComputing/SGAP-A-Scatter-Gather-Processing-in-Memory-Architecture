`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 20:11:18
// Design Name: 
// Module Name: filter_matrix
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


module filter_matrix(clk,reset,n,m,divisionBitA,divisionBitW,divisionWeightA,divisionWeightW,divisionOutA,divisionOutW,filterBit,filterWeight,filterOut,drop);
input clk,reset;
input [3:0] n,m;
input [5:0] divisionBitA,divisionBitW;
input [23:0] divisionWeightA,divisionWeightW;
input [17:0] divisionOutA,divisionOutW;

output [35:0] filterBit;         //1-bit
output [179:0] filterWeight;    //5-bit
output [215:0] filterOut;      //6-bit
output [35:0] drop;            //1-bit
wire [35:0] filterBit;
wire [179:0] filterWeight;
wire [215:0] filterOut;
wire [35:0] drop;

reg [2:0] i=3'b0;
reg [2:0] j=3'b0;



always@(negedge reset)
begin
    i<=3'b0;
    j<=3'b0;
end

//i=0
filter_unit filter_unit1(clk,m,divisionOutA[2:0],divisionOutW[2:0],divisionWeightA[3:0],divisionWeightW[3:0],divisionBitA[0],divisionBitW[0],filterOut[5:0],filterWeight[4:0],filterBit[0],drop[0]);
filter_unit filter_unit2(clk,m,divisionOutA[2:0],divisionOutW[5:3],divisionWeightA[3:0],divisionWeightW[7:4],divisionBitA[0],divisionBitW[1],filterOut[11:6],filterWeight[9:5],filterBit[1],drop[1]);
filter_unit filter_unit3(clk,m,divisionOutA[2:0],divisionOutW[8:6],divisionWeightA[3:0],divisionWeightW[11:8],divisionBitA[0],divisionBitW[2],filterOut[17:12],filterWeight[14:10],filterBit[2],drop[2]);
filter_unit filter_unit4(clk,m,divisionOutA[2:0],divisionOutW[11:9],divisionWeightA[3:0],divisionWeightW[15:12],divisionBitA[0],divisionBitW[3],filterOut[23:18],filterWeight[19:15],filterBit[3],drop[3]);
filter_unit filter_unit5(clk,m,divisionOutA[2:0],divisionOutW[14:12],divisionWeightA[3:0],divisionWeightW[19:16],divisionBitA[0],divisionBitW[4],filterOut[29:24],filterWeight[24:20],filterBit[4],drop[4]);
filter_unit filter_unit6(clk,m,divisionOutA[2:0],divisionOutW[17:15],divisionWeightA[3:0],divisionWeightW[23:20],divisionBitA[0],divisionBitW[5],filterOut[35:30],filterWeight[29:25],filterBit[5],drop[5]);

//i=1
filter_unit filter_unit7(clk,m,divisionOutA[5:3],divisionOutW[2:0],divisionWeightA[7:4],divisionWeightW[3:0],divisionBitA[1],divisionBitW[0],filterOut[41:36],filterWeight[34:30],filterBit[6],drop[6]);
filter_unit filter_unit8(clk,m,divisionOutA[5:3],divisionOutW[5:3],divisionWeightA[7:4],divisionWeightW[7:4],divisionBitA[1],divisionBitW[1],filterOut[47:42],filterWeight[39:35],filterBit[7],drop[7]);
filter_unit filter_unit9(clk,m,divisionOutA[5:3],divisionOutW[8:6],divisionWeightA[7:4],divisionWeightW[11:8],divisionBitA[1],divisionBitW[2],filterOut[53:48],filterWeight[44:40],filterBit[8],drop[8]);
filter_unit filter_unit10(clk,m,divisionOutA[5:3],divisionOutW[11:9],divisionWeightA[7:4],divisionWeightW[15:12],divisionBitA[1],divisionBitW[3],filterOut[59:54],filterWeight[49:45],filterBit[9],drop[9]);
filter_unit filter_unit11(clk,m,divisionOutA[5:3],divisionOutW[14:12],divisionWeightA[7:4],divisionWeightW[19:16],divisionBitA[1],divisionBitW[4],filterOut[65:60],filterWeight[54:50],filterBit[10],drop[10]);
filter_unit filter_unit12(clk,m,divisionOutA[5:3],divisionOutW[17:15],divisionWeightA[7:4],divisionWeightW[23:20],divisionBitA[1],divisionBitW[5],filterOut[71:66],filterWeight[59:55],filterBit[11],drop[11]);

//i=2
filter_unit filter_unit13(clk,m,divisionOutA[8:6],divisionOutW[2:0],divisionWeightA[11:8],divisionWeightW[3:0],divisionBitA[2],divisionBitW[0],filterOut[77:72],filterWeight[64:60],filterBit[12],drop[12]);
filter_unit filter_unit14(clk,m,divisionOutA[8:6],divisionOutW[5:3],divisionWeightA[11:8],divisionWeightW[7:4],divisionBitA[2],divisionBitW[1],filterOut[83:78],filterWeight[69:65],filterBit[13],drop[13]);
filter_unit filter_unit15(clk,m,divisionOutA[8:6],divisionOutW[8:6],divisionWeightA[11:8],divisionWeightW[11:8],divisionBitA[2],divisionBitW[2],filterOut[89:84],filterWeight[74:70],filterBit[14],drop[14]);
filter_unit filter_unit16(clk,m,divisionOutA[8:6],divisionOutW[11:9],divisionWeightA[11:8],divisionWeightW[15:12],divisionBitA[2],divisionBitW[3],filterOut[95:90],filterWeight[79:75],filterBit[15],drop[15]);
filter_unit filter_unit17(clk,m,divisionOutA[8:6],divisionOutW[14:12],divisionWeightA[11:8],divisionWeightW[19:16],divisionBitA[2],divisionBitW[4],filterOut[101:96],filterWeight[84:80],filterBit[16],drop[16]);
filter_unit filter_unit18(clk,m,divisionOutA[8:6],divisionOutW[17:15],divisionWeightA[11:8],divisionWeightW[23:20],divisionBitA[2],divisionBitW[5],filterOut[107:102],filterWeight[89:85],filterBit[17],drop[17]);

//i=3
filter_unit filter_unit19(clk,m,divisionOutA[11:9],divisionOutW[2:0],divisionWeightA[15:12],divisionWeightW[3:0],divisionBitA[3],divisionBitW[0],filterOut[113:108],filterWeight[94:90],filterBit[18],drop[18]);
filter_unit filter_unit20(clk,m,divisionOutA[11:9],divisionOutW[5:3],divisionWeightA[15:12],divisionWeightW[7:4],divisionBitA[3],divisionBitW[1],filterOut[119:114],filterWeight[99:95],filterBit[19],drop[19]);
filter_unit filter_unit21(clk,m,divisionOutA[11:9],divisionOutW[8:6],divisionWeightA[15:12],divisionWeightW[11:8],divisionBitA[3],divisionBitW[2],filterOut[125:120],filterWeight[104:100],filterBit[20],drop[20]);
filter_unit filter_unit22(clk,m,divisionOutA[11:9],divisionOutW[11:9],divisionWeightA[15:12],divisionWeightW[15:12],divisionBitA[3],divisionBitW[3],filterOut[131:126],filterWeight[109:105],filterBit[21],drop[21]);
filter_unit filter_unit23(clk,m,divisionOutA[11:9],divisionOutW[14:12],divisionWeightA[15:12],divisionWeightW[19:16],divisionBitA[3],divisionBitW[4],filterOut[137:132],filterWeight[114:110],filterBit[22],drop[22]);
filter_unit filter_unit24(clk,m,divisionOutA[11:9],divisionOutW[17:15],divisionWeightA[15:12],divisionWeightW[23:20],divisionBitA[3],divisionBitW[5],filterOut[143:138],filterWeight[119:115],filterBit[23],drop[23]);

//i=4
filter_unit filter_unit25(clk,m,divisionOutA[14:12],divisionOutW[2:0],divisionWeightA[19:16],divisionWeightW[3:0],divisionBitA[4],divisionBitW[0],filterOut[149:144],filterWeight[124:120],filterBit[24],drop[24]);
filter_unit filter_unit26(clk,m,divisionOutA[14:12],divisionOutW[5:3],divisionWeightA[19:16],divisionWeightW[7:4],divisionBitA[4],divisionBitW[1],filterOut[155:150],filterWeight[129:125],filterBit[25],drop[25]);
filter_unit filter_unit27(clk,m,divisionOutA[14:12],divisionOutW[8:6],divisionWeightA[19:16],divisionWeightW[11:8],divisionBitA[4],divisionBitW[2],filterOut[161:156],filterWeight[134:130],filterBit[26],drop[26]);
filter_unit filter_unit28(clk,m,divisionOutA[14:12],divisionOutW[11:9],divisionWeightA[19:16],divisionWeightW[15:12],divisionBitA[4],divisionBitW[3],filterOut[167:162],filterWeight[139:135],filterBit[27],drop[27]);
filter_unit filter_unit29(clk,m,divisionOutA[14:12],divisionOutW[14:12],divisionWeightA[19:16],divisionWeightW[19:16],divisionBitA[4],divisionBitW[4],filterOut[173:168],filterWeight[144:140],filterBit[28],drop[28]);
filter_unit filter_unit30(clk,m,divisionOutA[14:12],divisionOutW[17:15],divisionWeightA[19:16],divisionWeightW[23:20],divisionBitA[4],divisionBitW[5],filterOut[179:174],filterWeight[149:145],filterBit[29],drop[29]);

//i=5
filter_unit filter_unit31(clk,m,divisionOutA[17:15],divisionOutW[2:0],divisionWeightA[23:20],divisionWeightW[3:0],divisionBitA[5],divisionBitW[0],filterOut[185:180],filterWeight[154:150],filterBit[30],drop[30]);
filter_unit filter_unit32(clk,m,divisionOutA[17:15],divisionOutW[5:3],divisionWeightA[23:20],divisionWeightW[7:4],divisionBitA[5],divisionBitW[1],filterOut[191:186],filterWeight[159:155],filterBit[31],drop[31]);
filter_unit filter_unit33(clk,m,divisionOutA[17:15],divisionOutW[8:6],divisionWeightA[23:20],divisionWeightW[11:8],divisionBitA[5],divisionBitW[2],filterOut[197:192],filterWeight[164:160],filterBit[32],drop[32]);
filter_unit filter_unit34(clk,m,divisionOutA[17:15],divisionOutW[11:9],divisionWeightA[23:20],divisionWeightW[15:12],divisionBitA[5],divisionBitW[3],filterOut[203:198],filterWeight[169:165],filterBit[33],drop[33]);
filter_unit filter_unit35(clk,m,divisionOutA[17:15],divisionOutW[14:12],divisionWeightA[23:20],divisionWeightW[19:16],divisionBitA[5],divisionBitW[4],filterOut[209:204],filterWeight[174:170],filterBit[34],drop[34]);
filter_unit filter_unit36(clk,m,divisionOutA[17:15],divisionOutW[17:15],divisionWeightA[23:20],divisionWeightW[23:20],divisionBitA[5],divisionBitW[5],filterOut[215:210],filterWeight[179:175],filterBit[35],drop[35]);

//操作数为0,直接过滤一行或一列

endmodule

//    begin
//           filter_unit(divisionOutA[2:0],divisionOutW[2:0],divisionWeightA[3:0],divisionWeightW[3:0],divisionBitA[0],divisionBitW[0],filterOut[5:0],filterWeight[4:0],filterBit[0],drop[0]);
//           filter_unit1(divisionOutA[2:0],divisionOutW[5:3],divisionWeightA[3:0],divisionWeightW[7:4],divisionBitA[0],divisionBitW[1],filterOut[11:6],filterWeight[9:5],filterBit[1],drop[1]);
//           for(j=2;j<=3'b011;j=j+1)
//           begin
//              filter_unit(divisionOutA[i*3+:3],divisionOutW[j*3+:3],divisionWeightA[i*4+:4],divisionWeightW[j*4+:4],divisionBitA[i],divisionBitW[j],filterOut[(i*36+j*6)+:6],filterWeight[(i*30+j*5)+:5],filterBit[i*6+j],drop[i*6+j]);
//           end
//           //filterOut[(i*36+j*6)+:6]   divisionWeightW[(j*4)+:4]!=4'b0000
//      end


//     begin 
////        i<=3'b000;
////        j<=3'b000;
//        filter_unit(divisionOutA[2:0],divisionOutW[2:0],divisionWeightA[3:0],divisionWeightW[3:0],divisionBitA[0],divisionBitW[0],filterOut[5:0],filterWeight[4:0],filterBit[0],drop[0]);
//        //divisionWeightW[j+6:j+3]
//        for(j=3'b001;divisionWeightW[j*4+:4]!=4'b0000;j=j+3'b001)
//        begin
//            //filterOut[i*6+j+4:i*6+j]   filterWeight[i*6+j+4:i*6+j]
//            filter_unit(divisionOutA[i+:2],divisionOutW[j+:2],divisionWeightA[i+:3],divisionWeightW[j+:3],divisionBitA[i],divisionBitW[j],filterOut[(i*36+j)+:5],filterWeight[(i*30+j)+:4],filterBit[i*6+j],drop[i*6+j]);
//        end
//        //divisionWeightA[i+6:i+3]
//        for(i=3'b001;divisionWeightA[i*4+:4]!=4'b0000;i=i+3'b001)   
//        begin
//             j<=3'b000;
//             filter_unit(divisionOutA[i+:2],divisionOutW[j+:2],divisionWeightA[i+:3],divisionWeightW[j+:3],divisionBitA[i],divisionBitW[j],filterOut[(i*36+j)+:5],filterWeight[(i*30+j)+:4],filterBit[i*6+j],drop[i*6+j]);
//             //divisionWeightW[j+6:j+3]
//             for(j=3'b001;divisionWeightW[j*4+:4]!=4'b0000;j=j+3'b001)
//             begin
//                 //filterOut[i*6+j+4:i*6+j]   filterWeight[i*6+j+4:i*6+j]
//                 filter_unit(divisionOutA[i+:2],divisionOutW[j+:2],divisionWeightA[i+:3],divisionWeightW[j+:3],divisionBitA[i],divisionBitW[j],filterOut[(i*36+j)+:5],filterWeight[(i*30+j)+:4],filterBit[i*6+j],drop[i*6+j]);
//             end
//        end
        
     //end
