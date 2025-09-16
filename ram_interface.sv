interface ram_interface;
  logic chip_en;
  logic wr_en;
  logic reset;
  logic [15:0] addr;
  logic rd_en;
  logic [7:0] data_in;
  logic [7:0] data_out;
  
  modport driver_mp(
    output chip_en,
    output wr_en,
    output rd_en,
    output addr,
    output data_in,
    output reset,
    input data_out
  );
  
  modport monitor_mp(
    input chip_en,
    input wr_en,
    input rd_en,
    input addr,
    input data_in,
    input reset,
    input data_out
  );
endinterface
    
  
