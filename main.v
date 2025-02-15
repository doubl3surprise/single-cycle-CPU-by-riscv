`timescale 10ps/1ps
`include "define.v"
module main;
    	reg clk;
    	reg [31:0] pc;
    	wire [6:0] opcode;
	wire [4:0] rd;
	wire [9:0] funct;
	wire [4:0] rs1;
	wire [4:0] rs2;
	wire [31:0] imm;
	wire [2:0] instr_type;
	wire imem_error;
	wire [31:0] pc_plus4;
	wire [31:0] val1;
	wire [31:0] val2;
	wire [31:0] valE;
	wire Cnd;
	wire [31:0] valm;
	wire dmem_error;
	wire [31:0] new_pc;
	
    	fetch fetch_inst(
        	.pc_i(pc),
        	.opcode_o(opcode),
        	.rd_o(rd),
        	.funct_o(funct),
        	.rs1_o(rs1),
        	.rs2_o(rs2),
        	.imm_o(imm),
        	.instr_type_o(instr_type),
        	.imem_error_o(imem_error),
        	.pc_plus4_o(pc_plus4)
    	);

    	decode decode_inst(
        	.instr_type_i(instr_type),
        	.rs1_i(rs1),
        	.rs2_i(rs2),
        	.val1_o(val1),
        	.val2_o(val2)
    	);

    	execute execute_inst(
        	.clk_i(clk),
        	.instr_type_i(instr_type),
        	.opcode_i(opcode),
        	.val1_i(val1),
        	.val2_i(val2),
        	.imm_i(imm),
        	.funct_i(funct),
        	.pc_i(pc),
        	.valE_o(valE),
        	.Cnd_o(Cnd)
    	);

    	memory_access mem_inst(
        	.clk_i(clk),
        	.opcode(opcode),
        	.funct_i(funct),
        	.valE_i(valE),
        	.valA_i(val2),
        	.valm_o(valm),
        	.dmem_error_o(dmem_error)
    	);

    	select_pc pc_sel(
        	.clk_i(clk),
        	.opcode_i(opcode),
        	.pc_i(pc),
        	.imm_i(imm),
        	.valE_i(valE),
        	.default_pc_i(pc_plus4),
        	.Cnd_o(Cnd),
        	.new_pc_o(new_pc)
    	);

	initial begin
		forever @ (posedge clk) #2 pc= new_pc;
	end
	
	reg [6:0] cycle_count;
	always @(posedge clk) begin
    		cycle_count <= cycle_count + 1;
    		if (cycle_count >= 15) begin
      			$stop;
    		end
	end

	initial begin
        	clk = 0;
		pc = 0;
		cycle_count = 0;
        	forever #10 clk = ~clk;
    	end
endmodule