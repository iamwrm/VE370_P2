`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/22 18:13:48
// Design Name: 
// Module Name: RingCounter
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


module RingCounter(anode,clk_500);
    output [3:0] anode;
    input clk_500;
    
    reg [3:0] anode=4'b0111;
    
    always @(posedge clk_500)begin
 begin
        if (anode==4'b0111) anode<=4'b1011;
        else if (anode==4'b1011) anode<=4'b1101;
        else if (anode==4'b1101) anode<=4'b1110;
        else if (anode==4'b1110) anode<=4'b0111;
        else anode<=4'b0111;
        end
    end

endmodule
