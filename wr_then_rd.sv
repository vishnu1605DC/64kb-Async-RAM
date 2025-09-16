class wr_then_rd extends ram_test;
  `uvm_component_utils(wr_then_rd)
  
  write_read_sequence wr_rd_seq;
  
  function new(string name="wr_then_rd",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wr_rd_seq=write_read_sequence::type_id::create("wr_rd_seq",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    wr_rd_seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass
