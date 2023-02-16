module fir_filter
	#(  parameter ORDER	         = 50 ,
		parameter DATA_IN_WIDTH  = 16 ,
		parameter DATA_OUT_WIDTH = 32 ,
		parameter TAP_DATA_WIDTH = 16 ,
		parameter TAP_ADDR_WIDTH = 6  )
	(
		input  wire  signed [DATA_IN_WIDTH-1 : 0]   i_fir_data_in  ,
		input  wire                                 i_fir_en  	   ,
		input  wire         				  	    i_tap_wr_en    ,
		input  wire  	    [TAP_ADDR_WIDTH-1 : 0]  i_tap_wr_addr  , 
		input  wire         [TAP_DATA_WIDTH-1 : 0]  i_tap_wr_data  , 
		input  wire                        		    i_clk          ,
		input  wire                        		    i_rst_n        ,
		output reg   signed [DATA_OUT_WIDTH-1 : 0]  o_fir_data_out      
	);

//internal registers declaration as 2D-arrays for optimized hardware description 
reg signed [TAP_DATA_WIDTH-1 : 0] tap[ORDER : 0] ;
reg signed [DATA_IN_WIDTH-1  : 0] buffer[ORDER : 0] ;
reg signed [DATA_OUT_WIDTH-1 : 0] accumulator[ORDER : 0] ;

integer i ;

//51-taps block logic
always @(posedge i_clk or negedge i_rst_n) begin
	if (!i_rst_n)
		begin
		//50th order fir coefficients
			tap[0]  <= 16'b 1111_1111_1111_1101 ;
			tap[1]  <= 16'b 1111_1111_1110_1011 ;
			tap[2]  <= 16'b 1111_1111_1101_1010 ;
			tap[3]  <= 16'b 1111_1111_1100_1011 ;
			tap[4]  <= 16'b 1111_1111_1100_0101 ;
			tap[5]  <= 16'b 1111_1111_1101_0010 ;
			tap[6]  <= 16'b 1111_1111_1111_1010 ;
			tap[7]  <= 16'b 0000_0000_0011_1110 ;
			tap[8]  <= 16'b 0000_0000_1001_0011 ;
			tap[9]  <= 16'b 0000_0000_1101_1111 ;
			tap[10] <= 16'b 0000_0001_0000_0010 ;
			tap[11] <= 16'b 0000_0000_1101_1010 ;
			tap[12] <= 16'b 0000_0000_0101_0001 ;
			tap[13] <= 16'b 1111_1111_0110_1110 ;
			tap[14] <= 16'b 1111_1110_0101_0110 ;
			tap[15] <= 16'b 1111_1101_0101_0001 ;
			tap[16] <= 16'b 1111_1100_1011_1110 ;
			tap[17] <= 16'b 1111_1100_1111_1101 ;
			tap[18] <= 16'b 1111_1110_0101_0110 ;
			tap[19] <= 16'b 0000_0000_1110_0011 ;
			tap[20] <= 16'b 0000_0100_1000_0000 ;
			tap[21] <= 16'b 0000_1000_1100_0111 ;
			tap[22] <= 16'b 0000_1101_0010_0100 ;
			tap[23] <= 16'b 0001_0000_1110_1001 ;
			tap[24] <= 16'b 0001_0011_0111_0111 ;
			tap[25] <= 16'b 0001_0100_0101_1111 ;
			tap[26] <= 16'b 0001_0011_0111_0111 ;
			tap[27] <= 16'b 0001_0000_1110_1001 ;
			tap[28] <= 16'b 0000_1101_0010_0100 ;
			tap[29] <= 16'b 0000_1000_1100_0111 ;
			tap[30] <= 16'b 0000_0100_1000_0000 ;
			tap[31] <= 16'b 0000_0000_1110_0011 ;
			tap[32] <= 16'b 1111_1110_0101_0110 ;
			tap[33] <= 16'b 1111_1100_1111_1101 ;
			tap[34] <= 16'b 1111_1100_1011_1110 ;
			tap[35] <= 16'b 1111_1101_0101_0001 ;
			tap[36] <= 16'b 1111_1110_0101_0110 ;
			tap[37] <= 16'b 1111_1111_0110_1110 ;
			tap[38] <= 16'b 0000_0000_0101_0001 ;
			tap[39] <= 16'b 0000_0000_1101_1010 ;
			tap[40] <= 16'b 0000_0001_0000_0010 ;
			tap[41] <= 16'b 0000_0000_1101_1111 ;
			tap[42] <= 16'b 0000_0000_1001_0011 ;
			tap[43] <= 16'b 0000_0000_0011_1110 ;
			tap[44] <= 16'b 1111_1111_1111_1010 ;
			tap[45] <= 16'b 1111_1111_1101_0010 ;
			tap[46] <= 16'b 1111_1111_1100_0101 ;
			tap[47] <= 16'b 1111_1111_1100_1011 ;
			tap[48] <= 16'b 1111_1111_1101_1010 ;
			tap[49] <= 16'b 1111_1111_1110_1011 ;
			tap[50] <= 16'b 1111_1111_1111_1101 ;
		end
	else if(i_tap_wr_en && !i_fir_en) //preventing coeff change during the operation
		begin
			tap[i_tap_wr_addr] <= i_tap_wr_data ;
		end
end

//51-buffers block logic
always @(posedge i_clk or negedge i_rst_n) begin
	if (!i_rst_n)
		begin
			for (i=0 ; i<=ORDER ; i=i+1)
				begin
					buffer[i] <= 16'b0 ;
				end
		end
	else if (i_fir_en)
		begin
			buffer[0] <= i_fir_data_in ;
			for (i=0 ; i<ORDER ; i=i+1)
				begin
					buffer[i+1] <= buffer[i] ;
				end
		end
end

//51-accumulator block logic
always @(posedge i_clk or negedge i_rst_n) begin
	if (!i_rst_n)
		begin
			for (i=0 ; i<=ORDER ; i=i+1)
				begin
					accumulator[i] <= 32'b0 ;
				end			
		end
	else if (i_fir_en) 
		begin
			for (i=0 ; i<=ORDER ; i=i+1)
				begin
					accumulator[i] <= buffer[i] * tap[i] ;
				end		
		end
end

//output logic
always @(posedge i_clk or negedge i_rst_n) begin
	if (!i_rst_n)
		begin
			o_fir_data_out <= 32'b0 ;
		end
	else if (i_fir_en)
		begin
			o_fir_data_out <= accumulator[0]  + accumulator[1] 
					    	+ accumulator[2]  + accumulator[3]
					    	+ accumulator[4]  + accumulator[5]
					    	+ accumulator[6]  + accumulator[7]
					    	+ accumulator[8]  + accumulator[9]
					    	+ accumulator[10] + accumulator[11]
					    	+ accumulator[12] + accumulator[13]
					    	+ accumulator[14] + accumulator[15]
					    	+ accumulator[16] + accumulator[17]
					    	+ accumulator[18] + accumulator[19]
					    	+ accumulator[20] + accumulator[21]
					    	+ accumulator[22] + accumulator[23]
					    	+ accumulator[24] + accumulator[25]
					    	+ accumulator[26] + accumulator[27]
					    	+ accumulator[28] + accumulator[29]
					    	+ accumulator[30] + accumulator[31]
					    	+ accumulator[32] + accumulator[33]
					    	+ accumulator[34] + accumulator[35]
					    	+ accumulator[36] + accumulator[37]
					    	+ accumulator[38] + accumulator[39]	
					    	+ accumulator[40] + accumulator[41]
					    	+ accumulator[42] + accumulator[43]
					    	+ accumulator[44] + accumulator[45]
					    	+ accumulator[46] + accumulator[47]
					    	+ accumulator[48] + accumulator[49]
					    	+ accumulator[50] ;					  				  
		end
end
 
endmodule