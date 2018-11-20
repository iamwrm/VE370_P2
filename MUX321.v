`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 16:33:26
// Design Name: 
// Module Name: MUX321
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


module MUX321
            #(parameter bits=16)
            (input sel,
             input [bits-1:0] a, b, c,
             output reg [bits-1:0] out );
            always @(sel, a, b, c) begin
                    case (sel) 
                        2'b00: out = a;
                        2'b01: out = b;
                        2'b10: out =c;
                        default: out = 0;
                    endcase
                end
endmodule
