module full_adder (
	in_1, 
	in_2, 
	data_out
);  
	input [31:0]in_1; 
	input [31:0]in_2; 
	output reg [31:0]data_out; 
	
	always @(*) data_out = in_1 + in_2; 

endmodule 