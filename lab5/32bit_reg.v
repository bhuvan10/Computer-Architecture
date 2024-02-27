`include "d_ff.v"
module reg_32bit(q,d,clk,reset); 
  output [31:0] q;
        input [31:0] d;
        input clk;
        input reset;
    genvar num;

        generate for (num = 0 ; num < 32 ; num = num + 1) begin: ffs
                dff d( q[num],d[num], clk, reset );
            end
        endgenerate
endmodule

module tb32reg;
reg [31:0] d;
reg clk,reset;
wire [31:0] q;
reg_32bit R(q,d,clk,reset);
always @(clk)
#5 clk<=~clk;
initial begin
    $monitor("%b %b %b %b",q,d,clk,reset);
end
initial
begin
clk= 1'b1;
reset=1'b0;//reset the register
#20 reset=1'b1;
#20 d=32'hAFAFAFAF;
#200 $finish;
end
endmodule