
module MUX_2x1(input [0:1] ip,input select,output op);
 assign op =(select) ?  ip[1] : ip[0];
endmodule

module MUX_8x1(input [0:7] inp,input [0:2] select,output op);
    wire temp1,temp2,temp3,temp4,temp5,temp6,temp7;
    MUX_2x1 m1(inp[0:1],select[0],temp1);
    MUX_2x1 m2(inp[2:3],select[0],temp2);
    MUX_2x1 m3(inp[4:5],select[0],temp3);
    MUX_2x1 m4(inp[6:7],select[0],temp4);
    MUX_2x1 m5({temp1,temp2},select[1],temp5);
    MUX_2x1 m6({temp3,temp4},select[1],temp6);
    MUX_2x1 m7({temp5,temp6},select[2],temp1);
endmodule

module MUX_ARRAY(input [7:0] C,input [7:0] G,output [7:0] E);
 genvar j;
 generate
    for(j=0;j<8;j=j+1) begin
        MUX_2x1 m({C[j],1'b0},G[j],E[j]);
    end
 endgenerate
endmodule
module COUNTER_3BIT(input clear,output reg [2:0] Q,input clk);
   always @(posedge clk)
   begin
    if(clear)
     Q<=3'b000;
    else
     Q<=Q+1;
   end
endmodule
module DECODER(input [0:2] A,output reg [0:7] B);
  
    always@(A) begin
        case(A) 
				
				3'd0 : B = 8'b0000_0001;
				3'd1 : B = 8'b0000_0010;
				3'd2 : B = 8'b0000_0100;
				3'd3 : B = 8'b0000_1000;
				
				3'd4 : B = 8'b0001_0000;
				3'd5 : B = 8'b0010_0000;
				3'd6 : B = 8'b0100_0000;
				3'd7 : B = 8'b1000_0000;
			
			endcase
    end
     
endmodule

module MEMEORY(output reg [0:7] G,input [0:2] S)
 reg [0:7] memory[0:7];
  initial begin
     memory[0]=8'h01;
     memory[1]=8'h03;
     memory[2]=8'h07;
     memory[3]=8'h0f;
     memory[4]=8'h1f;
     memory[5]=8'h3f;
     memory[6]=8'h7f;
     memory[7]=8'hff;

  end
  always @(S)begin
      case(S)
          3'd0 : G = memory[0];
		  3'd1 : G = memory[1];
		  3'd2 : G = memory[2];
		  3'd3 : G = memory[3];
				
		  3'd4 : G = memory[4];
		  3'd5 : G = memory[5];
		  3'd6 : G = memory[6];
		  3'd7 : G = memory[7];
      endcase
  end
endmodule

module TOP_MODULE(input clear,input clk,input [0:2] S,output O)
 wire [0:2] q;
 COUNTER_3BIT c(clear,q,clk);
 wire [0:7] c;
 DECODER d(q,c);
 wire [0:7] G;
 MEMEORY m(G,S);
 MUX_ARRAY arr(c,G,O);
endmodule