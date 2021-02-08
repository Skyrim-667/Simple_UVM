interface my_interface(input clk, input rst);
    logic        rx_data  ;
    logic        rx_val;
    logic [31:0] tx_data       ;
    logic        tx_rdy       ;
    logic [31:0] index;

    clocking drv_cb @(posedge clk);
	default input #1ns output #1ns;
    	output rx_data, rx_val, index;
    endclocking

    clocking mon_cb @(posedge clk);
	default input #1ns output #1ns;
    	input tx_data, tx_rdy, index, rx_data, rx_val;
    endclocking

endinterface //my_interface
