`include "define.v"
module decode(
	input wire clk_i,
	input wire [2:0] instr_type_i,
	input wire [4:0] rs1_i,
	input wire [4:0] rs2_i,
	output wire [31:0] val1_o,
	output wire [31:0] val2_o
);
	wire valid_src1 = ((instr_type_i == `TYPER) | 
		(instr_type_i == `TYPEI) | 
		(instr_type_i == `TYPES) | 
		(instr_type_i == `TYPEB));
	wire valid_src2 = ((instr_type_i == `TYPER) |
		(instr_type_i == `TYPES) |
		(instr_type_i == `TYPEB));
	access_register_file(
		.clk_i(clk_i),
		.rs1_i(rs1_i),
		.rs2_i(rs2_i),
		.valid_src1_i(valid_src1),
		.valid_src2_i(valid_src2),
		.val1_o(val1_o),
		.val2_o(val2_o)
	);
endmodule