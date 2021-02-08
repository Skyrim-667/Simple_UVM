
class  case0_vseq extends uvm_sequence;

    `uvm_object_utils(case0_vseq)
    `uvm_declare_p_sequencer(my_vsqr)

    function new(string name = "case0_vseq");
        super.new(name);
    endfunction //new
    
    virtual task body();
        //connect seq with desired sqr
        my_sequence seq;
        `uvm_do_on(seq, p_sequencer.my_sqr);
    endtask

endclass //case0_vseq  
