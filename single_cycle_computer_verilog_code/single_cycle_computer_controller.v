module single_cycle_computer_controller(
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
	
	output reg RegSrc, RegWrite, MemWrite, MemtoReg, ALUSrc, flagUpdate, ALUShiftSelect; 
	output reg [1:0]ExtControl;
	output reg [2:0]ALUop; 
	output reg [1:0]ShiftSel; 
	input [31:0]FLAG_OUT; 
	input [5:0]funct;
	input [1:0]op; 
	input [1:0]shift_type; 
	input Clock; 
	
	reg [31:0]INSTRUCTION; 
	
	
	wire [5:0]funct_2;
	wire [1:0]op_2; 
	wire [1:0]shift_type_2; 
	

	
	always @(op, funct, shift_type) begin // when the instruction changes, change the control signals 
			
		if (op == 2'b00 && funct[4:1] == 4'b0100) begin // ADD
			RegSrc <= 0; // choose Rm  
			ExtControl <= 2'b00; // don't care 
			RegWrite <= 1; 
			MemWrite <= 0; 
			MemtoReg <= 0; 
			ALUSrc <= 0; // choose Rm output  
			flagUpdate <= 0; 
			ALUShiftSelect <= 0;
			ALUop <= 3'b000; // ADD operation  
			ShiftSel <= 2'b11;
		end 
		else if (op == 2'b00 && funct[4:1] == 4'b0010) begin // SUB 
			RegSrc <= 0; // choose Rm  
			ExtControl <= 2'b00; // don't care 
			RegWrite <= 1; 
			MemWrite <= 0; 
			MemtoReg <= 0; 
			ALUSrc <= 0; // choose Rm output  
			flagUpdate <= 0; 
			ALUShiftSelect <= 0;
			ALUop <= 3'b001; // SUB operation  
			ShiftSel <= 2'b11;
		end 

		else if (op == 2'b00 && funct[4:1] == 4'b1100) begin // ORR
			RegSrc <= 0; // choose Rm  
			ExtControl <= 2'b00; // don't care 
			RegWrite <= 1; 
			MemWrite <= 0; 
			MemtoReg <= 0; 
			ALUSrc <= 0; // choose Rm output  
			flagUpdate <= 0; 
			ALUShiftSelect <= 0;
			ALUop <= 3'b101; // OR operation  
			ShiftSel <= 2'b11;
		end 
		else if (op == 2'b00 && funct[4:1] == 4'b1101 && shift_type == 2'b00) begin // LSL 
			RegSrc <= 0; // choose Rm  
			ExtControl <= 2'b10; // don't care 
			RegWrite <= 1; 
			MemWrite <= 0; 
			MemtoReg <= 0; 
			ALUSrc <= 0; // choose Rm
			flagUpdate <= 0; 
			ALUShiftSelect <= 1;
			ALUop <= 3'b000; // ADD the shifted result with 0.
			ShiftSel <= 2'b00; // left shift
		end 
		else if (op == 2'b00 && funct[4:1] == 4'b1101 && shift_type == 2'b01) begin // LSR
			RegSrc <= 0; // choose Rm  
			ExtControl <= 2'b10; 
			RegWrite <= 1; 
			MemWrite <= 0; 
			MemtoReg <= 0; 
			ALUSrc <= 0; // choose Rm 
			flagUpdate <= 0; 
			ALUShiftSelect <= 1;
			ALUop <= 3'b000; // ADD the shifted result with 0.    
			ShiftSel <= 2'b01; // rigt shift
		end 
		else if (op == 2'b00 && funct[4:1] == 4'b0000) begin // AND 
			RegSrc <= 0; // choose Rm  
			ExtControl <= 2'b00; // don't care 
			RegWrite <= 1; 
			MemWrite <= 0; 
			MemtoReg <= 0; 
			ALUSrc <= 0; // choose Rm output  
			flagUpdate <= 0;
			ALUShiftSelect <= 0;	
			ALUop <= 3'b100; // AND operation  
			ShiftSel <= 2'b11;
		end 
		else if (op == 2'b00 && funct[4:1] == 4'b1010) begin // CMP 
			RegSrc <= 1; // choose Rd in 
			ExtControl <= 2'b00; // don't care 
			RegWrite <= 0; 
			MemWrite <= 0; 
			MemtoReg <= 0; 
			ALUSrc <= 0; // choose Rd output  
			flagUpdate <= 1; // update the flag
			ALUShiftSelect <= 0;	
			ALUop <= 3'b001; // SUB operation  
			ShiftSel <= 2'b11;
		end 
		else if (op == 2'b01 && funct[0] == 0) begin // STR
			RegSrc <= 1; 
			ExtControl <= 2'b01; 
			RegWrite <= 0; 
			MemWrite <= 1; 
			MemtoReg <= 0; 
			ALUSrc <= 1; // choose immediate 
			flagUpdate <= 0; 
			ALUShiftSelect <= 0;
			ALUop <= 3'b000; // add the immediate  
			ShiftSel <= 2'b11;
		end 
		else if (op == 2'b01 && funct[0] == 1) begin // LDR 
			RegSrc <= 1; 
			ExtControl <= 2'b01; 
			RegWrite <= 1; 
			MemWrite <= 0; 
			MemtoReg <= 1; 
			ALUSrc <= 1; // choose immediate 
			flagUpdate <= 0; 
			ALUShiftSelect <= 0;
			ALUop <= 3'b000; // add the immediate  
			ShiftSel <= 2'b11;
		end 
		else begin 
			RegSrc <= 1; 
			ExtControl <= 2'b00; 
			RegWrite <= 0; 
			MemWrite <= 1; 
			MemtoReg <= 1; 
			ALUSrc <= 1; // choose immediate 
			flagUpdate <= 0; 
			ALUShiftSelect <= 0;
			ALUop <= 3'b000; // add the immediate  
			ShiftSel <= 2'b11;
		end 
	
	end 
	
	

endmodule 