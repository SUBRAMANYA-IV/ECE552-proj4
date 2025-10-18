`default_nettype none
module WB(


  input wire[31:0] i_MemData,  //data coming from Memory
  input wire[31:0] i_AluRslt,   //ALU operation result 
  input wire[31:0] i_imm,        //output from immediate generator 
  input wire[31:0] i_PC4,       //incremented PC (used to save jump return adress in register)
  input wire [1:0] i_MUXsel,    //MUX select signals coming from control unit 

  output wire [31:0] o_dataSel // data selected from mux to feedback into write port of Register file
  );

endmodule
`default_nettype wire