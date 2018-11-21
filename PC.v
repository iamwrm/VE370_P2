`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 13:39:14
// Design Name: 
// Module Name: PC
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


module PC( input clk,reset,hold,
           input [31:0] next,
           output reg [31:0] address);
    
    always @(posedge clk,reset) begin
    
    if(hold==1'b1)  address<=address;
    else address <= next;
        end
    initial begin
    address<=32'b0;
    end
        
endmodule
