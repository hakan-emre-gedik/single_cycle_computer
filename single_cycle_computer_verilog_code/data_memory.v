	module data_memory(
	data_out, 
	data_in, 
	address_in, 
	we, 
	clk 
); 
	output reg [31:0] data_out; // input and output should have 32-bit length. 	
	input [31:0] data_in; 
	input [31:0] address_in; 
	input we; 
	input clk; 
	
	reg [31:0] mem[127:0]; 
	
	initial begin 
		mem[0] <= 32'd4; mem[1] <= 32'd8; mem[2] <= 32'd12; mem[3] <= 32'd16; 
		mem[4] <= 32'd20; mem[5] <= 32'd24; mem[6] <= 32'd28; mem[7] <= 32'd32; 
		mem[8] <= 32'd36; mem[9] <= 32'd40; mem[10] <= 32'd44; mem[11] <= 32'd48; 	
		mem[12] <= 32'd52; mem[13] <= 32'd56; mem[14] <= 32'd60; mem[15] <= 32'd64; 
		mem[16] <= 32'd68; mem[17] <= 32'd72; mem[18] <= 32'd76; mem[19] <= 32'd78; 
	end 
	
	always @(*) begin 
		data_out <= mem[address_in]; 
	end 
	
	always @(posedge clk) begin 
		if (we) mem[address_in] <= data_in; 
		else mem[address_in] <= mem[address_in]; 
	end 

endmodule 