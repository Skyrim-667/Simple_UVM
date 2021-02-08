class coverage_collector extends uvm_component;

//the data-collected interface
local virtual my_interface my_vifs;

`uvm_component_utils(coverage_collector)

    covergroup cg_input_valid;
        valid_in : coverpoint my_vifs.mon_cb.rx_val{
            bins valid_1_times = (1[*1]);
            bins valid_2_times = (1[*2]);
            bins valid_3_times = (1[*3]);
            bins valid_4_times = (1[*4]);
            bins valid_5_times = (1[*5]);
            bins valid_6_times = (1[*6]);
            bins valid_7_times = (1[*7]);
            bins valid_8_times = (1[*8]);
            bins valid_9_times = (1[*9]);
            bins valid_10_times = (1[*10]);
            bins valid_11_times = (1[*11]);
            bins valid_12_times = (1[*12]);
            bins valid_13_times = (1[*13]);
            bins valid_14_times = (1[*14]);
            bins valid_15_times = (1[*15]);
            bins valid_16_times = (1[*16]);
            bins valid_17_times = (1[*17]);
            bins valid_18_times = (1[*18]);
            bins valid_19_times = (1[*19]);
            bins valid_20_times = (1[*20]);
            bins valid_21_times = (1[*21]);
            bins valid_22_times = (1[*22]);
            bins valid_23_times = (1[*23]);
            bins valid_24_times = (1[*24]);
            //bins valid_25_times = (1[*25]);
            //bins valid_26_times = (1[*26]);
            //bins valid_27_times = (1[*27]);
            //bins valid_28_times = (1[*28]);
            //bins valid_29_times = (1[*29]);
            //bins valid_30_times = (1[*30]);
            //bins valid_31_times = (1[*31]);
            //bins valid_32_times = (1[*32]);
        } 
    endgroup

    function new(string name = "coverage_collector", uvm_component parent);
       super.new(name, parent);
       this.cg_input_valid = new();
    endfunction

    function void build_phase(uvm_phase phase);
       super.build_phase(phase);
       if(!uvm_config_db#(virtual my_interface)::get(this,"","cvg_if", my_vifs))
       `uvm_fatal("coverage_group", "error in getting interface!");
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(posedge my_vifs.clk iff my_vifs.rst)
            this.cg_input_valid.sample();
        end
    endtask

endclass
