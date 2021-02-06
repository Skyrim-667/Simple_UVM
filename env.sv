class env extends uvm_env;

    `uvm_component_utils(env);

    agt_in agt_in;
    agt_out agt_out;
    scb scb;
    my_model my_model;
    coverage_collector cvg;

    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      this.agt_in = agt_in::type_id::create("agt_in", this);
      this.agt_out = agt_out::type_id::create("agt_out", this);
      this.scb = scb::type_id::create("agt_scb", this);
      this.my_model = my_model::type_id::create("my_model", this);
      this.my_model = coverage_collector::type_id::create("cvg", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      this.agt_in.ap.connect(my_model.imp_md);
      this.my_model.ap.connect(scb.imp_exp);
      this.agt_out.ap.connect(scb.imp_act);
    endfunction

endclass