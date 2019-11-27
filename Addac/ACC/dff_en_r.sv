module dff_en_r (clk, enable, reset, d, q);
	input logic clk, enable, reset, d;
	output logic q;
	
	always_ff @(negedge clk, posedge reset) begin
		if(reset)
			q<=1'b0;
		else
			q<=d;
	end
endmodule