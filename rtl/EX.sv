`default_nettype none

module EX(
  input wire[31:0] i_pc,    //Current PC input should be added to immediate (used for branch instructions)
  input wire[2:0] func3,     //func 3 input for branch logic block (branch.v file)
  input wire i_jal,          //control signal for branch logic block
  input wire i_jalr,         //control signal for branch logic block
  input wire i_branch,       //control signal for branch logic block
  input wire [2:0] i_ALUOp,  //input to ALU CTRL unit

  input wire[31:0] i_op1,   //ALU operand1
  input wire[31:0] i_op2,   //ALU operand2

  input wire[31:0] i_imm,//i_imm is used for adding to current PC if we are in I instruction i_op2 will be input as immediate already
  input wire[3:0] func,  //combination of func7 and func 3 used by ALU control

 /* 
 Outputs defined below
 */
  output wire o_eq,             //connect to ALU
  output wire o_slt,            //connect to ALU
  output wire[31:0] o_result,   //connect to ALU
  output wire[1:0]  o_PC_Select, //output of Branch logic unit used to select next PC
  output wire[31:0] o_inc_pc   //The inputted PC + Immediate (used for branch adress calculation)
  );
endmodule

`default_nettype wire
