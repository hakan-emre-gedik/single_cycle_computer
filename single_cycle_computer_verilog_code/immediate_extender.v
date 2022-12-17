module immediate_extender (
	immediate_input, 
	imm_src, 
	immediate_output
); 
	input [11:0]immediate_input; 
	input [1:0]imm_src; 
	output reg [31:0]immediate_output; 
	
	reg [4:0] rotate_val; 
	reg [31:0] immediate_right_partition, immediate_left_partition; 
	reg [31:0]immediate_input_value; 
	
	
	always @(imm_src, immediate_input) begin 
		immediate_output = 32'b0; // initialize to 0. 
		rotate_val = (immediate_input[11:8] << 1 ) ; // multiply the rotate value by 2.
		immediate_input_value = 32'b0; 
		immediate_input_value[7:0] = immediate_input[7:0]; 
		if (imm_src == 2'b00) begin 
			// shift right the input with the provided rotate value. 
			// shift left the input with the provided 32-rotate value.
			// then or these two subpartitions to obtain the final output. 
			immediate_right_partition = immediate_input_value >> rotate_val; 
			immediate_left_partition = immediate_input_value << 32-rotate_val; 
			immediate_output = immediate_right_partition | immediate_left_partition; 
		end 
		else if (imm_src == 2'b01) begin  
			// if immediate source is 01, we have a memory reference instruction. 
			immediate_right_partition = 32'b0; 
			immediate_left_partition = 32'b0; 
			immediate_output[11:0] = immediate_input; 
			immediate_output[31:12] = 20'b0; 
		end 
		else begin 
			immediate_right_partition = 32'b0; 
			immediate_left_partition = 32'b0;
			immediate_output[4:0] = immediate_input[11:7];
			immediate_output[31:5] = 27'b0; 
		end 
	end 
	
endmodule 