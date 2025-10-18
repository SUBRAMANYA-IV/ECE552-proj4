`default_nettype none
module MEM(

  /* 
    Actual memory interface will be inside hart.v module 
    Designer can choose to just pass through input signals such as i_Memwrite since nothing will be done with 
    memory inside this file (to stay consistent) or remove completly from this module and interface inside hart.v
  */
  input wire i_MemWrite,       //input from control unit to memory
  input wire i_MemRead,        //input from control unit to memory 
  input wire [31:0] i_Wdata,    //input to Write data of Memory 
  input wire [31:0] i_aluResult,//Output from ALU can be used for either memory adress or multiplexed to next PC
  input wire [31:0] i_PC4,       //previous PC+4 used as input for multiplexer
  input wire [31:0] i_PCimm,     //previous PC+imm used as input for multiplexer 
  input wire [1:0] i_MUXpc,    //select signal used to select next PC


  output wire [31:0] o_nxtPC //the next PC based off Mux select signals 

  /*if we decide to pass memory interface signals through this module need to create the following 
    output for MemWrite, 
    output for Memread, 
    output for MemAdress (from i_aluResult)
    output for Write data
  */

  
  );

endmodule

`default_nettype wire