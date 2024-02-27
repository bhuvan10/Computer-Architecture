`ifndef ENC
`define ENC
 module encd(input [7:0] inp,output [2:0] otp);
  assign otp[0]=inp[1]|inp[3]|inp[5]|inp[7];
  assign otp[1]=inp[2]|inp[3]|inp[6]|inp[7];
  assign otp[2]=inp[4]|inp[5]|inp[6]|inp[7];
 endmodule
 `endif