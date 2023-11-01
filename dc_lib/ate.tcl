set REPORT_PATH "./checking"


read_file -f verilog ./ATE.v

current_design "ATE"

set_wire_load_model -name ForQA

set_wire_load_mode enclosed



#set area
set_max_area 0

#set clk
create_clock -period 10 -name clk  [get_ports clk]


#compile
compile -exact_map


#output
write_sdc ./output/ate.sdc
write_sdf -context verilog ./output/ate.sdf
write -f verilog -hier -o ./output/ate.v
#Log
redirect -append ./Log/ate.desgin { report_design }
redirect -append ./Log/ate.area { report_area -hier }
redirect -append ./Log/ate.cell { report_cell }
redirect -append ./Log/ate.max.timing { report_timing -delay max -max_paths 100 -sign 5}
redirect -append ./Log/ate.min.timing { report_timing -delay min -max_paths 100 -sign 5}
redirect -append ./Log/ate.max.timing { report_timing -delay max -max_paths 10000 -nets -cap -tran}
redirect -append ./Log/ate.timing { report_timing }

# Get report file
redirect -tee -file ${REPORT_PATH}/check_design.txt {check_design };
redirect -tee -file ${REPORT_PATH}/check_timing.txt {check_timing };
redirect -tee -file ${REPORT_PATH}/report_constraint.txt {report_constraint -all_violators};
redirect -tee -file ${REPORT_PATH}/check_setup.txt {report_timing -delay_type max };
redirect -tee -file ${REPORT_PATH}/check_hold.txt {report_timing -delay_type min };
redirect -tee -file ${REPORT_PATH}/report_area.txt {report_area };


sh date
