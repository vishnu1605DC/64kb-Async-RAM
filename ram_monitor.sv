`define MON_IF vif.monitor_mp

class ram_monitor extends uvm_monitor;
  
  `uvm_component_utils(ram_monitor)
  
  virtual ram_interface vif;
  
  uvm_analysis_port#(ram_sequence_item) ap;
  
  function new(string name="ram_monitor", uvm_component parent);
    super.new(name,parent);
    //ap = new("ap",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ap=new("ap",this);
    
    if(!uvm_config_db#(virtual ram_interface)::get(this,"","vif",vif)) begin
      `uvm_error("build_phase","no virtual interface specified for this monitor")
      
    end
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      
      ram_sequence_item transaction;
      transaction = ram_sequence_item::type_id::create("transaction");
      
      @(posedge `MON_IF.chip_en or posedge `MON_IF.rd_en or posedge `MON_IF.wr_en or posedge `MON_IF.reset)begin
  
        
      
      transaction.wr_en=`MON_IF.wr_en;
      transaction.rd_en=`MON_IF.rd_en;
      transaction.chip_en=`MON_IF.chip_en;
      transaction.addr=`MON_IF.addr;
      transaction.data_in=`MON_IF.data_in;
      transaction.data_out=`MON_IF.data_out;
      transaction.reset=`MON_IF.reset;  
      #20;
        
        
     ap.write(transaction);
        
       // $display("after write after delay At time %tns wr_en=%0b, rd_en=%0b, chip_en=%0b, addr=%0h, data_in=%0h,reset=%0b",$time,transaction.wr_en,transaction.rd_en,transaction.chip_en, transaction.addr, transaction.data_in, transaction.reset);
                    
        
      end
    end
      
      endtask
      endclass
      
  
  
