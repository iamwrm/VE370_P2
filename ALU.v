`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 13:31:11
// Design Name: 
// Module Name: ALU
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


module ALU( input [3:0] control, 
    input [31:0] a, b, 
    output reg [31:0] result);
    
    always @(control, a, b) begin
        case (control)
            4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0110: result = a - b;
            4'b0111: result = (a < b) ? 1 : 0;
            4'b1100: result = ~(a | b);
            default: result = 32'b0;
        endcase
    end
    
endmodule
