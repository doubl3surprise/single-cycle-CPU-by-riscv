module access_instruction_memory(
	input wire [63:0] pc_i,
	output wire [31:0] instr_o,
	output wire imem_error_o);
	reg [7:0] ins_mem [1023:0];
	// initaial instruction memory
	integer i;
	initial begin
		for(i = 0; i < 1024; i = i + 1) begin
			ins_mem[i] = 8'hcc;
		end
	end
	assign instr_o = {ins_mem[pc_i + 3], ins_mem[pc_i + 2], 
		ins_mem[pc_i + 1], ins_mem[pc_i + 0]};
	assign imem_error_o = (pc_i >= 1023);
endmodule