`include "define.v"
module decode(
	input  wire [2:0]  instr_type_i,
    	input  wire [4:0]  rs1_i,
    	input  wire [4:0]  rs2_i,
    	output wire [31:0] val1_o,
    	output wire [31:0] val2_o
);
    
    	wire read_rs1_en = (
        	(instr_type_i == `TYPER) |  
        	(instr_type_i == `TYPEI) |  
        	(instr_type_i == `TYPES) |  
        	(instr_type_i == `TYPEB)    
    	);

    	wire read_rs2_en = (
        	(instr_type_i == `TYPER) |  
        	(instr_type_i == `TYPES) |  
        	(instr_type_i == `TYPEB)    
    	);

    	access_register_file reg_file (
        	.rs1_i(rs1_i),
        	.rs2_i(rs2_i),
        	.valid_src1_i(read_rs1_en),
        	.valid_src2_i(read_rs2_en),
        	.val1_o(val1_o),
        	.val2_o(val2_o)
    	);
endmodule