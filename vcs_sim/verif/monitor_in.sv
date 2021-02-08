
class monitor_in extends uvm_monitor;

`uvm_component_utils(monitor_in)

virtual my_interface my_if;
uvm_analysis_port #(my_transaction) mon_ap;//port connected with scb


function new(string name ="monitor_in", uvm_component parent = null );
    super.new(name, parent);
    mon_ap = new("ap", this);
endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual my_interface)::get(this,"","monr_in_if", my_if))
        `uvm_fatal("my_monr", "error in getting interface!");
endfunction

task run_phase(uvm_phase phase);
    //super.main_phase(phase);
    //monitor interface and send it to scb
    this.mon_trans();
endtask

task mon_trans();
    my_transaction tr;
    forever begin
	@(posedge my_if.clk iff (my_if.rst))
        if(my_if.mon_cb.rx_val) begin
	    tr=new();
            tr.rx_data = my_if.mon_cb.rx_data;
            tr.rx_val = my_if.mon_cb.rx_val;
            tr.tx_data = my_if.mon_cb.tx_data;
            tr.tx_rdy = my_if.mon_cb.tx_rdy;
	    //`uvm_info("monitor_in",$sformatf("sample the data rx is(%0h) with index (%0h)!",tr.rx_data, my_if.mon_cb.index), UVM_LOW)
	    mon_ap.write(tr);
        end    
    end

endtask

endclass //monr
