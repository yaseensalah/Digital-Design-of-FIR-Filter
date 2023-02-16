//////////////////////////////////////////////////////////////////////////////
// Project: Testbench for 50th Order FIR Filter
// Creator: Yaseen Salah                                                  
// Date   : 10 Feb 2023                                                  
/////////////////////////////////////////////////////////////////////////////
module fir_filter_tb();
reg  signed [15 : 0]   fir_data_in_tb  ;
reg                    fir_en_tb       ;
reg         	       tap_wr_en_tb    ;
reg  	    [5  : 0]   tap_wr_addr_tb  ; 
reg         [15 : 0]   tap_wr_data_tb  ; 
reg                    clk_tb          ;
reg                    rst_n_tb        ;
wire signed [31 : 0]   fir_data_out_tb ;

parameter CLK_PERIOD  = 22675.73696 ; //periodic time of  44.1KHz CLK

parameter SIN1_SAMP   = 37500       ; //sampling time for 550Hz  + 3KHz    Sin Wave
parameter SIN2_SAMP   = 25000       ; //sampling time for 820Hz  + 4.3KHz  Sin Wave 
parameter SIN3_SAMP   = 10000       ; //sampling time for 2.1KHz + 10.8KHz Sin Wave 
parameter SIN4_SAMP   = 1562        ; //sampling time for 13KHz  + 70KHz   Sin Wave 

`include "fir_filter_tasks.v"

reg [15 : 0] sin_sampling_count ;
integer i ;

//-----DUT Instantiation
fir_filter DUT (
	.i_fir_data_in  (fir_data_in_tb)  ,
	.i_fir_en  	(fir_en_tb)       ,
	.i_tap_wr_en    (tap_wr_en_tb)    ,
	.i_tap_wr_addr  (tap_wr_addr_tb)  , 
	.i_tap_wr_data  (tap_wr_data_tb)  , 
	.i_clk          (clk_tb)          ,
	.i_rst_n        (rst_n_tb)        ,
	.o_fir_data_out (fir_data_out_tb)
	);

//-----Clock Generation
initial 
	begin
        clk_tb  = 1'b1 ;     
        forever      
        #(CLK_PERIOD*0.5) clk_tb = ~clk_tb ;  		
	end

//-----Filtering Test
initial 
    begin
    	reset_pattern () ;
    	initialization() ;
    	//550Hz + 3KHz
        sin_sampling_count = SIN1_SAMP ;
        wave_cycles(10) ;

        //820Hz  + 4.3KHz
        sin_sampling_count = SIN2_SAMP ;
		wave_cycles(20) ;

		//2.1KHz + 10.8KHz
        sin_sampling_count = SIN3_SAMP ;
		wave_cycles(30) ;

		//13KHz  + 70KHz
		sin_sampling_count = SIN4_SAMP ;
		wave_cycles(100) ;	

		#(CLK_PERIOD) 
		fir_data_in_tb = 0 ; 
		#(100*CLK_PERIOD)  ;
		$stop ;
	end

//-----Control Signals Test
initial
	begin
		#(300*CLK_PERIOD)  fir_en_tb = 1'b0 ; 	
		#(60*CLK_PERIOD)   fir_en_tb = 1'b1 ; 		
		#(2500*CLK_PERIOD) clear_taps() ;    
	end

endmodule
