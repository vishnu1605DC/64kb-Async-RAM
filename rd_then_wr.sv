class rd_then_wr extends ram_test;
  `uvm_component_utils(rd_then_wr)
  
  read_then_write_sequence rd_wr_seq;
  
  function new(string name="rd_then_wr",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rd_wr_seq=read_then_write_sequence::type_id::create("rd_wr_seq",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
 
    phase.raise_objection(this);
    rd_wr_seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass
