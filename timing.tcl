read_liberty <path_to_sky130_fd_sc_hd__ff_n40C_1v65.lib>

read_verilog netlist_out_pwm.v

link_design pwm_generator

read_sdc constraints.sdc

report_checks