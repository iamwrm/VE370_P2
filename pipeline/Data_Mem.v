`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 16:06:52
// Design Name: 
// Module Name: Data_Mem
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

module Data_Mem(input [31:0] address,
                input [31:0] Write_data,
                input MemWrite, MemRead,clk,
                output [31:0]Read_data);
         reg [31:0]Data[0:31];  
         wire [31:0]a;
         assign a=address >> 2;  
         integer i;

initial begin
             for (i = 0; i < 32; i=i+1) begin
                 Data[i] = 32'b0;
             end
         end
         
         always @(posedge clk) begin
                if(MemWrite==1'b1) Data[a]=Write_data;
                else Data[a]=Data[a];
                end
                
                assign Read_data=(MemRead==1'b1)? Data[a]:32'b0;

endmodule
