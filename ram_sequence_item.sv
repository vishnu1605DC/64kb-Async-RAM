`include "uvm_macros.svh"

class ram_sequence_item extends uvm_sequence_item;
 `uvm_object_utils(ram_sequence_item)
  
 
  
  logic wr_en=1;
  logic rd_en=0;
  logic chip_en=1;
  rand logic [15:0] addr;
  rand logic [7:0] data_in;
  rand logic reset;
  logic [7:0] data_out;

  function new(string name="ram_sequence_item");
    super.new(name);
  endfunction
endclass
