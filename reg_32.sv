module reg_32(input logic [31:0]d,
			input logic clk, en, rst,
			output logic [31:0]y);

	genvar i;
	
	generate
		for(i=0; i < 32; i++) begin : register
			flopenr reg_32(en, d[i], clk, rst, y[i]);
		end 
	endgenerate
	 
endmodule
