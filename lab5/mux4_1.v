module mux4_1(regData,q1,q2,q3,q4,reg_no);
 input [31:0] q1,q2,q3,q4;
 output [31:0] regData;
 input [1:0] reg_no;
 wire [31:0] temp1,temp2,temp3,temp4;
 and(temp1,~reg_no[1],~reg_no[0],temp1);
  and(temp1,~reg_no[1],reg_no[0],temp2);
 and(temp1,reg_no[1],~reg_no[0],temp3);
 and(temp1,reg_no[1],reg_no[0],temp4);
 or(regData,temp1,temp2,temp3,temp4);
endmodule