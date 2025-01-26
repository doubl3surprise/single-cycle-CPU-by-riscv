// instruction type
`define TYPEB 3'd0
`define TYPEI 3'd1
`define TYPEU 3'd2
`define TYPES 3'd3
`define TYPEJ 3'd4
`define TYPER 3'd5
// opcode
`define OP_LUI 7'b0110111 
`define OP_ALUIPC 7'b0010111
`define OP_JAL 7'b1101111
`define OP_JALR 7'b1100111
`define OP_B 7'b1100011
`define OP_IOAD 7'b0000011
`define OP_S 7'b0100011
`define OP_IMM 7'b0010011
`define OP_R 7'b0110011
// ALU
`define ALUADD 10'b0000000000
`define ALUSUB 10'b0100000000
`define ALUSLL 10'b0000000001
`define ALUSLT 10'b0000000010
`define ALUSLTU 10'b0000000011
`define ALUXOR 10'b0000000100
`define ALUSRL 10'b0100000100
`define ALUSRA 10'b0000000101
`define ALUOR 10'b0000000110
`define ALUAND 10'b0000000111
// funct
`define FUNC_BEQ 10'b0000000000
`define FUNC_BNE 10'b0000000001
`define FUNC_BLT 10'b0000000100
`define FUNC_BGE 10'b0000000101
`define FUNC_BLTU 10'b0000000110
`define FUNC_BGEU 10'b0000000111