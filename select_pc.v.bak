`include "define.v"
module select_pc(
	input wire clk_i,
	input wire [6:0] opcode_i,
	input wire [31:0] pc_i,
	input wire [31:0] imm_i,
	input wire [31:0] valE_i,
	input wire [31:0] default_pc_i,
	input wire Cnd_o,
	output reg [31:0] new_pc_o
);
	wire [31:0] jalr_target = valE_i & 32'hFFFFFFFE;
    
    	always @(posedge clk_i) begin
        	case(opcode_i)
            		`OP_JAL  : new_pc_o <= imm_i;
            		`OP_JALR : new_pc_o <= jalr_target;
            		`OP_B    : new_pc_o <= Cnd_o ? valE_i : default_pc_i;
            		default  : new_pc_o <= default_pc_i;
        	endcase
    	end
endmodule