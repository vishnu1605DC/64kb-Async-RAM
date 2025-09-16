module asyncRam(
  input logic chip_en,
  input logic wr_en,
  input logic reset,
  input logic [15:0] addr,
  input logic rd_en,
  input logic [7:0] data_in,
  output logic [7:0] data_out
);
  reg [7:0] memory [0:65535];
  
  function void rst();
       for(int i=0;i<65536;i++) begin
        memory[i]=8'b0;
      end
      data_out=8'b0;
  endfunction
      
  always@(chip_en or rd_en or wr_en or reset)begin
    if(reset) begin
      rst();
    end
    else if(chip_en)begin
      if(wr_en&&!rd_en) begin
        memory[addr]=data_in;
      end
      else if(rd_en&&!wr_en) begin
        data_out=memory[addr];
      end
      else if(rd_en&&wr_en) begin
        memory[addr]=data_in;
        data_out=memory[addr];
      end
    end
    else begin
      data_out = 8'bz;
      end
  end
endmodule
