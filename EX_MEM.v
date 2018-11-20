`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/17 04:14:20
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(input clk,reset,
             input MemRead,MemtoReg,MemWrite
             ,RegWrite,
             input [31:0] ALUResult,ReadData,
             input[4:0] ReadRegister1, ReadRegister2
             ,RegisterDst,
             
             output reg MemReadM,MemtoRegM,MemWriteM
             ,RegWriteM,
             output reg [31:0] ALUResultM,ReadDataM,
             output reg [4:0] ReadRegister1M, ReadRegister2M
             ,RegisterDstM);
             
             always @(posedge clk,reset) begin
             if(reset==1'b1) begin
             MemReadM<=1'b0;
             MemtoRegM<=1'b0;
             MemWriteM<=1'b0;
             RegWriteM<=1'b0;
             ALUResultM<=32'b00000000000000000000000000000000;
             ReadDataM<=32'b00000000000000000000000000000000;
             ReadRegister1M<=5'b00000;
             ReadRegister2M<=5'b00000;
             RegisterDstM<=5'b00000;             
             end
             else begin
                 MemReadM<=MemRead;
                 MemtoRegM<=MemtoReg;
                 MemWriteM<=MemWrite;
                 RegWriteM<=RegWrite;
                 ALUResultM<=ALUResult;
                 ReadDataM=ReadData;
                 RegisterDstM<=RegisterDst;
                 ReadRegister1M<=ReadRegister1;
                 ReadRegister2M<=ReadRegister2;
                 end
                 end                           

endmodule
