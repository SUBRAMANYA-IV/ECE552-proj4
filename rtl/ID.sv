`default_nettype none
module ID (
    input wire rst,           //input to RF
    input wire clk,           //input to RF
    input wire [31:0] i_instruct, //full instruction input
    input wire [31:0] i_write_back, //input from write back stage goes into RF write port 

    output wire o_jal,     //output from control unit
    output wire o_jalr,    //output from control unit
    output wire o_branch,  //output from control unit
    output wire o_MemRead, //output from control unit
    output wire [2:0] o_Data_sel, //output from control unit used for WB module
    output wire o_MemWrite,       //output from control unit
    output wire o_ALUsrc1,        //output from control unit (select ALU operand)
    output wire o_ALUsrc2,        //output from control unit (selects ALU operand)
    output wire o_ALUop[1:0],     //output from control unit goes to ALU control


    output wire [31:0] o_op1, //alu operand 1 
    output wire [31:0] o_op2, //alu operand 2 
    output wire [31:0] o_imm,  //the generated immediate 
    output wire [31:0] o_Rdata2 // will feed into memory 'write data' port 
);

  //instantiate decoder?
  decoder Control (
      .i_opcode(i_instruct[6:0]),
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

      .i_rs1_radder(i_instruct[19:15]),
      .o_rs1_rdata (o_r_data1),

      .i_rs1_radder(i_instruct[24:20]),
      .o_rs2_rdata (o_r_data2),

      .i_rd_wen  (o_RegWrite),
      .i_rd_waddr(i_instruct[11:7]),
      .i_rd_wdata(write_back),
  );

  //instantiate imm_gen
  imm_gen imm (
      .i_inst(i_instruct),
      .i_format(i_instruct[6:0]),  //TODO: how does it shrink a 7 bit input to 6?
      .o_immediate(o_imm)
  );

endmodule

`default_nettype wire
