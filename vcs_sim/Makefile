#!/bin/csh
test_name = testcase_0


All:
	make com \
	sim	\


#Compile command
com:
	vcs -debug_access+all +vpi -sverilog $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS -timescale=1ns/1ps -f filelist.f 

#simulation command
sim:
	./simv +UVM_TESTNAME=$(test_name)

#verdi
verdi:
	verdi -sv -f filelist.f -ssf -nologo test.fsdb

#show the coverage
cov:
	dve -covdir simv.vdb &

clean:
	rm -f ucli.key
	rm -f *.fsdb  novas*
	rm -f *.log
	rm -rf vc_hdrs.h
	rm -rf csrc  DVE*  vdCov*  verdiL*
	rm -rf simv.daidir
	rm -rf simv.vdb
	rm -rf simv
	rm -rf top_tb.vcd*
