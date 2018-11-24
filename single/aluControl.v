`ifndef __VE370__ALU__CONTROL__
`define __VE370__ALU__CONTROL__
module aluControl(
    input [1:0] aluOp,
    input [5:0] funct,
    output reg [3:0] aluControl
);

always @(aluOp, funct) begin
    case (aluOp)
        2'b00: aluControl = 4'b0010;
        2'b01: aluControl = 4'b0110;
        2'b10: begin
            case (funct)
                6'b100000: aluControl = 4'b0010;
                6'b100010: aluControl = 4'b0110;
                6'b100100: aluControl = 4'b0000;
                6'b100101: aluControl = 4'b0001;
                6'b101010: aluControl = 4'b0111;
                default: aluControl = 4'b0000;
            endcase
        end
        default: aluControl = 4'b0000;
    endcase
end

endmodule // aluControl
`endif