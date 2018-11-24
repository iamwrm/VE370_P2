`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 17:01:28
// Design Name: 
// Module Name: Control
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


module Control(input [5:0] opcode,
               output reg 
               jump,
               Branch,
               Bne,
               MemRead,
               MemtoReg ,
               MemWrite,
               ALUSrc,
               RegWrite,
               RegDst
               ,output reg [1:0] ALUOp);
               
                   initial begin
                       RegDst      = 1'b0;
                       jump        = 1'b0;
                       Branch    = 1'b0;
                       Bne    = 1'b0;
                       MemRead     = 1'b0;
                       MemtoReg    = 1'b0;
                       MemWrite    = 1'b0;
                       ALUSrc      = 1'b0;
                       RegWrite    = 1'b0;
                       ALUOp       = 2'b00;
                   end

         always @(opcode)begin      
               case(opcode)
               6'b000000://add, sub, and, or, slt
               begin
               RegDst= 1'b1;
               Branch= 1'b0;
               Bne=1'b0;
               MemRead= 1'b0;
               MemtoReg= 1'b1;
               MemWrite= 1'b0;
               ALUSrc= 1'b0;
               RegWrite= 1'b1;
               jump= 1'b0;
               ALUOp= 2'b10;
               end
               6'b001000://addi
               begin
               RegDst= 1'b0;
               Branch= 1'b0;
               Bne=1'b0;
               MemRead= 1'b0;
               MemtoReg= 1'b1;
               MemWrite= 1'b0;
               ALUSrc= 1'b1;
               RegWrite= 1'b1;
               jump= 1'b0;
               ALUOp= 2'b00;
               end
                6'b001100://andi
               begin
               RegDst= 1'b0;
               Branch= 1'b0;
               Bne=1'b0;
               MemRead= 1'b0;
               MemtoReg= 1'b1;
               MemWrite= 1'b0;
               ALUSrc= 1'b1;
               RegWrite= 1'b1;
               jump= 1'b0;
               ALUOp= 2'b11;
               end
               6'b000100:// beq
               begin
               RegDst= 1'b1;
               Branch= 1'b1;
               Bne=1'b0;
               MemRead= 1'b0;
               MemtoReg= 1'b0;
               MemWrite= 1'b0;
               ALUSrc= 1'b0;
               RegWrite= 1'b0;
               jump= 1'b0;
               ALUOp= 2'b01;               
               end
               6'b000101:// bne
               begin
               RegDst= 1'b1;
               Branch= 1'b0;
               Bne=1'b1;
               MemRead= 1'b0;
               MemtoReg= 1'b0;
               MemWrite= 1'b0;
               ALUSrc= 1'b0;
               RegWrite= 1'b0;
               jump= 1'b0;
               ALUOp= 2'b01;               
               end               
               6'b100011://lw
               begin
               RegDst= 1'b0;
               Branch= 1'b0;
               Bne=1'b0;
               MemRead= 1'b1;
               MemtoReg= 1'b0;
               MemWrite= 1'b0;
               ALUSrc= 1'b1;
               RegWrite= 1'b1;
               jump= 1'b0;
               ALUOp= 2'b00;               
               end
               6'b101011://sw
               begin
               RegDst= 1'b0;
               Branch= 1'b0;
               Bne=1'b0;
               MemRead= 1'b0;
               MemtoReg= 1'b0;
               MemWrite= 1'b1;
               ALUSrc= 1'b1;
               RegWrite= 1'b0;
               jump= 1'b0;
               ALUOp= 2'b00;               
               end               
               6'b000010://jump
               begin
               RegDst= 1'b0;
               Branch= 1'b0;
               Bne=1'b0;
               MemRead= 1'b0;
               MemtoReg= 1'b0;
               MemWrite= 1'b0;
               ALUSrc= 1'b0;
               RegWrite= 1'b0;
               jump= 1'b1;
               ALUOp= 2'b00;
               end
               default:
               begin
               RegDst= 1'b0;
               Branch= 1'b0;
               Bne=1'b0;
               MemRead= 1'b0;
               MemtoReg= 1'b0;
               MemWrite= 1'b0;
               ALUSrc= 1'b0;
               RegWrite= 1'b0;
               jump= 1'b0;
               ALUOp= 2'b00;               
               end       
               endcase
              end 
               
endmodule
