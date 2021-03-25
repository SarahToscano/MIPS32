module regbank_32(input logic clk,
						input logic we,
						input logic rst,
						input logic [31:0]d,
						input logic [4:0] ra, rb, rw,
						output logic [31:0]busA, busB);
				  
	genvar i;
	generate
		for(i = 0; i < 32; i = i + 1)begin: regbank32
			regbank regbank_32(clk,we,rst,d[i],ra,rb,rw,busA[i], busB[i]);
		end
	endgenerate
	 
endmodule
