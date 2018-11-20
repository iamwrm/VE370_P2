`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 16:30:25
// Design Name: 
// Module Name: Reg_File
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


module Reg_File(input clk ,RegWrite,
              input [4:0] ReadRegister1, ReadRegister2,WriteReg,
       	        input [31:0] WriteData,
       	        output wire [31:0] read_data1, read_data2
);      
        reg[31:0] registers[0:31];
    integer i;
        assign read_data1 = registers[ReadRegister1];
        assign read_data2 = registers[ReadRegister2];
        
    initial begin
            for (i = 0; i < 32; i=i+1) begin
                registers[i] = 32'b0;
            end
        end
        
        always@(negedge clk)
        begin
            if(RegWrite)
                registers[WriteReg] = WriteData;
        end

endmodule
