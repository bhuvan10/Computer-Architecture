`include "encoder.v"
`include "Alu.v"
`include "parity.v"
module pipeline(input [7:0] inst,input [3:0] A,input [3:0] B,output [3:0] Aluout,output parity);
   wire [2:0] opcode;
   encd e(inst,opcode);
   alu a(A,B,Aluout,opcode);
   even_parity ep(Aluout,parity);
endmodule