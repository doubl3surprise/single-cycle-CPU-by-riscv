`include "define.v"
module fetch(
    input  [31:0] pc_i,
    output [6:0]  opcode_o,
    output [4:0]  rd_o,
    output [9:0]  funct_o,
    output [4:0]  rs1_o,
    output [4:0]  rs2_o,
    output [31:0] imm_o,
    output [2:0]  instr_type_o,
    output        imem_error_o,
    output [31:0] pc_plus4_o
);
    
    	wire [31:0]  instr;
    	wire [14:12] func3_bits;
    	wire [31:25] func7_bits;
    	wire [31:0] imm_i, imm_s, imm_b, imm_u, imm_j;
    	wire is_jalr;
    	wire funct_r_type, funct_istb;
    	wire is_imm_i, is_imm_s, is_imm_b, is_imm_u, is_imm_j;

    	access_instruction_memory acc_instr_mem(
     	   .pc_i(pc_i),
    	    .instr_o(instr),
    	    .imem_error_o(imem_error_o)
    	);

    	assign func3_bits = instr[14:12];
    	assign func7_bits = instr[31:25];
    	assign opcode_o    = instr[6:0];
    	assign rd_o        = instr[11:7];
    	assign rs1_o       = instr[19:15];
    	assign rs2_o       = instr[24:20];
    	assign pc_plus4_o  = pc_i + 32'd4;

    	assign imm_i = {{20{instr[31]}}, instr[31:20]};
    	assign imm_s = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    	assign imm_b = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0};
    	assign imm_u = {instr[31:12], 12'b0};
    	assign imm_j = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

    	assign instr_type_o = 
    	    (opcode_o == `OP_B)    ? `TYPEB :
    	    (opcode_o == `OP_S)    ? `TYPES :
   	     (opcode_o == `OP_JAL)  ? `TYPEJ :
   	     (opcode_o == `OP_JALR) ? `TYPEI :
    	    (opcode_o == `OP_R)    ? `TYPER :
    	    (opcode_o == `OP_IMM)  ? `TYPEI :
    	    (opcode_o == `OP_LOAD) ? `TYPEI :
    	    ((opcode_o == `OP_LUI) || (opcode_o == `OP_AUIPC)) ? `TYPEU :
    	    `TYPEI;

    	assign funct_r_type = (instr_type_o == `TYPER);
    	assign funct_istb   = (instr_type_o == `TYPEI) || 
                         (instr_type_o == `TYPES) || 
                         (instr_type_o == `TYPEB);
	wire is_shift_imm = (opcode_o == `OP_IMM) && (func3_bits == 3'b001 || func3_bits == 3'b101);
	assign funct_o = funct_r_type ? {func7_bits, func3_bits} :
                (funct_istb && is_shift_imm) ? {func7_bits, func3_bits} :  // ?? func7
                funct_istb ? {7'b0, func3_bits} :
                10'd0;

    	assign is_imm_i = (instr_type_o == `TYPEI);
    	assign is_imm_s = (instr_type_o == `TYPES);
    	assign is_imm_b = (instr_type_o == `TYPEB);
    	assign is_imm_u = (instr_type_o == `TYPEU);
    	assign is_imm_j = (instr_type_o == `TYPEJ);
    	assign imm_o = ({32{is_imm_i}} & imm_i) |
        	           ({32{is_imm_s}} & imm_s) |
        	           ({32{is_imm_b}} & imm_b) |
        	           ({32{is_imm_u}} & imm_u) |
         	          ({32{is_imm_j}} & imm_j);
endmodule