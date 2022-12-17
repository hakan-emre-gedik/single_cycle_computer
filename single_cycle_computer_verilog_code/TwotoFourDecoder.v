module TwotoFourDecoder (
	input enable, 
	input in_0, 
	input in_1, 
	output out_0,
	output out_1, 
	output out_2, 
	output out_3
);  


// The decoder logic equtions are implemented using AND and NOT gates. 
assign out_0 = (~in_0 & ~in_1) & enable; 
assign out_1 = (in_0 & ~in_1) & enable; 
assign out_2 = (~in_0 & in_1) & enable; 
assign out_3 = (in_0 & in_1) & enable; 
 

endmodule 