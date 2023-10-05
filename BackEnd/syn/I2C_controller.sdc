###################################################################

# Created by write_sdc on Thu Oct  5 22:00:15 2023

###################################################################
set sdc_version 2.0

set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA
group_path -name INOUT  -from [list [get_ports clk] [get_ports rst] [get_ports wr_i2c] [get_ports     \
{cmd[2]}] [get_ports {cmd[1]}] [get_ports {cmd[0]}] [get_ports {data_in[7]}]   \
[get_ports {data_in[6]}] [get_ports {data_in[5]}] [get_ports {data_in[4]}]     \
[get_ports {data_in[3]}] [get_ports {data_in[2]}] [get_ports {data_in[1]}]     \
[get_ports {data_in[0]}] [get_ports {dvsr[15]}] [get_ports {dvsr[14]}]         \
[get_ports {dvsr[13]}] [get_ports {dvsr[12]}] [get_ports {dvsr[11]}]           \
[get_ports {dvsr[10]}] [get_ports {dvsr[9]}] [get_ports {dvsr[8]}] [get_ports  \
{dvsr[7]}] [get_ports {dvsr[6]}] [get_ports {dvsr[5]}] [get_ports {dvsr[4]}]   \
[get_ports {dvsr[3]}] [get_ports {dvsr[2]}] [get_ports {dvsr[1]}] [get_ports   \
{dvsr[0]}] [get_ports sda_input_s]]  -to [list [get_ports {data_out[7]}] [get_ports {data_out[6]}] [get_ports      \
{data_out[5]}] [get_ports {data_out[4]}] [get_ports {data_out[3]}] [get_ports  \
{data_out[2]}] [get_ports {data_out[1]}] [get_ports {data_out[0]}] [get_ports  \
ack] [get_ports ready] [get_ports done_tick] [get_ports sda_output_m]          \
[get_ports scl]]
group_path -name INREG  -from [list [get_ports clk] [get_ports rst] [get_ports wr_i2c] [get_ports     \
{cmd[2]}] [get_ports {cmd[1]}] [get_ports {cmd[0]}] [get_ports {data_in[7]}]   \
[get_ports {data_in[6]}] [get_ports {data_in[5]}] [get_ports {data_in[4]}]     \
[get_ports {data_in[3]}] [get_ports {data_in[2]}] [get_ports {data_in[1]}]     \
[get_ports {data_in[0]}] [get_ports {dvsr[15]}] [get_ports {dvsr[14]}]         \
[get_ports {dvsr[13]}] [get_ports {dvsr[12]}] [get_ports {dvsr[11]}]           \
[get_ports {dvsr[10]}] [get_ports {dvsr[9]}] [get_ports {dvsr[8]}] [get_ports  \
{dvsr[7]}] [get_ports {dvsr[6]}] [get_ports {dvsr[5]}] [get_ports {dvsr[4]}]   \
[get_ports {dvsr[3]}] [get_ports {dvsr[2]}] [get_ports {dvsr[1]}] [get_ports   \
{dvsr[0]}] [get_ports sda_input_s]]
group_path -name REGOUT  -to [list [get_ports {data_out[7]}] [get_ports {data_out[6]}] [get_ports      \
{data_out[5]}] [get_ports {data_out[4]}] [get_ports {data_out[3]}] [get_ports  \
{data_out[2]}] [get_ports {data_out[1]}] [get_ports {data_out[0]}] [get_ports  \
ack] [get_ports ready] [get_ports done_tick] [get_ports sda_output_m]          \
[get_ports scl]]
