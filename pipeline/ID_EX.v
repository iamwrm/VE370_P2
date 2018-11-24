`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 17:39:17
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(input clk,
             input RegDst,MemRead
             ,MemtoReg,MemWrite,ALUSrc
             ,RegWrite,
             input [1:0] ALUOp,
             input [31:0] ReadData1,ReadData2,ExtendedIm,
             input[4:0] ReadRegister1, ReadRegister2
             ,Rt,Rd,
             
             output reg RegDstEX,MemReadEX
             ,MemtoRegEX,MemWriteEX,ALUSrcEX
             ,RegWriteEX,
             output reg [1:0] ALUOpEX,
             output reg [31:0] ReadData1EX,ReadData2EX
             ,ExtendedImEX,
             output reg[4:0] ReadRegister1EX
             ,ReadRegister2EX,RtEX,RdEX
             );
             
             initial begin
             RegDstEX<=1'b0;
             MemReadEX<=1'b0;
             MemtoRegEX<=1'b0;
             MemWriteEX<=1'b0;
             ALUSrcEX<=1'b0;
             RegWriteEX<=1'b0;
             ALUOpEX<=2'b00;
             ReadData1EX<=32'b00000000000000000000000000000000;
             ReadData2EX<=32'b00000000000000000000000000000000;
             ExtendedImEX<=32'b00000000000000000000000000000000;
             ReadRegister1EX<=5'b00000;
             ReadRegister2EX<=5'b00000;
             RtEX<=5'b00000;
             RdEX<=5'b00000;
             end
always @(posedge clk) begin
                 RegDstEX<=RegDst;
                 MemReadEX<=MemRead;
                 MemtoRegEX<=MemtoReg;
                 MemWriteEX<=MemWrite;
                 ALUSrcEX<=ALUSrc;
                 RegWriteEX<=RegWrite;
                 ALUOpEX<=ALUOp;
                 ReadData1EX<=ReadData1;
                 ReadData2EX<=ReadData2;
                 ExtendedImEX<=ExtendedIm;
                 ReadRegister1EX<=ReadRegister1;
                 ReadRegister2EX<=ReadRegister2;
                 RtEX<=Rt;
                 RdEX<=Rd;
                 end    
endmodule
