module alu_control(
    //bits [30, 14:12] of instruction, 30 is funct7[5], 14:12 is funct3
    input wire [3:0] instruction_bits,

    //000 for R
    //001 for I
    //010 for S
    //011 for B 
    //100 for U
    //101 for J
    input wire [2:0] alu_op,

    // When asserted, comparison operations should be treated as unsigned.
    // This is only used for branch comparisons and set less than.
    // For branch operations, the ALU result is not used, only the comparison
    // results.
    output wire i_unsigned,

    // When asserted, addition operations should subtract instead.
    // This is only used for `i_opsel == 3'b000` (addition/subtraction).
    output wire i_sub,

    // When asserted, right shifts should be treated as arithmetic instead of
    // logical. This is only used for `i_opsel == 3'b011` (shift right).
    output wire i_arith,

    // 3'b000: addition/subtraction if `i_sub` asserted
    // 3'b001: shift left logical
    // 3'b010,
    // 3'b011: set less than/unsigned if `i_unsigned` asserted
    // 3'b100: exclusive or
    // 3'b101: shift right logical/arithmetic if `i_arith` asserted
    // 3'b110: or
    // 3'b111: and
    output wire [2:0] i_opsel
);
    
    assign i_arith = instruction_bits[3]; //funct7[5] bit

    assign i_unsigned = instruction_bits[0]; //funct3[0] bit

    assign i_sub = instruction_bits[3]; //funct7[5] bit is 1



endmodule