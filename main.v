`timescale 1ns/1ps
`include "define.v"

module riscv32i_tb;
    reg clk;
    reg reset;
    wire [31:0] pc;
    wire [31:0] instr;
    wire [31:0] reg_write_data;
    wire [4:0]  reg_write_rd;
    wire        reg_write_en;

    // Instantiate Processor Modules
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
        .set_cc_i(1'b0),
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
        .valA_i(val2),  // Store data from rs2
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

    // Simulated Register File Writeback
    assign reg_write_en = (opcode == `OP_JAL || opcode == `OP_JALR || opcode == `OP_LUI || opcode == `OP_AUIPC || opcode == `OP_R || opcode == `OP_IMM);
    assign reg_write_rd = rd;
    assign reg_write_data = (opcode == `OP_JAL || opcode == `OP_JALR) ? pc_plus4 : valE;

    // Clock Generation
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    // Monitor Signals
    initial begin
        $monitor("Time=%t PC=%h Instr=%h Reg[%d]=%h", 
                 $time, pc, fetch_inst.instr, reg_write_rd, reg_write_data);
    end

    // Generate VCD Waveform
    initial begin
        $dumpfile("riscv32i.vcd");
        $dumpvars(0, riscv32i_tb);
    end
endmodule