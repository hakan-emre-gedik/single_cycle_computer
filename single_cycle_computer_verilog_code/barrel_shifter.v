module barrel_shifter (
	data_in, 
	shift_type, 
	shamt, 
	data_out
); 
	input [31:0]data_in; 
	input [4:0]shamt; 
	input [1:0]shift_type; 
	output reg [31:0] data_out; 

	always @(*) begin 
		if (shift_type == 2'b00) data_out <= data_in << shamt; // select 00 for left shift
		else if (shift_type == 2'b01) data_out <= data_in >> shamt; // 01 for right shift 
		else if (shift_type == 2'b10) data_out <= data_in; // do nothing 
		else data_out <= data_in; // do nothing 
	end 
	
endmodule 