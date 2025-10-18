`default_nettype none

module IF(
  input wire clk,           //clk to control PC update
  input wire rst,           //used to reset PC to starting value
  input wire i_NextPC,      //next adress for PC either PC+4 or branch/jump PC

  output wire o_PC,          //current PC will feed into instruction memory and other locations (schematic) 
  output wire[31:0] o_inc_pc //Output current PC + 4 
  );
endmodule

`default_nettype wire