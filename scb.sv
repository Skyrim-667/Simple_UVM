class scb class extends uvm_scoreboard;
    
    `uvm_component_utils(scb)

    `uvm_analysis_imp_decl(_exp)
    `uvm_analysis_imp_decl(_act)

    my_transaction exp_q[$];
    my_transaction act_q[$];

    bit checked;

    //port connected with agt_out
    uvm_analysis_imp #(my_transaction)  imp_act;
    //port connected with ref
    uvm_analysis_port #(my_tranction) imp_exp;

    function new (string name,uvm_component parent);
      super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      imp_act = new("imp_act",this);
      imp_exp=new("imp_exp",this);
    endfunction

    function void check_phase(uvm_phase phase);
        super.check_phase(phase);
        if(this.exp_q.size()>0 || this.act_q.size()>0) begin
            `uvm_error("scb", $sformatf("scb-exq_q != 0 (%0d) or act_q != 0 (%0d)", exp_q.size(), act_q.size()))
        end
        if(checked == 0) begin
            `uvm_error("scb", "no check has been made!")
        end
    endfunction

    task run_phase(uvm_phase phase);
        my_tranction exp;
        my_tranction act;
        checked = 0;
        forever begin
            while (exp_q.size() > 0 && act_q.size()>0) begin
                exp = exp_q.pop_front();
                act = act_q.pop_front();
                checked = 1;
                if(exp.tx_data!=act.tx_data)
                    `uvm_error("scb", $sformatf("mismatch-the exq is (%0h) while the act is (%0h)", exp.tx_data, act.tx_data))
            end
            #1ns
        end  
    endtask

    task write_act(my_tranction tr);
        act_q.push_back(tr);
        `uvm_info("scb","tr has been writen in the act queue!",UVM_LOW)
    endtask

    task write_exp(my_tranction tr);
        exp_q.push_back(tr);
        `uvm_info("scb","tr has been writen in the exp queue!",UVM_LOW)
    endtask

endclass //scb 