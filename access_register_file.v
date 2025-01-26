module access_register_file(
	input wire clk_i,
	input wire [4:0] rs1_i,
	input wire [4:0] rs2_i,
	input wire valid_src1_i,
	input wire valid_src2_i,
	output wire [31:0] val1_o,
	output wire [31:0] val2_o
);
	reg [63:0] reg_file [31:0];
	initial begin
		reg_file[0] = 32'd0;
		reg_file[1] = 32'd1;
		reg_file[2] = 32'd2;
		reg_file[3] = 64'd3;
		reg_file[4] = 64'd4;
		reg_file[5] = 64'd5;
		reg_file[6] = 64'd6;
		reg_file[7] = 64'd7;
		reg_file[8] = 64'd8;
		reg_file[9] = 64'd9;
		reg_file[10] = 64'd10;
		reg_file[11] = 64'd11;
		reg_file[12] = 64'd12;
		reg_file[13] = 64'd13;
		reg_file[14] = 64'd14;
		reg_file[15] = 64'd15;
		reg_file[16] = 64'd16;
		reg_file[17] = 64'd17;
		reg_file[18] = 64'd18;
		reg_file[19] = 64'd19;
		reg_file[20] = 64'd20;
		reg_file[21] = 64'd21;
		reg_file[22] = 64'd22;
		reg_file[23] = 64'd23;
		reg_file[24] = 64'd24;
		reg_file[25] = 64'd25;
		reg_file[26] = 64'd26;
		reg_file[27] = 64'd27;
		reg_file[28] = 64'd28;
		reg_file[29] = 64'd29;
		reg_file[30] = 64'd30;
		reg_file[31] = 64'd31;
	end

	assign val1_o = (valid_src1_i) ? reg_file[rs1_i] : 32'd0;
	assign val2_o = (valid_src2_i) ? reg_file[rs2_i] : 32'd0;
endmodule