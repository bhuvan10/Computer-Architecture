module shift(input [31:0] ip,ouput [31:0] op);
 
 op={ip[29:0],2b'00};
endmodule