`default_nettype none
module ID (
    input wire rst,           //input to RF
    input wire clk,           //input to RF
    input wire [31:0] i_instruct, //full instruction input
    input wire [31:0] i_write_back, //input from write back stage goes into RF write port 
    input wire [31:0] i_currentPC, //the current PC value (used for auipc instruction)

    output wire o_jal,     //output from control unit
    output wire o_jalr,    //output from control unit
    output wire o_branch,  //output from control unit
    output wire o_MemRead, //output from control unit
    output wire [1:0] o_Data_sel, //output from control unit used for WB module
    output wire o_MemWrite,       //output from control unit
    output wire [31:0] o_op1,        //output from control unit (select ALU operand)
    output wire [31:0] o_op2,        //output from control unit (selects ALU operand)
    output wire [2:0] o_ALUop,     //output from control unit goes to ALU control
    output wire [31:0] o_imm,  //the generated immediate 
    output wire [31:0] o_Rdata2, // will feed into memory 'write data' port 

    output wire [3:0] func,
    output wire [2:0] func3
);

    wire ALUmux1; 
    wire ALUmux2;
    wire RegWrite; //enable signal for register writing
    wire [5:0] OneHotDecode;//used when converting from opcode to instructin type
    wire [31:0] regData1;//read data1 from register
    wire [31:0] regData2;//read data2 from register 

  //instantiate decoder?
  decoder Control (
      .i_opcode(i_instruct[6:0]),
      .jal(o_jal),
      .jalr(o_jalr),
      .branch(o_branch),
      .MemRead(o_MemRead),
      .MemWrite(o_MemWrite),
      .ALUsrc1(ALUmux1),
      .ALUsrc2(ALUmux2),
      .RegWrite(RegWrite),
      .Data_sel(o_Data_sel),
      .ALUOp(o_ALUop)
  );

  //instantiate register file
  register_file rf (
      .i_clk(clk),
      .i_rst(rst),

      .i_rs1_raddr(i_instruct[19:15]),
      .o_rs1_rdata (regData1),

      .i_rs2_raddr(i_instruct[24:20]),
      .o_rs2_rdata (regData2),

      .i_rd_wen  (RegWrite),
      .i_rd_waddr(i_instruct[11:7]),
      .i_rd_wdata(i_write_back)
  );


 // Instruction format, determined by the instruction decoder based on the
 // opcode. This is one-hot encoded according to the following format:
 // [0] R-type (don't-care, see below)
 // [1] I-type
 // [2] S-type
 // [3] B-type
 // [4] U-type
 // [5] J-type
OneHot imm_format(
   .opcode(i_instruct[6:0]),
   .i_format(OneHotDecode)    //ouput of imm_format
);

  //instantiate imm_gen
  imm_gen imm (
      .i_inst(i_instruct),      //full instruction
      .i_format(OneHotDecode),  //instruction type input
      .o_immediate(o_imm)       //generated immediate 
  ); 

  //func 3 input to branch logic block
  assign func3 = {i_instruct[14:12]}; 

  //combination of func7 and func3 for ALU CTRL
  assign func = {i_instruct[30], i_instruct[14:12] }; 

 //feeds into memory write data port
  assign o_Rdata2 = regData2; 
  
  //if 1 current PC else reagister read 1
  assign o_op1 = (ALUmux1)? i_currentPC : regData1; //mux for ALU operand

  //if 1 take immediate else register read2
  assign o_op2 = (ALUmux2)? o_imm : regData2;

endmodule

`default_nettype wire
