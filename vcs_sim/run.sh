#!/bin/csh

#to run the sim, you may need to setenv first
vcs -debug_access+all +vpi -sverilog $UVM_HOME/src/dpi/uvm_dpi.cc -CFLAGS -DVCS -timescale=1ns/1ps -f filelist.f 
./simv +UVM_TESTNAME=$1
