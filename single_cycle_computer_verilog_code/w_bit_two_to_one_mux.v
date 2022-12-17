module w_bit_two_to_one_mux #(
	parameter W=2 
) 
(
	input [W-1:0] in_0, 
	input [W-1:0] in_1, 
	input s, 
	output [W-1:0]outs
	
);  
	// MUX logic eqution is implemented here using the if statement of verilog. 
	assign outs = s ? in_1: in_0; 

endmodule 