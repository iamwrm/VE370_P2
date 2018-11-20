`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 17:32:06
// Design Name: 
// Module Name: ALU_Control
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


module ALU_Control(input [5:0] funct,
               input [1:0] ALUop,
               output reg [3:0] control );
               
               always @(funct, ALUop) begin
               case (ALUop)
               2'b00: control=4'b0010; //lw/sw(add)
               2'b01: control=4'b0110;//branch(subtrsct)
               2'b10: case(funct)
                      6'b100000: control=4'b0010;//add
                      6'b100010: control=4'b0110;//subtract
                      6'b100100: control=4'b0000;//AND
                      6'b100101: control=4'b0001;//OR
                      6'b101010: control=4'b0111;//slt
                      default: control=4'b0000;
                      endcase
              default:control=4'b0000; 
              endcase
              end        
                      
               
endmodule
