`ifndef __VE370__INSTRUCTION__MEMORY__
`define __VE370__INSTRUCTION__MEMORY__
module instructionMemory(
    input [31:0] readAddress,
    output reg [31:0] instruction
);

wire [31:0] memoryIndex;
assign memoryIndex = readAddress >> 2;

reg [31:0] memory[0:29];

initial begin
    memory[0] = 32'b00100000000010000000000000100000; //addi $t0, $zero, 0x20
    memory[1] = 32'b00100000000010010000000000110111; //addi $t1, $zero, 0x37
    memory[2] = 32'b00000001000010011000000000100100; //and $s0, $t0, $t1
    memory[3] = 32'b00000001000010011000000000100101; //or $s0, $t0, $t1
    memory[4] = 32'b10101100000100000000000000000100; //sw $s0, 4($zero)
    memory[5] = 32'b10101100000010000000000000001000; //sw $t0, 8($zero)
    memory[6] = 32'b00000001000010011000100000100000; //add $s1, $t0, $t1
    memory[7] = 32'b00000001000010011001000000100010; //sub $s2, $t0, $t1
    memory[8] = 32'b00010010001100100000000000001001; //beq $s1, $s2, error0
    memory[9] = 32'b10001100000100010000000000000100; //lw $s1, 4($zero)
    memory[10]= 32'b00110010001100100000000001001000; //andi $s2, $s1, 0x48
    memory[11] =32'b00010010001100100000000000001001; //beq $s1, $s2, error1
    memory[12] =32'b10001100000100110000000000001000; //lw $s3, 8($zero)
    memory[13] =32'b00010010000100110000000000001010; //beq $s0, $s3, error2
    memory[14] =32'b00000010010100011010000000101010; //slt $s4, $s2, $s1 (Last)
    memory[15] =32'b00010010100000000000000000001111; //beq $s4, $0, EXIT
    memory[16] =32'b00000010001000001001000000100000; //add $s2, $s1, $0
    memory[17] =32'b00001000000000000000000000001110; //j Last
    memory[18] =32'b00100000000010000000000000000000; //addi $t0, $0, 0(error0)
    memory[19] =32'b00100000000010010000000000000000; //addi $t1, $0, 0
    memory[20] =32'b00001000000000000000000000011111; //j EXIT
    memory[21] =32'b00100000000010000000000000000001; //addi $t0, $0, 1(error1)
    memory[22] =32'b00100000000010010000000000000001; //addi $t1, $0, 1
    memory[23] =32'b00001000000000000000000000011111; //j EXIT
    memory[24] =32'b00100000000010000000000000000010; //addi $t0, $0, 2(error2)
    memory[25] =32'b00100000000010010000000000000010; //addi $t1, $0, 2
    memory[26] =32'b00001000000000000000000000011111; //j EXIT
    memory[27] =32'b00100000000010000000000000000011; //addi $t0, $0, 3(error3)
    memory[28] =32'b00100000000010010000000000000011; //addi $t1, $0, 3
    memory[29] =32'b00001000000000000000000000011111; //j EXIT
end
always @(*) begin
    instruction = memory[memoryIndex];
end

endmodule // instructionMemory
`endif