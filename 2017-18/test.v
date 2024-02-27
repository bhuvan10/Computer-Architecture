module MUX_SMALL(input A,input B,input S,output Op);
  assign Op=(S)? A:B;
endmodule

module MUX_BIG(input [0:7] A,input [0:2] S,output Op);
   assign Op= (S[2])?(S[1]?(S[0]?A[7]:A[6]):(S[0]?A[5]:A[4])):(S[1]?(S[0]?A[3]:A[2]):(S[0]?A[1]:A[0]));
endmodule
module TFF(input clk,input clear,input T,output reg  q);
 initial
  q=1'b0;
 always@(posedge clk)begin
    if(clear)
     q<=1'b0;
    else begin
        if(T)
         q<=~q;
        else
         q<=q;
      end
 end
endmodule


module COUNTER_4BIT(input clk,input clear,output  [0:3] q);
    wire [0:3] t;
    assign t[0]=1'b1;
    assign t[1]=q[0];
    and(t[2],q[0],q[1]);
    and(t[3],q[2],t[2]);
    TFF t1(clk,t[0],clear,q[0]);
    TFF t2(clk,t[1],clear,q[1]);
    TFF t3(clk,t[2],clear,q[2]);
    TFF t4(clk,t[3],clear,q[3]);

endmodule

module COUNTER_3BIT(input clk,input clear,output  [0:2] q);
    wire [0:2] t;
    assign t[0]=1'b0;
    assign t[1]=q[0];
    and(t[2],q[0],q[1]);
    TFF tt1(clk,clear,t[0],q[0]);
    TFF tt2(clk,clear,t[1],q[1]);
    TFF tt3(clk,clear,t[2],q[2]);
endmodule

module MEMORY(input [0:3] A,output reg [0:7] D);
  reg [0:7] memory [0:15];
  initial begin
    memory[0]= 8'hcc;
    memory[1]= 8'haa;
    memory[2]= 8'hcc;
    memory[3]= 8'haa;
    memory[4]= 8'hcc;
    memory[5]= 8'haa;
    memory[6]= 8'hcc;
    memory[7]= 8'haa;
    memory[8]= 8'hcc;
    memory[9]= 8'haa;
    memory[10]= 8'hcc;
    memory[11]= 8'haa;
    memory[12]= 8'hcc;
    memory[13]= 8'haa;
    memory[14]= 8'hcc;
    memory[15]= 8'haa;

  end
  always @(A) begin
     case (A)
      4'd0 : D=memory[0];
      4'd1 : D=memory[1];
      4'd2 : D=memory[2] ;
      4'd3: D=memory[3];
      4'd4 : D=memory[4];
      4'd5 : D=memory[5];
      4'd6 : D=memory[6];
      4'd7 : D=memory[7];
      4'd8 : D=memory[8];
      4'd9 : D=memory[9];
      4'd10 : D=memory[10];
      4'd11 : D=memory[11];
      4'd12 : D=memory[12];
      4'd13 : D=memory[13];
      4'd14 : D=memory[14];
      4'd15 : D=memory[15];
     endcase
  end
endmodule

module INTG(input clear,input clk1,output Op);
 wire [0:2] q;
 COUNTER_3BIT c1(clk1,clear,q);
 wire clk2;
 and(clk2,q[0],q[1],q[2]);
 wire [0:3] Q;
 COUNTER_4BIT c2(clk2,clear,Q);
 wire [0:7]D;
 MEMORY m(Q,D);
 MUX_BIG mu(D,q,Op);
endmodule

module testbench;
 initial begin
        $dumpfile("tb_intg.vcd");
        $dumpvars;
    end
 reg clk,clear;
 wire op;
 INTG intg(clear,clk,op);
 initial clk=1'b0;

 initial begin
       clear=1'b1;
    #1 clear=1'b0;
    #1000 $finish;
 end
 always
 #0.5 clk=~clk;
initial
 $monitor("clk : %b, clear : %b, output : %b\n",clk,clear,op);
endmodule
