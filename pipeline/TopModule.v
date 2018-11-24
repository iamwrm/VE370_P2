`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/22 22:02:24
// Design Name: 
// Module Name: TopModule
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


module TopModule(
    input [4:0]reg_Sel,
    input reg_0_pc_1,
    input clk,clock_Push,
    
    output [6:0] ca,
    output [3:0] an    
   );
    wire [31:0] PC_value,reg_value;
    SSD ssd( PC_value,reg_value,clk,reg_0_pc_1,an,ca);
    Pipeline pipeline( clock_Push, reg_Sel, PC_value, reg_value);
endmodule
