class ram_environment extends uvm_env;
  `uvm_component_utils(ram_environment)
  ram_agent agt;
  ram_scoreboard scb;
  
  function new(string name="ram_environment", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt=ram_agent::type_id::create("agt",this);
    scb=ram_scoreboard::type_id::create("scb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.ap.connect(scb.scb_export);
    uvm_report_info("ram_environment","Maneater connected to scoreboard successfully");
  endfunction
endclass
    
