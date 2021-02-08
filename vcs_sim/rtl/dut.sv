//rtl file
//transform a  1 bit input rx to 32 bit tx
module serdes(
  input              clk     ,
  input              rst     ,
  input              rx_data,
  input              rx_val,
  output  reg [31:0] tx_data,
  output             tx_rdy  
);

reg [4:0] cnt;

//to detect the transition 31 -> 0
wire flag_31;
wire flag_0;
reg flag_31_syn;

//cnt
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        cnt <= 5'b0_0000;
    end        
    else if(rx_val) begin
        cnt <= cnt + 1;             
    end                           
end 

assign flag_31 = (cnt == 5'b1_1111)?1'b1:1'b0;
assign flag_0 = (cnt == 5'b0_0000)?1'b1:1'b0;

always @(posedge clk or negedge rst) begin
    if (!rst)
        flag_31_syn  <= 0;
    else
	flag_31_syn  <= flag_31;                            
end 

assign tx_rdy = flag_31_syn && flag_0;

//always @(posedge clk or negedge rst) 
//  begin
//    if (!rst)
//      begin
//        tx_rdy  <= 0;
//      end
//    else if(cnt == 5'b1_1111) begin 
//        tx_rdy  <= 1;              
//    end
//    else
//	tx_rdy  <= 0;                             
//  end 

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
