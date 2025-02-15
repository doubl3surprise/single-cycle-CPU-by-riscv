module access_instruction_memory(
	input wire [31:0] pc_i,
	output wire [31:0] instr_o,
	output wire imem_error_o);
	reg [7:0] ins_mem [1023:0];
	// initaial instruction memory
	integer i;
		initial begin
    		// ????????0
    		for (i=0; i<1024; i=i+1) begin
        		ins_mem[i] = 8'h00;
    		end

    		// ??1: (I-type) ADDI x1, x0, 0x123 - ???????
    		// 0x12308093 (???: 0x12 30 80 93)
    		ins_mem[3] = 8'h12;  // PC=0
    		ins_mem[2] = 8'h30;
    		ins_mem[1] = 8'h80;
    		ins_mem[0] = 8'h93;

    		// ??2: (R-type) ADD x2, x1, x2 - ???????
    		// 0x00208133 (00 20 81 33)
    		ins_mem[7] = 8'h00;
    		ins_mem[6] = 8'h20;
    		ins_mem[5] = 8'h81;
    		ins_mem[4] = 8'h33;

    		// ??3: (S-type) SW x3, 0x100(x4) - ??store??
    		// 0x08322023 (08 32 20 23)
    		ins_mem[11] = 8'h08;
    		ins_mem[10] = 8'h32;
    		ins_mem[9] = 8'h20;
    		ins_mem[8] = 8'h23;

    		// ??4: (B-type) BEQ x1, x2, label - ??????
    		// 0x00208863 (00 20 88 63)
    		ins_mem[15] = 8'h00;
    		ins_mem[14] = 8'h20;
    		ins_mem[13] = 8'h88;
    		ins_mem[12] = 8'h63;

    		// ??5: (U-type) LUI x5, 0x12345 - ???????
    		// 0x123452b7 (12 34 52 b7)
    		ins_mem[19] = 8'h12;
    		ins_mem[18] = 8'h34;
    		ins_mem[17] = 8'h52;
    		ins_mem[16] = 8'hb7;

    		// ??6: (J-type) JAL x6, target - ??????
    		// 0x0100036f (01 00 03 6f)
    		ins_mem[23] = 8'h01;
    		ins_mem[22] = 8'h00;
    		ins_mem[21] = 8'h03;
    		ins_mem[20] = 8'h6f;

    		// ??7: (I-type) LW x7, 0x100(x8) - ??load??
    		// 0x10042383 (10 04 23 83)
    		ins_mem[27] = 8'h10;
    		ins_mem[26] = 8'h04;
    		ins_mem[25] = 8'h23;
    		ins_mem[24] = 8'h83;

    		// ??8: (R-type) XOR x9, x10, x11 - ??????
    		// 0x00b544b3 (00 b5 44 b3)
    		ins_mem[31] = 8'h00;
    		ins_mem[30] = 8'hb5;
    		ins_mem[29] = 8'h44;
    		ins_mem[28] = 8'hb3;

    		// ??9: (I-type) ANDI x12, x13, 0xff - ?????????
    		// 0x0ff6f613 (0f f6 f6 13)
    		ins_mem[35] = 8'h0f;
    		ins_mem[34] = 8'hf6;
    		ins_mem[33] = 8'hf6;
    		ins_mem[32] = 8'h13;

    		// ??10: (S-type) SH x14, 0x20(x15) - ??????
    		// 0x0ee79023 (0e e7 90 23)
    		ins_mem[39] = 8'h0e;
    		ins_mem[38] = 8'he7;
    		ins_mem[37] = 8'h90;
    		ins_mem[36] = 8'h23;

    		// ??11: (B-type) BNE x0, x0, target - ??????
    		// 0x00001463 (00 00 14 63)
    		ins_mem[43] = 8'h00;
    		ins_mem[42] = 8'h00;
    		ins_mem[41] = 8'h14;
    		ins_mem[40] = 8'h63;

    		// ??12: (U-type) AUIPC x16, 0x87654 - ??PC????
    		// 0x87654817 (87 65 48 17)
    		ins_mem[47] = 8'h87;
    		ins_mem[46] = 8'h65;
    		ins_mem[45] = 8'h48;
    		ins_mem[44] = 8'h17;

    		// ??13: (I-type) SRAI x17, x18, 5 - ??????
    		// 0x40595893 (40 59 58 93)
    		ins_mem[51] = 8'h40;
    		ins_mem[50] = 8'h59;
    		ins_mem[49] = 8'h58;
    		ins_mem[48] = 8'h93;

    		// ??14: (R-type) SLT x19, x20, x21 - ??????
    		// 0x015a29b3 (01 5a 29 b3)
    		ins_mem[55] = 8'h01;
    		ins_mem[54] = 8'h5a;
    		ins_mem[53] = 8'h29;
    		ins_mem[52] = 8'hb3;

    		// ??????15: (I-type) ADDI x0, x0, 0 - ????????
    		// 0x00000013 (00 00 00 13) @ pc=56
    		ins_mem[59] = 8'h00;
    		ins_mem[58] = 8'h00;
    		ins_mem[57] = 8'h00;
    		ins_mem[56] = 8'h13;
	end
	assign instr_o = {ins_mem[pc_i + 3], ins_mem[pc_i + 2], 
		ins_mem[pc_i + 1], ins_mem[pc_i + 0]};
	assign imem_error_o = (pc_i >= 1023);
endmodule