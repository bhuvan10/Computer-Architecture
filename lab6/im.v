module im(input [4:0] pc,input reset,output [31:0] instr);
 reg [31:0] mem[0:31];
 always@(pc) begin
  instr=mem[pc];
  
 end
 always @(reset) begin
			if(reset) begin
				
				//initialization
				mem[0] = 32'h00000200;
				mem[1] = 32'h00000201;
				mem[2] = 32'h00000204;
				mem[3] = 32'h00000108;
				
			end
		end

endmodule