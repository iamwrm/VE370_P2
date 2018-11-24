`ifndef __VE370__CONTROL__
`define __VE370__CONTROL__
module control(
    input [5:0] opcode,
    output reg RegDst, Jump, Brancheq, Branchne, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
    output reg [1:0] aluop
);

initial begin
    RegDst = 1'b0;
    Jump = 1'b0;
    Brancheq = 1'b0;
    Branchne = 1'b0;
    MemRead = 1'b0;
    MemtoReg = 1'b0;
    MemWrite = 1'b0;
    ALUSrc = 1'b0;
    RegWrite = 1'b0;
    aluop = 2'b00;
end

always @(opcode) begin
    case (opcode) 
        6'b100011: begin //lw
            RegDst = 1'b0;
            Jump = 1'b0;
            Brancheq = 1'b0;
            Branchne = 1'b0;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
            aluop = 2'b00;
        end
        6'b101011: begin //sw
            RegDst = 1'b0;
            Jump = 1'b0;
            Brancheq = 1'b0;
            Branchne = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
            RegWrite = 1'b0;
            aluop = 2'b00;
        end
        6'b000000: begin //R-type
            RegDst = 1'b1;
            Jump = 1'b0;
            Brancheq = 1'b0;
            Branchne = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b1;
            aluop = 2'b10;
        end
        6'b001000: begin //addi
            RegDst = 1'b0;
            Jump = 1'b0;
            Brancheq = 1'b0;
            Branchne = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
            aluop = 2'b00;
        end
        6'b001100: begin //andi
            RegDst = 1'b0;
            Jump = 1'b0;
            Brancheq = 1'b0;
            Branchne = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
            aluop = 2'b11;
        end
        6'b000100: begin //beq
            RegDst = 1'b1;
            Jump = 1'b0;
            Brancheq = 1'b1;
            Branchne = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
            aluop = 2'b01;
        end
        6'b000101: begin //bne  
            RegDst = 1'b1;
            Jump = 1'b0;
            Brancheq = 1'b0;
            Branchne = 1'b1;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b0;
            aluop = 2'b01;
        end
        6'b000010: begin //jump
            RegDst = 1'b1;
            Jump = 1'b1;
            Brancheq = 1'b0;
            Branchne = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
            aluop = 2'b10;
        end
        default: begin
            RegDst = 1'b0;
            Jump = 1'b0;
            Brancheq = 1'b0;
            Branchne = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
            aluop = 2'b00;
        end
    endcase
end

endmodule // control
`endif