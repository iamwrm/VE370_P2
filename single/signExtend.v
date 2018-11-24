`ifndef __VE370__SIGN__EXTEND__
`define __VE370__SIGN__EXTEND__
module signExtend(
    input [15:0] in,
    output reg [31:0] out
);

always @(in) begin
    out[31:0]  = { {16{in[15]}}, in[15:0]};
end

endmodule // signExtend
`endif