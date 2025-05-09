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


module division_unit(clk,reset,n,m,beforeDivision,divisionBit,divisionWeight,divisionOut);
input clk,reset;
input [3:0] n,m;
input [11:0] beforeDivision;

output [5:0] divisionBit;
output [23:0] divisionWeight;
output [17:0] divisionOut;
reg [5:0] divisionBit;
wire [23:0] divisionWeight;
wire [17:0] divisionOut;

reg [5:0] divisionLUT [0:12];
reg [3:0] divisionWarray [0:5];
reg [2:0] divisionArray [0:5];

reg [2:0] i=3'b000;
reg [3:0] j=4'b0000;
reg [2:0] k=3'b000;

//二维数组打包为一维数组
`define PACK_ARRAY1(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST) \
                generate \
                genvar pk_idx; \
                for (pk_idx=0; pk_idx<(PK_LEN); pk_idx=pk_idx+1) \
                begin \
                        assign PK_DEST[((PK_WIDTH)*pk_idx+((PK_WIDTH)-1)):((PK_WIDTH)*pk_idx)] = PK_SRC[pk_idx][((PK_WIDTH)-1):0]; \
                end \
                endgenerate

`define PACK_ARRAY2(PK_WIDTH,PK_LEN,PK_SRC,PK_DEST) \
                generate \
                genvar pk_id; \
                for (pk_id=0; pk_id<(PK_LEN); pk_id=pk_id+1) \
                begin \
                        assign PK_DEST[((PK_WIDTH)*pk_id+((PK_WIDTH)-1)):((PK_WIDTH)*pk_id)] = PK_SRC[pk_id][((PK_WIDTH)-1):0]; \
                end \
                endgenerate
                

always@(negedge reset)
begin
    divisionLUT[0]<=6'b0000_01;   //5-bit    1表示3位操作数
    divisionLUT[1]<=6'b000_000;   //6-bit
    divisionLUT[2]<=6'b000_010;   //7-bit
    divisionLUT[3]<=6'b00_0000;   //8-bit
    divisionLUT[4]<=6'b00_0001;   //9-bit
    divisionLUT[5]<=6'b0_00000;   //10-bit
    divisionLUT[6]<=6'b0_00001;   //11-bit
    divisionLUT[7]<=6'b000000;    //12-bit
end

always@(posedge clk or negedge reset)
begin
    if(reset==1'b0)
      begin
         divisionBit<=6'b0;
         for(k=3'b0;k<3'b111;k=k+1'b1)
           begin
              divisionArray[k]=3'b0;
              divisionWarray[k]<=4'b0;
           end
      end
    else
      begin
         if(j!=n)
         begin
         if(divisionLUT[n-5][i])
           begin 
              divisionBit[i]<=1'b1;
              divisionWarray[i]<=j;
              divisionArray[i]<={beforeDivision[j+2],beforeDivision[j+1],beforeDivision[j]};
              j<=j+3;
              i<=i+1;
           end
         else
           begin
              divisionBit[i]<=1'b0;
              divisionWarray[i]<=j;
              divisionArray[i]<={1'b0,beforeDivision[j+1],beforeDivision[j]};
              j<=j+2;
              i<=i+1;
           end
         end
         else
         begin
             i<=3'b000;
             j<=4'b0000;
         end
      end
end


`PACK_ARRAY1(4,6,divisionWarray,divisionWeight)
`PACK_ARRAY2(3,6,divisionArray,divisionOut)


endmodule
