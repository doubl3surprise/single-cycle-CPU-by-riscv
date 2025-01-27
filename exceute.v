`include "define.v"
module execute(
	input wire clk_i,
	input wire set_cc_i,
	input wire [2:0] instr_type_i,
	input wire [6:0] opcode_i,
	input wire signed [31:0] val1_i,
	input wire signed [31:0] val2_i,
	input wire signed [31:0] imm_i,
	input wire [9:0] funct_i,
	input wire [31:0] pc_i,
	output reg signed [31:0] valE_o,
	output wire Cnd_o,
	output wire [31:0] branch_target_o
);
	wire signed [31:0] alu1;
	wire signed [31:0] alu2;
	wire [31:0] alu1U;
	wire [31:0] alu2U;
	wire [17:0] instr_id;
	wire [9:0] alu_fun;
	wire of, sf, zf;
	assign alu1 = ((opcode_i == `OP_AUIPC) |
		(opcode_i == `OP_JAL)) ? pc_i : val1_i;
	assign alu2 = ((instr_type_i == `TYPEU) | 
		(instr_type_i == `TYPEJ) | 
		(instr_type_i == `TYPEI) | 
		(instr_type_i == `TYPES)) ? imm_i : val2_i;

	assign alu_fun = ((opcode_i == `OP_R) | (opcode_i == `OP_IMM)) ? funct_i
		: (opcode_i == `OP_B) ? `ALUSUB
		: `ALUADD;
	assign alu1U = alu1;
	assign alu2U = alu2;
	always@ (*) begin
		case (alu_fun) 
			`ALUADD : valE_o = alu1 + alu2;
			`ALUSUB : valE_o = alu1 - alu2;
			`ALUSLL : valE_o = alu1 << alu2;
			`ALUSLT : valE_o = (alu1 < alu2);
			`ALUSLTU : valE_o = (alu1U < alu2U);
			`ALUXOR : valE_o = alu1 ^ alu2;
			`ALUSRL : valE_o = alu1 >> alu2;
			`ALUSRA : valE_o = alu1 >>> alu2;
			`ALUOR : valE_o = alu1 | alu2;
			`ALUAND : valE_o = alu1 & alu2;
		endcase
	end

	
	assign of = ((instr_type_i == `TYPEB) && ((alu_fun == `ALUADD && (alu1[31] != valE_o[31]) && (alu2[31] != valE_o[31])) 
		|| ((alu_fun == `ALUSUB) && (alu1[31] != alu2[31]) && (alu2[31] != valE_o[31]))));
	
	assign sf = ((instr_type_i == `TYPEB) && valE_o[31]);
	
	assign zf = ((instr_type_i == `TYPEB) && (valE_o == 0));
	

	assign Cnd_o = (((funct_i == `FUNC_BEQ) && zf) | 
			((funct_i == `FUNC_BNE) && ~zf) | 
			((funct_i == `FUNC_BLT) && (sf ^ of)) | 
			((funct_i == `FUNC_BGE) && ~(sf ^ of)) |
			((funct_i == `FUNC_BLTU) && (sf ^ of)) | 
			((funct_i == `FUNC_BGEU) && ~(sf ^ of)));

	assign branch_target_o = pc_i + imm_i; 
endmodule