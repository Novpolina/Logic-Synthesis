read_liberty "your_path_to_sky130"

read_verilog netlist_out_pwm.v

link_design pwm_generator

read_sdc constraints.sdc

report_checks