module computer_tb(); 

	
	reg Clock; 
	
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
	
	initial begin 
		Clock = 0; 
		reset = 1; #9; reset = 0; 
	end 	
	
	always begin 
		Clock = ~Clock; #5; 
	end 


endmodule 