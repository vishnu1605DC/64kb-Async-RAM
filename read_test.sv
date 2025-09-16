class read_test extends ram_test;
  `uvm_component_utils(read_test)
  
  read_sequence rd_seq;
  
  function new(string name="read_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rd_seq=read_sequence::type_id::create("rd_seq",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    rd_seq.start(env.agt.seqr);
    phase.drop_objection(this);
  endtask
endclass
     
