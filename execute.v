`include "define.v"
module execute(
    	input  wire         clk_i,
    	input  wire [2:0]   instr_type_i,
    	input  wire [6:0]   opcode_i,
    	input  wire [31:0]  val1_i, 
    	input  wire [31:0]  val2_i, 
    	input  wire [31:0]  imm_i,
    	input  wire [9:0]   funct_i,
    	input  wire [31:0]  pc_i,
    	output reg  [31:0]  valE_o,
    	output wire         Cnd_o
);
    	wire is_b_type   = (instr_type_i == `TYPEB);
    	wire is_jal      = (opcode_i == `OP_JAL);
    	wire is_auipc    = (opcode_i == `OP_AUIPC);
    	wire is_r_type   = (opcode_i == `OP_R);
    	wire is_i_type   = (opcode_i == `OP_IMM);

    	wire [31:0] alu1 = (is_auipc | is_jal | is_b_type) 
			? pc_i : val1_i;
    	wire [31:0] alu2 = (is_auipc | is_jal | is_b_type | 
		       (instr_type_i == `TYPEU) | 
                       (instr_type_i == `TYPEI) | 
		       (instr_type_i == `TYPES)) ? 
                       imm_i : val2_i;

    	wire [9:0] alu_fun;
    	assign alu_fun = (is_r_type | is_i_type) ? funct_i : `ALUADD;

    	always @(*) begin
        	case (alu_fun)
            		`ALUADD  : valE_o = alu1 + alu2;
            		`ALUSUB  : valE_o = alu1 - alu2;
            		`ALUSLL  : valE_o = alu1 << alu2[4:0];
            		`ALUSLT  : valE_o = ($signed(alu1) < $signed(alu2)) ? 1 : 0;
            		`ALUSLTU : valE_o = (alu1 < alu2) ? 1 : 0;
            		`ALUXOR  : valE_o = alu1 ^ alu2;
            		`ALUSRL  : valE_o = alu1 >> alu2[4:0];
            		`ALUSRA  : valE_o = $signed(alu1) >>> alu2[4:0];
            		`ALUOR   : valE_o = alu1 | alu2;
            		`ALUAND  : valE_o = alu1 & alu2;
            		default  : valE_o = 0;
        	endcase
    	end

    	assign Cnd_o = is_b_type & (
        	(funct_i == `FUNC_BEQ)  ? (val1_i == val2_i) :
        	(funct_i == `FUNC_BNE)  ? (val1_i != val2_i) :
        	(funct_i == `FUNC_BLT)  ? ($signed(val1_i) < $signed(val2_i)) :
        	(funct_i == `FUNC_BGE)  ? ($signed(val1_i) >= $signed(val2_i)) :
        	(funct_i == `FUNC_BLTU) ? (val1_i < val2_i) :
        	(funct_i == `FUNC_BGEU) ? (val1_i >= val2_i) :
        	1'b0
    	);
endmodule