module avgpooling(clk,operands,avgOut);
input clk;
input [71:0] operands;       //9*7-bit

output [7:0] avgOut;
reg [7:0] avgOut;

always@(*)
begin
//    if(reset==1'b0)
//      avgOut<=8'b0;
//   else
      avgOut<=((({4'b0,operands[7:0]}+operands[15:8])+(operands[23:16]+operands[31:24]))+((operands[39:32]+operands[47:40])+(operands[55:48]+operands[63:56]))+operands[71:64])/9;
end

endmodule