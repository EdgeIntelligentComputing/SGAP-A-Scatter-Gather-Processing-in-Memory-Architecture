`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/07 10:40:28
// Design Name: 
// Module Name: dram_controller
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


module dram_controller(clk,reset,request,op,rank_id,bg_id,addr,rank1_id,bg1_id,addr1,rank2_id,bg2_id,addr2,bgs,act_func);
input clk,reset;
input [25:0] request;

output [2:0] op;
output [2:0] rank_id;
output [3:0] bg_id;
output [14:0] addr;

output [2:0] rank1_id;
output [3:0] bg1_id;
output [3:0] addr1;
output [2:0] rank2_id;
output [3:0] bg2_id;
output [3:0] addr2;

output bgs;
output [1:0] act_func;

reg [2:0] op;
reg [2:0] rank_id;
reg [3:0] bg_id;
reg [14:0] addr;

reg [2:0] rank1_id;
reg [3:0] bg1_id;
reg [3:0] addr1;
reg [2:0] rank2_id;
reg [3:0] bg2_id;
reg [3:0] addr2;

reg bgs;
reg [1:0] act_func;


reg [24:0] ins_req;
reg [24:0] read_queue [7:0];
reg [24:0] write_queue [7:0];
reg [2:0] i=0;
reg [2:0] j=0;

//read/write request queue
always@(posedge clk or negedge reset)
begin
  if(reset==1'b0)
  begin
     read_queue[0]<=0;
     read_queue[1]<=0;
     read_queue[2]<=0;
     read_queue[3]<=0;
     read_queue[4]<=0;
     read_queue[5]<=0;
     read_queue[6]<=0;
     read_queue[7]<=0;
     write_queue[0]<=0;
     write_queue[1]<=0;
     write_queue[2]<=0;
     write_queue[3]<=0;
     write_queue[4]<=0;
     write_queue[5]<=0;
     write_queue[6]<=0;
     write_queue[7]<=0;
  end
  else
  begin
     if(request[25])
     begin
       read_queue[i]<=request[24:0];
     end
     else
     begin
       write_queue[j]<=request[24:0];
     end
  end
end

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
   begin
       i<=0;
       j<=0;
   end
   else
   begin
     if(request[25])
     begin
       i<=i+1;
     end
     else
     begin
       j<=j+1;
     end
     
     if(i>0 || j>0) 
     begin
      if(i>=j )
      begin
         ins_req<=read_queue[i-1];
         i<=i-1;
      end
      else
      begin
         ins_req<=write_queue[j-1];
         j<=j-1;
      end
     end
   end
end

//decode

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
   begin
      op<=3'b111;
   end
   else
   begin
   case(ins_req[24:22])
      3'b000,3'b010: op<=3'b000;   //ld
      3'b001,3'b011: op<=3'b001;   //st
      3'b100: op<=3'b010;          //ld st
      3'b101: op<=3'b011;          //pre
      3'b110: op<=3'b100;          //mac
      3'b111: op<=3'b101;          //pool
      default: op<=3'b111;
   endcase
   end
end

always@(posedge clk or negedge reset)
begin
   if(reset==1'b0)
   begin
       rank_id<=3'bz;  
       bg_id<=4'bz;   
       addr<=15'bz;
       rank1_id<=3'bz;   
       bg1_id<=4'bz;  
       addr1<=4'bz;
       rank2_id<=3'bz;   
       bg2_id<=4'bz;  
       addr2<=4'bz;
       bgs<=1'bz;
       act_func<=1'bz;
   end
   else
   begin
     case(ins_req[24:22])
        3'b000,3'b001: begin rank_id<=ins_req[21:19];  bg_id<=ins_req[18:15];   addr<=ins_req[14:0];  end //ldr str
        3'b010,3'b011: begin rank_id<=ins_req[21:19];  addr<=ins_req[18:4];  end //ldpu stpu
        3'b100: begin rank1_id<=ins_req[21:19];   bg1_id<=ins_req[18:15];  addr1<=ins_req[14:11];  
                      rank2_id<=ins_req[10:8];   bg2_id<=ins_req[7:4];  addr2<=ins_req[3:0];   end      //ld st
        3'b101: rank_id<=ins_req[21:19];          //pre
        3'b110: begin rank_id<=ins_req[21:19];  bgs<=ins_req[18]; act_func<=ins_req[17];   end          //mac
        3'b111: begin rank_id<=ins_req[21:19];  bgs<=ins_req[18];                          end          //pool
     endcase
   end
end

endmodule





//module dram_controller(clk,reset,ins,request,op,rank_id,bg_id,addr,rank1_id,bg1_id,addr1,rank2_id,bg2_id,addr2,bgs,act_func);
//input clk,reset;
//input [24:0] ins;
//input [25:0] request;

//output [2:0] op;
//output [2:0] rank_id;
//output [3:0] bg_id;
//output [14:0] addr;

//output [2:0] rank1_id;
//output [3:0] bg1_id;
//output [3:0] addr1;
//output [2:0] rank2_id;
//output [3:0] bg2_id;
//output [3:0] addr2;

//output bgs;
//output [1:0] act_func;

//reg [2:0] op;
//reg [2:0] rank_id;
//reg [3:0] bg_id;
//reg [14:0] addr;

//reg [2:0] rank1_id;
//reg [3:0] bg1_id;
//reg [3:0] addr1;
//reg [2:0] rank2_id;
//reg [3:0] bg2_id;
//reg [3:0] addr2;

//reg bgs;
//reg [1:0] act_func;


//reg [24:0] ins_req;
//reg [24:0] read_queue [7:0];
//reg [24:0] write_queue [7:0];
//reg [2:0] i=0;
//reg [2:0] j=0;

////read/write request queue
//always@(posedge clk or negedge reset)
////always@(*)
//begin
//  if(reset==1'b0)
//  begin
//     read_queue[0]<=0;
//     read_queue[1]<=0;
//     read_queue[2]<=0;
//     read_queue[3]<=0;
//     read_queue[4]<=0;
//     read_queue[5]<=0;
//     read_queue[6]<=0;
//     read_queue[7]<=0;
//     write_queue[0]<=0;
//     write_queue[1]<=0;
//     write_queue[2]<=0;
//     write_queue[3]<=0;
//     write_queue[4]<=0;
//     write_queue[5]<=0;
//     write_queue[6]<=0;
//     write_queue[7]<=0;
//  end
//  else
//  begin
//   if(request==26'b0)
//   begin
//      i<=0;
//      j<=0;
//   end
//   else
//   begin
//     if(request[25])
//     begin
//       read_queue[i]<=request[24:0];
//       i<=i+1;
//     end
//     else
//     begin
//       write_queue[j]<=request[24:0];
//       j<=j+1;
//     end
//   end
//  end
//end

//always@(posedge clk)
//begin
//   if(i==0 && j==0)
//   begin
//      ins_req<=ins;
//   end
//   else
//   begin
//      if(i>=j)
//      begin
//         i<=i-1;
//         ins_req<=read_queue[i];
//      end
//      else
//      begin
//         j<=j-1;
//         ins_req<=write_queue[j];
//      end
//   end
//end

////decode

////always@(posedge clk or negedge reset)
//always@(*)
//begin
//   if(reset==1'b0)
//   begin
//      op<=3'b111;
//   end
//   else
//   begin
//   case(ins_req[24:22])
//      3'b000,3'b010: op<=3'b000;   //ld
//      3'b001,3'b011: op<=3'b001;   //st
//      3'b100: op<=3'b010;          //ld st
//      3'b101: op<=3'b011;          //pre
//      3'b110: op<=3'b100;          //mac
//      3'b111: op<=3'b101;          //pool
//      default: op<=3'b111;
//   endcase
//   end
//end

//always@(posedge clk or negedge reset)
//begin
//   if(reset==1'b0)
//   begin
//       rank_id<=3'bz;  
//       bg_id<=4'bz;   
//       addr<=15'bz;
//       rank1_id<=3'bz;   
//       bg1_id<=4'bz;  
//       addr1<=4'bz;
//       rank2_id<=3'bz;   
//       bg2_id<=4'bz;  
//       addr2<=4'bz;
//       bgs<=1'bz;
//       act_func<=1'bz;
//   end
//   else
//   begin
//     case(ins_req[24:22])
//        3'b000,3'b001: begin rank_id<=ins_req[21:19];  bg_id<=ins_req[18:15];   addr<=ins_req[14:0];  end //ldr str
//        3'b010,3'b011: begin rank_id<=ins_req[21:19];  addr<=ins_req[18:4];  end //ldpu stpu
//        3'b100: begin rank1_id<=ins_req[21:19];   bg1_id<=ins_req[18:15];  addr1<=ins_req[14:11];  
//                      rank2_id<=ins_req[10:8];   bg2_id<=ins_req[7:4];  addr2<=ins_req[3:0];   end      //ld st
//        3'b101: rank_id<=ins_req[21:19];          //pre
//        3'b110: begin rank_id<=ins_req[21:19];  bgs<=ins_req[18]; act_func<=ins_req[17];   end          //mac
//        3'b111: begin rank_id<=ins_req[21:19];  bgs<=ins_req[18];                          end          //pool
//     endcase
//   end
//end



//endmodule
