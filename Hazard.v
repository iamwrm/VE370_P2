`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/20 10:48:54
// Design Name: 
// Module Name: Hazard
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


module Hazard( input ID_EX_MemRead,EX_MEM_MemRead,clk,jump,bne,beq,IfEqual,
               input [4:0] ID_EX_RegisterRt,IF_ID_RegisterRs, IF_ID_RegisterRt,EX_MEM_RegisterRt,
               output PC_Hold,IF_ID_Hold,ID_EX_Flush,IF_Flush);
               
//     always @(*)
//               begin
//               if(PC_Hold && (jump||(bne&&IfEqual==1'b0)||(beq&&IfEqual==1'b1)))
//               IF_Flush<=1'b1;
//               else
//               IF_Flush<=1'b0;
//               end
               
//     always@(*)          
//               begin
//               if(
//               ((ID_EX_MemRead==1'b1)&&((ID_EX_RegisterRt==IF_ID_RegisterRs)
//               ||(ID_EX_RegisterRt==IF_ID_RegisterRt)))
//               || (ID_EX_MemRead==1'b1 &&(beq || bne) && ((ID_EX_RegisterRt==IF_ID_RegisterRs)
//               ||(ID_EX_RegisterRt==IF_ID_RegisterRt)))
//               ||(EX_MEM_MemRead && (beq ||bne) && ((EX_MEM_RegisterRt==IF_ID_RegisterRs)
//               ||(EX_MEM_RegisterRt==IF_ID_RegisterRt)))
//               ///////////////////////////////Lack//////////////////////////////////
//               )
//               begin
//               ID_EX_Flush<=1'b1;
//               PC_Hold<=1'b1;
//               IF_ID_Hold<=1'b1;
//               end
//               else
//               begin
//               ID_EX_Flush<=1'b0;
//               PC_Hold<=1'b0;
//               IF_ID_Hold<=1'b0;
//               end
//               end
               assign PC_Hold=(
                              ((ID_EX_MemRead==1'b1)&&((ID_EX_RegisterRt==IF_ID_RegisterRs)
                              ||(ID_EX_RegisterRt==IF_ID_RegisterRt)))
                              || ((beq || bne) && ID_EX_MemRead==1'b1 && ((ID_EX_RegisterRt==IF_ID_RegisterRs)
                              ||(ID_EX_RegisterRt==IF_ID_RegisterRt)))
                              ||((beq ||bne) &&  EX_MEM_MemRead && ((EX_MEM_RegisterRt==IF_ID_RegisterRs)
                              ||(EX_MEM_RegisterRt==IF_ID_RegisterRt)))
                              ///////////////////////////////Lack//////////////////////////////////
                              )? 1:0;
                              assign ID_EX_Flush=PC_Hold;
                              assign IF_ID_Hold=PC_Hold;
                              assign IF_Flush=(PC_Hold && (jump||(bne&&IfEqual==1'b0)||(beq&&IfEqual==1'b1)))?1:0;
endmodule
