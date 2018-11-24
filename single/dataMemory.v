`ifndef __VE370__DATA__MEMORY__
`define __VE370__DATA__MEMORY__
module dataMemory(
    input clock, memRead, memWrite,
    input [31:0] address, writeData,
    output [31:0] readData
);

wire [31:0] memoryIndex;
integer i;
assign memoryIndex = address >> 2;

reg [31:0] memory [0:7];

initial begin
    for (i = 0; i < 8; i = i + 1) begin
        memory[i] = 32'b0;
    end
end

always @(posedge clock) begin
    if (memWrite == 1'b1) begin
        memory[memoryIndex] = writeData;
    end
end

// always @(memRead) begin
//     case (memRead)
//       1'b1: readData = memory[memoryIndex];
//       1'b0: readData = 32'b0;
//       default: readData = 32'b0;
//     endcase
// end
assign readData = (memRead == 1'b1) ? memory[memoryIndex] : 32'b0;

endmodule // dataMemory
`endif
