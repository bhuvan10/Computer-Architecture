`include "32bitor.v"
`include "32bitand.v"
`include "32bitadder.v"
 `include "mux3_32to1.v"
module ALU(a,b,Binvert,Carryin,Operation,Result,CarryOut);
 input [31:0] a,b;
 input Binvert,Carryin;
 output [31:0] Result;
 input [1:0] Operation;
 output CarryOut;
 wire [31:0] or_res,and_res,add_res,addsub_res,b_temp,b_neg;
 assign b_neg=~b;
 bi32_2to1mux f1(b_temp,Binvert,b,b_neg);
 bit32OR f2(or_res,a,b);
 bit32AND f3(and_res,a,b);
 FA_dataflow f4(temp1,addsub_res,a,b,Carryin);
 mux3_32to1 f5(Result,Operation,and_res,or_res,addsub_res);
endmodule
module tbALU();
reg Binvert, Carryin;
reg [1:0] Operation;
reg [31:0] a,b;
wire [31:0] Result;
wire CarryOut;
ALU f6(a,b,Binvert,Carryin,Operation,Result,CarryOut);
initial begin
    $monitor("%b %b %b %b %b %b %b",a,b,Binvert,Carryin,Operation,Result,CarryOut);
end
initial
begin
a=32'ha5a5a5a5;
b=32'h5a5a5a5a;
Operation=2'b00;
Binvert=1'b0;
Carryin=1'b0; //must perform AND resulting in zero
#100 Operation=2'b01; //OR
#100 Operation=2'b10; //ADD
#100 Binvert=1'b1;//SUB
#200 $finish;
end
endmodule