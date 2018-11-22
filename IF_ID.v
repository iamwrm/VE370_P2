`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/16 17:34:57
// Design Name: 
// Module Name: IF_ID
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


module IF_ID(input clk,hold,Flush,
             input [31:0] Instr, Addr,
             output reg [31:0] out_Instr, out_Addr);
             always @(posedge clk) begin
            if(Flush==1'b1)
             begin
             out_Instr<=32'b00000000000000000000000000000000;
             out_Addr<=out_Addr;             
             end
             else if(hold==1'b1)begin
             out_Instr<=out_Instr;
             out_Addr<=out_Addr;
             end
             else begin
             out_Instr<=Instr;
             out_Addr<=Addr;
             end
             end
             
endmodule
