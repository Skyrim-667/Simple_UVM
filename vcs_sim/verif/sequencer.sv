
class  my_sequencer extends uvm_sequencer #(my_transaction);

    `uvm_component_utils(my_sequencer);

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

   //task run_phase(uvm_phase phase);

   //    my_sequence seq;

   //    phase.raise_objection(this);
   //    seq = my_sequence::type_id::create("seq", this);
   //    seq.start(this);
   //    phase.drop_objection(this);

   //endtask

endclass //  