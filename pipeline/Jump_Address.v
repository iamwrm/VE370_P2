`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/21 02:07:36
// Design Name: 
// Module Name: Jump_Address
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


module Jump_Address(input [25:0]JumpWhere26,
                    input [3:0] PCNext_4,
                    output [31:0] JumpAddress );
  assign JumpAddress={PCNext_4[3:0],JumpWhere26[25:0],2'b0};
                    
endmodule
