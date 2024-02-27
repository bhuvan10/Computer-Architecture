module RSFF(input clk,input R,input S,input reset,output reg q,output reg nq);
  always @(clk) begin
    if(reset)
     q<=1'b0;
    else begin
        case({R,S})
          2'b01 : q<=1'b1;
          2'b10 : q<=1'b0;
          2'b11 : q<=1'b0;
        endcase
        nq<=~q;
    end
  end
endmodule

module DFF(input clk,input D,input reset,output  q,output  nq);
 RSFF r(clk,D,~D,reset,q,nq);
endmodule

module Ripple_Counter(input clk,input reset,ouput [0:3] Q,ouput [0:3] nQ);
   DFF d1(clk,nQ[0],reset,Q[0],nQ[0]);
   DFF d2(clk,nQ[1],reset,Q[1],nQ[1]);
   DFF d3(clk,nQ[2],reset,Q[2],nQ[2]);
   DFF d4(clk,nQ[3],reset,Q[3],nQ[3]);

endmodule