module DECODER(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
input x,y,z;
output d0,d1,d2,d3,d4,d5,d6,d7;
wire x0,y0,z0;
not n1(x0,x);
not n2(y0,y);
not n3(z0,z);
and a0(d0,x0,y0,z0);
and a1(d1,x0,y0,z);
and a2(d2,x0,y,z0);
and a3(d3,x0,y,z);
and a4(d4,x,y0,z0);
and a5(d5,x,y0,z);
and a6(d6,x,y,z0);
and a7(d7,x,y,z);
endmodule
module FADDER(s,c,x,y,z);
input x,y,z;
wire d0,d1,d2,d3,d4,d5,d6,d7;
output s,c;
DECODER dec(d0,d1,d2,d3,d4,d5,d6,d7,x,y,z);
assign s = d1 | d2 | d4 | d7,
c = d3 | d5 | d6 | d7;
endmodule
module adder8bit(x,y,cout,sum);
input [0:7] x;
input [0:7] y;
output cout;
output [0:7]sum;
FADDER f1(sum[0],cout,x[0],y[0],1'b0);
FADDER f2(sum[1],cout,x[1],y[1],cout);
FADDER f3(sum[2],cout,x[2],y[2],cout);
FADDER f4(sum[3],cout,x[3],y[3],cout);
FADDER f5(sum[4],cout,x[4],y[4],cout);
FADDER f6(sum[5],cout,x[5],y[5],cout);
FADDER f7(sum[6],cout,x[6],y[6],cout);
FADDER f8(sum[7],cout,x[7],y[7],cout);

endmodule
module testbench;
reg [0:7]x;reg [0:7]y;
wire [0:7]s;wire c;
adder8bit fl(x,y,c,s);
initial
$monitor(,$time,"x=%b | y=%b | s=%b | c=%b",x,y,s,c);
initial
begin
#0 x=8'b00000011;y=8'b00000010;
end
endmodule