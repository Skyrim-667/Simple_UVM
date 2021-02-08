class my_env extends uvm_env;

    `uvm_component_utils(my_env);

    agent_in agt_in;
    agent_out agt_out;
    scoreboard scb;
    my_model my_mdl;
    coverage_collector cvg;

    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      this.agt_in = agent_in::type_id::create("agt_in", this);
      this.agt_out = agent_out::type_id::create("agt_out", this);
      this.scb = scoreboard::type_id::create("agt_scb", this);
      this.my_mdl = my_model::type_id::create("my_model", this);
      this.cvg = coverage_collector::type_id::create("cvg", this);
    endfunction

    function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      this.agt_in.ap.connect(my_mdl.imp_md);
      this.my_mdl.ap.connect(scb.imp_exp);
      this.agt_out.ap.connect(scb.imp_act);
    endfunction

endclass
