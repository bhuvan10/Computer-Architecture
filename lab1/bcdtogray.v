module bcdtogray_gate(b3,b2,b1,b0,a3,a2,a1,a0);
 input a3,a2,a1,a0;
 output b3,b2,b1,b0;
 and(b3,1,a3);
 xor(b2,a3,a2);
 xor(b1,a2,a1);
 xor(b0,a1,a0);
endmodule
module bcdtogray_df(b3,b2,b1,b0,a3,a2,a1,a0);
 input a3,a2,a1,a0;
 output b3,b2,b1,b0;
 assign b3=a3;
 assign b2=a3^a2;
 assign b1=a2^a1;
 assign b0=a1^a0;
endmodule
module testbench;
reg a3,a2,a1,a0;
wire b3,b2,b1,b0;
bcdtogray_df f1(b3,b2,b1,b0,a3,a2,a1,a0);
initial
begin
    $monitor(,$time," b3=%b b2=%b b1=%b b0=%b    a3=%b a2=%b a1=%b a0=%b",b3,b2,b1,b0,a3,a2,a1,a0);
#0 a3=1'b0;a2=1'b0;a1=1'b0;a0=1'b0;
#1 a3=1'b0;a2=1'b0;a1=1'b0;a0=1'b1;
#2 a3=1'b0;a2=1'b0;a1=1'b1;a0=1'b0;
#3 a3=1'b0;a2=1'b0;a1=1'b1;a0=1'b1;
#4 a3=1'b0;a2=1'b1;a1=1'b0;a0=1'b0;
#5 a3=1'b0;a2=1'b1;a1=1'b0;a0=1'b1;
#6 a3=1'b0;a2=1'b1;a1=1'b1;a0=1'b0;
#7 a3=1'b0;a2=1'b1;a1=1'b1;a0=1'b1;
#8 a3=1'b1;a2=1'b0;a1=1'b0;a0=1'b0;
#9 a3=1'b1;a2=1'b0;a1=1'b0;a0=1'b1;
#10 $finish;
end
endmodule