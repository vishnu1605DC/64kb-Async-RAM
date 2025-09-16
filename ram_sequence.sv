import uvm_pkg::*;
class ram_sequence extends uvm_sequence#(ram_sequence_item);
  `uvm_object_utils(ram_sequence)

 function new(string name="ram_sequence");
super.new(name);
endfunction
 
/*virtual task body();
  repeat (15) begin
   req=ram_sequence_item::type_id::create("req");
    wait_for_grant();
    assert(req.randomize());
    send_request(req);
    wait_for_item_done();
    
    set_response_queue_depth(10);*/
    
   virtual task body;
    repeat(5)begin
      ram_sequence_item trans;
      trans=ram_sequence_item::type_id::create("trans");
      
      uvm_report_info("ram_sequence","iinside seq block1");
      trans.randomize(); //with {trans.wr_en=1;trans.rd_en=0;};
      $display("Randomized values sent from sequence to sequencer: wr_en=%0b, rd_en=%0b, chip_en=%0b, addr=%0h, data_in=%0h,reset=%0b",trans.wr_en,trans.rd_en,trans.chip_en, trans.addr, trans.data_in, trans.reset);
      
      uvm_report_info("ram_sequence","iinside seq block2");
      start_item(trans);
      uvm_report_info("ram_sequence","iinside seq block3");
      finish_item(trans);
      uvm_report_info("ram_sequence","iinside seq block4");
    
    end
  endtask
endclass