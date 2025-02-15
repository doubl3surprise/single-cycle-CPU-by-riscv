module access_register_file(
    	input  wire [4:0]  rs1_i,
    	input  wire [4:0]  rs2_i,
    	input  wire        valid_src1_i,
    	input  wire        valid_src2_i,
    	output wire [31:0] val1_o,
    	output wire [31:0] val2_o
);
    	reg [31:0] reg_file [0:31];
    
    	integer i;
    	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			reg_file[i] = 32'd0;
		end
    	end

    	assign val1_o = (valid_src1_i && rs1_i != 5'd0) ? reg_file[rs1_i] : 32'd0;
    	assign val2_o = (valid_src2_i && rs2_i != 5'd0) ? reg_file[rs2_i] : 32'd0;
endmodule