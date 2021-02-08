class my_driver extends uvm_driver #(my_transaction);
    virtual my_interface drv_if;
     `uvm_component_utils(my_driver)

    function new(string name = "my_driver", uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual my_interface)::get(this,"","drv_if",drv_if))
        `uvm_fatal("my_driver","Error in Getting interface");
    endfunction

    task run_phase(uvm_phase phase);
        my_transaction req;
        forever begin
            seq_item_port.get_next_item(req);
            drv_bus(req);
            seq_item_port.item_done();
        end
    endtask

    task drv_bus(my_transaction req);
    @(posedge drv_if.clk)
    begin
	//`uvm_info("drv",$sformatf("drive the data(%0h)!",req.rx_data), UVM_LOW)
        drv_if.drv_cb.rx_data <= req.rx_data;
        drv_if.drv_cb.rx_val     <= req.rx_val;
	drv_if.drv_cb.index <= req.index;
    end
    endtask

endclass //driver
