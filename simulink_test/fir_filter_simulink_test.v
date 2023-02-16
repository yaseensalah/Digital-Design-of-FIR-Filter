//////////////////////////////////////////////////////////////////////////////
// Project: 50th Order FIR Filter (Modified Version for Simulink Test)
// Creator: Yaseen Salah                                                  
// Date   : 10 Feb 2023                                                  
/////////////////////////////////////////////////////////////////////////////
// MATLAB HDL Parser is not supporting "for loops" //
// and "write in" memories with variable addres.   //
module fir_filter
	#(  parameter ORDER	         = 50 ,
		parameter DATA_IN_WIDTH  = 16 ,
		parameter DATA_OUT_WIDTH = 33 ,
		parameter TAP_DATA_WIDTH = 16 )
	(
		input  wire signed [DATA_IN_WIDTH-1 : 0]   i_fir_data_in   ,
		input  wire                                 i_fir_en  	   ,
		input  wire                        	    i_clk          ,
		input  wire                                 i_rst_n        ,
		output reg   signed [DATA_OUT_WIDTH-1 : 0]  o_fir_data_out      
	);

wire signed [TAP_DATA_WIDTH-1 : 0] tap[ORDER : 0] ;
reg signed [DATA_IN_WIDTH-1  : 0] buffer[ORDER : 0] ;
reg signed [DATA_OUT_WIDTH-1 : 0] accumulator[ORDER : 0] ;

integer i ;

		//50th order fir tabs coefficients
			assign tap[0]  = 16'b 1111_1111_1111_1101 ;
			assign tap[1]  = 16'b 1111_1111_1110_1011 ;
			assign tap[2]  = 16'b 1111_1111_1101_1010 ;
			assign tap[3]  = 16'b 1111_1111_1100_1011 ;
			assign tap[4]  = 16'b 1111_1111_1100_0101 ;
			assign tap[5]  = 16'b 1111_1111_1101_0010 ;
			assign tap[6]  = 16'b 1111_1111_1111_1010 ;
			assign tap[7]  = 16'b 0000_0000_0011_1110 ;
			assign tap[8]  = 16'b 0000_0000_1001_0011 ;
			assign tap[9]  = 16'b 0000_0000_1101_1111 ;
			assign tap[10] = 16'b 0000_0001_0000_0010 ;
			assign tap[11] = 16'b 0000_0000_1101_1010 ;
			assign tap[12] = 16'b 0000_0000_0101_0001 ;
			assign tap[13] = 16'b 1111_1111_0110_1110 ;
			assign tap[14] = 16'b 1111_1110_0101_0110 ;
			assign tap[15] = 16'b 1111_1101_0101_0001 ;
			assign tap[16] = 16'b 1111_1100_1011_1110 ;
			assign tap[17] = 16'b 1111_1100_1111_1101 ;
			assign tap[18] = 16'b 1111_1110_0101_0110 ;
			assign tap[19] = 16'b 0000_0000_1110_0011 ;
			assign tap[20] = 16'b 0000_0100_1000_0000 ;
			assign tap[21] = 16'b 0000_1000_1100_0111 ;
			assign tap[22] = 16'b 0000_1101_0010_0100 ;
			assign tap[23] = 16'b 0001_0000_1110_1001 ;
			assign tap[24] = 16'b 0001_0011_0111_0111 ;
			assign tap[25] = 16'b 0001_0100_0101_1111 ;
			assign tap[26] = 16'b 0001_0011_0111_0111 ;
			assign tap[27] = 16'b 0001_0000_1110_1001 ;
			assign tap[28] = 16'b 0000_1101_0010_0100 ;
			assign tap[29] = 16'b 0000_1000_1100_0111 ;
			assign tap[30] = 16'b 0000_0100_1000_0000 ;
			assign tap[31] = 16'b 0000_0000_1110_0011 ;
			assign tap[32] = 16'b 1111_1110_0101_0110 ;
			assign tap[33] = 16'b 1111_1100_1111_1101 ;
			assign tap[34] = 16'b 1111_1100_1011_1110 ;
			assign tap[35] = 16'b 1111_1101_0101_0001 ;
			assign tap[36] = 16'b 1111_1110_0101_0110 ;
			assign tap[37] = 16'b 1111_1111_0110_1110 ;
			assign tap[38] = 16'b 0000_0000_0101_0001 ;
			assign tap[39] = 16'b 0000_0000_1101_1010 ;
			assign tap[40] = 16'b 0000_0001_0000_0010 ;
			assign tap[41] = 16'b 0000_0000_1101_1111 ;
			assign tap[42] = 16'b 0000_0000_1001_0011 ;
			assign tap[43] = 16'b 0000_0000_0011_1110 ;
			assign tap[44] = 16'b 1111_1111_1111_1010 ;
			assign tap[45] = 16'b 1111_1111_1101_0010 ;
			assign tap[46] = 16'b 1111_1111_1100_0101 ;
			assign tap[47] = 16'b 1111_1111_1100_1011 ;
			assign tap[48] = 16'b 1111_1111_1101_1010 ;
			assign tap[49] = 16'b 1111_1111_1110_1011 ;
			assign tap[50] = 16'b 1111_1111_1111_1101 ;

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
			buffer[0]  <= i_fir_data_in ;
			buffer[1]  <= buffer[0]     ;
			buffer[2]  <= buffer[1]     ;
			buffer[3]  <= buffer[2]     ;
			buffer[4]  <= buffer[3]     ;
			buffer[5]  <= buffer[4]     ;
			buffer[6]  <= buffer[5]     ;
			buffer[7]  <= buffer[6]     ;
			buffer[8]  <= buffer[7]     ;
			buffer[9]  <= buffer[8]     ;
			buffer[10] <= buffer[9]     ;
			buffer[11] <= buffer[10]    ;
			buffer[12] <= buffer[11]    ;
			buffer[13] <= buffer[12]    ;
			buffer[14] <= buffer[13]    ;
			buffer[15] <= buffer[14]    ;
			buffer[16] <= buffer[15]    ;
			buffer[17] <= buffer[16]    ;
			buffer[18] <= buffer[17]    ;
			buffer[19] <= buffer[18]    ;
			buffer[20] <= buffer[19]    ;
			buffer[21] <= buffer[20]    ;
			buffer[22] <= buffer[21]    ;
			buffer[23] <= buffer[22]    ;
			buffer[24] <= buffer[23]    ;
			buffer[25] <= buffer[24]    ;
			buffer[26] <= buffer[25]    ;
			buffer[27] <= buffer[26]    ;
			buffer[28] <= buffer[27]    ;
			buffer[29] <= buffer[28]    ;
			buffer[30] <= buffer[29]    ;
			buffer[31] <= buffer[30]    ;
			buffer[32] <= buffer[31]    ;
			buffer[33] <= buffer[32]    ;
			buffer[34] <= buffer[33]    ;
			buffer[35] <= buffer[34]    ;
			buffer[36] <= buffer[35]    ;
			buffer[37] <= buffer[36]    ;
			buffer[38] <= buffer[37]    ;
			buffer[39] <= buffer[38]    ;
			buffer[40] <= buffer[39]    ;	
			buffer[41] <= buffer[40]    ;
			buffer[42] <= buffer[41]    ;
			buffer[43] <= buffer[42]    ;
			buffer[44] <= buffer[43]    ;
			buffer[45] <= buffer[44]    ;
			buffer[46] <= buffer[45]    ;
			buffer[47] <= buffer[46]    ;
			buffer[48] <= buffer[47]    ;
			buffer[49] <= buffer[48]    ;
			buffer[50] <= buffer[49]    ;					
		end
end

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
			accumulator[0]  <= buffer[0]  * tap[0]  ;	
			accumulator[1]  <= buffer[1]  * tap[1]  ;	
			accumulator[2]  <= buffer[2]  * tap[2]  ;	
			accumulator[3]  <= buffer[3]  * tap[3]  ;	
			accumulator[4]  <= buffer[4]  * tap[4]  ;	
			accumulator[5]  <= buffer[5]  * tap[5]  ;	
			accumulator[6]  <= buffer[6]  * tap[6]  ;	
			accumulator[7]  <= buffer[7]  * tap[7]  ;	
			accumulator[8]  <= buffer[8]  * tap[8]  ;	
			accumulator[9]  <= buffer[9]  * tap[9]  ;	
			accumulator[10] <= buffer[10] * tap[10] ;	
			accumulator[11] <= buffer[11] * tap[11] ;	
			accumulator[12] <= buffer[12] * tap[12] ;	
			accumulator[13] <= buffer[13] * tap[13] ;	
			accumulator[14] <= buffer[14] * tap[14] ;	
			accumulator[15] <= buffer[15] * tap[15] ;	
			accumulator[16] <= buffer[16] * tap[16] ;	
			accumulator[17] <= buffer[17] * tap[17] ;	
			accumulator[18] <= buffer[18] * tap[18] ;	
			accumulator[19] <= buffer[19] * tap[19] ;	
			accumulator[20] <= buffer[20] * tap[20] ;	
			accumulator[21] <= buffer[21] * tap[21] ;	
			accumulator[22] <= buffer[22] * tap[22] ;	
			accumulator[23] <= buffer[23] * tap[23] ;	
			accumulator[24] <= buffer[24] * tap[24] ;	
			accumulator[25] <= buffer[25] * tap[25] ;	
			accumulator[26] <= buffer[26] * tap[26] ;	
			accumulator[27] <= buffer[27] * tap[27] ;	
			accumulator[28] <= buffer[28] * tap[28] ;	
			accumulator[29] <= buffer[29] * tap[29] ;	
			accumulator[30] <= buffer[30] * tap[30] ;	
			accumulator[31] <= buffer[31] * tap[31] ;	
			accumulator[32] <= buffer[32] * tap[32] ;	
			accumulator[33] <= buffer[33] * tap[33] ;	
			accumulator[34] <= buffer[34] * tap[34] ;	
			accumulator[35] <= buffer[35] * tap[35] ;	
			accumulator[36] <= buffer[36] * tap[36] ;	
			accumulator[37] <= buffer[37] * tap[37] ;	
			accumulator[38] <= buffer[38] * tap[38] ;	
			accumulator[39] <= buffer[39] * tap[39] ;
			accumulator[40] <= buffer[40] * tap[40] ;	
			accumulator[41] <= buffer[41] * tap[41] ;	
			accumulator[42] <= buffer[42] * tap[42] ;	
			accumulator[43] <= buffer[43] * tap[43] ;	
			accumulator[44] <= buffer[44] * tap[44] ;	
			accumulator[45] <= buffer[45] * tap[45] ;	
			accumulator[46] <= buffer[46] * tap[46] ;	
			accumulator[47] <= buffer[47] * tap[47] ;	
			accumulator[48] <= buffer[48] * tap[48] ;	
			accumulator[49] <= buffer[49] * tap[49] ;	
			accumulator[50] <= buffer[50] * tap[50] ;													
		end
end

always @(posedge i_clk or negedge i_rst_n) begin
	if (!i_rst_n)
		begin
			o_fir_data_out <= 33'b0 ;
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
