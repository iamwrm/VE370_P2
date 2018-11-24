`ifndef __VE370__ALU__
`define __VE370__ALU__
module alu(
    input [3:0] control, 
    input [31:0] a, b, 
    output zero, 
    output reg [31:0] result 
);

// input [3:0] control;
// input [31:0] a, b;
// output zero;
// output [31:0] result;
// reg [31:0] result;

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

assign zero = (result == 0);

endmodule // alu
`endif