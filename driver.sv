class drv extends uvm_driver #(my_transaction);
    virtual my_if drv_if;
     `uvm_component_utils(drv)

    function new(string name = "drv", uvm_component parent= NULL);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual my_if)::get(this,"","mon_if",drv_if))
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
    @drv_if.drv_cb;
    begin
        drv_if.drv_cb.rx_data <= req.rx_data;
        drv_if.drv_cb.rx_val     <= req.rx_val;
    end

    endtask
endclass //driver