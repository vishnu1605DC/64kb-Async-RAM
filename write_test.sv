class write_test extends ram_test;
  `uvm_component_utils(write_test)
  
  function new(string name="write_test",uvm_component parent= null);
    super.new(name,parent);
  endfunction
  
  write_sequence wr_seq;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wr_seq=write_sequence::type_id::create("wr_seq",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    phase.raise_objection(this);
    $display("%t Write sequence start time",$time);                      
    wr_seq.start(env.agt.seqr);
    phase.drop_objection(this,"write sequence finished");
    endtask
endclass 
   
