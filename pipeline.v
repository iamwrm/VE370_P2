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



	wire [31:0] mux_pc_in_1__out;
	MUX221 mux_pc_in_1(.sel(IfBr),
	.a(PcNext),
	.b(PCBranch),
	.out(mux_pc_in_1__out)
	);


	wire [31:0] mux_pc_in_2__out;
	MUX221 mux_pc_in_2(.sel(Jump),
	.a(PCJump),
	.b(mux_pc_in_1__out),
	.out(mux_pc_in_2__out)
	);

	assign pc__in__next = mux_pc_in_2__out;

	wire [31:0] pc__in__next;
	wire [31:0] pc__out__address;
	PC pc(.clock(clock),  .reset(reset), .next(pc__in__next), .address(pc__out__address));


	wire [31:0] ins_mem__out__ins;
	Instruction_Mem ins_mem(.addr(pc__out__address),
				.out_Instr(ins_mem__out__ins));


	wire [31:0] if_id__in__addr, if_id__out__addr, if_id__out__ins;
	IF_ID if_id(.clk(clock), .reset(reset)
		.Instr(ins_mem__out__ins),
		.Addr(if_id__in__addr),
		.out_Instr(if_id__out__ins),
		.out_Addr(if_id__out__addr)
	);






	// TODO:
	// module Hazard( input ID_EX_MemRead,EX_MEM_MemRead,clk,jump,bne,beq,IfEqual,
	//                input [4:0] ID_EX_RegisterRt,IF_ID_RegisterRs, IF_ID_RegisterRt,EX_MEM_RegisterRt,
	//                output PC_Hold,IF_ID_Hold,ID_EX_Flush,IF_Flush);
	Hazard hazard(

	);


	wire reg_file__in__RegWrite;
	wire [4:0] reg_file__in__read_addr_1, reg_file__in__read_addr_2,reg_file__in__write_addr;
	// module Reg_File(input clk ,RegWrite,
	//               input [4:0] ReadRegister1, ReadRegister2,WriteReg,
	//        	        input [31:0] WriteData,
	//        	        output wire [31:0] read_data1, read_data2
	// );      
	Reg_File reg_file(.clk(clock), 
		.RegWrite(reg_file__in__RegWrite),
		.ReadRegister1(reg_file__in__read_addr_1),  
		.ReadRegister2( reg_file__in__read_addr_2), 
		.WriteReg(reg_file__in__write_addr),
		.WriteData(reg_file__in__write_data),
		.read_data1(reg_file__out__read_data_1), 
		.read_data2(reg_file__out__read_data_2)
	);


	wire Fw1;
	wire [31:0] mux_regfile_out_1__out__data;
	wire [31:0] ex_mem__out__address; // TODO:
	MUX221 #(32) mux_regfile_out_1(
		.sel(Fw1),
		.a(reg_file__out__read_data_1),
		.b(ex_mem__out__address), 
		.out(mux_regfile_out_1__out__data)
	);


	wire Fw2;
	wire [31:0] mux_regfile_out_2___out__data;
	MUX221 #(32) mux_regfile_out_2(
		.sel(Fw2),
		.a(reg_file__out__read_data_2),
		.b(ex_mem__out__address), 
		.out(mux_regfile_out_2___out__data)
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
	        //      input RegDst,MemRead
	        //      ,MemtoReg,MemWrite,ALUSrc
	        //      ,RegWrite,
	        //      input [1:0] ALUOp,
	        //      input [31:0] ReadData1,ReadData2,ExtendedIm,
	        //      input[4:0] ReadRegister1, ReadRegister2
	        //      ,Rt,Rd,
	        //      output reg RegDstEX,MemReadEX
	        //      ,MemtoRegEX,MemWriteEX,ALUSrcEX
	        //      ,RegWriteEX,
	        //      output reg [1:0] ALUOpEX,
	        //      output reg [31:0] ReadData1EX,ReadData2EX
	        //      ,ExtendedImEX,
	        //      output reg[4:0] ReadRegister1EX
	        //      ,ReadRegister2EX,RtEX,RdEX
	);

	// TODO: 4 mux 

	// TODO: ALU

	// TODO: ALU control

	// TODO: Forwarding Unit	




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


	// module Data_Mem(input [31:0] address,
	//                 input [31:0] Write_data,
	//                 input MemWrite, MemRead,clk,
	//                 output reg [31:0]Read_data);
	Data_Mem data_mem(


	);





	// module MEM_WB(input clk,reset,
	//              input MemtoReg,RegWrite,
	//              input [31:0] Data2Write, ALUResult,
	//              input [4:0] RegisterDst,
	//              output reg MemtoRegWB,RegWriteWB,
	//              output reg [31:0] Data2WriteWB, ALUResultWB,
	//              output reg [4:0] RegisterDstWB);
	MEM_WB mem_wb(.clock(clock), .reset(reset),
	
	

	);


	MUX221 mux_mem_wb_out(.sel(mem_wb__out__MemToReg),
		.a(mem_wb__out__ReadFromMemory),
		.b(mem_wb__out__ALUResult),
		.out(mux_mem_wb_out__out__data)
	);

	


	

	















endmodule
