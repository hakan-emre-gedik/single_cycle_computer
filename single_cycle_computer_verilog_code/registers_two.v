module registers_two #(
	parameter W=4 
) 
(
	input clk, 
	input [W-1:0] data, 
	input rst,
	input wen, 
	output reg [W-1:0] A
);  

	always @(posedge clk) begin 
		if (rst == 0 && wen == 1) begin 
			A <= data; // If write enable is high and reset is low, transfer the data 
			// to the register. 
		end 
		
		else if (rst == 0 && wen == 0) begin  
			A <= A; // If write enable is low, retain the previous data. 
		end 
		
		else begin 
			A <= 0; // If reset is high, reset the register value. 
		end 
		
	end 

endmodule 