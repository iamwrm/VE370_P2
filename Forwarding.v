`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/20 10:04:06
// Design Name: 
// Module Name: Forwarding
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


module Forwarding(input  MEM_WB_RegWrite ,EX_MEM_RegWrite,bne,beq,

                  input [4:0] MEM_WB_RegisterRd,ID_EX_RegisterRs
                             ,EX_MEM_RegisterRd,ID_EX_RegisterRt
                             ,IF_ID_RegisterRs,IF_ID_RegisterRt,
                 output reg [1:0] ForwardA,ForwardB,
                 output reg  Fw1,Fw2
                 );
                 
               initial begin 
               ForwardA=2'b00;
               ForwardB=2'b00;
               Fw1=1'b0;
               Fw2=1'b0;
               end  
               
                 always @(*)
                 begin
                 if(((EX_MEM_RegWrite) && (EX_MEM_RegisterRd))
                  && (EX_MEM_RegisterRd==ID_EX_RegisterRs)) ForwardA= 2'b10;
                 else if((((MEM_WB_RegWrite) && (MEM_WB_RegisterRd))
                  && (MEM_WB_RegisterRd==ID_EX_RegisterRs))&& !(((EX_MEM_RegWrite)
                  && (EX_MEM_RegisterRd))&& (EX_MEM_RegisterRd==ID_EX_RegisterRs))) 
                 ForwardA= 2'b01;
                 else ForwardA<= 2'b00;
                 end
                 
                 always @(*)
                 begin
                 if(((EX_MEM_RegWrite) && (EX_MEM_RegisterRd))
                 && (EX_MEM_RegisterRd==ID_EX_RegisterRt)) ForwardB= 2'b10;
                 else if((((MEM_WB_RegWrite) && (MEM_WB_RegisterRd))
                 && (MEM_WB_RegisterRd==ID_EX_RegisterRt)) && !(((EX_MEM_RegWrite) 
                 && (EX_MEM_RegisterRd))
                 && (EX_MEM_RegisterRd==ID_EX_RegisterRt)))
                 ForwardB= 2'b01;
                 else ForwardB<= 2'b00;
                 end
                 
                  always @(*)
                  begin  
                  if(EX_MEM_RegisterRd && EX_MEM_RegWrite &&(bne|| beq)
                  && (EX_MEM_RegisterRd==IF_ID_RegisterRs)) Fw1= 1'b1;
                  else Fw1=1'b0;
                  end 
                  
                   always @(*)
                   begin  
                   if(EX_MEM_RegisterRd && EX_MEM_RegWrite &(bne||beq)
                   && (EX_MEM_RegisterRd==IF_ID_RegisterRt)) Fw2= 1'b1;
                   else Fw2=1'b0;
                   end 
                 
               
endmodule
