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


	wire [31:0] sign_extend__out__data;
	Sign_Extend sign_extend(.small_In(if_id__out__ins[15:0]),
		.big_Out(sign_extend__out__data)
	);


	assign reg_file__in__read_addr_1 = if_id__out__ins[25:21];
    	assign reg_file__in__read_addr_2 = if_id__out__ins[20:16];


	wire reg_file__in__RegWrite;
	wire [4:0] reg_file__in__read_addr_1, reg_file__in__read_addr_2,reg_file__in__write_addr;
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

	
	
	

	wire	
			id_ex__in__RegDst,
			id_ex__in__MemRead,
			id_ex__in__MemtoReg,
			id_ex__in__MemWrite,
			id_ex__in__ALUSrc,
			id_ex__in__RegWrite,
			id_ex__out__RegDst,
			id_ex__out__MemRead,
			id_ex__out__MemtoReg,
			id_ex__out__MemWrite,
			id_ex__out__ALUSrc,
			id_ex__out__RegWrite;
	wire [1:0] 	
			id_ex__in__ALUOp,
			id_ex__out__ALUOp;
	wire [31:0] 	
			id_ex__in__ExtendedIm, 
			id_ex__in__ReadData1, 
			id_ex__in__ReadData2,
			id_ex__out_ExtendedIm,
			id_ex__out__ReadData1,
			id_ex__out__ReadData2;
	wire [4:0] 	
			id_ex__in__ReadRegister1,
			id_ex__in__ReadRegister2,
			id_ex__in__Rt,
			id_ex__in__Rd,
			id_ex__out__ReadRegister1,
			id_ex__out__ReadRegister2,
			id_ex__out__Rt,
			id_ex__out__Rd;
	ID_EX id_ex(.clk(clock), .reset(reset),
	        .RegDst(id_ex__in__RegDst),
		.MemRead(id_ex__in__MemRead),
		.MemtoReg(id_ex__in__MemtoReg),
		.MemWrite(id_ex__in__MemWrite),
		.ALUSrc(id_ex__in__ALUSrc),
		.RegWrite(id_ex__in__RegWrite),
		.ALUOp(id_ex__in__ALUOp),
		.ReadData1(id_ex__in__ReadData1),
		.ReadData2(id_ex__in__ReadData2),
		.ExtendedIm(id_ex__in__ExtendedIm),
		.ReadRegister1(id_ex__in__ReadRegister1), 
		.ReadRegister2(id_ex__in__ReadRegister2),
		.Rt(id_ex__in__Rt),
		.Rd(id_ex__in__Rd),
		.RegDstEX(id_ex__out__RegDst),
		.MemReadEX(id_ex__out__MemRead),
		.MemtoRegEX(id_ex__out__MemtoReg),
		.MemWriteEX(id_ex__out__MemWrite),
		.ALUSrcEX(id_ex__out__ALUSrc),
		.RegWriteEX(id_ex__out__RegWrite),
		.ALUOpEX(id_ex__out__ALUOp),
	        .ReadData1EX(id_ex__out__ReadData1),
		.ReadData2EX(id_ex__out__ReadData2),
	        .ExtendedImEX(id_ex__out_ExtendedIm),
		.ReadRegister1EX(id_ex__out__ReadRegister1),
		.ReadRegister2EX(id_ex__out__ReadRegister2),
		.RtEX(id_ex__out__Rt),
		.RdEX(id_ex__out__Rd)
	);

	assign mux_regfile_out_1__out__data=id_ex__in__ReadData1;
	assign mux_regfile_out_2__out__data=id_ex__in__ReadData2;

	// TODO: 4 mux 

	MUX321 mux_ex_1();
	MUX321 mux_ex_2();
	MUX221 mux_ex_3();
	MUX221 mux_ex_4();

	// TODO: ALU

	ALU alu();

	// TODO: ALU control
	ALU_Control alu_control();

	// TODO: Forwarding Unit	


	wire 		
			ex_mem__in__MemRead,
			ex_mem__in__MemtoReg,
			ex_mem__in__MemWrite,
			ex_mem__in__RegWrite,
			ex_mem__out__MemRead,
			ex_mem__out__MemtoReg,
			ex_mem__out__MemWrite,
			ex_mem__out__RegWrite ;	
	wire [31:0]	
			ex_mem__in__ALUResult,
			ex_mem__in__ReadData,
			ex_mem__out__ALUResult,
			ex_mem__out__ReadData ;
	wire [4:0]	
			ex_mem__in__ReadRegister1,
			ex_mem__in__ReadRegister2,
			ex_mem__in__RegisterDst,
			ex_mem__out__ReadRegister1,
			ex_mem__out__ReadRegister2,
			ex_mem__out__RegisterDst ;

	EX_MEM ex_mem( .clk(clock), .reset(reset),
			.MemRead(ex_mem__in__MemRead),
			.MemtoReg(ex_mem__in__MemtoReg),
			.MemWrite(ex_mem__in__MemWrite),
			.RegWrite(ex_mem__in__RegWrite),
	//              input [31:0] 
			.ALUResult(ex_mem__in__ALUResult),
			.ReadData(ex_mem__in__ReadData),
	//              input[4:0] 
			.ReadRegister1(ex_mem__in__ReadRegister1), 
			.ReadRegister2(ex_mem__in__ReadRegister2),
			.RegisterDst(ex_mem__in__RegisterDst),
	//              output reg 
			.MemReadM(ex_mem__out__MemRead),
			.MemtoRegM(ex_mem__out__MemtoReg),
			.MemWriteM(ex_mem__out__MemWrite),
			.RegWriteM(ex_mem__out__RegWrite),
	//              output reg [31:0] 
			.ALUResultM(ex_mem__out__ALUResult),
			.ReadDataM(ex_mem__out__ReadData),
	//              output reg [4:0] 
			.ReadRegister1M(ex_mem__out__ReadRegister1), 
			.ReadRegister2M(ex_mem__out__ReadRegister2),
			.RegisterDstM(ex_mem__out__RegisterDst)
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
