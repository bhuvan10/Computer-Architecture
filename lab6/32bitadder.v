module FA_dataflow (Cout, Sum,In1,In2,Cin);
input [31:0] In1,In2;
input Cin;
output Cout;
output [31:0] Sum;
assign {Cout,Sum}=In1+In2+Cin;
endmodule

// module tb32bitadd;
// reg [31:0] IN1,IN2;
// wire [31:0] OUT;
// wire Cout;
// FA_dataflow a1 (Cout,OUT,IN1,IN2,1'b0);
// initial
// begin
//     $monitor("%b %b %b %b",Cout,OUT,IN1,IN2);
// end
// initial
// begin
// IN1=32'hA5A5;
// IN2=32'h5A5A;
// #100 IN1=32'h5A5A;
// #400 $finish;
// end
// endmodule