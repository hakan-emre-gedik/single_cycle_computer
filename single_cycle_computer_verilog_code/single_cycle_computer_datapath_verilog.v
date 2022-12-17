// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 18.1.0 Build 625 09/12/2018 SJ Lite Edition"
// CREATED		"Sun May 08 21:55:48 2022"

module single_cycle_computer_datapath_verilog(
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


input wire	RegSrc;
input wire	RegWrite;
input wire	MemWrite;
input wire	MemtoReg;
input wire	Clock;
input wire	ALUSrc;
input wire	flagUpdate;
input wire	ALUShiftSelect;
input wire	reset;
input wire	[2:0] ALUop;
input wire	[1:0] ExtControl;
input wire	[1:0] ShiftSel;
output wire	[3:0] FLAG_OUT;
output wire	[5:0] funct;
output wire	[1:0] op;
output wire	[31:0] RegisterOut_0;
output wire	[31:0] RegisterOut_1;
output wire	[1:0] shift_type;

wire	[3:0] FLAG_IN;
wire	[31:0] INSTRUCTION;
wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;
wire	[31:0] SYNTHESIZED_WIRE_21;
wire	[31:0] SYNTHESIZED_WIRE_3;
wire	[31:0] SYNTHESIZED_WIRE_22;
wire	[31:0] SYNTHESIZED_WIRE_23;
wire	[31:0] SYNTHESIZED_WIRE_7;
wire	[31:0] SYNTHESIZED_WIRE_9;
wire	[3:0] SYNTHESIZED_WIRE_10;
wire	[31:0] SYNTHESIZED_WIRE_11;
wire	[31:0] SYNTHESIZED_WIRE_12;
wire	[31:0] SYNTHESIZED_WIRE_13;
wire	[31:0] SYNTHESIZED_WIRE_14;
wire	[31:0] SYNTHESIZED_WIRE_24;
wire	[31:0] SYNTHESIZED_WIRE_25;
wire	SYNTHESIZED_WIRE_19;

assign	RegisterOut_0 = SYNTHESIZED_WIRE_13;
assign	RegisterOut_1 = SYNTHESIZED_WIRE_3;
assign	SYNTHESIZED_WIRE_19 = 1;




alu_unit	b2v_ALU(
	.in_0(SYNTHESIZED_WIRE_0),
	.in_1(SYNTHESIZED_WIRE_1),
	.s(ALUop),
	.CO(FLAG_IN[1]),
	.OVF(FLAG_IN[0]),
	.Z(FLAG_IN[2]),
	.N(FLAG_IN[3]),
	.outs(SYNTHESIZED_WIRE_22));
	defparam	b2v_ALU.W = 32;


instruction_memory	b2v_inst(
	.address_in(SYNTHESIZED_WIRE_21),
	.data_out(INSTRUCTION));


registers_two	b2v_inst1(
	.clk(Clock),
	.rst(reset),
	.wen(flagUpdate),
	.data(FLAG_IN),
	.A(FLAG_OUT));
	defparam	b2v_inst1.W = 4;


constant_value_gen	b2v_inst10(
	.outs(SYNTHESIZED_WIRE_24));
	defparam	b2v_inst10.constant_val = 1;
	defparam	b2v_inst10.W = 32;


barrel_shifter	b2v_inst107(
	.data_in(SYNTHESIZED_WIRE_3),
	.shamt(INSTRUCTION[11:7]),
	.shift_type(ShiftSel),
	.data_out(SYNTHESIZED_WIRE_23));


constant_value_gen	b2v_inst109(
	.outs(SYNTHESIZED_WIRE_14));
	defparam	b2v_inst109.constant_val = 0;
	defparam	b2v_inst109.W = 32;


w_bit_two_to_one_mux	b2v_inst113(
	.s(RegSrc),
	.in_0(INSTRUCTION[3:0]),
	.in_1(INSTRUCTION[15:12]),
	.outs(SYNTHESIZED_WIRE_10));
	defparam	b2v_inst113.W = 4;



data_memory	b2v_inst3(
	.we(MemWrite),
	.clk(Clock),
	.address_in(SYNTHESIZED_WIRE_22),
	.data_in(SYNTHESIZED_WIRE_23),
	.data_out(SYNTHESIZED_WIRE_7));


w_bit_two_to_one_mux	b2v_inst4(
	.s(MemtoReg),
	.in_0(SYNTHESIZED_WIRE_22),
	.in_1(SYNTHESIZED_WIRE_7),
	.outs(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst4.W = 32;


immediate_extender	b2v_inst5(
	.imm_src(ExtControl),
	.immediate_input(INSTRUCTION[11:0]),
	.immediate_output(SYNTHESIZED_WIRE_9));


w_bit_two_to_one_mux	b2v_inst6(
	.s(ALUSrc),
	.in_0(SYNTHESIZED_WIRE_23),
	.in_1(SYNTHESIZED_WIRE_9),
	.outs(SYNTHESIZED_WIRE_1));
	defparam	b2v_inst6.W = 32;


register_file	b2v_inst7(
	.wen(RegWrite),
	.clk(Clock),
	.reset(reset),
	.A_1(INSTRUCTION[19:16]),
	.A_2(SYNTHESIZED_WIRE_10),
	.A_3(INSTRUCTION[15:12]),
	.R15(SYNTHESIZED_WIRE_11),
	.WD3(SYNTHESIZED_WIRE_12),
	.RD1(SYNTHESIZED_WIRE_13),
	.RD2(SYNTHESIZED_WIRE_3));


w_bit_two_to_one_mux	b2v_inst703(
	.s(ALUShiftSelect),
	.in_0(SYNTHESIZED_WIRE_13),
	.in_1(SYNTHESIZED_WIRE_14),
	.outs(SYNTHESIZED_WIRE_0));
	defparam	b2v_inst703.W = 32;


full_adder	b2v_inst8(
	.in_1(SYNTHESIZED_WIRE_21),
	.in_2(SYNTHESIZED_WIRE_24),
	.data_out(SYNTHESIZED_WIRE_25));


full_adder	b2v_inst9(
	.in_1(SYNTHESIZED_WIRE_25),
	.in_2(SYNTHESIZED_WIRE_24),
	.data_out(SYNTHESIZED_WIRE_11));


registers_two	b2v_PC(
	.clk(Clock),
	.rst(reset),
	.wen(SYNTHESIZED_WIRE_19),
	.data(SYNTHESIZED_WIRE_25),
	.A(SYNTHESIZED_WIRE_21));
	defparam	b2v_PC.W = 32;

assign	funct[5:0] = INSTRUCTION[25:20];
assign	op[1:0] = INSTRUCTION[27:26];
assign	shift_type[1:0] = INSTRUCTION[6:5];

endmodule
