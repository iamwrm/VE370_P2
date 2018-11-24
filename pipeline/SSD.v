`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/22 17:37:32
// Design Name: 
// Module Name: SSD
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


module SSD(
    input [31:0] PC_value,reg_value,
    input clock,reg_0_pc_1,
    output [3:0]an,
    output reg [6:0]ca
);
wire clock500Hz;
reg [4:0]in_an_1,in_an_2,in_an_3,in_an_4;
reg [6:0]Ca1,Ca2,Ca3,Ca4;
ClockDivider ClkDivider500Hz(clock,clock500Hz);
RingCounter RingShow(an,clock500Hz);
always@(*)begin
if(reg_0_pc_1==1'b0)begin
in_an_1<=reg_value[3:0];
in_an_2<=reg_value[7:4];
in_an_3<=reg_value[11:8];
in_an_4<=reg_value[15:12];
end
else
begin
in_an_1<=PC_value[3:0];
in_an_2<=PC_value[7:4];
in_an_3<=PC_value[11:8];
in_an_4<=PC_value[15:12];
end
end
	 always @ (in_an_1) begin
    case (in_an_1)
         4'b0000: Ca1=7'b0000001;
           4'b0001: Ca1=7'b1001111;
           4'b0010: Ca1=7'b0010010;
           4'b0011: Ca1=7'b0000110;
           4'b0100: Ca1=7'b1001100;
           4'b0101: Ca1=7'b0100100;
           4'b0110: Ca1=7'b0100000;
           4'b0111: Ca1=7'b0001111;
           4'b1000: Ca1=7'b0000000;
           4'b1001: Ca1=7'b0000100;
           4'b1010: Ca1=7'b0001000;
           4'b1011: Ca1=7'b1100000;
           4'b1100: Ca1=7'b0110001;
           4'b1101: Ca1=7'b1000010;
           4'b1110: Ca1=7'b0110000;
           4'b1111: Ca1=7'b0111000;
           default Ca1=7'b1111111;
     endcase
end

always @ (in_an_2) begin
    case (in_an_2)
         4'b0000: Ca2=7'b0000001;
           4'b0001: Ca2=7'b1001111;
           4'b0010: Ca2=7'b0010010;
           4'b0011: Ca2=7'b0000110;
           4'b0100: Ca2=7'b1001100;
           4'b0101: Ca2=7'b0100100;
           4'b0110: Ca2=7'b0100000;
           4'b0111: Ca2=7'b0001111;
           4'b1000: Ca2=7'b0000000;
           4'b1001: Ca2=7'b0000100;
           4'b1010: Ca2=7'b0001000;
           4'b1011: Ca2=7'b1100000;
           4'b1100: Ca2=7'b0110001;
           4'b1101: Ca2=7'b1000010;
           4'b1110: Ca2=7'b0110000;
           4'b1111: Ca2=7'b0111000;
           default Ca2=7'b1111111;
     endcase
end

always @ (in_an_3) begin
    case (in_an_3)
         4'b0000: Ca3=7'b0000001;
           4'b0001: Ca3=7'b1001111;
           4'b0010: Ca3=7'b0010010;
           4'b0011: Ca3=7'b0000110;
           4'b0100: Ca3=7'b1001100;
           4'b0101: Ca3=7'b0100100;
           4'b0110: Ca3=7'b0100000;
           4'b0111: Ca3=7'b0001111;
           4'b1000: Ca3=7'b0000000;
           4'b1001: Ca3=7'b0000100;
           4'b1010: Ca3=7'b0001000;
           4'b1011: Ca3=7'b1100000;
           4'b1100: Ca3=7'b0110001;
           4'b1101: Ca3=7'b1000010;
           4'b1110: Ca3=7'b0110000;
           4'b1111: Ca3=7'b0111000;
           default Ca3=7'b1111111;
     endcase
end

always @ (in_an_4) begin
    case (in_an_4)
         4'b0000: Ca4=7'b0000001;
           4'b0001: Ca4=7'b1001111;
           4'b0010: Ca4=7'b0010010;
           4'b0011: Ca4=7'b0000110;
           4'b0100: Ca4=7'b1001100;
           4'b0101: Ca4=7'b0100100;
           4'b0110: Ca4=7'b0100000;
           4'b0111: Ca4=7'b0001111;
           4'b1000: Ca4=7'b0000000;
           4'b1001: Ca4=7'b0000100;
           4'b1010: Ca4=7'b0001000;
           4'b1011: Ca4=7'b1100000;
           4'b1100: Ca4=7'b0110001;
           4'b1101: Ca4=7'b1000010;
           4'b1110: Ca4=7'b0110000;
           4'b1111: Ca4=7'b0111000;
           default Ca4=7'b1111111;
     endcase
end
always@(an)begin
   case(an)
   4'b0111:ca=Ca1;
   4'b1011:ca=Ca2;
   4'b1101:ca=Ca3;
   4'b1110:ca=Ca4;
   endcase
end

endmodule
