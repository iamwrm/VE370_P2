`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 16:58:07
// Design Name: 
// Module Name: If_Equal
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


module If_Equal(input [31:0] a,b,
                output wire IfEqual);
                
                 assign IfEqual = (a == b) ? 1'b1 : 1'b0;
endmodule
