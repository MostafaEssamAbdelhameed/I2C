
########################### Define Top Module ############################
                                                   
set top_module I2C_controller

##################### Define Working Library Directory ######################
                                                   
define_design_lib work -path ./work
set_svf $top_module.svf

################## Design Compiler Library Files #setup ######################

lappend search_path /home/IC/I2C/std_cells
lappend search_path /home/IC/I2C/rtl


set SSLIB "scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

## Standard Cell libraries 
set target_library [list $SSLIB $TTLIB $FFLIB]

## Standard Cell & Hard Macros libraries 
set link_library [list * $SSLIB $TTLIB $FFLIB]  

#echo "###############################################"
#echo "############# Reading RTL Files  ##############"
#echo "###############################################"

#System_Top Files


analyze -format verilog I2C_controller.v 
#
 

###################### Defining toplevel ###################################

#current_design $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## Liniking All The Design Parts ########"
puts "###############################################"

elaborate -lib work $top_module

#################### Liniking All The Design Parts #########################
puts "###############################################"
puts "######## checking design consistency ##########"
puts "###############################################"

check_design

############################### Path groups ################################
puts "###############################################"
puts "################ Path groups ##################"
puts "###############################################"

group_path -name INREG -from [all_inputs]
group_path -name REGOUT -to [all_outputs]
group_path -name INOUT -from [all_inputs] -to [all_outputs]

#################### Define Design Constraints #########################
puts "###############################################"
puts "############ Design Constraints #### ##########"
puts "###############################################"

#source -echo ./cons.tcl

###################### Mapping and optimization ########################
puts "###############################################"
puts "########## Mapping & Optimization #############"
puts "###############################################"

compile -map_effort high

set_svf -off

#############################################################################
# Write out Design after initial compile
#############################################################################
write_file -format verilog -hierarchy -output I2C_Netlist.v
write_file -format ddc -hierarchy -output $top_module.ddc
write_sdc $top_module.sdc
write_sdf $top_module.sdf

################# reporting #######################
report_area -hierarchy > area.rpt
report_power -hierarchy > power.rpt
report_timing -max_paths 100 -delay_type min > hold.rpt
report_timing -max_paths 100 -delay_type max > setup.rpt
report_clock -attributes > clocks.rpt
report_constraint -all_violators > constraints.rpt

################# starting graphical user interface #######################

#gui_start
exit
