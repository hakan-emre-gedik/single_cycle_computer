module tester_module (input a); 

	
	reg Clock; 
	reg [31:0] vectornum, errors; 
	reg [31:0] testvectors [18:0]; 

	
	
	// instantiate device under test. 
	wire [31:0]FLAG_OUT; 
	wire [31:0]RegisterOut_0; 
	wire [31:0]RegisterOut_1; 
	reg [31:0]RegisterOut_0_expected; 
	reg [31:0]FLAG_OUT_expected; 
	reg reset; 
	
	single_cycle_computer_all dut(
		.Clock(Clock),
		.reset(reset), 
		.RegisterOut_0(RegisterOut_0), 
		.RegisterOut_1(RegisterOut_1), 
		.FLAG_OUT(FLAG_OUT)
	); 
	
	
	always begin 
		Clock = 1; #5; Clock = 0; #5; 
	end 
	
	initial begin 
		vectornum = 0; 
		errors = 0; 
		reset = 1; #8; reset = 0; #2; 
		$readmemb("single_cycle_computer_test_vectors.tv", testvectors); 
	end 
	
	// upload vectors in rising edge
	always @(posedge Clock) begin 
		#1; RegisterOut_0_expected = testvectors[vectornum]; 
	end 
	
	
	// Check results in falling edge
	always @(negedge Clock) begin 
		if (~reset) begin  
			if ( FLAG_OUT_expected != FLAG_OUT) begin 
				$display("Error!");
				errors = errors + 1; 
			end 
			vectornum = vectornum + 1; 
			
			if (testvectors[vectornum] == 4'bx) begin 
				$display ("It is over."); 
			end 
		end 
	end 
	
	
endmodule  