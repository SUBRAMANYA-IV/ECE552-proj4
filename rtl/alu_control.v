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

    // 3'b000: addition/subtraction if `i_sub` asserted //R type
    // 3'b001: shift left logical //R type
    // 3'b010, //R type
    // 3'b011: set less than/unsigned if `i_unsigned` asserted //R type
    // 3'b100: exclusive or //R type
    // 3'b101: shift right logical/arithmetic if `i_arith` asserted //R type
    // 3'b110: or //R type
    // 3'b111: and //R type
    output wire [2:0] i_opsel
);

    wire [2:0] ri_type; //for R and I type instructions
    wire [2:0] sbuj_type; //for S, B, U, J type instructions

    
    //logic to assign smaller conditional signals
    assign i_arith = instruction_bits[3]; //funct7[5] bit

    assign i_unsigned = instruction_bits[0]; //funct3[0] bit

    assign i_sub = instruction_bits[3] && (alu_op == 3'b000); //funct7[5] bit is 1

    //logic to assign i_opsel
    assign ri_type = instruction_bits[2:0]; //funct3 bits
    assign sbuj_type = 3'b000;

    assign i_opsel = (alu_op == 3'b000 || alu_op == 3'b001) ? ri_type : sbuj_type;


    


endmodule