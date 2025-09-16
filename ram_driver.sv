	`define DRIV_IF vif.driver_mp

class ram_driver extends uvm_driver#(ram_sequence_item);
  `uvm_component_utils(ram_driver)
  ram_sequence_item trans;
  virtual ram_interface vif;
  
  function new(string name="ram_driver", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ram_interface)::get(this,"","vif",vif))
    `uvm_fatal("NO_vif",{"virtual interface must be set for :  ",get_full_name(),".vif"});
  endfunction
  
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      trans=ram_sequence_item::type_id::create("trans");
      seq_item_port.get_next_item(trans);
      
      
       if(trans.reset) begin
        `DRIV_IF.reset=trans.reset;
        `DRIV_IF.wr_en = 0;
        `DRIV_IF.rd_en = 0;
        `DRIV_IF.addr = 0;
        `DRIV_IF.data_in = 0;
        #20;
      end
      if(trans.chip_en==1) begin
        
        if(trans.rd_en==0 && trans.wr_en==0) begin
        //do nothing
      end
        
      
        else if((trans.rd_en==0 && trans.wr_en==1) || (trans.rd_en==1 && trans.wr_en==1) ) begin
        `DRIV_IF.chip_en=trans.chip_en;
        `DRIV_IF.addr=trans.addr;
        `DRIV_IF.data_in=trans.data_in;
        `DRIV_IF.wr_en=trans.wr_en;
        `DRIV_IF.rd_en=trans.rd_en;
        `DRIV_IF.reset=trans.reset;
        #20;
      end
      
      else if(trans.rd_en==1 && trans.wr_en==0) begin
        `DRIV_IF.chip_en=trans.chip_en;
        `DRIV_IF.wr_en=trans.wr_en;
        `DRIV_IF.rd_en=trans.rd_en;
        `DRIV_IF.addr=trans.addr;
        `DRIV_IF.reset=trans.reset;
        #20;
      end
      end
      else if(trans.chip_en==0)begin
        uvm_report_info("ram_driver","Chip enable is low");
        `DRIV_IF.chip_en=trans.chip_en;
        `DRIV_IF.addr=trans.addr;
        `DRIV_IF.data_in=trans.data_in;
        `DRIV_IF.wr_en=trans.wr_en;
        `DRIV_IF.rd_en=trans.rd_en;
        `DRIV_IF.reset=trans.reset;
        
        #20;
      end
        
      seq_item_port.item_done();
      
     // $display("Randomized values received at driver after sending to dut after itemdone: wr_en=%0b, rd_en=%0b, chip_en=%0b, addr=%0h, data_in=%0h,reset=%0b",`DRIV_IF.wr_en,`DRIV_IF.rd_en,`DRIV_IF.chip_en, `DRIV_IF.addr,`DRIV_IF.data_in,`DRIV_IF.reset);
    end
  endtask
endclass
   
  
