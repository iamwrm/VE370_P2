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

//module dataMemory(
//    input clock, memRead, memWrite,
//    input [31:0] address, writeData,
//    output [31:0] readData
//);

//wire [31:0] memoryIndex;
//integer i;
//assign memoryIndex = address >> 2;

//reg [31:0] memory [0:7];

//initial begin
//    for (i = 0; i < 8; i++) begin
//        memory[i] = 32'b0;
//    end
//end

//always @(posedge clock) begin
//    if (memWrite == 1'b1) begin
//        memory[memoryIndex] = writeData;
//    end
//end

//assign readData = (memRead == 1'b1) ? memory[memoryIndex] : 32'b0;

//endmodule 

module Data_Mem(input [31:0] address,
                input [31:0] Write_data,
                input MemWrite, MemRead,clk,
                output reg [31:0]Read_data);
         reg [31:0]Data[0:31];  
         wire [31:0]a;
         assign a=address >> 2;  
                        initial begin
         Data[0]=32'b0;
         Data[1]=32'b0;
         Data[2]=32'b0;
         Data[3]=32'b0;
         Data[4]=32'b0;
         Data[5]=32'b0;
         Data[6]=32'b0;
         Data[7]=32'b0;
         Data[8]=32'b0;
         Data[9]=32'b0;
         Data[10]=32'b0;
         Data[11]=32'b0;
         Data[12]=32'b0;
         Data[13]=32'b0;
         Data[14]=32'b0;
         Data[15]=32'b0;
         Data[16]=32'b0;
         Data[17]=32'b0;
         Data[18]=32'b0;
         Data[19]=32'b0;
         Data[20]=32'b0;
         Data[21]=32'b0;
         Data[22]=32'b0; 
         Data[23]=32'b0;
         Data[24]=32'b0;
         Data[25]=32'b0;
         Data[26]=32'b0;
         Data[27]=32'b0;
         Data[28]=32'b0;
         Data[29]=32'b0;
         Data[30]=32'b0;
         Data[31]=32'b0;             
         end   
         always @(MemWrite,Write_data,address,posedge clk) begin
                if(MemWrite==1'b1) Data[a]<=Write_data;
                else Data[a]<=Data[a];
                end
          always @(MemRead,address) begin       
                               if(MemRead==1'b1) Read_data<=Data[a];
                               else Read_data<=Read_data;
                               end

endmodule
