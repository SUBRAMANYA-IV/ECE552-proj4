module ID(
  input wire[31:0] i_imem,
  input wire clk,
  output wire o_jal,
  output wire o_jalr,
  output wire o_branch,
  output wire o_MemRead,
  output wire[1:0] o_Data_sel,
  output wire o_MemWrite,
  output wire o_ALUSrc,
  output wire o_ALUop,
  output wire o_RegWrite,
  output wire[31:0] o_r_data1,
  output wire[31:0] o_r_data2,
  output wire[31:0] o_imm
  );
endmodule
