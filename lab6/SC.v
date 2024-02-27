`include "im.v"
`include "CU.v"
`include "regfile.v"
module reg5bit(input [4:0] ip,input clk,ouput [4:0] op);
 always @(posedge clk)
  op=ip;
endmodule
module SCDataPath();
 reg clk;
 reg [4:0] pc;
 reg5bit p(5b'0,clk,pc);
endmodule

module TestBench;
wire [31:0] ALU_output;
reg [31:0] PC;
reg reset,clk;
SCDataPath SCDP(ALU_output,PC,reset,clk);
initial
begin
$monitor("at time %0d IPC = %d, Reset = %d , CLK = %d ,
ALU Output = %d",$time,start_pc,rst,clk, ALU_output);
#0 clk = 0; PC = 5;
#120 rst = 1;
#400 $stop;
end
always
begin
#20 clk = ~clk;
end
endmodule