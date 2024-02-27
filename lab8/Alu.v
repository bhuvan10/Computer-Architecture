`ifndef ALU
`define ALU
 module alu(input [3:0] ip1,input [3:0] ip2,output reg  [3:0] op,input[2:0] opcode);
   always @(opcode) begin
			case (opcode)
				3'b000 : op = ip1+ip2;
				3'b001 : op = ip1-ip2;
				3'b010 : op = ip1^ip2;
				3'b011 : op = ip1|ip2;
				3'b100 : op = ip1&ip2;
				3'b101 : op = ~(ip1|ip2);
				3'b110 : op = ~(ip1&ip2);
				3'b111 : op = ~(ip1^ip2);
			endcase
		end
   
 endmodule
 `endif