module alu_unit #(
	parameter W=4 
) 
(
	input [W-1:0] in_0, 
	input [W-1:0] in_1, 
	input [2:0] s, 
	output reg [W-1:0] outs, 
	output reg CO, 
	output reg OVF, 
	output reg Z, 
	output reg N 
	
);  
		
always @(*) begin 
	// update the alu flags in the parallel operation 
	if (outs == 0) begin 
		Z <= 1; 
	end
	else begin 
		Z <= 0;  
	end 
	
	if (outs[W-1] == 1) begin 
		N <= 1; 
	end 
	
	else begin 
		N<= 0; 
	end 

	// Implement the input output relations for various cases of the input select. 
	// ALU has 8 functions each corresponding to a value of the select. 
	// Any change in the inputs trigger the output change. To achieve this, 
	// we have used the always block with * 
	if (s == 3'b000) begin 
		{CO, outs} <= in_0 + in_1; // CO is the carry out and it should updated.  
		if (outs[W-1] != in_0[W-1] && (in_0[W-1] == in_1[W-1])) begin // check the sign bits for overflow 
			OVF <= 1; // if the initial signs are different, no overflow can happen 
		end 
		else begin 
			OVF <= 0; 
		end 
	end 
	
	else if (s == 3'b001) begin 
		{CO, outs} <= in_0 - in_1; // CO is the carry out and it should updated.
		if ((in_0[W-1] != in_1[W-1]) && (in_0[W-1] != outs[W-1])) begin 
			OVF <= 1; // if the initial signs are the same, no overflow can happen 
		end 
		else begin 
			OVF <= 0; 
		end 
	end 
	
	else if (s == 3'b010) begin 
		{CO, outs} <= in_1 - in_0; // CO is the carry out and it should updated.
		if ((in_0[W-1] != in_1[W-1]) && (in_1[W-1] != outs[W-1])) begin 
			OVF <= 1; // if the initial signs are the same, no overflow can happen 
		end 
		else begin 
			OVF <= 0; 
		end 
	end 
	
	else if (s == 3'b011) begin 
		outs <= in_0 & (~in_1); 
		// no overflow can happen
		// no carry out
		CO <= 0; 
		OVF <= 0; 
	end 
	
	else if (s == 3'b100) begin 
		outs <= in_0 & in_1; 
		// no overflow can happen
		// no carry out
		CO <= 0; 
		OVF <= 0;
	end

	else if (s == 3'b101) begin 
		outs <= in_0 | in_1;
		// no overflow can happen
		// no carry out
		CO <= 0; 
		OVF <= 0;
	end
	
	else if (s == 3'b110) begin 
		outs <= (in_0 & (~in_1)) | (in_1 & (~in_0));  
		// no overflow can happen
		// no carry out 
		CO <= 0; 
		OVF <= 0;
	end
	
	else begin 
		outs <= (in_0 & in_1) | ((~in_1)& (~in_0)); 
		// no overflow can happen
		// no carry out
		CO <= 0; 
		OVF <= 0;
	end
	
	
	
	
end 
	
endmodule 