`include "mux2_32to1.v"

module mux3_32to1(out,sel,in1,in2,in3);
  input [31:0] in1,in2,in3;
  output [31:0] out;
  input [1:0] sel;
  wire [31:0] temp1;
  bi32_2to1mux m1(temp1,sel[0],in1,in2);
  bi32_2to1mux m2(out,sel[1],temp1,in3);
endmodule

// module tb_32bit2to1mux;
// reg [31:0] INP1, INP2,INP3;
// reg [1:0] SEL;
// wire [31:0] out;
// mux3_32to1 M1(out,SEL,INP1,INP2,INP3);
// initial begin
// $monitor($time," out=%b sel= %b inp1=%b inp2=%b inp3=&b  \n",out,SEL,INP1,INP2,INP3);
//     end
// initial
// begin
// INP1 = 32'b00000000000000000000000000000000;
// INP2 = 32'b11111111111111111111111111111111;
// INP3 = 32'b10000000000000111111111111111111;

// SEL=2'b01;
// // $monitor($time," out=%b sel= %b inp1=%b inp2=%b\n",out,SEL,INP1,INP2);
// #100 SEL=2'b10;
// #500 SEL=2'b00;
// // $monitor($time," out=%b sel= %b inp1=%b inp2=%b\n",out,SEL,INP1,INP2);
// #1000 $finish;
// end
// endmodule 