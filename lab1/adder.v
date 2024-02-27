module onebit(a,b,cin,s,cout)
  input a,b,cin;
  output s,cout;
  wire x1,x2,x3;
  xor(x1,a,b);
  and(x2,cin,x1);
  and(X3,a,b);
  or(cout,x2,x3);
  xor(s,cin,x1);
endmodule

module testbench;
reg a,b,cin;
wire s,cout0;
onebit f1(a,b,cin,s,cout);
initial
begin
    $monitor(,$time," a,b,cin,s,cout",a,b,cin,s,cout);
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