`timescale 1ns/1ns

`include "uvm_macros.svh"
import uvm_pkg::*;

module top();

logic clk, rst;

my_interface my_if(clk,rst);

//dut
adder32_cla adder
(
  .clk    (clk            ),
  .rst    (rst            ),
  .enable (my_if.enable ),
  .a      (my_if.a      ),
  .b      (my_if.b      ),
  .cin    (my_if.cin    ),
  .sum_r  (my_if.sum_r  ),
  .cout_r (my_if.cout_r )
);

//clk & rst signal 
initial begin
  rst = 1;
  enable = 0;
  #50 rst = 0;
  #200 rst = 1;
  enable = 1;
end

initial begin
  clk = 0;
  forever #5 clk = ~clk;
end

initial begin
  //the interface passing
  uvm_config_db#(virtual my_interface)::set(null,"uvm_test.env.agt_in.drv","drv_if", my_if);
  uvm_config_db#(virtual my_interface)::set(null,"uvm_test.env.agt_in.monr_in","monr_in_if", my_if);
  uvm_config_db#(virtual my_interface)::set(null,"uvm_test.env.agt_out.monr_out","monr_out_if", my_if);
  uvm_config_db#(virtual my_interface)::set(null,"uvm_test.env.cvg","cvg_if", my_if);
  run_test();
end

//some assignment

endmodule