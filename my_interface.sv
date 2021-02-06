interface my_interface(input clk, input rst);
    logic        rx_data  ;
    logic        rx_val;
    logic [31:0] tx_data       ;
    logic        tx_rdy       ;

    clocking drv_cb @posedge(clk);
    output rx_data, rx_val;
    endclocking

    clocking mon_cb @posedge(clk);
    input rx_data, rx_val, tx_data, tx_rdy;
    endclocking

endinterface //my_interface