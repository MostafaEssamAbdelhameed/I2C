
####################################################################################
# Constraints
# ----------------------------------------------------------------------------
#
# 0. Design Compiler variables
#
# 1. Master Clock Definitions
#
# 2. Generated Clock Definitions
#
# 3. Clock Uncertainties
#
# 4. Clock Latencies 
#
# 5. Clock Relationships
#
# 6. set input/output delay on ports
#
# 7. Driving cells
#
# 8. Output load

####################################################################################
           #########################################################
                  #### Section 0 : DC Variables ####
           #########################################################
#################################################################################### 

# Prevent assign statements in the generated netlist (must be applied before compile command)
set_fix_multiple_port_nets -all -buffer_constants -feedthroughs

####################################################################################
           #########################################################
                  #### Section 1 : Clock Definition ####
           #########################################################
#################################################################################### 
# 1. Master Clock Definitions 
# 2. Generated Clock Definitions
# 3. Clock Latencies
# 4. Clock Uncertainties
# 4. Clock Transitions
####################################################################################
set CLK_SETUP_SKEW 0.2
set CLK_HOLD_SKEW 0.2
set CLK_LAT 0
set CLK_RISE 0.05
set CLK_FALL 0.05

#SOURCE_1
create_clock -period 10 -name clk_ref [get_ports ref_clk]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks clk_ref]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks ]
set_clock_transition -rise $CLK_RISE  [get_clocks clk_ref]
set_clock_transition -fall $CLK_FALL  [get_clocks clk_ref]
set_clock_latency $CLK_LAT [get_clocks clk_ref]
#
create_generated_clock -master_clock clk_ref -source [get_ports ref_clk] \
                       -name "ALU_CLK" [get_port CLK_GATE_0/GATED_CLK] \
                       -divide_by 1
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks ALU_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks ALU_CLK]
set_clock_transition -rise $CLK_RISE  [get_clocks ALU_CLK]
set_clock_transition -fall $CLK_FALL  [get_clocks ALU_CLK]
set_clock_latency $CLK_LAT [get_clocks ALU_CLK]

#

#SOURCE_2
create_clock -period 271.2967987 -name clk_uart [get_ports uart_clk]
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks clk_uart]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks clk_uart]
set_clock_transition -rise $CLK_RISE  [get_clocks clk_uart]
set_clock_transition -fall $CLK_FALL  [get_clocks clk_uart]
set_clock_latency $CLK_LAT [get_clocks clk_uart]
#
create_generated_clock -master_clock clk_uart -source [get_ports uart_clk] \
                       -name "TX_CLK" [get_port ClkDiv_1/o_div_clk] \
                       -divide_by 32
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks TX_CLK]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks TX_CLK]
set_clock_transition -rise $CLK_RISE  [get_clocks TX_CLK]
set_clock_transition -fall $CLK_FALL  [get_clocks TX_CLK]
set_clock_latency $CLK_LAT [get_clocks TX_CLK]

#
create_generated_clock -master_clock clk_uart -source [get_ports uart_clk] \
                       -name "RX_CLK" [get_port ClkDiv_0/o_div_clk] \
                       -divide_by 1
#
set_clock_uncertainty -setup $CLK_SETUP_SKEW [get_clocks RX_CLK ]
set_clock_uncertainty -hold $CLK_HOLD_SKEW  [get_clocks RX_CLK]
set_clock_transition -rise $CLK_RISE  [get_clocks RX_CLK]
set_clock_transition -fall $CLK_FALL  [get_clocks RX_CLK]
set_clock_latency $CLK_LAT [get_clocks RX_CLK]




####################################################################################
           #########################################################
             #### Section 2 : Clocks Relationship ####
           #########################################################
####################################################################################
set_clock_groups -asynchronous -group [get_clocks "clk_ref ALU_CLK"] \
			       -group [get_clocks "clk_uart TX_CLK RX_CLK"]
  

####################################################################################
           #########################################################
             #### Section 3 : set input/output delay on ports ####
           #########################################################
####################################################################################
#INPUTS
set in1_delay  [expr 0.2*271.2967987]
set_input_delay $in1_delay -clock RX_CLK [get_port RX_IN]

#OUTPUTS
set out1_delay  [expr 0.2*271.2967987*32]
set out2_delay  [expr 0.2*271.2967987]
set_output_delay $out1_delay -clock TX_CLK [get_port TX_OUT]
set_output_delay $out2_delay -clock RX_CLK [get_port stop_err]
set_output_delay $out2_delay -clock RX_CLK [get_port par_err]

####################################################################################
           #########################################################
                  #### Section 4 : Driving cells ####
           #########################################################
####################################################################################
set_driving_cell -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -lib_cell BUFX2M -pin Y [get_port RX_IN]

####################################################################################
           #########################################################
                  #### Section 5 : Output load ####
           #########################################################
####################################################################################
set_load 0.5 [get_port TX_OUT]
set_load 0.5 [get_port stop_err]
set_load 0.5 [get_port par_err]


####################################################################################
           #########################################################
                 #### Section 6 : Operating Condition ####
           #########################################################
####################################################################################

# Define the Worst Library for MaxDelay(#setup) analysis ss
# Define the Best Library for MinDelay(hold) analysis ff

set_operating_conditions -min_library scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c -min scmetro_tsmc_cl013g_rvt_ff_1p32v_m40c \
			 -max_library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c -max scmetro_tsmc_cl013g_rvt_ss_1p08v_125c


set_dont_touch_network {clk_ref clk_uart ALU_CLK TX_CLK RX_CLK rst}
####################################################################################
           #########################################################
                  #### Section 7 : wireload Model ####
           #########################################################
####################################################################################

#set_wire_load_model -name tsmc13_wl30 -library scmetro_tsmc_cl013g_rvt_ss_1p08v_125c

####################################################################################


