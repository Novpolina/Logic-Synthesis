read_verilog scr1_flattened.v

delete scr1_cg
read_verilog cg_struct.v

hierarchy -check -top scr1_core_top
synth -top scr1_core_top

dfflibmap -liberty <path_to_sky130_fd_sc_hd__ff_n40C_1v65.lib>
abc -liberty <path_to_sky130_fd_sc_hd__ff_n40C_1v65.lib> -D 20 -constr constraints_scr1.sdc

opt
clean
write_verilog -noattr netlist_scr1.v