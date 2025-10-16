module EX(
  input wire[31:0] i_pc,
  input wire[2:0] func3,
  input wire i_jal,
  input wire i_jalr,
  input wire i_branch,
  input wire i_MemRead,
  input wire[1:0] i_Data_sel,
  input wire i_MemWrite,
  input wire i_ALUSrc,
  input wire i_ALUOp,

  input wire[31:0] i_r_data1,
  input wire[31:0] i_r_data2,

  input wire[31:0] i_imm,

  input wire[3:0] thing, //TODO: tf is this? [30,14:12] bit slide from op code?

  input wire[31:0] i_inc_pc,

  output wire o_eq,
  output wire o_slt,
  output wire[31:0] o_result,

  //TODO: decide how to handle the 2 priority-muxes at the top of the diagram



  );
endmodule
