`timescale 1ns / 1ps


`include "PC.v"
`include "Instruction_Mem.v"
`include "IF_ID.v"
`include "Hazard.v"
`include "Reg_File.v"


module pipeline(
	input clock,
	input reset,
	input [4:0] register_switch, 
	output [31:0] pc_out, 
	reg [31:0] register_out);




	wire [31:0] next;
	wire [31:0] pc_out_address;
	// module PC( input clock,
        //    input reset,
        //    input [31:0] next,
        //    output reg [31:0] address);
	PC pc(clock, reset, next, pc_out_address);


	wire [31:0] ins_mem__ins_out;
	// module Instruction_Mem(input [31:0] addr, 
        //                output wire [31:0]out_Instr);
	Instruction_Mem ins_mem(pc_out_address,
				ins_mem__ins_out);


	wire [31:0] if_id__addr_in, if_id__addr_out, if_id__ins_out;
	// module IF_ID(input clk,reset,
        //      input [31:0] Instr, Addr,
        //      output reg [31:0] out_Instr, out_Addr);
	IF_ID if_id(clock,reset
		ins_mem__ins_out,if_id__addr_in,
		if_id__ins_out,if_id__addr_out);


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
	Reg_File reg_file(clock,RegWrite,
		read_register_1_addr, read_register_2_addr, write_register_addr,
		write_data,
		read_data_1, read_data_2);

	



	

	















endmodule
