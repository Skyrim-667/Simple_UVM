class testcase_0 extends  base_test;
  `uvm_component_utils(testcase_0) 
  extern function new(string name="testcase_0",uvm_component parent=null);
  extern virtual function void build_phase(uvm_phase phase);  
endclass

function my_case0::new (string name="testcase_0",uvm_component parent=null);
  super.new(name,parent);
endfunction

function void my_case0::build_phase(uvm_phase phase);
  super.build_phase(phase);
  //uvm_config_db#(uvm_object_wrapper)::set(this,"env.agt_in.sqr.run_phase","default_sequence",my_sequence::type_id::get());
endfunction

task my_case0::run_top_virtual_sequence();
  //the real difference between testcase
  //connect vsqr with vseq defined in base test
  case0_vseq top_seq =new();
  top_seq.start(my_vsqr);
endfunction
