
class my_model extends uvm_component;

    `uvm_component_utils(my_model)

    //port connected with agt_in
    uvm_analysis_imp #(my_transaction, my_model)  imp_md;
    //port connected with scb
    uvm_analysis_port #(my_transaction) ap;
    
    my_transaction trans_q[$];

    function new(string name = "my_model", uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
       //port connected with agt_in
        imp_md = new("imp_md",this);
       //to scb
       ap=new("ap",this);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            my_transaction tr_packed;
            while(trans_q.size >=32) begin
		tr_packed = new();
                pack(tr_packed);
            	//write to scb
            	ap.write(tr_packed);
	    end
	//`uvm_info("my_model","enter the loop1!",UVM_LOW)
	#1ns;
        end
        
    endtask

    task write(my_transaction tr);
        trans_q.push_back(tr);
        //`uvm_info("ref_model","tr has been writen in the queue!",UVM_LOW)
    endtask

    task pack(ref my_transaction tr);
        integer i;
        my_transaction tr_tmp;
        logic rx_data;
        logic [31:0] tx_data = 32'h0000_0000;
	//`uvm_info("my_model",$sformatf("initial tx data is(%0h)!",tx_data), UVM_LOW)
        for(i=0; i<32;i++) begin
            tr_tmp = new();
            tr_tmp = trans_q.pop_front();
            rx_data = tr_tmp.rx_data;
	    //`uvm_info("my_model",$sformatf("data before packed(%0h)!",tr_tmp.rx_data), UVM_LOW)
            tx_data = {tx_data[30:0], rx_data};
	    //`uvm_info("my_model",$sformatf("shifted tx data is(%0h)!",tx_data), UVM_LOW)
        end
        tr.tx_data = tx_data;
	//`uvm_info("my_model",$sformatf("data after packed(%0h)!",tr.tx_data), UVM_LOW)
    endtask

endclass
