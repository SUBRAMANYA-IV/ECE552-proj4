//store command: 7'b010 0011
//load command: 7'b000 0011
//
//load/store byte: 000
//load/store half: 001
//load/store word:010
//load byte unsigned: 100
//load half unsigned: 101
//
///////////Notes/////////////////////////
//- address is 32 bits, 4 bytes. 
//- 1 word is 32 bits, 4 bytes. 
//- normally byte alligned, ie address increments by 4 in *hex*
//- ie 0x00000000, 0x00000004, 0x00000008...
//- values like 0x00000005 are misaligned. in binary, 0000 0000 0000 0000 0000 0000 0000 0101
//- to allign it, mask lower 2 *bits*, giving an aligned address of 0x00000004, 
//////////// How to Work ////////////////
//- takes in the address
//- alligns the address (word alligned)
//- inspects the LSB[1:0] as well as the func3
//- depending on this, outputs the alligned address and the appropriate mask. 
//
//byte access/write:
//00- lowest
//01- second lowest
//10- third lowest
//11- highest
//
//
//half word-
//00- bottom half
//10- top half
//
//DEFAULT MASK: 1111
module address_read (
    input wire [31:0] address,
    input wire [2:0] func3,
    input wire [6:0] op_code,
    output wire [31:0] aligned_address,
    output wire o_unsigned,
    output wire [3:0] mask
);

  wire [31:0] aligned_address;
  wire lsb;
  assign lsb = address[1:0];
  assign aligned_address = {address[31:2], 2'b0};

  assign mask = (func3 == 3'b000 || func3 == 3'b100) ?  // byte load/store
      (lsb == 2'b00 ? 4'b1000 :
         lsb == 2'b01 ? 4'b0100 :
         lsb == 2'b10 ? 4'b0010 :
                        4'b0001 ) :
    (func3 == 3'b001 || func3 == 3'b101) ?  // halfword load/store
      (lsb[1] == 1'b0 ? 4'b1100 : 4'b0011) : 4'b0000;  // default

  assign o_unsigned = (func3 == 3'b100 || func3 == 3'b101);
endmodule

