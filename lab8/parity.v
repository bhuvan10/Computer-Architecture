`ifndef PAR
`define PAR
  module even_parity(input [3:0] inp,output otp);
   assign otp = inp[0]^inp[1]^inp[2]^inp[3];
  endmodule
`endif
