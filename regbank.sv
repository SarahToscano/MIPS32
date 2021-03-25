module regbank(input logic clk, we,rst,
			input logic d,
			input logic [4:0]ra, rb,rw,
			output logic busA,
			output logic busB);
			
	logic [31:0]outDecoder, en, inMux;		
	decoder decoder5_32(rw, outDecoder);
	genvar i;
	
	generate
		for(i=0; i < 32; i++) begin : flops
			and and_(en[i], we, outDecoder[i]);
			flopenr2 flops(en[i], d, clk, rst, inMux[i]); 
		end
	endgenerate
	
	mux32 muxA(inMux, ra, busA);
	mux32 muxB(inMux, rb, busB);
	 
endmodule
