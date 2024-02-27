module REG_8bit(reg_out,num_in,clk,reset);
 output reg [7:0] reg_out;
 input clk,reset;
 input [7:0] num_in;
 always @(posedge clk) begin
    if(reset)
     reg_out<=8'd0;
    else
     reg_out<=num_in;
 end
endmodule

module EXPANSION_BOX(in,out);
 input [7:0] in;
 output [7:0] out;
 assign out[7]=in[3];
 assign out[6]=in[0];
 assign out[5]=in[1];
 assign out[4]=in[2];
 assign out[3]=in[1];
 assign out[2]=in[3];
 assign out[1]=in[2];
 assign out[0]=in[0];
endmodule

module XOR_8BIT(xout_8,xin1_8,xin2_8);
   input [7:0] xin1_8,xin2_8;
   output [7:0] xout_8;
   assign xout_8=xin1_8^xin2_8;
endmodule

module CONCAT(concat_out,concat_in1,concat_in2);
 input [3:0] concat_in1,concat_in2;
 output [7:0] concat_out;
 assign concat_out={concat_in1,concat_in2};
endmodule

module fadder(input [3:0] A,input [3:0] B,output [3:0] sum,output cout,input cin);
  assign {cout,sum} = A+B+cin;
endmodule

module CSA_4BIT(input cin,input [3:0] inA,input [3:0] inB,output cout,output [3:0] out);
      
      fadder f1(inA,inB,out,cout,cin);
endmodule

module ENCRYPT(number,key,clk,reset,enc_number);
  input [7:0] number,key;
  input clk,reset;
  output [7:0] enc_number;
  wire [7:0] reg_number,reg_key,exp_d,xor_result;
  wire [3:0] csa_res;
  wire cout;
  REG_8bit r1(reg_number,number,clk,reset);
  REG_8bit r2(reg_key,key,clk,reset);
  EXPANSION_BOX e(reg_number[7:0],exp_d);
  XOR_8BIT xo(xor_result,exp_d,reg_key);
  CSA_4BIT c(reg_key[0],xor_result[7:4],xor_result[3:0],cout,csa_res);
  CONCAT cn(enc_number,csa_res,reg_number[3:0]);
endmodule

module test;

  initial $monitor("number = %b ,key = %b ,reset = %b, result = %b",number,key,reset,enc_number);
  initial
begin
reset=1'b0;
clk=0;
end
reg [7:0] number,key;
reg clk,reset;
wire [7:0] enc_number;
ENCRYPT en(number,key,clk,reset,enc_number);
always #0.5 clk=~clk;
 initial begin

    #1 number=8'b0100_0110;key = 8'b1001_0011;
    #2 number=8'b1100_1001;key = 8'b1010_1100;
    #3 number=8'b1010_0101;key = 8'b0101_1010;
    #4 number=8'b1111_0000;key = 8'b1011_0001;
    #5 reset=1'b1;
    #5 $finish;
 end
endmodule