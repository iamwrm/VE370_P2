`ifndef __VE370__SINGLE__CYCLE__
`define __VE370__SINGLE__CYCLE__
`include "alu.v"
`include "aluControl.v"
`include "control.v"
`include "dataMemory.v"
`include "instructionMemory.v"
`include "pc.v"
`include "registers.v"
`include "signExtend.v"

module singleCycle(
    input clock
);
//branch
wire branch;
//control
wire RegDst, Jump, Brancheq, Branchne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;
wire [3:0] ALUControlOut;
//sign extension
wire [31:0] signExtendOut;
//alu
wire zero;
wire [31:0] ALUin, ALUResult;
//pc
wire [31:0] pcIn, pcOut, pcResult;
//instruction memory
wire [31:0] instruction;
//registers
wire [4:0] writeRegister;
wire [31:0] readData1, readData2, WriteData;
//data memory
wire [31:0] dataMemoryReadData;
//branch mux
wire [31:0] addResult, branchMuxOut;
//jump
wire [31:0] jumpAddress;

assign pcResult = pcOut + 4;
assign branch = (zero & Brancheq) | (~zero & Branchne);
assign zero = (ALUResult == 0);
assign ALUin = (ALUSrc == 1'b1) ? signExtendOut : readData2;
assign addResult = pcResult + (signExtendOut << 2);
assign branchMuxOut = (branch == 1'b1) ? addResult : pcResult;
assign jumpAddress = {pcResult[31:28], instruction[25:0] << 2};
assign pcIn = (Jump == 1'b1) ? jumpAddress : branchMuxOut;
assign writeRegister = (RegDst == 1'b1) ? instruction[15:11] : instruction[20:16];
assign WriteData = (MemtoReg == 1'b1) ? dataMemoryReadData : ALUResult;

control controlUnit (
    instruction[31:26],
    RegDst, Jump, Brancheq, Branchne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    ALUOp
);

instructionMemory instructionMemoryUnit (
    pcOut,
    instruction
);

pc pcUnit (
    clock, 
    pcIn,
    pcOut
);

signExtend signExtendUnit (
    instruction[15:0],
    signExtendOut
);

alu aluUnit (
    ALUControlOut,
    readData1,
    ALUin,
    zero,
    ALUResult
);

aluControl aluControlUnit (
    ALUOp,
    instruction[5:0],
    ALUControlOut
);

dataMemory dataMemoryUnit (
    clock, MemRead, MemWrite,
    ALUResult, readData2,
    dataMemoryReadData
);

registers registerFile (
    clock, RegWrite,
    instruction[25:21], instruction[20:16], writeRegister,
    WriteData,
    readData1, readData2
);

endmodule // singleCycle
`endif
