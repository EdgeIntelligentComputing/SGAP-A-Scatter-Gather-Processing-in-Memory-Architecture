`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 15:51:30
// Design Name: 
// Module Name: division_unit
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
//��ͬn,m��6��ѡ�񣩵�ѡ��

module division_unit(clk,reset,n,m,beforeDivision,divisionBit,divisionWeight,divisionOut);
input clk,reset;
input [3:0] n,m;
input [11:0] beforeDivision;

output [5:0] divisionBit;
output [23:0] divisionWeight;
output [17:0] divisionOut;
reg [5:0] divisionBit;
reg [23:0] divisionWeight;
reg [17:0] divisionOut;

reg [35:0] divisionLUT [0:7];
//reg [3:0] divisionWarray [0:5];
//reg [2:0] divisionArray [0:5];

reg [2:0] i=3'b000;
reg [3:0] j=4'b0000;
reg [2:0] k=6'b0;

//��ά������Ϊһά����
//`define PACK_ARRAY1(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST) \
//                generate \
//                genvar pk_idx; \
//                for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) \
//                begin \
//                        assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; \
//                end \
//                endgenerate

//`define PACK_ARRAY2(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST) \
//                generate \
//                genvar pk_id; \
//                for (pk_id=0; pk_id<(PK_LEN); pk_id=pk_id+1) \
//                begin \
//                        assign PK_DEST[((PK_WIDTH)*pk_id+((PK_WIDTH)-1)):((PK_WIDTH)*pk_id)] = PK_SRC[pk_id][((PK_WIDTH)-1):0]; \
//                end \
//                endgenerate
                

always@(negedge reset)
begin
    divisionLUT[0]<=36'b111111_0000_01;   //5-bit    1��ʾ3λ������
    divisionLUT[1]<=36'b111111_000_000;   //6-bit
    divisionLUT[2]<=36'b1111111_000_010;   //7-bit
    divisionLUT[3]<=36'b111111_00_0000;   //8-bit
    divisionLUT[4]<=36'b111111_00_0001;   //9-bit
    divisionLUT[5]<=36'b111111_0_00000;   //10-bit
    divisionLUT[6]<=36'b111111_0_00001;   //11-bit
    divisionLUT[7]<=36'b111111_000000;    //12-bit
end

//always@(*)
//begin
//   if(m>=3 && m<8)
//   begin
//      k<=(m-3)*6;
//   end
//   else
//   begin
//      k<=0;
//   end
//end

always@(posedge clk or negedge reset)
begin
    if(reset==1'b0)
    begin
         divisionBit<=6'b0;
         divisionOut<=18'b0;
         divisionWeight<=24'b0;
         if(m>=3 && m<8)
         begin
           k<=(m-3)*6;
         end
         else
         begin
           k<=0;
         end
    end
    else
      begin
         if(j!=n)
         begin
         if(divisionLUT[n-5][k])
           begin 
              divisionBit[i]<=1'b1;
              divisionWeight[i*4+:4]<=j;
              divisionOut[i*3+:3]<={beforeDivision[j+2],beforeDivision[j+1],beforeDivision[j]};
              j<=j+3;
              i<=i+1;
              k<=k+1;
           end
         else
           begin
              divisionBit[i]<=1'b0;
              divisionWeight[i*4+:4]<=j;
              divisionOut[i*3+:3]<={1'b0,beforeDivision[j+1],beforeDivision[j]};
              j<=j+2;
              i<=i+1;
              k<=k+1;
           end
         end
         else
         begin
             i<=3'b000;
             k<=0;
             j<=4'b0000;
         end
      end
end


//`PACK_ARRAY1(4,6,divisionWarray,divisionWeight)
//`PACK_ARRAY2(3,6,divisionArray,divisionOut)


endmodule
