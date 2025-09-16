
class ram_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(ram_scoreboard)
  
  function new (string name="ram_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  ram_sequence_item que[$];
  logic [7:0] dup_mem [0:8];
  logic [7:0] expected_data_out;
  
  uvm_analysis_imp#(ram_sequence_item,ram_scoreboard) scb_export;
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_export=new("scb_export",this);
    foreach(dup_mem[i]) begin
      dup_mem[i]=8'b0;
    end
  endfunction
  
  function void write(ram_sequence_item trans);
    que.push_back(trans);
  endfunction
  ram_sequence_item pkt;
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      if(que.size>0) begin
        pkt=que.pop_front();
        if(pkt.reset) begin
          foreach(dup_mem[i]) begin
      dup_mem[i]=8'b0;
    end
          expected_data_out=8'b0;
           `uvm_info("RAM_SCOREBOARD", "Resetting memory", UVM_MEDIUM)
        end
        else if(pkt.chip_en) begin
          if(pkt.wr_en && !pkt.rd_en) begin
            dup_mem[pkt.addr]=pkt.data_in;
            expected_data_out=8'bz;
             `uvm_info("RAM_SCOREBOARD", "Resetting memory", UVM_MEDIUM)
          end
          else if(!pkt.wr_en && pkt.rd_en) begin
            expected_data_out=dup_mem[pkt.addr];
             `uvm_info("RAM_SCOREBOARD", $sformatf("Read operation: addr=%0h, expected_data_out=%0h", pkt.addr, expected_data_out), UVM_MEDIUM)
        end
          end
          
          else if(pkt.wr_en && pkt.rd_en) begin
            dup_mem[pkt.addr]=pkt.data_in;
            expected_data_out = pkt.data_in;
             `uvm_info("RAM_SCOREBOARD", $sformatf("Write and Read operation: addr=%0h, data_in=%0h, expected_data_out=%0h", pkt.addr, pkt.data_in, expected_data_out), UVM_MEDIUM)

          end
          else begin
            expected_data_out=8'bz;
            `uvm_info("RAM_SCOREBOARD", "No write or read operation", UVM_MEDIUM)
          end
        end
        else begin
          expected_data_out=8'bz;
           `uvm_info("RAM_SCOREBOARD", "Chip disabled (chip_en is low)", UVM_MEDIUM)
        end
      end
    
  endtask
endclass
      

      
          
            
            
            
         
            
       
    
  
  
    
  
 
  
  