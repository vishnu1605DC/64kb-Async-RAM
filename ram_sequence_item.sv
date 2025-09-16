//`include "uvm_macros.svh"

class ram_sequence_item extends uvm_sequence_item;
 `uvm_object_utils(ram_sequence_item)
  
 
  
  randc logic wr_en;
  randc logic rd_en;
  randc bit chip_en;
  randc logic [15:0] addr;
  randc logic [7:0] data_in;
  randc bit reset;
  logic [7:0] data_out;

  function new(string name="ram_sequence_item");
    super.new(name);
  endfunction
endclass
