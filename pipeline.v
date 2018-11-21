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
`include "MUX321.v"
`include "Jump_Address.v"
`include "Sign_Extend.v"
`include "If_Equal.v"
`include "Data_Mem.v"
`include "Control.v"
`include "Forwarding.v"



module pipeline(
	input clock,
	input reset,
	input [4:0] register_switch, 
	output [31:0] pc_out,  
	output reg [31:0] register_out);

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
			id_ex__in__ALUOp_2,
			id_ex__out__ALUOp_2;
	wire [31:0] 	
			id_ex__in__ExtendedIm_32, 
			id_ex__in__ReadData1_32, 
			id_ex__in__ReadData2_32,
			id_ex__out__ExtendedIm_32,
			id_ex__out__ReadData1_32,
			id_ex__out__ReadData2_32;
	wire [4:0] 	
			id_ex__in__ReadRegister1_5,
			id_ex__in__ReadRegister2_5,
			id_ex__in__Rt_5,
			id_ex__in__Rd_5,
			id_ex__out__ReadRegister1_5,
			id_ex__out__ReadRegister2_5,
			id_ex__out__Rt_5,
			id_ex__out__Rd_5;

	// ========================================================

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
			ex_mem__in__ALUResult_32,
			ex_mem__in__ReadData_32,
			ex_mem__out__ALUResult_32,
			ex_mem__out__ReadData_32 ;
	wire [4:0]	
			ex_mem__in__ReadRegister1,
			ex_mem__in__ReadRegister2,
			ex_mem__in__RegisterDst,
			ex_mem__out__ReadRegister1,
			ex_mem__out__ReadRegister2,
			ex_mem__out__RegisterDst;

	// ========================================================

	wire 		
			mem_wb__in__MemtoReg,
			mem_wb__in__RegWrite,
			mem_wb__out__MemToReg,
			mem_wb__out__RegWriteWB;
	wire	[31:0]
			mem_wb__out__ReadFromMemory_32,
			mem_wb__out__ALUResult_32;
	wire	[4:0]
			mem_wb__out__Rd;


	wire [31:0] 	PcNext,
			PCBranch;
	wire IfBr;
	assign PcNext = pc__out__address_32+32'h4;
	assign PCBranch = if_id__out__PCNext_32 + (sign_extend__out__data_32<<2);


	wire [31:0] mux_pc_in_1__out_32;
	MUX221 #(32) mux_pc_in_1(.sel(IfBr),
	.a(PcNext),
	.b(PCBranch),
	.out(mux_pc_in_1__out_32)
	);


	wire [31:0] jump_address__out__data_32;
	wire [31:0] mux_pc_in_2__out_32;
	MUX221 #(32) mux_pc_in_2(.sel(Jump),
	.a(jump_address__out__data_32),
	.b(mux_pc_in_1__out_32),
	.out(mux_pc_in_2__out_32)
	);


	wire pc__in__hold;

	wire [31:0] 	pc__in__next_32;
	wire [31:0] 	pc__out__address_32;
	assign pc__in__next_32 = mux_pc_in_2__out_32;
	PC pc(.clk(clock),  
		.reset(reset), 
		.hold(pc__in__hold),
		.next(pc__in__next_32), 
		.address(pc__out__address_32)
	);


	Jump_Address jump_address(
		.JumpWhere26(if_id__out__ins_32[25:0]),
		.PCNext(pc__out__address_32+32'h4),
		.JumpAddress(jump_address__out__data_32)
	);


	wire [31:0] 	ins_mem__out__ins_32;
	Instruction_Mem ins_mem(.addr(pc__out__address_32),
				.out_Instr(ins_mem__out__ins_32)
	);


	wire 		
			if_id__in__hold, 
			if_id__in__flush;
	wire [31:0] 
			if_id__in__addr_32, 
			if_id__out__PCNext_32, 
			if_id__out__ins_32;
	IF_ID if_id(.clk(clock), .reset(reset),
		.hold(if_id__in__hold),
		.Flush(if_id__in__flush),
		.Instr(ins_mem__out__ins_32),
		.Addr(if_id__in__addr_32),
		.out_Instr(if_id__out__ins_32),
		.out_Addr(if_id__out__PCNext_32)
	);








	// TODO: Control

	
	wire 
			control__out__jump,
			control__out__branch,
			control__out__bne,
			control__out__MemRead,
			control__out__MemtoReg,
			control__out__MemWrite,
			control__out__ALUSrc,
			control__out__RegWrite,
			control__out__RegDst ;
	wire [1:0]	control__out__ALUOp;

 	Control control (.opcode(if_id__out__ins_32[31:26]),
		.reset(reset),
		.jump(control__out__jump),
		.Branch(control__out__branch),
		.Bne(control__out__bne),
		// 
		.MemRead(control__out__MemRead),
		.MemtoReg(control__out__MemtoReg) ,
		.MemWrite(control__out__MemWrite),
		.ALUSrc(control__out__ALUSrc),
		.RegWrite(control__out__RegWrite),
		.RegDst(control__out__RegDst),
		.ALUOp(control__out__ALUOp)
	);


	wire 	
		hazard__out__pc_hold,
		hazard__out__if_id_hold,
		hazard__out__id_ex_flush,
		hazard__out__if_flush
		;
	wire 	if_equal__out__if_zero;
	// TODO:
	Hazard hazard(
			.ID_EX_MemRead(id_ex__out__MemRead),
			.EX_MEM_MemRead(ex_mem__out__MemRead),
			.ID_EX_RegWrite(id_ex__out__RegWrite),
			.ID_EX_RegDst(id_ex__out__RegDst),
			.jump(control__out__jump),
			.bne(control__out__bne),
			.beq(control__out__branch),
			.IfEqual(if_equal__out__if_zero),
			.ID_EX_RegisterRt(id_ex__out__ReadRegister2_5),
			.ID_EX_RegisterRd(id_ex__out__Rd_5),
			.IF_ID_RegisterRs(id_ex__in__ReadRegister1_5), 
			.IF_ID_RegisterRt(id_ex__in__ReadRegister2_5),
			.EX_MEM_RegisterRd(ex_mem__out__RegisterDst),
			//                output 
			.PC_Hold(hazard__out__pc_hold),
			.IF_ID_Hold(hazard__out__if_id_hold),
			.ID_EX_Flush(hazard__out__id_ex_flush),
			.IF_Flush(hazard__out__if_flush)
	);

	assign pc__in__hold = hazard__out__pc_hold;
	assign if_id__in__hold = hazard__out__if_id_hold;
	assign if_id__in__flush = hazard__out__if_flush;

	wire [7:0] 	control__out__combined;
	assign control__out__combined = {
			control__out__MemRead,
			control__out__MemtoReg,
			control__out__MemWrite,
			control__out__ALUSrc,
			control__out__RegWrite,
			control__out__RegDst,
			control__out__ALUOp};


	wire 		mux_control_out__in__id_ex_flush;
	wire [7:0]	mux_control_out__out__combined;

	assign mux_control_out__in__id_ex_flush  = hazard__out__id_ex_flush;

	MUX221 #(8)	mux_control_out(
		.sel(mux_control_out__in__id_ex_flush),
		.a(control__out__combined),
		.b(8'h0),
		.out(mux_control_out__out__combined)
	);


	wire [31:0] sign_extend__out__data_32;
	Sign_Extend sign_extend(.small_In(if_id__out__ins_32[15:0]),
		.big_Out(sign_extend__out__data_32)
	);




	wire reg_file__in__RegWrite;
	wire [4:0] 	
			reg_file__in__read_addr_1_5, 
			reg_file__in__read_addr_2_5,
			reg_file__in__write_addr_2_5
			;
	wire [31:0]
			reg_file__in__write_data_32,
			reg_file__out__read_data_1_32,
			reg_file__out__read_data_2_32
			;
	Reg_File reg_file(.clk(clock), 
		.RegWrite(reg_file__in__RegWrite),
		.ReadRegister1(reg_file__in__read_addr_1_5),  
		.ReadRegister2( reg_file__in__read_addr_2_5), 
		.WriteReg(reg_file__in__write_addr_2_5),
		.WriteData(reg_file__in__write_data_32),
		.read_data1(reg_file__out__read_data_1_32), 
		.read_data2(reg_file__out__read_data_2_32)
	);

	assign reg_file__in__read_addr_1_5 = if_id__out__ins_32[25:21];
    	assign reg_file__in__read_addr_2_5 = if_id__out__ins_32[20:16];



	wire Fw1;
	wire [31:0] mux_regfile_out_1__out__data_32;
	wire [31:0] ex_mem__out__address_32; 
	MUX221 #(32) mux_regfile_out_1(
		.sel(Fw1),
		.a(reg_file__out__read_data_1_32),
		.b(ex_mem__out__address_32), 
		.out(mux_regfile_out_1__out__data_32)
	);


	wire Fw2;
	wire [31:0] mux_regfile_out_2__out__data_32;
	MUX221 #(32) mux_regfile_out_2(
		.sel(Fw2),
		.a(reg_file__out__read_data_2_32),
		.b(ex_mem__out__address_32), 
		.out(mux_regfile_out_2__out__data_32)
	);

	//wire 	if_equal__out__if_zero;
	If_Equal if_equal(
		.a(mux_regfile_out_1__out__data_32),
		.b(mux_regfile_out_2__out__data_32),
		.IfEqual(if_equal__out__if_zero)
	);

	
	


	assign id_ex__in__RegDst = mux_control_out__out__combined[2];
	assign id_ex__in__MemRead = mux_control_out__out__combined[7];
	assign id_ex__in__MemtoReg = mux_control_out__out__combined[6];
	assign id_ex__in__MemWrite = mux_control_out__out__combined[5];
	assign id_ex__in__ALUSrc = mux_control_out__out__combined[4];
	assign id_ex__in__RegWrite = mux_control_out__out__combined[3];
	assign id_ex__in__ALUOp_2=mux_control_out__out__combined[1:0];

	assign id_ex__in__ReadRegister1_5=reg_file__in__read_addr_1_5;
	assign id_ex__in__ReadRegister2_5=reg_file__in__read_addr_2_5;
	assign id_ex__in__Rt_5=reg_file__in__write_addr_2_5;
	assign id_ex__in__Rd_5=if_id__out__ins_32[15:11];


	
	ID_EX id_ex(.clk(clock), .reset(reset),
	        .RegDst(id_ex__in__RegDst),
		.MemRead(id_ex__in__MemRead),
		.MemtoReg(id_ex__in__MemtoReg),
		.MemWrite(id_ex__in__MemWrite),
		.ALUSrc(id_ex__in__ALUSrc),
		.RegWrite(id_ex__in__RegWrite),
		// input 1:0
		.ALUOp(id_ex__in__ALUOp_2),
		// input 31:0
		.ReadData1(id_ex__in__ReadData1_32),
		.ReadData2(id_ex__in__ReadData2_32),
		.ExtendedIm(id_ex__in__ExtendedIm_32),
		// input 4:0
		.ReadRegister1(id_ex__in__ReadRegister1_5), 
		.ReadRegister2(id_ex__in__ReadRegister2_5),
		.Rt(id_ex__in__Rt_5),
		.Rd(id_ex__in__Rd_5),
		// ouput 
		.RegDstEX(id_ex__out__RegDst),
		.MemReadEX(id_ex__out__MemRead),
		.MemtoRegEX(id_ex__out__MemtoReg),
		.MemWriteEX(id_ex__out__MemWrite),
		.ALUSrcEX(id_ex__out__ALUSrc),
		.RegWriteEX(id_ex__out__RegWrite),
		// ouput 31:0
		.ALUOpEX(id_ex__out__ALUOp_2),
	        .ReadData1EX(id_ex__out__ReadData1_32),
		.ReadData2EX(id_ex__out__ReadData2_32),
	        .ExtendedImEX(id_ex__out__ExtendedIm_32),
		// 4:0
		.ReadRegister1EX(id_ex__out__ReadRegister1_5),
		.ReadRegister2EX(id_ex__out__ReadRegister2_5),
		.RtEX(id_ex__out__Rt_5),
		.RdEX(id_ex__out__Rd_5)
	);




	

	assign mux_regfile_out_1__out__data_32=id_ex__in__ReadData1_32;
	assign mux_regfile_out_2__out__data_32=id_ex__in__ReadData2_32;


	wire [31:0] mux_ex_1__out__data_32;
	wire [1:0] mux_ex_1__sel__ForwadA;

	wire [31:0]	mux_mem_wb_out__out__data_32;

	MUX321 #(32) mux_ex_1(
		.sel(mux_ex_1__sel__ForwadA),
		.a(id_ex__out__ReadData1_32),
		.b(mux_mem_wb_out__out__data_32),
		.c(ex_mem__out__ALUResult_32),
		.out(mux_ex_1__out__data_32)
	);
	wire [1:0] mux_ex_2__sel__ForwadB;
	wire [31:0] mux_ex_2__out__data_32;
	MUX321 #(32) mux_ex_2(
		.sel(mux_ex_2__sel__ForwadB),
		.a(id_ex__out__ReadData2_32),
		.b(mux_mem_wb_out__out__data_32),
		.c(ex_mem__out__ALUResult_32),
		.out(mux_ex_2__out__data_32)
	);

	wire [31:0] mux_ex_3__out__data_32;
	MUX221 #(32) mux_ex_3(
		.sel(mux_ex_3__in__ALUsrc),
		.a(mux_ex_2__out__data_32),
		.b(id_ex__out__ExtendedIm_32),
		.out(mux_ex_3__out__data_32)
	);
	wire mux_ex_4__in__RegDst;
	wire [31:0] mux_ex_4__out__data_32;
	MUX221 #(5) mux_ex_4(
		.sel(mux_ex_4__in__RegDst),
		.a(id_ex__out__ReadRegister1_5),
		.b(id_ex__out__ReadRegister2_5),
		.out(ex_mem__in__RegisterDst)
	);


	wire [3:0] alu__in__alu_control;
	wire [31:0] alu__out__data_32;
	ALU alu(
		.control(alu__in__alu_control),
		.a(mux_ex_1__out__data_32),
		.b(mux_ex_3__out__data_32),
		.result(alu__out__data_32)
	);

	wire [5:0] alu_control__in__funct;
	wire [1:0] alu_control__in__ALUop;
	ALU_Control alu_control(
		.funct(alu_control__in__funct),
		.ALUop(alu_control__in__ALUop),
		.control(alu__in__alu_control)
	);

	// TODO: Forwarding Unit	

	Forwarding forwarding(
		.MEM_WB_RegWrite(mem_wb__out__RegWriteWB) ,
		.EX_MEM_RegWrite(ex_mem__out__RegWrite),
		.bne(control__out__bne),
		.beq(control__out__branch),
//                   input [4:0] 
		.MEM_WB_RegisterRd(mem_wb__out__Rd),
		.ID_EX_RegisterRs(id_ex__out__ReadRegister1_5),
		.EX_MEM_RegisterRd(ex_mem__out__RegisterDst),
		.ID_EX_RegisterRt(id_ex__out__ReadRegister2_5),
		.IF_ID_RegisterRs(reg_file__in__read_addr_1_5),
		.IF_ID_RegisterRt(reg_file__in__read_addr_2_5),
//                  output reg [1:0] 
		.ForwardA(mux_ex_1__sel__ForwadA),
		.ForwardB(mux_ex_2__sel__ForwadB),
//                  output reg  
		.Fw1(Fw1),
		.Fw2(Fw2)
	);



	EX_MEM ex_mem( 
	// 		input
			.clk(clock), .reset(reset),
			.MemRead(ex_mem__in__MemRead),
			.MemtoReg(ex_mem__in__MemtoReg),
			.MemWrite(ex_mem__in__MemWrite),
			.RegWrite(ex_mem__in__RegWrite),
	//              input [31:0] 
			.ALUResultAddr(ex_mem__in__ALUResult_32),
			.DataWriteIn(ex_mem__in__ReadData_32),
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
			.ALUResultAddrM(ex_mem__out__ALUResult_32),
			.DataWriteInM(ex_mem__out__ReadData_32),
	//              output reg [4:0] 
			.ReadRegister1M(ex_mem__out__ReadRegister1), 
			.ReadRegister2M(ex_mem__out__ReadRegister2),
			.RegisterDstM(ex_mem__out__RegisterDst)
	);


	wire	[31:0]	data_mem__out__Data_32;
	Data_Mem data_mem(
	//	input [31:0]
		.address(ex_mem__out__ALUResult_32), 
		.Write_data(ex_mem__out__ReadData_32), 
	//	input 
		.MemWrite(ex_mem__out__MemWrite),
		.MemRead(ex_mem__out__MemRead),
		.clk(clock),
	//	output [31:0]
		.Read_data(data_mem__out__Data_32)
	);






	assign mem_wb__in__RegWrite = ex_mem__out__RegWrite;
	MEM_WB mem_wb(.clk(clock), .reset(reset),
	//              input 
			.MemtoReg(mem_wb__in__MemtoReg),
			.RegWrite(mem_wb__in__RegWrite),
	//              input [31:0] 
			.Data2Write(data_mem__out__Data_32), 
			.ALUResult(ex_mem__out__ALUResult_32),
	//              input [4:0] 
			.RegisterDst(ex_mem__out__RegisterDst),
	//              output reg 
			.MemtoRegWB(mem_wb__out__MemToReg),
			.RegWriteWB(mem_wb__out__RegWriteWB),
	//              output reg [31:0] 
			.Data2WriteWB(mem_wb__out__ReadFromMemory_32), 
			.ALUResultWB(mem_wb__out__ALUResult_32),
	//              output reg [4:0] 
			.RegisterDstWB(mem_wb__out__Rd)
	);



	//wire [31:0]	mux_mem_wb_out__out__data_32;
	MUX221 #(32) mux_mem_wb_out(.sel(mem_wb__out__MemToReg),
		.a(mem_wb__out__ReadFromMemory_32),
		.b(mem_wb__out__ALUResult_32),
		.out(mux_mem_wb_out__out__data_32)
	);

endmodule
