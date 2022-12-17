module single_cycle_computer_all (Clock, 
reset, 
RegisterOut_0, 
RegisterOut_1, 
FLAG_OUT
); 

input Clock; 
wire RegSrc, RegWrite, MemWrite, MemtoReg, ALUSrc, flagUpdate, ALUShiftSelect; 
wire [1:0]ExtControl; 
wire [2:0]ALUop; 
wire [1:0]ShiftSel; 
output wire [31:0]FLAG_OUT; 
wire [5:0]funct;
wire [1:0]op; 
wire [1:0]shift_type;
output wire [31:0]RegisterOut_0; 
output wire [31:0]RegisterOut_1; 
input reset; 


single_cycle_computer_controller controller(
	RegSrc,
	ExtControl,
	RegWrite,
	MemWrite,
	MemtoReg,
	Clock,
	ALUSrc,
	flagUpdate,
	ALUShiftSelect,
	ALUop,
	ShiftSel,
	FLAG_OUT,
	funct,
	op,
	shift_type
); 

	single_cycle_computer_datapath_verilog datapath (
		RegSrc,
		RegWrite,
		MemWrite,
		MemtoReg,
		Clock,
		ALUSrc,
		flagUpdate,
		ALUShiftSelect,
		reset,
		ALUop,
		ExtControl,
		ShiftSel,
		FLAG_OUT,
		funct,
		op,
		RegisterOut_0,
		RegisterOut_1,
		shift_type
	);  




endmodule 