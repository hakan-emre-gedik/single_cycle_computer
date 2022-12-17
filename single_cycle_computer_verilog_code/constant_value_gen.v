module constant_value_gen #(
	parameter W=4,  
	parameter constant_val=4 
) 
(
	output [W-1:0] outs 
	
);  
	// Only output is assigned to the value of the parameter inputted. 
	assign outs = constant_val; 
	
endmodule 