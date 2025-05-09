`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/15 15:31:13
// Design Name: 
// Module Name: main_bench
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


module main_bench();
reg clk,reset;
reg [3:0] n,m;
reg [11:0] activation,weight;
reg [25:0] request;

wire [35:0] filterBit;      
wire [179:0] filterWeight;         
wire [215:0] filterOut;  
wire [35:0] drop;  

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

main main1(clk,reset,n,m,activation,weight,request,filterBit,filterWeight,filterOut,drop,op,rank_id,bg_id,addr,rank1_id,bg1_id,addr1,rank2_id,bg2_id,addr2,bgs,act_func);

initial clk=1;
always #1 clk<=~clk;

initial
begin 
     reset<=1'b0;    weight<=12'b1011_0110_1101;     activation<=12'b0100_1001_1111;    n<=4'b1000;   m<=4'b01001;    request<=26'b00000_001_1001_0000000_00001000; 
     #2  reset<=1'b1;
end

endmodule
