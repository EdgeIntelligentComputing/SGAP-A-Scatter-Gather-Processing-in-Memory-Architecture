`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/20 10:37:19
// Design Name: 
// Module Name: mul
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


module mul(clk,reset,filterOut2,computeOut2);
input clk,reset;
input [63:0] filterOut2;        //4-bit

output [63:0] computeOut2;        //4-bit

genvar i;
generate
    //2*2
    for (i = 0; i < 16; i=i+1)
       mul_2bit mul_2bit1(clk,reset,filterOut2[i*4+:2],filterOut2[(i*4+2)+:2],computeOut2[i*4+:4]);
    
endgenerate


//POWER2 1.077
//POWER3 2.194
endmodule







//mul_2bit mul_2bit1(clk,reset,filterOut[2:0],filterOut[5:3],computeOut[5:0]);
//mul_2bit mul_2bit2(clk,reset,filterOut[8:6],filterOut[11:9],computeOut[11:6]);
//mul_2bit mul_2bit3(clk,reset,filterOut[14:12],filterOut[17:15],computeOut[17:12]);
//mul_2bit mul_2bit4(clk,reset,filterOut[20:18],filterOut[23:21],computeOut[23:18]);
//mul_2bit mul_2bit5(clk,reset,filterOut[26:24],filterOut[29:27],computeOut[29:24]);
//mul_2bit mul_2bit6(clk,reset,filterOut[32:30],filterOut[35:33],computeOut[35:30]);

//mul_2bit mul_2bit7(clk,reset,filterOut[38:36],filterOut[41:39],computeOut[41:36]);
//mul_2bit mul_2bit8(clk,reset,filterOut[44:42],filterOut[47:45],computeOut[47:42]);
//mul_2bit mul_2bit9(clk,reset,filterOut[50:48],filterOut[53:51],computeOut[53:48]);
//mul_2bit mul_2bit10(clk,reset,filterOut[56:54],filterOut[59:57],computeOut[59:54]);
//mul_2bit mul_2bit11(clk,reset,filterOut[62:60],filterOut[65:63],computeOut[65:60]);
//mul_2bit mul_2bit12(clk,reset,filterOut[68:66],filterOut[71:69],computeOut[71:66]);

//mul_2bit mul_2bit13(clk,reset,filterOut[74:72],filterOut[77:75],computeOut[77:72]);
//mul_2bit mul_2bit14(clk,reset,filterOut[80:78],filterOut[83:81],computeOut[83:78]);
//mul_2bit mul_2bit15(clk,reset,filterOut[86:84],filterOut[89:87],computeOut[89:84]);
//mul_2bit mul_2bit16(clk,reset,filterOut[92:90],filterOut[95:93],computeOut[95:90]);
//mul_2bit mul_2bit17(clk,reset,filterOut[98:96],filterOut[101:99],computeOut[101:96]);
//mul_2bit mul_2bit18(clk,reset,filterOut[104:102],filterOut[107:105],computeOut[107:102]);

//mul_2bit mul_2bit18(clk,reset,filterOut[104:102],filterOut[107:105],computeOut[107:102]);
//mul_2bit mul_2bit18(clk,reset,filterOut[104:102],filterOut[107:105],computeOut[107:102]);
//mul_2bit mul_2bit18(clk,reset,filterOut[104:102],filterOut[107:105],computeOut[107:102]);
//mul_2bit mul_2bit18(clk,reset,filterOut[104:102],filterOut[107:105],computeOut[107:102]);
//mul_2bit mul_2bit18(clk,reset,filterOut[104:102],filterOut[107:105],computeOut[107:102]);
//mul_2bit mul_2bit18(clk,reset,filterOut[104:102],filterOut[107:105],computeOut[107:102]);
