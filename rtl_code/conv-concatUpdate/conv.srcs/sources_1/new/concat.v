`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/20 21:10:54
// Design Name: 
// Module Name: concat
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


module concat(clk,reset,computeOut2,computeOut3,filterWeight2,filterWeight3,concatOut,nonconcatOut);
input clk,reset;
input [63:0] computeOut2;        //4-bit  *36
input [35:0] computeOut3;        //6-bit   *12
input [89:0] filterWeight2;     //5-bit
input [29:0] filterWeight3;     //5-bit

output [167:0] concatOut;
output [191:0] nonconcatOut;
reg [167:0] concatOut;
reg [191:0] nonconcatOut;    

wire [383:0] shiftOut2;     //24*16
wire [143:0] shiftOut3;     //24*6

//wire [239:0] regOut;     //24*10


//shift     36 = 10 10 10  6       
genvar i;
generate
    for (i = 0 ; i < 16; i=i+1)
       shifter4bit shifter4bit1(clk,reset,computeOut2[i*4+:4],filterWeight2[i*5+:5],shiftOut2[i*24+:24]);
    
    for (i = 0; i < 6; i=i+1)
       shifter6bit shifter6bit1(clk,reset,computeOut3[i*6+:6],filterWeight3[i*5+:5],shiftOut3[i*24+:24]);
endgenerate

//OR     36   5个可拼接，4个不可拼接
always@(*)
begin
  if(reset==1'b0)
  begin
    concatOut<=168'b0;
    nonconcatOut<=192'b0;
  end
  else
  begin
    nonconcatOut[23:0]<=shiftOut2[23:0];
    nonconcatOut[47:24]<=shiftOut2[47:24];
    concatOut[23:0]<=shiftOut2[71:48] | shiftOut3[23:0];
    concatOut[47:24]<=shiftOut2[95:72] | shiftOut3[47:24];
    concatOut[71:48]<=shiftOut2[143:120] | shiftOut2[119:96];
    concatOut[95:72]<=shiftOut2[167:144] | shiftOut3[71:48];
    concatOut[119:96]<=shiftOut2[191:168] | shiftOut3[95:72];
    nonconcatOut[71:48]<=shiftOut2[215:192];
    nonconcatOut[95:72]<=shiftOut2[239:216];
    
    nonconcatOut[119:96]<=shiftOut2[263:240];
    nonconcatOut[143:120]<=shiftOut2[287:264];
    concatOut[143:120]<=shiftOut2[311:288] | shiftOut3[119:96];
    concatOut[167:144]<=shiftOut2[335:312] | shiftOut3[143:120];
    nonconcatOut[167:144]<=shiftOut2[359:336];
    nonconcatOut[191:168]<=shiftOut2[383:360];
  end
end



endmodule

//       if( i%10==3'b011 ||  i%10==3'b101 ||  i%10==3'b111 )
//       begin
//           regOut2[23:0] <= shiftOut2[i+:24] | shiftOut2[(i-24)+:24];
//       end

//    regOut[23:0]<=shiftOut2[23:0];
//    regOut[47:24]<=shiftOut2[47:24];
//    regOut[71:48]<=shiftOut2[71:48] | shiftOut3[23:0];
//    regOut[95:72]<=shiftOut2[95:72] | shiftOut3[47:24];
//    regOut[119:96]<=shiftOut2[143:120] | shiftOut2[119:96];
//    regOut[143:120]<=shiftOut2[167:144] | shiftOut3[71:48];
//    regOut[167:144]<=shiftOut2[191:168] | shiftOut3[95:72];
//    regOut[191:168]<=shiftOut2[215:192];
//    regOut[215:192]<=shiftOut2[239:216];
    
//    regOut[239:216]<=shiftOut2[263:240];
//    regOut[263:240]<=shiftOut2[287:264];
//    regOut[287:264]<=shiftOut2[311:288] | shiftOut3[119:96];
//    regOut[311:288]<=shiftOut2[335:312] | shiftOut3[143:120];
//    regOut[335:312]<=shiftOut2[383:360] | shiftOut2[359:336];
//    regOut[359:336]<=shiftOut2[407:384] | shiftOut3[167:144];
//    regOut[383:360]<=shiftOut2[431:408] | shiftOut3[191:168];
//    regOut[407:384]<=shiftOut2[455:432];
//    regOut[431:408]<=shiftOut2[479:456];
    
//    regOut[455:432]<=shiftOut2[503:480];
//    regOut[479:456]<=shiftOut2[527:504];
//    regOut[503:480]<=shiftOut2[551:528] | shiftOut3[215:192];
//    regOut[527:504]<=shiftOut2[575:552] | shiftOut3[239:216];
//    regOut[551:528]<=shiftOut2[623:600] | shiftOut2[599:576];
//    regOut[575:552]<=shiftOut2[647:624] | shiftOut3[263:240];
//    regOut[599:576]<=shiftOut2[671:648] | shiftOut3[287:264];
//    regOut[623:600]<=shiftOut2[695:672];
//    regOut[647:624]<=shiftOut2[719:696];
    
//    regOut[671:648]<=shiftOut2[743:720];
//    regOut[695:672]<=shiftOut2[767:744];
//    regOut[719:696]<=shiftOut2[815:792] | shiftOut3[791:768];
//    regOut[743:720]<=shiftOut2[839:816];
//    regOut[767:744]<=shiftOut2[863:840];
