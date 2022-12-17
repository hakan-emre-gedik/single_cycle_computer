module instruction_memory(
	data_out, 
	address_in
); 
	output reg [31:0] data_out; // input and output should have 32-bit length. 	
	input [31:0] address_in; 

	reg [31:0] mem[127:0]; 
	
	initial begin 
		mem[0] <= 32'h04100000; // LDR R0 MEM[0]
		mem[1] <= 32'h04181002; // LDR R1 MEM[2]
		mem[2] <= 32'h00800008; // ADD R0, R0, R8 SEE R0 
		mem[3] <= 32'h00811008; // ADD R1, R1, R8 SEE R1
		mem[4] <= 32'h00410000; // SUB R0, R1, R0 
		mem[5] <= 32'h00800008; // ADD R0, R0, R9, SEE R0 
		mem[6] <= 32'h01810001; // ORR R0, R0, R1 
		mem[7] <= 32'h00800008; // ADD R0, R0, R9, SEE R0
		mem[8] <= 32'h01410000; // CMP R0, R1, SEE UPDATE IN FLAG Z
		mem[9] <= 32'h00800008;  // ADD R0, R0, R9, SEE R0 
		mem[10] <= 32'h01A000A0; // LSR R0, R0, #1
		mem[11] <= 32'h00000001; // AND R0, R0, R1
		mem[12] <= 32'h00800008; // ADD R0, R0, R8 SEE R0
		mem[13] <= 32'h01A00080; // LSL R0, R0, #1  
		mem[14] <= 32'h00800008; // ADD R0, R0, R8 SEE R0
		mem[15] <= 32'h04080000; // STR R0, [R8, #0] => MEM[0] <- 8 
		mem[16] <= 32'h01A000A0; // LSR R0, R0, #1
		mem[17] <= 32'h00800008; // ADD R0, R0, R8 SEE R0
		mem[18] <= 32'h04180000; // LDR R0 MEM[0], SEE R0=8 
		mem[19] <= 32'h00800001; // ADD R0, R0, R8 SEE R0
		//h04080000
	end 
	
	always @(*) begin 
		data_out <= mem[address_in]; 
	end 

endmodule 