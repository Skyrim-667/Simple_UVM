
class my_vsqr extends uvm_sequencer;

    `uvm_component_utils(my_vsqr);

    my_sequencer my_sqr;


    function new(string name = "my_vsqr", uvm_component parent);
        super.new(name, parent);
    endfunction //new

endclass //  
