module access_instruction_memory(
	input wire [63:0] pc_i,
	output wire [31:0] instr_o,
	output wire imem_error_o);
	reg [7:0] ins_mem [1023:0];
	// initaial instruction memory
	integer i;
	initial begin
    		// Initialize all memory to zero
    		for (i=0; i<1024; i=i+1) begin
    		    ins_mem[i] = 8'h00;
    		end
    
   		 // ??1: 0x00000013 (NOP)
    		ins_mem[3] = 8'h00;  // ???????
    		ins_mem[2] = 8'h00;
    		ins_mem[1] = 8'h00;
    		ins_mem[0] = 8'h13;

    		// ??2: 0x00100093 (ADDI x1, x0, 1)
    		ins_mem[7] = 8'h00;
    		ins_mem[6] = 8'h10;
    		ins_mem[5] = 8'h00;
    		ins_mem[4] = 8'h93;

    		// ??3: 0x00200113 (ADDI x2, x0, 2)
    		ins_mem[11] = 8'h00;
    		ins_mem[10] = 8'h20;
    		ins_mem[9] = 8'h01;
    		ins_mem[8] = 8'h13;

    		// ??4: 0x00308193 (ADDI x3, x1, 3)
    		ins_mem[15] = 8'h00;
    		ins_mem[14] = 8'h30;
    		ins_mem[13] = 8'h81;
    		ins_mem[12] = 8'h93;

    		// ??5: 0x00420213 (ADDI x4, x4, 4)
    		ins_mem[19] = 8'h00;
    		ins_mem[18] = 8'h42;
    		ins_mem[17] = 8'h02;
    		ins_mem[16] = 8'h13;

    		// ??6: 0x00528293 (ADDI x5, x5, 5)
    		ins_mem[23] = 8'h00;
    		ins_mem[22] = 8'h52;
    		ins_mem[21] = 8'h82;
    		ins_mem[20] = 8'h93;

    		// ??7: 0x00630313 (ADDI x6, x6, 6)
    		ins_mem[27] = 8'h00;
    		ins_mem[26] = 8'h63;
    		ins_mem[25] = 8'h03;
    		ins_mem[24] = 8'h13;

    		// ??8: 0x00738393 (ADDI x7, x7, 7)
    		ins_mem[31] = 8'h00;
    		ins_mem[30] = 8'h73;
    		ins_mem[29] = 8'h83;
    		ins_mem[28] = 8'h93;

    		// ??9: 0x00840413 (ADDI x8, x8, 8)
    		ins_mem[35] = 8'h00;
    		ins_mem[34] = 8'h84;
    		ins_mem[33] = 8'h04;
    		ins_mem[32] = 8'h13;

    		// ??10: 0x00948493 (ADDI x9, x9, 9)
    		ins_mem[39] = 8'h00;
    		ins_mem[38] = 8'h94;
    		ins_mem[37] = 8'h84;
    		ins_mem[36] = 8'h93;

    		// ??11: 0x00a50513 (ADDI x10, x10, 10)
    		ins_mem[43] = 8'h00;
    		ins_mem[42] = 8'ha5;
    		ins_mem[41] = 8'h05;
    		ins_mem[40] = 8'h13;

    		// ??12: 0x00b58593 (ADDI x11, x11, 11)
    		ins_mem[47] = 8'h00;
    		ins_mem[46] = 8'hb5;
    		ins_mem[45] = 8'h85;
    		ins_mem[44] = 8'h93;

    		// ??13: 0x00c60613 (ADDI x12, x12, 12)
    		ins_mem[51] = 8'h00;
    		ins_mem[50] = 8'hc6;
    		ins_mem[49] = 8'h06;
    		ins_mem[48] = 8'h13;

    		// ??14: 0x00d68693 (ADDI x13, x13, 13)
    		ins_mem[55] = 8'h00;
    		ins_mem[54] = 8'hd6;
    		ins_mem[53] = 8'h86;
    		ins_mem[52] = 8'h93;

    		// ??15: 0x00e70713 (ADDI x14, x14, 14)
    		ins_mem[59] = 8'h00;
    		ins_mem[58] = 8'he7;
    		ins_mem[57] = 8'h07;
    		ins_mem[56] = 8'h13;

    		// ??16: 0x00f78793 (ADDI x15, x15, 15)
    		ins_mem[63] = 8'h00;
    		ins_mem[62] = 8'hf7;
    		ins_mem[61] = 8'h87;
    		ins_mem[60] = 8'h93;
	end
	assign instr_o = {ins_mem[pc_i + 3], ins_mem[pc_i + 2], 
		ins_mem[pc_i + 1], ins_mem[pc_i + 0]};
	assign imem_error_o = (pc_i >= 1023);
endmodule