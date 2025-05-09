`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/26 10:26:54
// Design Name: 
// Module Name: shifter6bit
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


module shifter6bit(clk,reset,a,shift_bits,shiftOut);
input clk,reset;
input [5:0] a;
input [3:0] shift_bits;

output [17:0] shiftOut;
reg [17:0] shiftOut;

always@(posedge clk or negedge reset)
//always@(*)
begin
    if(reset==1'b0)
    begin
        shiftOut<=18'b0;
    end
    else
    begin
        case(shift_bits)
            4'b0000:  shiftOut<={12'b0,a};
            4'b0001:  shiftOut<={11'b0,a,1'b0};
            4'b0010:  shiftOut<={10'b0,a,2'b0};
            4'b0011:  shiftOut<={9'b0,a,3'b0};
            4'b0100:  shiftOut<={8'b0,a,4'b0};
            4'b0101:  shiftOut<={7'b0,a,5'b0};
            4'b0110:  shiftOut<={6'b0,a,6'b0};
            4'b0111:  shiftOut<={5'b0,a,7'b0};
            4'b1000:  shiftOut<={4'b0,a,8'b0};
            4'b1001:  shiftOut<={3'b0,a,9'b0};
            4'b1010:  shiftOut<={2'b0,a,10'b0};
            4'b1011:  shiftOut<={1'b0,a,11'b0};
            4'b1100:  shiftOut<={a,12'b0};
            default:   shiftOut<=18'b0;
        endcase
    end
end

endmodule
