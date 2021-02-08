
class my_transaction extends uvm_sequence_item;
    rand bit rx_data;
    rand bit rx_val;
    rand bit [31:0] index;
    bit [31:0] tx_data;
    bit tx_rdy;

    `uvm_object_utils_begin(my_transaction)
    `uvm_field_int(rx_data,UVM_ALL_ON)
    `uvm_field_int(rx_val,UVM_ALL_ON)
    `uvm_field_int(index,UVM_ALL_ON)
    `uvm_field_int(tx_data,UVM_ALL_ON)
    `uvm_field_int(tx_rdy,UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name ="my_transaction");
        super.new(name);        
    endfunction //new()

endclass //my_transaction
