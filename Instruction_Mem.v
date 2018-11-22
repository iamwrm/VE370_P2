`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 13:44:00
// Design Name: 
// Module Name: Instruction_Mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Instruction_Mem(input [31:0] addr, 
                       output wire [31:0]out_Instr);
                      
wire [31:0] memory[0:31];
wire [31:0] A;
assign A=addr>>2;
assign out_Instr = memory[A];

/* assign memory[0] = 32'b00100000000010000000000000100000; //addi $t0, $zero, 0x20
assign memory[1] = 32'b00100000000010010000000000100111; //addi $t1, $zero, 0x27
assign memory[2] = 32'b00000001000010011000000000100100; //and $s0, $t0, $t1
assign memory[3] = 32'b00000001000010011000000000100101; //or $s0, $t0, $t1
assign memory[4] = 32'b10101100000100000000000000000100; //sw $s0, 4($zero)
assign memory[5] = 32'b10101100000010000000000000001000; //sw $t0, 8($zero)
assign memory[6] = 32'b00000001000010011000100000100000; //add $s1, $t0, $t1
assign memory[7] = 32'b00000001000010011001000000100010; //sub $s2, $t0, $t1
assign memory[8] = 32'b00010010001100100000000000001001; //beq $s1, $s2, error0
assign memory[9] = 32'b10001100000100010000000000000100; //lw $s1, 4($zero)
assign memory[10]= 32'b00110010001100100000000000011000; //andi $s2, $s1, 0x18
assign memory[11] =32'b00010010001100100000000000001001; //beq $s1, $s2, error1
assign memory[12] =32'b10001100000100110000000000001000; //lw $s3, 8($zero)
assign memory[13] =32'b00010010000100110000000000001010; //beq $s0, $s3, error2
assign memory[14] =32'b00000010010100011010000000101010; //slt $s4, $s2, $s1 (Last)
assign memory[15] =32'b00010010100000000000000000001111; //beq $s4, $0, EXIT
assign memory[16] =32'b00000010001000001001000000100000; //add $s2, $s1, $0
assign memory[17] =32'b00001000000000000000000000001110; //j Last
assign memory[18] =32'b00100000000010000000000000000000; //addi $t0, $0, 0(error0)
assign memory[19] =32'b00100000000010010000000000000000; //addi $t1, $0, 0
assign memory[20] =32'b00001000000000000000000000011111; //j EXIT
assign memory[21] =32'b00100000000010000000000000000001; //addi $t0, $0, 1(error1)
assign memory[22] =32'b00100000000010010000000000000001; //addi $t1, $0, 1
assign memory[23] =32'b00001000000000000000000000011111; //j EXIT
assign memory[24] =32'b00100000000010000000000000000010; //addi $t0, $0, 2(error2)
assign memory[25] =32'b00100000000010010000000000000010; //addi $t1, $0, 2
assign memory[26] =32'b00001000000000000000000000011111; //j EXIT
assign memory[27] =32'b00100000000010000000000000000011; //addi $t0, $0, 3(error3)
assign memory[28] =32'b00100000000010010000000000000011; //addi $t1, $0, 3
assign memory[29] =32'b00001000000000000000000000011111; //j EXIT */

assign  memory[0] = 32'b00100000000010000000000000100000; //addi $t0, $zero, 0x20
assign    memory[1] = 32'b00100000000010010000000000110111; //addi $t1, $zero, 0x37
assign    memory[2] = 32'b00000001000010011000000000100100; //and $s0, $t0, $t1
assign    memory[3] = 32'b00000001000010011000000000100101; //or $s0, $t0, $t1
assign    memory[4] = 32'b10101100000100000000000000000100; //sw $s0, 4($zero)
assign    memory[5] = 32'b10101100000010000000000000001000; //sw $t0, 8($zero)
assign    memory[6] = 32'b00000001000010011000100000100000; //add $s1, $t0, $t1
assign    memory[7] = 32'b00000001000010011001000000100010; //sub $s2, $t0, $t1
assign    memory[8] = 32'b00010010001100100000000000001001; //beq $s1, $s2, error0
assign    memory[9] = 32'b10001100000100010000000000000100; //lw $s1, 4($zero)
assign    memory[10]= 32'b00110010001100100000000001001000; //andi $s2, $s1, 0x48
assign    memory[11] =32'b00010010001100100000000000001001; //beq $s1, $s2, error1
assign    memory[12] =32'b10001100000100110000000000001000; //lw $s3, 8($zero)
assign    memory[13] =32'b00010010000100110000000000001010; //beq $s0, $s3, error2
assign    memory[14] =32'b00000010010100011010000000101010; //slt $s4, $s2, $s1 (Last)
assign    memory[15] =32'b00010010100000000000000000001111; //beq $s4, $0, EXIT
assign    memory[16] =32'b00000010001000001001000000100000; //add $s2, $s1, $0
assign    memory[17] =32'b00001000000000000000000000001110; //j Last
assign    memory[18] =32'b00100000000010000000000000000000; //addi $t0, $0, 0(error0)
assign    memory[19] =32'b00100000000010010000000000000000; //addi $t1, $0, 0
assign    memory[20] =32'b00001000000000000000000000011111; //j EXIT
assign    memory[21] =32'b00100000000010000000000000000001; //addi $t0, $0, 1(error1)
assign    memory[22] =32'b00100000000010010000000000000001; //addi $t1, $0, 1
assign    memory[23] =32'b00001000000000000000000000011111; //j EXIT
assign    memory[24] =32'b00100000000010000000000000000010; //addi $t0, $0, 2(error2)
assign    memory[25] =32'b00100000000010010000000000000010; //addi $t1, $0, 2
assign    memory[26] =32'b00001000000000000000000000011111; //j EXIT
assign    memory[27] =32'b00100000000010000000000000000011; //addi $t0, $0, 3(error3)
assign    memory[28] =32'b00100000000010010000000000000011; //addi $t1, $0, 3
assign    memory[29] =32'b00001000000000000000000000011111; //j EXIT

endmodule
