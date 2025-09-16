class ram_sequence extends uvm_sequence#(ram_sequence_item);
  `uvm_object_utils(ram_sequence)
ram_sequence_item req;
 function new(string name="ram_sequence");
super.new(name);
endfunction
 
virtual task body();
  repeat (1) begin
   req=ram_sequence_item::type_id::create("req");
    wait_for_grant();
    assert(req.randomize());
    send_request(req);
    wait_for_item_done();
   $display("Randomized values sent from sequence to sequencer: wr_en=%0b, rd_en=%0b, chip_en=%0b, addr=%0h, data_in=%0h,reset=%0b",req.wr_en,req.rd_en,req.chip_en,req.addr, req.data_in, req.reset);
     
    set_response_queue_depth(10);
  end
    endtask
endclass
    
 /*  virtual task body;
     repeat(2)begin
      ram_sequence_item trans;
      trans=ram_sequence_item::type_id::create("trans");
      
     // uvm_report_info("ram_sequence","iinside seq block1");
      trans.randomize(); //with {trans.wr_en=1;trans.rd_en=0;};
      $display("Randomized values sent from sequence to sequencer: wr_en=%0b, rd_en=%0b, chip_en=%0b, addr=%0h, data_in=%0h,reset=%0b",trans.wr_en,trans.rd_en,trans.chip_en, trans.addr, trans.data_in, trans.reset);
      
     // uvm_report_info("ram_sequence","iinside seq block2");
      start_item(trans);
      uvm_report_info("ram_sequence","iinside seq block3");
      finish_item(trans);
      uvm_report_info("ram_sequence","iinside seq block4");
    
    end
  endtask
endclass*/
//_________________________________________________________________________________________________________

class write_sequence extends uvm_sequence#(ram_sequence_item);
  `uvm_object_utils(write_sequence)
  function new (string name="write_sequence");
    super.new(name);
  endfunction
    
  virtual task body();
    repeat(5) begin
      `uvm_do_with(req,{req.chip_en==1;req.wr_en==1;req.rd_en==0;})
      set_response_queue_depth(10);
    end
  endtask
endclass

//_____________________________________ 3 ___________________________________



class read_sequence extends uvm_sequence#(ram_sequence_item);
  `uvm_object_utils(read_sequence)
  function new (string name="read_sequence");
    super.new(name);
  endfunction
    
  virtual task body();
    repeat(5) begin
      `uvm_do_with(req,{req.chip_en==1;req.wr_en==0;req.rd_en==1;})
      set_response_queue_depth(10);
    end
  endtask
endclass

//______________________________________ 4 ___________________________________


class read_then_write_sequence extends uvm_sequence#(ram_sequence_item);
  `uvm_object_utils(read_then_write_sequence)
  function new(string name="read_then_write_sequence");
    super.new(name);
  endfunction
  virtual task body();
    read_sequence rd_seq;
    write_sequence wr_seq;
    `uvm_do(wr_seq)
    repeat(5) begin
      `uvm_do(rd_seq)
      `uvm_do(wr_seq)
    end
  endtask
endclass

//_______________________________________ 5 _________________________________


class write_read_sequence extends uvm_sequence#(ram_sequence_item);
  `uvm_object_utils(write_read_sequence)
  function new(string name="write_read_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5) begin
      `uvm_do_with(req,{req.chip_en==1;req.wr_en==1;req.rd_en==0;})
      `uvm_do_with(req,{req.chip_en==1;req.wr_en==0;req.rd_en==1;})
    end
  endtask
endclass

//_________________________________________ 6 _______________________________

class wr_parallel_rd_sequence extends uvm_sequence#(ram_sequence_item);
  `uvm_object_utils(wr_parallel_rd_sequence)
  
  function new(string name="wr_parallel_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)begin
      req=ram_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {req.chip_en==1;req.wr_en==1;req.rd_en==1;});
      finish_item(req);
      set_response_queue_depth(10);	
    end
  endtask
endclass

//___________________________________________ 7 __________________________


class reset_chip_sequence extends uvm_sequence#(ram_sequence_item);
  `uvm_object_utils(reset_chip_sequence)
  
  function new(string name="reset_chip_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    req=ram_sequence_item::type_id::create("req");
    wait_for_grant();
    assert(req.randomize() with {req.reset==1;});
    send_request(req);
    wait_for_item_done();
  endtask
endclass
