

class monr_out extends uvm_monitor;

`uvm_component_utils(uart_monitor)

virtual my_interface my_if;
uvm_analysis_port #(my_tranction) mon_ap;//port connected with scb/ref


function new(string name ="my_monitor", uvm_component parent = null );
    super.new(name, parent);
    mon_ap = new("ap", this);
endfunction //new()

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual my_interface)::get(this,"","monr_out_if", my_if)
        `uvm_fatal("my_monr", "error in getting interface!");
endfunction

task run_phase(uvm_phase phase);
    //super.main_phase(phase);
    //monitor interface and send it to scb
    this.mon_trans();
endtask

task mon_trans();
    my_tranction tr;
    tr=new();
    forever begin
        if(my_if.mon_cb.tx_rdy) begin
            tr.rx_data = my_if.mon_cb.rx_data;
            tr.rx_val = my_if.mon_cb.rx_val;
            tr.tx_data = my_if.mon_cb.tx_data;
            tr.tx_rdy = my_if.mon_cb.tx_rdy;
        end
        mon_ap.write(tr);
    end

endtask
endclass //monr
