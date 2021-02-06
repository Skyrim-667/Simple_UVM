class my_model extends uvm_component;

    `uvm_component_utils(my_model)

    //port connected with agt_in
    uvm_analysis_imp #(my_transaction)  imp_md;
    //port connected with scb
    uvm_analysis_port #(my_tranction) ap;
    
    my_transaction trans_q[$];

    function new(string name = "my_model", uvm_component parent);
      super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
       //port connected with agt_in
        port = new("imp_md",this);
       //to scb
       md_ap=new("ap",this);
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            my_tranction tr_packed;
            tr_packed = new();
            while(trans_q.size >=31)
                pack(tr_packed);
            //write to scb
            md_ap.write(tr_packed);
        end
        
    endtask

    task write(my_tranction tr);
        trans_q.push_back(tr);
        `uvm_info("ref_model","tr has been writen in the queue!",UVM_LOW)
    endtask

    task pack(ref my_transaction tr);
        integer i;
        my_transaction tr_tmp;
        logic rx_data;
        logic [31:0] tx_data;
        for(i=0; i<32;i++) begin
            tr_tmp = new();
            tr_tmp = trans_q.pop_front;
            rx_data = tr_tmp.rx_data;
            tx_data = {tx_data[30:0], rx_data};
        end
        tr.tx_data = tx_data;
    endtask

endclass