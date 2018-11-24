`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/22 17:52:29
// Design Name: 
// Module Name: ClockDivider
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


// module ClockDivider(clock,clk500Hz);
//     input clock;
//     output clk500Hz;
//     reg [17:0] Q;
//     reg clk500Hz;
//     always @(Q)
//     begin
//     if(Q==18'b110000110100111111) clk500Hz<=1'b1;
//     else clk500Hz=1'b0;
//     end
//     always @ (posedge clock)
//  if(clk500Hz==1'b1) Q={18'b110000110100111111};
//     else Q<=Q-1;

// endmodule
module ClockDivider(
    input clock,
    output clk500Hz
);
reg[27:0] counter = 28'd0;
parameter DIVISOR = 28'd200000;
always @(posedge clock) begin
    counter <= counter + 28'd1;
    if(counter >= (DIVISOR-1))
        counter <= 28'd0;
end
assign clk500Hz = (counter<DIVISOR/2)?1'b0:1'b1;

endmodule // ClockDivider