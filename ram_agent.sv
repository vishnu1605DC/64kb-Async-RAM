class ram_agent extends uvm_agent;
  `uvm_component_utils(ram_agent)
  ram_sequencer seqr;
  ram_driver driv;
  ram_monitor mon;
  /*agent_cfg cfg;*/
  
 /* `uvm_component_utils_begin(ram_agent)
  `uvm_field_object(seqr, UVM_ALL_ON)
  `uvm_field_object(driv, UVM_ALL_On)
  `uvm_field_object(mon, UVM_ALL_ON)
  `uvm_component_utils_end*/
  
  function new(string name="ram_agent", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon=ram_monitor::type_id::create("mon",this);
//     uvm_config_db#(agent_cfg)::get(this,"","cfg",cfg);
//     if(cfg.get_active())begin
      seqr=ram_sequencer::type_id::create("seqr",this);
      driv=ram_driver::type_id::create("driv",this);
    //end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
   // if(cfg.get_active()) begin
    driv.seq_item_port.connect(seqr.seq_item_export);
      uvm_report_info("ram_agent", "driver and sequencer connected successfully");
   // end
  endfunction
endclass
    
  
  
