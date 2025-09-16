
class ram_sequencer extends uvm_sequencer#(ram_sequence_item);
  `uvm_component_utils(ram_sequencer)
  
  function new(string name="ram_seqeuncer", uvm_component parent);
    super.new(name,parent);
  endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  endclass