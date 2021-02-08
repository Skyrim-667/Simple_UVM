
class  my_sequence extends uvm_sequence #(my_transaction);

    `uvm_object_utils(my_sequence);

    my_transaction my_trans;

    function new(string name = "my_sequence");
        super.new(name);
    endfunction //new()

    virtual task body();
        if(starting_phase!=null)
         starting_phase.raise_objection(this);
        repeat(10000) begin
            `uvm_do(my_trans);
        end
        #1000;
        if(starting_phase!=null)
         starting_phase.drop_objection(this);
    endtask
    
endclass // ny_sequencer extends uvm_sequencer #()
