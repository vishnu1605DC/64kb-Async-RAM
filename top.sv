
import uvm_pkg::*;
 `include "uvm_macros.svh"
`include "ram.sv"
`include "ram_interface.sv"
`include "ram_sequence_item.sv"
`include "ram_sequence.sv"
`include "ram_sequencer.sv"
`include "ram_driver.sv"
`include "ram_monitor.sv"
`include "ram_agent.sv"
`include "ram_scoreboard.sv"
`include "ram_environment.sv"
`include "ram_test.sv"
`include "write_test.sv"
`include "read_test.sv"

`include "rd_then_wr.sv"
`include "wr_then_rd.sv"

module tbench_top;
  ram_interface inf();
  
  asyncRam dut(
    .chip_en(inf.chip_en),
    .wr_en(inf.wr_en),
    .reset(inf.reset),
    .addr(inf.addr),
    .rd_en(inf.rd_en),
    .data_in(inf.data_in),
    .data_out(inf.data_out)
  );
  
  initial begin
    uvm_config_db#(virtual ram_interface)::set(null,"*","vif",inf);
  end

initial begin
  /*agent_cfg cfg=new();
  cfg.set_active(1);
  
  uvm_config_db#(agent_cfg)::set(null,"*","cfg",cfg);*/
  run_test("ram_test");
  //run_test("write_test");
end
    
    
    endmodule
