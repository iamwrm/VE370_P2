`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/17 04:22:30
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(input clk,
             input MemtoReg,RegWrite,
             input [31:0] Data2Write, ALUResult,
             input [4:0] RegisterDst,
             
             output reg MemtoRegWB,RegWriteWB,
             output reg [31:0] Data2WriteWB, ALUResultWB,
             output reg [4:0] RegisterDstWB);
             
             initial begin
             MemtoRegWB<=1'b0;
             RegWriteWB<=1'b0;
             Data2WriteWB<=32'b00000000000000000000000000000000;
             ALUResultWB<=32'b00000000000000000000000000000000;
             RegisterDstWB<=5'b00000;             
             end

              always @(posedge clk) begin
             MemtoRegWB<=MemtoReg;
             RegWriteWB<=RegWrite;
             Data2WriteWB<=Data2Write;
             ALUResultWB<=ALUResult;
             RegisterDstWB<=RegisterDst;  
                 end            
endmodule
