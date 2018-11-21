`timescale 1ns / 1ps


`include "PC.v"
`include "Instruction_Mem.v"
`include "IF_ID.v"
`include "Hazard.v"
`include "Reg_File.v"
`include "ID_EX.v"
`include "EX_MEM.v"
`include "MEM_WB.v"
`include "ALU.v"
`include "ALU_Control.v"
`include "MUX221.v"



module pipeline(
	input clock,
	input reset,
	input [4:0] register_switch, 
	output [31:0] pc_out, 
	reg [31:0] register_out);




	wire [31:0] pc__in__next;
	wire [31:0] pc__out__address;
	// module PC( input clock,
        //    input reset,
        //    input [31:0] next,
        //    output reg [31:0] address);
	PC pc(.clock(clock),  .reset(reset), .next(pc__in__next), .address(pc__out__address));


	wire [31:0] ins_mem__out__ins;
	// module Instruction_Mem(input [31:0] addr, 
        //                output wire [31:0]out_Instr);
	Instruction_Mem ins_mem(pc__out__address,
				ins_mem__out__ins);


	wire [31:0] if_id__in__addr, if_id__out__addr, if_id__out__ins;
	// module IF_ID(input clk,reset,
        //      input [31:0] Instr, Addr,
        //      output reg [31:0] out_Instr, out_Addr);
	IF_ID if_id(clock,reset
		ins_mem__out__ins,if_id__in__addr,
		if_id__out__ins,if_id__out__addr);


	// module Hazard( input ID_EX_MemRead,EX_MEM_MemRead,clk,jump,bne,beq,IfEqual,
	//                input [4:0] ID_EX_RegisterRt,IF_ID_RegisterRs, IF_ID_RegisterRt,EX_MEM_RegisterRt,
	//                output PC_Hold,IF_ID_Hold,ID_EX_Flush,IF_Flush);
	Hazard hazard(

	);


	wire RegWrite;
	wire [4:0] read_register_1_addr,read_register_2_addr,write_register_addr;
	// module Reg_File(input clk ,RegWrite,
	//               input [4:0] ReadRegister1, ReadRegister2,WriteReg,
	//        	        input [31:0] WriteData,
	//        	        output wire [31:0] read_data1, read_data2
	// );      
	Reg_File reg_file(.clk(clock), .RegWrite(RegWrite),
		.ReadRegister1(read_register_1_addr), read_register_2_addr, write_register_addr,
		write_data,
		read_data_1, read_data_2);


	wire Fw1;
	wire [31:0] mux_regfile_out_1_value;
	wire [31:0] ex_mem_out_address; // TODO:
	MUX221 #(32) mux_regfile_out_1(
		.sel(Fw1),
		.a(read_data_1),
		.b(ex_mem_out_address), 
		.out(mux_regfile_out_1_value)
	);


	wire Fw2;
	wire [31:0] mux_regfile_out_2_value;
	MUX221 #(32) mux_regfile_out_2(
		.sel(Fw2),
		.a(read_data_2),
		.b(ex_mem_out_address), 
		.out(mux_regfile_out_2_value)
	);

	

	

	wire [31:0] id_ex__in__extended_im;
	// module ID_EX(input clk,reset,
	//              input RegDst,MemRead
	//              ,MemtoReg,MemWrite,ALUSrc
	//              ,RegWrite,
	//              input [1:0] ALUOp,
	//              input [31:0] ReadData1,ReadData2,ExtendedIm,
	//              input[4:0] ReadRegister1, ReadRegister2
	//              ,Rt,Rd,
	//              output reg RegDstEX,MemReadEX
	//              ,MemtoRegEX,MemWriteEX,ALUSrcEX
	//              ,RegWriteEX,
	//              output reg [1:0] ALUOpEX,
	//              output reg [31:0] ReadData1EX,ReadData2EX
	//              ,ExtendedImEX,
	//              output reg[4:0] ReadRegister1EX
	//              ,ReadRegister2EX,RtEX,RdEX
	//              );
	ID_EX id_ex(.clk(clock), .reset(reset),


	);



	// module EX_MEM(input clk,reset,
	//              input MemRead,MemtoReg,MemWrite
	//              ,RegWrite,
	//              input [31:0] ALUResult,ReadData,
	//              input[4:0] ReadRegister1, ReadRegister2
	//              ,RegisterDst,
	
	//              output reg MemReadM,MemtoRegM,MemWriteM
	//              ,RegWriteM,
	//              output reg [31:0] ALUResultM,ReadDataM,
	//              output reg [4:0] ReadRegister1M, ReadRegister2M
	//              ,RegisterDstM);
	EX_MEM ex_mem(

	);


	// module MEM_WB(input clk,reset,
	//              input MemtoReg,RegWrite,
	//              input [31:0] Data2Write, ALUResult,
	//              input [4:0] RegisterDst,
	//              output reg MemtoRegWB,RegWriteWB,
	//              output reg [31:0] Data2WriteWB, ALUResultWB,
	//              output reg [4:0] RegisterDstWB);
	MEM_WB mem_wb(clock,reset,
	
	

	);

	


	

	















endmodule
