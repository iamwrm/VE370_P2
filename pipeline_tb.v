`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   21:34:58 11/21/2017
// Design Name:   pipeline
// Module Name:   /home/liu/VE370/p2/pipeline_tb.v
// Project Name:  p2
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: pipeline
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

`include "pipeline.v"

module pipeline_tb;

    integer i = 0;

	// Inputs
	reg clk;

	// Instantiate the Unit Under Test (UUT)
	Pipeline uut (
		.clock(clk)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
        $dumpfile("pipeline.vcd");
        $dumpvars(1, uut);
        $display("Texual result of pipeline:");
        $display("==========================================================");
        #600;
        $stop;
	end

	//wire [31:0] 	pc__out__address_32;
    always #10 begin
        $display("Time: %d, CLK = %d, PC = 0x%H", i, clk, uut.pc__out__address_32);
        // 
        $display("ins_mem_out: %d, ins_mem_in = %d, \ncontrol out combined = 0x%H", uut.ins_mem__out__ins_32, uut.pc__out__address_32, uut.control__out__combined);
         $display("%d,  %d, 0x%H", 
         uut.reg_file__in__write_data_32, uut.reg_file__in__write_addr_2_5, uut.id_ex__in__ExtendedIm_32);
        // $display("%d,  %d, 0x%H", 
        // uut.if_id__out__ins_32, uut.mux_pc_in_2__out_32, uut.jump_address__out__data_32);
        $display("[$s0] = 0x%H, [$s1] = 0x%H, [$s2] = 0x%H", uut.reg_file.registers[16],uut.reg_file.registers[17], uut.reg_file.registers[18]);
        $display("[$s3] = 0x%H, [$s4] = 0x%H, [$s5] = 0x%H", uut.reg_file.registers[19], uut.reg_file.registers[20], uut.reg_file.registers[21]);
        $display("[$s6] = 0x%H, [$s7] = 0x%H, [$t0] = 0x%H", uut.reg_file.registers[22], uut.reg_file.registers[23], uut.reg_file.registers[8]);
        $display("[$t1] = 0x%H, [$t2] = 0x%H, [$t3] = 0x%H", uut.reg_file.registers[9], uut.reg_file.registers[10], uut.reg_file.registers[11]);
        $display("----------------------------------------------------------");
        clk = ~clk;
        if (~clk) i = i + 1;
    end



endmodule
