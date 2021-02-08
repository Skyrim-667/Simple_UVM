`timescale 1ns/1fs

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "macro.sv"

module top();

logic clk, rst;

my_interface my_if(clk,rst);

//dut
serdes dut
(
  .clk     (clk                    ),
  .rst     (rst                    ),
  .rx_data (my_if.rx_data          ),
  .rx_val  (my_if.rx_val           ),
  .tx_data (my_if.tx_data          ),
  .tx_rdy  (my_if.tx_rdy           )
);

//clk & rst signal 
initial begin
  rst = 0;
  #200 rst = 1;
end

initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  //the interface passing
  uvm_config_db#(virtual my_interface)::set(null,"uvm_test_top.env.agt_in.drv","drv_if", my_if);
  uvm_config_db#(virtual my_interface)::set(null,"uvm_test_top.env.agt_in.monr_in","monr_in_if", my_if);
  uvm_config_db#(virtual my_interface)::set(null,"uvm_test_top.env.agt_out.monr_out","monr_out_if", my_if);
  uvm_config_db#(virtual my_interface)::set(null,"uvm_test_top.env.cvg","cvg_if", my_if);
  run_test();
end

initial begin
  $fsdbDumpfile("test.fsdb");
  $fsdbDumpvars(0);
end

//some assignment

endmodule
