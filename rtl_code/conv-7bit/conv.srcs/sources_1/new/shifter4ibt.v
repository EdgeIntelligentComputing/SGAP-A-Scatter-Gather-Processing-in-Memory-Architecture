`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/06/21 15:37:31
// Design Name: 
// Module Name: shifter4ibt
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


module shifter4bit(clk,reset,a,shift_bits,shiftOut);
input clk,reset;
input [3:0] a;
input [3:0] shift_bits;

output [13:0] shiftOut;
reg [13:0] shiftOut;

always@(posedge clk or negedge reset)
//always@(*)
begin
    if(reset==1'b0)
    begin
        shiftOut<=14'b0;
    end
    else
    begin
        case(shift_bits)
            4'b0000:  shiftOut<={10'b0,a};
            4'b0001:  shiftOut<={9'b0,a,1'b0};
            4'b0010:  shiftOut<={8'b0,a,2'b0};
            4'b0011:  shiftOut<={7'b0,a,3'b0};
            4'b0100:  shiftOut<={6'b0,a,4'b0};
            4'b0101:  shiftOut<={5'b0,a,5'b0};
            4'b0110:  shiftOut<={4'b0,a,6'b0};
            4'b0111:  shiftOut<={3'b0,a,7'b0};
            4'b1000:  shiftOut<={2'b0,a,8'b0};
            4'b1001:  shiftOut<={1'b0,a,9'b0};
            4'b1010:  shiftOut<={a,10'b0};
            default:   shiftOut<=14'b0;
        endcase
    end
end

endmodule


//begin
//        case(shift_bits)
//            5'b00000:  shiftOut<={20'b0,a};
//            5'b00001:  shiftOut<={19'b0,a,1'b0};
//            5'b00010:  shiftOut<={18'b0,a,2'b0};
//            5'b00011:  shiftOut<={17'b0,a,3'b0};
//            5'b00100:  shiftOut<={16'b0,a,4'b0};
//            5'b00101:  shiftOut<={15'b0,a,5'b0};
//            5'b00110:  shiftOut<={14'b0,a,6'b0};
//            5'b00111:  shiftOut<={13'b0,a,7'b0};
//            5'b01000:  shiftOut<={12'b0,a,8'b0};
//            5'b01001:  shiftOut<={11'b0,a,9'b0};
//            5'b01010:  shiftOut<={10'b0,a,10'b0};
//            5'b01011:  shiftOut<={9'b0,a,11'b0};
//            5'b01100:  shiftOut<={8'b0,a,12'b0};
//            5'b01101:  shiftOut<={7'b0,a,13'b0};
//            5'b01110:  shiftOut<={6'b0,a,14'b0};
//            5'b01111:  shiftOut<={5'b0,a,15'b0};
//            5'b10000:  shiftOut<={4'b0,a,16'b0};
//            5'b10001:  shiftOut<={3'b0,a,17'b0};
//            5'b10010:  shiftOut<={2'b0,a,18'b0};
//            5'b10011:  shiftOut<={1'b0,a,19'b0};
//            5'b10100:  shiftOut<={a,20'b0};
//            default:   shiftOut<=24'b0;
//        endcase
//    end