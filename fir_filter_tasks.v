//////--------fir_filter_tb Tasks ---------//////

/*--------------- Reset Pattern ---------------*/
task reset_pattern ();
    begin
        rst_n_tb = 1'b1 ; 
        #60
        rst_n_tb = 1'b0 ;
        #60
        rst_n_tb = 1'b1 ;
    end
endtask

/*----------- Inputs Initialization -----------*/
task initialization ();
    begin
		fir_data_in_tb = 16'b0 ;
		fir_en_tb      = 1'b1  ;
		tap_wr_en_tb   = 1'b0  ;
		tap_wr_addr_tb = 6'b0  ; 
		tap_wr_data_tb = 16'b0 ; 
		#(CLK_PERIOD)
		fir_en_tb      = 1'b1  ;
    end
endtask

/*--------------- Taps Clearing ---------------*/
task clear_taps ();
    begin
		fir_en_tb      = 1'b0 ;
		tap_wr_en_tb   = 1'b1 ;
		for(i=0; i<=50; i=i+1) 
			begin
				tap_wr_addr_tb = i     ;
				tap_wr_data_tb = 16'b0 ;
				#(CLK_PERIOD);
			end
    end
endtask

/*---------- Input Signal Generation ----------*/
task wave_cycles (input [6:0] cycles);
	begin
        for(i=0 ; i<=cycles ; i=i+1)
        	begin
        		#(sin_sampling_count) wave() ;
        	end		
	end
endtask
task wave ();
    begin
                              fir_data_in_tb = 127 ;
        #(sin_sampling_count) fir_data_in_tb = 113 ;
        #(sin_sampling_count) fir_data_in_tb = 78  ;
        #(sin_sampling_count) fir_data_in_tb = 34  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb =-13  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb = 30  ;
        #(sin_sampling_count) fir_data_in_tb = 64  ;
        #(sin_sampling_count) fir_data_in_tb = 83  ;
        #(sin_sampling_count) fir_data_in_tb = 78  ;
        #(sin_sampling_count) fir_data_in_tb = 47  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb =-47  ;
        #(sin_sampling_count) fir_data_in_tb =-78  ;
        #(sin_sampling_count) fir_data_in_tb =-83  ;
        #(sin_sampling_count) fir_data_in_tb =-63  ;
        #(sin_sampling_count) fir_data_in_tb =-30  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb = 13  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb =-34  ;
        #(sin_sampling_count) fir_data_in_tb =-78  ;
        #(sin_sampling_count) fir_data_in_tb =-113 ;
        #(sin_sampling_count) fir_data_in_tb =-127 ;
        #(sin_sampling_count) fir_data_in_tb =-113 ;
        #(sin_sampling_count) fir_data_in_tb =-78  ;
        #(sin_sampling_count) fir_data_in_tb =-34  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb = 13  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb =-30  ;
        #(sin_sampling_count) fir_data_in_tb =-63  ;
        #(sin_sampling_count) fir_data_in_tb =-83  ;
        #(sin_sampling_count) fir_data_in_tb =-78  ;
        #(sin_sampling_count) fir_data_in_tb =-47  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb = 47  ;
        #(sin_sampling_count) fir_data_in_tb = 78  ;
        #(sin_sampling_count) fir_data_in_tb = 83  ;
        #(sin_sampling_count) fir_data_in_tb = 64  ;
        #(sin_sampling_count) fir_data_in_tb = 30  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb =-13  ;
        #(sin_sampling_count) fir_data_in_tb = 0   ;
        #(sin_sampling_count) fir_data_in_tb = 34  ;
        #(sin_sampling_count) fir_data_in_tb = 78  ;
        #(sin_sampling_count) fir_data_in_tb = 113 ;        
   end
endtask