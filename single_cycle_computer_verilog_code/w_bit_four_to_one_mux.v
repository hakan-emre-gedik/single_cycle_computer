module w_bit_four_to_one_mux #(
	parameter W=2 
) 
(
	input [W-1:0] in_0, 
	input [W-1:0] in_1,
	input [W-1:0] in_2,	
	input [W-1:0] in_3,
	input [1:0]s, 
	output [W-1:0]outs
	
);  
	// The MUX logic equation is implemented using nested if statements. 
	assign outs = s[1] ? (s[0] ? in_3 : in_2 ) : (s[0] ? in_1 : in_0); 
	
endmodule 