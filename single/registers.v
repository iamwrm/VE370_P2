`ifndef __VE370__REGISTERS__
`define __VE370__REGISTERS__
module registers(
    input clock, regWrite,
    input [4:0] readRegister1, readRegister2, writeRegister,
    input [31:0] writeData,
    output reg [31:0] readData1, readData2
);

reg [31:0] registers[0:31];
integer i;

initial begin
    for (i = 0; i < 32; i = i + 1) begin
        registers[i] = 32'b0;
    end
end

always @(posedge clock) begin
    if (regWrite == 1'b1) 
        registers[writeRegister] <= writeData;
end

always @(*) begin
    readData1 = registers[readRegister1];
    readData2 = registers[readRegister2];
end

endmodule // registers
`endif
