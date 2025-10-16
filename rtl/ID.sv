module ID (
    input wire rst,
    input wire clk,
    input wire [31:0] i_imem,
    input wire [31:0] write_back,
    input wire clk,
    output wire o_jal,
    output wire o_jalr,
    output wire o_branch,
    output wire o_MemRead,
    output wire [2:0] o_Data_sel,
    output wire o_MemWrite,
    output wire o_ALUsrc1,
    output wire o_ALUsrc2,
    output wire o_ALUop[1:0],
    output wire o_RegWrite,  //note: doesn't have to be output?
    output wire [31:0] o_r_data1,
    output wire [31:0] o_r_data2,
    output wire [31:0] o_imm
);

  //instantiate decoder?
  decoder Control (
      .i_opcode(i_imen[6:0]),
      .jal(o_jal),
      .jalr(o_jalr),
      .branch(o_branch),
      .MemRead(o_MemRead),
      .MemWrite(o_MemWrite),
      .ALUsrc1(o_ALUSrc1),
      .ALUsrc2(o_ALUSrc2),
      .RegWrite(o_RegWrite),
      .Data_sel(o_Data_sel),
      .ALUOp(o_ALUop)
  );

  //instantiate register file
  register_file rf (
      .i_clk(clk),
      .i_rst(rst),

      .i_rs1_radder(i_imem[19:15]),
      .o_rs1_rdata (o_r_data1),

      .i_rs1_radder(i_imem[24:20]),
      .o_rs2_rdata (o_r_data2),

      .i_rd_wen  (o_RegWrite),
      .i_rd_waddr(i_imem[11:7]),
      .i_rd_wdata(write_back),
  );

  //instantiate imm_gen
  imm_gen imm (
      .i_inst(i_imem),
      .i_format(i_imem[6:0]),  //TODO: how does it shrink a 7 bit input to 6?
      .o_immediate(o_imm)
  );

endmodule

