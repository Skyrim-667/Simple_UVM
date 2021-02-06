//rtl file
//transform a  1 bit input rx to 32 bit tx
module serdes(
  input          clk     ,
  input          rst     ,
  input          rx_data,
  input          rx_val,
  output  reg [31:0] tx_data,
  output        tx_rdy  
);

reg [4:0] cnt;

//cnt
always @(posedge clk or negedge rst) 
  begin
    if (!rst)
      begin
        cnt <= 6'b000000;
      end
    else if(rx_val)
      begin 
        cnt <= cnt + 1;             
      end                            
  end 

always @(posedge clk or negedge rst) 
  begin
    if (!rst)
      begin
        tx_rdy  <= 0;
      end
    else if(cnt == 5'b11111)
      begin 
        tx_rdy  <= 1;              
      end                            
  end

always @(posedge clk or negedge rst) 
  begin
    if (!rst)
      begin
        tx_data  <= 32'h00000000;
      end
    else if(rx_val)
      begin 
        tx_data <= {tx_data[30:0],rx_data};              
      end                            
  end 
  
endmodule