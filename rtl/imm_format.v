module imm_format(
    input wire [6:0] opcode,

    // Instruction format, determined by the instruction decoder based on the
    // opcode. This is one-hot encoded according to the following format:
    // [0] R-type (don't-care, see below)
    // [1] I-type
    // [2] S-type
    // [3] B-type
    // [4] U-type
    // [5] J-type
    output wire [5:0] i_format
);


    assign i_format = (opcode == 7'b011_0011) ? 6'b00_0001 : // R-type
                      (opcode == 7'b000_0011 || opcode == 7'b001_0011 || opcode == 7'b110_0111) ? 6'b000010 : // I-type
                      (opcode == 7'b010_0011) ? 6'b000100 : // S-type
                      (opcode == 7'b110_0011) ? 6'b001000 : // B-type
                      (opcode == 7'b011_0111 || opcode == 7'b001_0111) ? 6'b010000 : // U-type
                      (opcode == 7'b110_1111) ? 6'b100000 : // J-type
                      6'b000000; // default to R-type for don't care



endmodule