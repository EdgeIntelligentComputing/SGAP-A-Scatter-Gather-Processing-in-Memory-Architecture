`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/07 16:24:32
// Design Name: 
// Module Name: dram_controller_bench
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


module dram_controller_bench();
reg clk,reset;
reg [25:0] request;

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

dram_controller dram_controller1(clk,reset,request,op,rank_id,bg_id,addr,rank1_id,bg1_id,addr1,rank2_id,bg2_id,addr2,bgs,act_func);

initial clk=1;
always #1 clk<=~clk;

initial
begin 
     reset<=1'b0;  request<=26'b00000_001_1001_0000000_00001000; 
     #2   reset<=1'b1; 
     //#2   //request<=26'b0000_001_1001_0000000_00001000; 
end







endmodule
