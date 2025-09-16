
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
      $display("Randomized values sent to driver: wr_en=%0b, rd_en=%0b, chip_en=%0b, addr=%0h, data_in=%0h,reset=%0b",trans.wr_en,trans.rd_en,trans.chip_en, trans.addr, trans.data_in, trans.reset);
      
      if(trans.rd_en==0 && trans.wr_en==0) begin
        //do nothing
      end
      else if(trans.reset) begin
        `DRIV_IF.reset=trans.reset;
        `DRIV_IF.wr_en = 0;
        `DRIV_IF.rd_en = 0;
        `DRIV_IF.addr = 0;
        `DRIV_IF.data_in = 0;
        #10;
      end
      
      else if(trans.rd_en==0 && trans.wr_en==1) begin
        `DRIV_IF.addr=trans.addr;
        `DRIV_IF.data_in=trans.data_in;
        `DRIV_IF.wr_en=trans.wr_en;
        `DRIV_IF.rd_en=trans.rd_en;
        #10;
      end
      
      else if(trans.rd_en==1 && trans.wr_en==0) begin
        `DRIV_IF.wr_en=trans.wr_en;
        `DRIV_IF.rd_en=trans.rd_en;
        #10;
         end
      else if(trans.rd_en==1 && trans.wr_en==1) begin
        `DRIV_IF.addr=trans.addr;
        `DRIV_IF.data_in=trans.data_in;
        `DRIV_IF.wr_en=trans.wr_en;
        `DRIV_IF.rd_en=trans.rd_en;
        #10;
      end
      seq_item_port.item_done();
    end
  endtask
endclass
   
  