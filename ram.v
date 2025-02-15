`include "define.v"
module ram(input wire clk_i,
	input wire r_en_i,
	input wire w_en_i,
	input wire [9:0] funct_i,
	input wire [31:0] addr_i,
	input wire [31:0] wdata_i,
	output wire [31:0] rdata_o
);
	reg [7:0] mem[1023:0];
	integer i;
	initial begin
		for(i = 0; i < 32; i = i + 1) begin
            		mem[i] = i[7:0];
        	end
		for(i = 33; i < 1024; i = i + 1) begin
			mem[i] = 8'd0;
		end
	end

	always @(posedge clk_i) if(w_en_i) begin
        	case(funct_i)
            	`FUNC_SB: mem[addr_i] <= wdata_i[7:0];
            	`FUNC_SH: {mem[addr_i+1], mem[addr_i]} <= wdata_i[15:0];
            	`FUNC_SW: {mem[addr_i+3], mem[addr_i+2], 
                      	mem[addr_i+1], mem[addr_i]} <= wdata_i;
        	endcase
    	end

    	wire [31:0] load_word = {mem[addr_i+3], mem[addr_i+2], 
                            mem[addr_i+1], mem[addr_i]};
    	wire [15:0] load_half = {mem[addr_i+1], mem[addr_i]};
    	wire  [7:0] load_byte = mem[addr_i];
    	assign rdata_o = r_en_i ? 
        	(funct_i == `FUNC_LW)  ? load_word :
        	(funct_i == `FUNC_LH)  ? {{16{load_half[15]}}, load_half} :
        	(funct_i == `FUNC_LB)  ? {{24{load_byte[7]}}, load_byte} :
        	(funct_i == `FUNC_LHU) ? {16'd0, load_half} :
        	(funct_i == `FUNC_LBU) ? {24'd0, load_byte} : 32'd0
        	: 32'd0;

endmodule