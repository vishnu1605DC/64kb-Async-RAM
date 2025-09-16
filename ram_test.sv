class ram_test extends uvm_test;
  `uvm_component_utils(ram_test)
  virtual ram_interface vif;
  
  
  ram_environment env;
  ram_sequence ram_seq;
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env=ram_environment::type_id::create("env",this);
    if(!uvm_config_db#(virtual ram_interface)::get(this,"","vif",vif))begin
      `uvm_error("ram_test","test virtual interface failed")
     
    end
  endfunction
  
  virtual function void end_of_elaboration();
    print();
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
   // uvm_report_info("ram_test","test problem1");
    ram_seq=ram_sequence::type_id::create("ram_seq");
  //  uvm_report_info("ram_test","test problem2");
    
    phase.raise_objection(this,"Starting base sequence");
    $display("%t Base sequence started",$time);
   // uvm_report_info("ram_test","test problem3");
    ram_seq.start(env.agt.seqr);
    uvm_report_info("ram_test","seqr driv handshake initiated");
  //  uvm_report_info("ram_test","test problem4");
    phase.drop_objection(this,"Base sequence completed");
   // uvm_report_info("ram_test","test problem5");
  endtask
endclass
    
    
