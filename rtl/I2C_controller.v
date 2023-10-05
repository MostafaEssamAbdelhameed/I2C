module I2C_controller (
    input clk ,rst,
    input wr_i2c,
    input [2:0] cmd,
    input [7:0] data_in,
    input [15:0] dvsr ,

    output [7:0] data_out,
    output ack,
    output reg ready,
    output reg done_tick,

    //inout sda,
    input sda_input_s,
    output sda_output_m,
    output scl
);
/*-------------------------------------------------------------------*/
parameter [2:0] cmd_start = 3'b000 ,
                cmd_wr = 3'b001 ,
                cmd_rd = 3'b010 ,
                cmd_stop = 3'b011 ,
                cmd_restart = 3'b100 ;
/*-------------------------------------------------------------------*/
parameter state_reg_width = 4;
parameter [state_reg_width-1:0] idle_state = 0,
                                start1_state = 1,
                                start2_state = 2,
                                hold_state = 3,
                                stop1_state = 4,
                                stop2_state = 5,
                                data1_state = 6,
                                data2_state = 7, 
                                data3_state = 8, 
                                data4_state = 9, 
                                data_end_state = 10,
                                restart_state = 11;   
reg [state_reg_width-1:0] current_state , next_state;  
/*-------------------------------------------------------------------*/

reg [15:0] counter , count_reg ;
wire [15:0] quarter , half;
assign quarter = dvsr;
assign half = dvsr << 1 ; 


reg [3:0] N_bits , bits_count;
reg [8:0] TX , RX , TX_reg , RX_reg ;

/*-------------------------------------------------------------------*/
reg scl_reg , sda_reg ;
reg scl_t , sda_t ;
assign scl = scl_reg ? 1'b1 : 1'b0 ;
/*-------------------------------------------------------------------*/
wire disconnect_line;
assign disconnect_line = ((bits_count == 8 && cmd == cmd_wr)|| (cmd == cmd_rd && bits_count < 8))? 1'b1:1'b0;

assign sda_output_m = (disconnect_line) ? 1'bz : sda_reg;
//always_Sequential 
	always @(posedge clk or negedge rst) begin
		if(!rst)
			begin
                current_state <= idle_state;
                counter <= 0;
                scl_reg <= 1'b1;
                N_bits <= 0;
                RX_reg <= 0;
                TX_reg <= 0;
                sda_reg <= 0;
			end
		else 
			begin
                current_state <= next_state;
                counter <= count_reg +1 ;
                scl_reg <= scl_t;
                sda_reg <= sda_t;
                N_bits <= bits_count;
                RX_reg <= RX;
                TX_reg <= TX;

			end
	end

    //always_Combinational
    always @(*) begin
            done_tick = 1'b0;
            count_reg = counter;
            ready = 1'b0;
            scl_t = scl_reg;
            count_reg = counter;
            TX = TX_reg;
            RX = RX_reg;
            bits_count = N_bits;
            sda_t = sda_reg;
            case(current_state)
                idle_state: 
                begin
                    ready = 1'b1;
                    sda_t = 1'b1;
                    scl_t = 1'b1;
                    if (wr_i2c && cmd == cmd_start) begin
                         next_state = start1_state ;
                         count_reg = 0;
                    end
                    else begin
                        next_state = idle_state;
                    end
                end
                start1_state:
                begin
                    sda_t = 1'b0;
                    scl_t = 1'b1;
                    if (counter == half) begin
                        next_state = start2_state;
                        count_reg = 0;
                    end
                    else next_state = start1_state;
                end
                start2_state:
                begin
                    sda_t = 1'b0;
                    scl_t = 1'b0;
                    if (counter == half) begin 
                        next_state = hold_state;
                        count_reg = 0;
                    end
                    else next_state = start2_state;
                end
                hold_state:
                begin
                    ready = 1'b1;
                    scl_t = 1'b0;
                    sda_t = 1'b0;
                    count_reg = 0;
                    bits_count = 0;
                    if(cmd == cmd_stop) begin
                         next_state = stop1_state;
                    end
                    else if (cmd == cmd_restart) begin
                        next_state = restart_state ;
                    end
                    else if (cmd == cmd_rd || cmd_wr)begin
                         next_state = data1_state;
                         TX = {data_in, 1'b0};
                    end
                    else begin
                         next_state = hold_state;
                    end
                end

                data1_state:
                begin
                    scl_t = 1'b0;
                    sda_t = TX[8];
                    if(counter == quarter) begin
                        next_state = data2_state;
                        count_reg = 1'b0;
                    end
                    else begin
                        next_state = data1_state;
                    end
                end
                data2_state:
                begin
                    scl_t = 1'b1;
                    sda_t = TX[8];
                    if(counter == quarter) begin
                        next_state = data3_state;
                        count_reg = 1'b0;
                        if      (cmd == cmd_wr && N_bits !=8) RX[8-N_bits]= sda_output_m;
                        else if (cmd == cmd_wr && N_bits ==8) RX[8-N_bits]= sda_input_s;
                        else if (cmd == cmd_rd && N_bits !=8) RX[8-N_bits]= sda_input_s;
                        else if (cmd == cmd_rd && N_bits ==8) RX[8-N_bits]= sda_output_m;
                        //RX = {RX[7:0] , sda};
                    end
                    else begin
                        next_state = data2_state;
                    end
                end
                data3_state:
                begin
                    scl_t = 1'b1;
                    sda_t = TX[8] ;
                    if(counter == quarter) begin
                        next_state = data4_state;
                        count_reg = 1'b0;
                    end
                    else begin
                        next_state = data3_state;
                    end
                end
                data4_state:
                begin
                    scl_t = 1'b0;
                    sda_t = TX[8] ;
                    if(counter == quarter) begin
                        count_reg = 1'b0;                        
                        if (N_bits != 8) begin
                             next_state = data1_state;
                             TX = {TX[7:0] , 1'b0};
                             bits_count = bits_count + 1;
                        end
                        else begin
                            next_state = data_end_state;
                            done_tick = 1;
                        end
                    end
                    else begin
                        next_state = data4_state;
                    end
                end    
                data_end_state:
                begin
                    scl_t = 1'b0;
                    sda_t = 1'b0 ;
                    if(counter == quarter) begin
                        count_reg = 0;
                        next_state = hold_state;
                    end
                    else begin
                        next_state = data_end_state;
                    end
                end
                stop1_state:
                begin
                    scl_t = 1'b1;
                    sda_t = 1'b0;
                    if(counter == half)begin
                        count_reg=0;
                        next_state = stop2_state;
                    end
                    else begin
                        next_state = stop1_state; 
                    end
                end   
                stop2_state:
                begin
                    scl_t = 1'b1;
                    sda_t = 1'b1;
                    bits_count = 0;
                    if(counter == half)begin
                        count_reg=0;
                        next_state = idle_state;
                    end
                    else begin
                        next_state = stop2_state; 
                    end
                end  
                default: 
                begin
                        done_tick = 1'b0;
                        count_reg = counter;
                        ready = 1'b0;
                        scl_t = scl_reg;
                        count_reg = counter;
                        TX = TX_reg;
                        RX = RX_reg;
                        bits_count = N_bits;
                        sda_t = sda_reg;

                        next_state = idle_state;
                end     
            endcase
    end

    assign ack = RX[0];
    assign data_out =(done_tick == 1 && cmd == cmd_rd)? RX[8:1]:0;
endmodule