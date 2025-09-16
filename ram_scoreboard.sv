class ram_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(ram_scoreboard)

  function new (string name="ram_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
 ram_sequence_item que[$];
 logic [7:0] dup_mem [0:65535];
 logic [7:0] expected_data_out;
   ram_sequence_item transa;
  uvm_analysis_imp#(ram_sequence_item,ram_scoreboard) scb_export;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_export=new("scb_export",this);
     transa=ram_sequence_item::type_id::create("transa");
     foreach(dup_mem[i]) begin
     dup_mem[i]=8'b0;
      end
   endfunction
  
  function void write(ram_sequence_item trans);
    
   
 $display("wr_en=%0b, rd_en=%0b, chip_en=%0b, addr=%0h, data_in=%0h,reset=%0b",trans.wr_en,trans.rd_en,trans.chip_en, trans.addr, trans.data_in, trans.reset);
    que.push_front(trans);
    $display(" que size %0d %h",que.size(),que[0].addr);
    
  endfunction
  

   task run_phase(uvm_phase phase);
    super.run_phase(phase);
     while(1) begin
  wait(que.size()>0) ;
     transa= que.pop_back();
      /* if(transa!=null) begin 
         `uvm_info("RAM_SCOREBOARD", "queue is working",UVM_NONE)
          $display("%0h",transa.addr);  
     end
     else begin
       `uvm_info("RAM_SCOREBOARD", "queue is not working",UVM_NONE)
       break;
     end*/
       
       if(transa.reset) begin
         foreach(dup_mem[i])begin
           dup_mem[i]=8'b0;
         end
         expected_data_out=8'b0;
           `uvm_info("RAM_SCOREBOARD", "Resetting memory", UVM_MEDIUM)
       end //if(transa.reset)
       
       else if(transa.chip_en) begin
         if(transa.wr_en && !transa.rd_en) begin
           dup_mem[transa.addr]=transa.data_in;
            expected_data_out=8'bz;
           `uvm_info("RAM_SCOREBOARD", $sformatf("Write operation: addr=%0h, data=%0d", transa.addr, transa.data_in), UVM_MEDIUM)
          end       
       
       
         else if(!transa.wr_en && transa.rd_en)begin
         expected_data_out=dup_mem[transa.addr];
         `uvm_info("RAM_SCOREBOARD", $sformatf("Read operation: addr=%0h, expected_data_out=%0d", transa.addr, expected_data_out), UVM_MEDIUM)
         end //(!transa.chipen and transa.rd_en)
       
       
         else if(transa.wr_en && transa.rd_en)begin
          dup_mem[transa.addr]=transa.data_in;
           expected_data_out = dup_mem[transa.addr];
          `uvm_info("RAM_SCOREBOARD", $sformatf("Write and Read operation: addr=%0h, data_in=%0d, expected_data_out=%0d", transa.addr, transa.data_in, expected_data_out), UVM_MEDIUM)
         end // (transa.wr_en && transa.rd_en)
       
       
         else begin
            expected_data_out=8'bz;
            `uvm_info("RAM_SCOREBOARD", "No write or read operation", UVM_MEDIUM)
         end
       end //(transa.chip_en)
       else if(!transa.chip_en) begin
         expected_data_out=8'bz;
         `uvm_info("RAM_SCOREBOARD", "Chip enable is low", UVM_MEDIUM)
       end //(!transa.chip_en)
         
         
         
       end //while loop
  endtask
endclass
      
  


            
            
         
            
       
    
  
  
    
  
 
  
  
