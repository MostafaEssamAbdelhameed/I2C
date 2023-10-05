

############################## Formality Setup File ##############################

############################## Guidance  ##############################

set synopsys_auto_setup true 
set verification_verify_directly_undriven_output false

set_svf "/home/IC/I2C/syn/I2C_controller.svf"

set SSLIB "/home/IC/I2C/std_cells/scmetro_tsmc_cl013g_rvt_ss_1p08v_125c.db"
set TTLIB "/home/IC/I2C/std_cells/scmetro_tsmc_cl013g_rvt_tt_1p2v_25c.db"
set FFLIB "/home/IC/I2C/std_cells/scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c.db"

##########################################################################################################################
############################################# Reference ##################################################################
##########################################################################################################################

## Read Reference Design Files

read_verilog -container Ref /home/IC/I2C/rtl/I2C_controller.v 
#


## Read Reference technology libraries
read_db -container Ref $SSLIB
read_db -container Ref $TTLIB
read_db -container Ref $FFLIB

## set the top Reference Design 
set_reference_design I2C_controller
set_top I2C_controller

##########################################################################################################################
############################################# Implementation #############################################################
##########################################################################################################################

## Read Implementation Design Files
read_verilog -netlist -container imp "/home/IC/I2C/syn/I2C_Netlist.v" 

## Read Impelementation technology libraries
read_db -container imp $SSLIB
read_db -container imp $TTLIB
read_db -container imp $FFLIB

## set the top Implementation Design
set_implementation_design I2C_controller
set_top I2C_controller

##########################################################################################################################
############################################### Match & Verify ###########################################################
##########################################################################################################################

## matching Compare points

match

## verify
set successful [verify]
if {!$successful} {
diagnose
analyze_points -failing
}

#Reports
report_passing_points > "passing_points.rpt"
report_failing_points > "failing_points.rpt"
report_aborted_points > "aborted_points.rpt"
report_unverified_points > "unverified_points.rpt"

#command to run in terminal " fm_shell -f fm_script.tcl | tee fm.log "

start_gui

