## Simple_UVM

#### Overview

Simple_UVM is a simple and intuitive UVM verification platform for the demonstrative design under test (DUT), a 32-bit serial data packer, which basically packs the input serial data when the valid signal is asserted and generate the parallel 32-bit data. With the Universal Verification Methodology (UVM), the verification environment is highly modular and reusable. You can easily modify it and develop the scalable testbench for your specific DUT. 
The directory structure of the project is as shown below.

```
   ~
   |---vcs_sim
       |---coverage
       |---rtl
       |---tb
       |---test_case
       |---verif
       |---filelist.f
       |---macro.sv
       |---Makefile
```

- **coverage**: includes the coverage collector component.
- **rtl**: includes the rtl dur design.
- **tb**: includes the top testbench.
- **test_case**: includes the base test and specific testcase extended from base test.
- **verif**: includes all the components of the verification environment. 


#### About the DUT

As mentioned above, in general, the DUT converts 1-bit serial input signals to a 32-bit parallel output, which was schematically demonstrated in the following waveform diagram.



![img](D:/%E6%9C%89%E9%81%93%E4%BA%91/hustcyt@163.com/bc6d2e49f70241d1aacb361dc30271a4/clipboard.png)

#### Quick start

To run the testcase, in the directory `./vcs_sim/`

```makefile
$ make
```

or

```shell
$ source ./run.sh test_name
```

testcase_0 is the only available test case at present. Notice that, you may need to set the environment first.

```bash
setenv VCS_HOME
setenv UVM_HOME
# and so on
```


#### To do

- Introduce control and status registers in the rtl design to implement a configurable design for a various-bit output and interrupt function.
- Utilize UVM register model for the verification of the modified design.
