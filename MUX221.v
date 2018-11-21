`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 16:16:03
// Design Name: 
// Module Name: MUX221
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


module MUX221
            #(parameter bits=32)
             (  input sel,
                input [bits-1:0] a, b,
                output reg [bits-1:0] out );
                
    always @(sel, a, b) begin
        case (sel) 
            1'b0: out = a;
            1'b1: out = b;
            default: out = 0;
        endcase
    end

endmodule
