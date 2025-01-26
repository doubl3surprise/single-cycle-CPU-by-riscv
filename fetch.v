`include "define.v"
module fetch(
	input wire [31:0] pc_i,
	output wire [6:0] opcode_o,
	output wire [4:0] rd_o,
	output wire [9:0] funct_o,
	output wire [4:0] rs1_o,
	output wire [4:0] rs2_o,
	output wire [31:0] imm_o,
	output wire [2:0] instr_type_o,
	output wire imem_error_o
);
	wire [31:0] instr;
	access_instruction_memory acc_instr_mem(
		.pc_i(pc_i),
		.instr_o(instr),
		.imem_error_o(imem_error_o)
	);
	assign opcode_o = instr[6:0];
	assign instr_type_o = (opcode_o == 7'b1100011) ? `TYPEB
		: (opcode_o == 7'b0100011) ? `TYPES
		: (opcode_o == 7'b1101111) ? `TYPEJ
		: (opcode_o == 7'b0110011) ? `TYPER
		: (opcode_o == 7'b0110111) | (opcode_o == 7'b0010111) ? `TYPEU
		: `TYPEI;
	assign rd_o = instr[11:7];
	assign funct_o = (instr_type_o == `TYPER) ? {instr[31:25], instr[11:7]}
		: ((instr_type_o == `TYPEU) | (instr_type_o == `TYPEJ)) ? 10'd0
		: {7'd0, instr[11:7]};
	assign rs1_o = instr[19:15];
	assign rs2_o = instr[24:20];
	assign imm_o = (instr_type_o == `TYPEI) ? instr[31:20]
		: (instr_type_o == `TYPES) ? {instr[31:25], instr[11:7]}
		: (instr_type_o == `TYPEB) ? {instr[31], instr[7], instr[30:25], instr[11:8], 1'd0}
		: (instr_type_o == `TYPEU) ? instr[31:12]
		: (instr_type_o == `TYPEJ) ? {instr[31], instr[19:12], instr[20], instr[30:21], 1'd0}
		: 20'd0;
endmodule