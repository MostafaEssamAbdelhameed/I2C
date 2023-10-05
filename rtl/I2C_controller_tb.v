`timescale 1ns / 1ps

module I2C_controller_tb ();

parameter [2:0] cmd_start = 3'b000 ,
                cmd_wr = 3'b001 ,
                cmd_rd = 3'b010 ,
                cmd_stop = 3'b011 ,
                cmd_restart = 3'b100 ;

/////////////////////////////////////////////////////
//////////////////clk_generator//////////////////////
/////////////////////////////////////////////////////

parameter clk_period= 10; 
reg clk_tb=0; 
always #(clk_period/2) clk_tb = ~clk_tb;

/////////////////////////////////////////////////////
///////////////Decleration & Instances///////////////
/////////////////////////////////////////////////////

reg		            wr_i2c_tb;
reg         [2:0]	cmd_tb; 
reg         [7:0]	data_in_tb; 
reg         [15:0]	dvsr_tb; 
reg		            rst_tb;
reg                 sda_input_s_tb;
wire	    [7:0]	data_out_tb; 
wire		    	ack_tb;
wire		    	ready_tb;
wire		    	done_tick_tb;
wire		    	sda_output_s_tb;
wire		    	scl_tb;

 master DUT (
		.wr_i2c(wr_i2c_tb),
		.cmd(cmd_tb),
		.data_in(data_in_tb),
		.dvsr(dvsr_tb),
		.rst(rst_tb),
		.clk(clk_tb),
		.data_out(data_out_tb),
		.ack(ack_tb),
		.ready(ready_tb),
		.done_tick(done_tick_tb),
		.sda_input_s(sda_input_s_tb),
        .sda_output_m(sda_output_m_tb),
		.scl(scl_tb)
		);


/////////////////////////////////////////////////////
///////////////////Initial Block/////////////////////
/////////////////////////////////////////////////////

initial begin 
	$dumpfile("master.vcd"); 
	$dumpvars; 
    reset();
    @(negedge clk_tb)
    dvsr_tb = 250;
    wr_i2c_tb=1'b1;

   // write(ADDRESS , DATA)
   // read(ADDRESS , DATA_COMES_FROM_SLAVE);
     write (8'b0_1010101 , 8'b10101010);
     read  (8'b1_1010101 , 8'b11110000);

     $stop();

end 

/////////////////////////////////////////////////////
//////////////////////Tasks//////////////////////////
/////////////////////////////////////////////////////

task reset;
 begin
 rst_tb=1;
 #(clk_period)
 rst_tb=0;
 #(clk_period)
 rst_tb=1;
 end
endtask


task write (
    input [7:0] address,
    input [7:0] data
);
    begin
        cmd_tb = cmd_start;
        @(posedge ready_tb) 
        data_in_tb = address ; // writing address
        cmd_tb = cmd_wr;
        @(DUT.N_bits == 8)
        sda_input_s_tb = 0;
        @(posedge ready_tb) 
        data_in_tb = data ; // writing data 
        cmd_tb = cmd_wr;
        @(posedge ready_tb) 
        cmd_tb = cmd_stop;
        @(DUT.current_state == 0)
        $display("For the Write Task");
        $display("The Recived data = %b",DUT.RX);
        $display("Data = %b \n",DUT.RX[8:1],
                "Acknowledge = %b",DUT.RX[0]);
    end
endtask
integer i;
task read (input [7:0] address , input [7:0] data);
    begin
        cmd_tb = cmd_start;
        #(clk_period)
        @(posedge ready_tb) 
        data_in_tb = address ; // writing address
        cmd_tb = cmd_wr;
        @(posedge ready_tb) 
        cmd_tb = cmd_rd; 
        for(i=7 ; i>=0 ; i=i-1) begin
        @(posedge DUT.current_state == 6)
        sda_input_s_tb = data[i] ;
        end
        @(posedge ready_tb)  
        cmd_tb = cmd_stop;
        @(DUT.current_state == 0)
        $display("\nFor the Read Task");
        $display("The Recived data = %b",DUT.RX);
        $display("Data = %b \n",DUT.RX[8:1],
                "Acknowledge = %b",DUT.RX[0]);             
    end
endtask

endmodule
