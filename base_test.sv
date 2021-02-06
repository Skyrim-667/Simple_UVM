class base_test extends uvm_test;
    env env;
    my_vsqr my_vsqr;

    function new (string name="base_test",uvm_component parent=null);
      super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = env::type_id::create("env"，this);
      my_vsqr = my_vsqr::type_id::create("my_vsqr", this);
      //uvm_config_db#(uvm_object_wrapper)::set(this,"env.agt_in.sqr.run_phase","default_sequence",my_sequence::type_id::get());
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      //connect the handles in vsqr with sqr
      ///can be moved to env
      my_vsqr.my_sqr=env.agt_in.sqr;
    endfunction

    task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      this.run_top_virtual_sequence();
      phase.drop_objection(this);
    endtask

    virtual task run_top_virtual_sequence();
      // you may implement this task in child tests
    endtask

endclass