module d_ff(input clk,input d,input reset,input set,output reg q);
 always @(posedge clk)begin
    case({reset,set})
       2'b00 : q<=d;
       2'b01 : q<=1'b1;
       2'b10 : q<=1'b0;
       2'b00 : q<=1'bz;
    endcase
 end
endmodule
module Tff(input clk,input T,input reset,output reg q);
 initial
  q<=1'b0;
 always@(posedge clk)begin
    if(reset)
     q<=1'b0;
    else begin
        if(T)
         q<=~q;
        else
         q<=q;
      end
 end
endmodule
module COUNTER_4BIT(input CLK,input clear,output reg [0:3] q,input en);
    wire [0:3] t;
    assign t[0]=1'b1;
    assign t[1]=q[0];
    and(t[2],q[0],q[1]);
    and(t[3],q[2],t[2]);
    wire clk;
    and(clk,en,CLK);
    Tff t1(clk,t[0],clear,q[0]);
    Tff t2(clk,t[1],clear,q[1]);
    Tff t3(clk,t[2],clear,q[2]);
    Tff t4(clk,t[3],clear,q[3]);

endmodule
module ctrlLogic(
	output t0,
	output t1,
	output t2,
	input clk,
	input s,
	input z,
	input x,
	input set
);
	// reg t0;
	// initial 
	// 	t0 = 1'b1;
	wire sbar, zbar, xbar;
	wire t0and1, t0and2, t0or1;
	wire t1and1, t1and2, t1and3, t1or1, t1or2;
	wire t2and1, t2and2, t2or1;
	
	not(sbar,s);
	not(zbar,z);
	not(xbar,x);

	and(t0and1, t0, sbar);
	and(t0and2, t2, z);
	or(t0or1, t0and1, t0and2);

	and(t1and1, t0, s);
	and(t1and2, t2, xbar, zbar);
	and(t1and3, t1, xbar);
	or(t1or1, t1and1, t1and2);
	or(t1or2, t1or1, t1and3);

	and(t2and1, t1, x);
	and(t2and2, t2, x, zbar);
	or(t2or1, t2and1, t2and2);
		
	d_ff ff1(clk,t0or1,clk, 1'b0, set);
	d_ff ff2(t1,t1or2,clk, 1'b0, 1'b0);
	d_ff ff3(t2,t2or1,clk, 1'b0, 1'b0);

endmodule

module INTG(input clk,input S,input xx,output [0:3] q,output G,input set);
wire zz;
wire [0:2] t;
  COUNTER_4BIT c(clk,t[0]&S,q,(t[1]&X)|(t[2]&~zz&xx));
  and(zz,q[0],q[1],q[2],q[3]);
  ctrlLogic cl(t[0],t[1],t[2],clk,S,zz,xx,set);
  d_ff d(clk,t[2]&zz,1'b0,set,G);
endmodule