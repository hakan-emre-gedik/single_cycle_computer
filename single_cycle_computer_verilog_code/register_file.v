module register_file (
	A_1,
	A_2, 
	A_3, 
	WD3, 
	R15, 
	wen, 
	clk, 
	RD1, 
	RD2, 
	reset
); 

	input [3:0] A_1, A_2, A_3; 
	input [31:0] WD3, R15; 
	input wen; 
	input clk; 
	input reset; 
	output[31:0] RD1, RD2; 
	
	// create in total of 16 registers for the computer register file. 
	
		// create register data output wires. 
	wire [31:0] R0_out, R1_out, R2_out, R3_out, R4_out; 
	wire [31:0] R5_out, R6_out, R7_out, R8_out, R9_out; 
	wire [31:0] R10_out, R11_out, R12_out, SP_out, LR_out, PC_out; 
	
		// create write enables for registers. 
			// for this, create a select schema
	wire wen_0, wen_1, wen_2, wen_3, wen_4; 
	wire wen_5, wen_6, wen_7, wen_8, wen_9; 
	wire wen_10, wen_11, wen_12, wen_13, wen_14, wen_15;
	
	assign wen_0 = (~A_3[0]) & (~A_3[1]) & (~A_3[2]) & (~A_3[3]) & wen;  
	assign wen_1 = (A_3[0]) & (~A_3[1]) & (~A_3[2]) & (~A_3[3]) & wen; 
	assign wen_2 = (~A_3[0]) & (A_3[1]) & (~A_3[2]) & (~A_3[3]) & wen; 
	assign wen_3 = (A_3[0]) & (A_3[1]) & (~A_3[2]) & (~A_3[3]) & wen; 
	assign wen_4 = (~A_3[0]) & (~A_3[1]) & (A_3[2]) & (~A_3[3]) & wen; 
	assign wen_5 = (A_3[0]) & (~A_3[1]) & (A_3[2]) & (~A_3[3]) & wen; 
	assign wen_6 = (~A_3[0]) & (A_3[1]) & (A_3[2]) & (~A_3[3]) & wen; 
	assign wen_7 = (A_3[0]) & (A_3[1]) & (A_3[2]) & (~A_3[3]) & wen;
	assign wen_8 = (~A_3[0]) & (~A_3[1]) & (~A_3[2]) & (A_3[3]) & wen;  
	assign wen_9 = (A_3[0]) & (~A_3[1]) & (~A_3[2]) & (A_3[3]) & wen; 
	assign wen_10 = (~A_3[0]) & (A_3[1]) & (~A_3[2]) & (A_3[3]) & wen; 
	assign wen_11 = (A_3[0]) & (A_3[1]) & (~A_3[2]) & (A_3[3]) & wen; 
	assign wen_12 = (~A_3[0]) & (~A_3[1]) & (A_3[2]) & (A_3[3]) & wen; 
	assign wen_13 = (A_3[0]) & (~A_3[1]) & (A_3[2]) & (A_3[3]) & wen; 
	assign wen_14 = (~A_3[0]) & (A_3[1]) & (A_3[2]) & (A_3[3]) & wen; 
	assign wen_15 = 1; // program counter register is always written.  
	
	// Instantiate the registers 
	registers_two #(.W(32)) R0 (clk, WD3, reset, wen_0, R0_out); 
	registers_two #(.W(32)) R1 (clk, WD3, reset, wen_1, R1_out);
	registers_two #(.W(32)) R2 (clk, WD3, reset, wen_2, R2_out);
	registers_two #(.W(32)) R3 (clk, WD3, reset, wen_3, R3_out);
	registers_two #(.W(32)) R4 (clk, WD3, reset, wen_4, R4_out);
	registers_two #(.W(32)) R5 (clk, WD3, reset, wen_5, R5_out);
	registers_two #(.W(32)) R6 (clk, WD3, reset, wen_6, R6_out);
	registers_two #(.W(32)) R7 (clk, WD3, reset, wen_7, R7_out);
	registers_two #(.W(32)) R8 (clk, WD3, reset, wen_8, R8_out);
	registers_two #(.W(32)) R9 (clk, WD3, reset, wen_9, R9_out);
	registers_two #(.W(32)) R10 (clk, WD3, reset, wen_10, R10_out);
	registers_two #(.W(32)) R11 (clk, WD3, reset, wen_11, R11_out);
	registers_two #(.W(32)) R12 (clk, WD3, reset, wen_12, R12_out);
	registers_two #(.W(32)) SP (clk, WD3, reset, wen_13, SP_out);
	registers_two #(.W(32)) LR (clk, WD3, reset, wen_14, LR_out);
	registers_two #(.W(32)) PC (clk, R15, reset, wen_15, PC_out);
	//----
	
	// create 5 4x1 MUXs (x2) to create a select schema for the file outputs 
	
		// create 5 MUXs for RD1. 
	wire [31:0] rd1_00, rd1_01, rd1_10, rd1_11; 
	w_bit_four_to_one_mux #(.W(32)) mux_000_0 (R0_out, R1_out, R2_out, R3_out, A_1[1:0], rd1_00); 
	w_bit_four_to_one_mux #(.W(32)) mux_001_0 (R4_out, R5_out, R6_out, R7_out, A_1[1:0], rd1_01);
	w_bit_four_to_one_mux #(.W(32)) mux_010_0 (R8_out, R9_out, R10_out, R11_out, A_1[1:0], rd1_10);
	w_bit_four_to_one_mux #(.W(32)) mux_011_0 (R12_out, SP_out, LR_out, PC_out, A_1[1:0], rd1_11);
	w_bit_four_to_one_mux #(.W(32)) mux_100_0 (rd1_00, rd1_01, rd1_10, rd1_11, A_1[3:2], RD1);
	
		// create 5 MUXs for RD2. 
	wire [31:0] rd2_00, rd2_01, rd2_10, rd2_11; 
	w_bit_four_to_one_mux #(.W(32)) mux_000_1 (R0_out, R1_out, R2_out, R3_out, A_2[1:0], rd2_00); 
	w_bit_four_to_one_mux #(.W(32)) mux_001_1 (R4_out, R5_out, R6_out, R7_out, A_2[1:0], rd2_01);
	w_bit_four_to_one_mux #(.W(32)) mux_010_1 (R8_out, R9_out, R10_out, R11_out, A_2[1:0], rd2_10);
	w_bit_four_to_one_mux #(.W(32)) mux_011_1 (R12_out, SP_out, LR_out, PC_out, A_2[1:0], rd2_11);
	w_bit_four_to_one_mux #(.W(32)) mux_100_1 (rd2_00, rd2_01, rd2_10, rd2_11, A_2[3:2], RD2);
endmodule 