module dff_en_r (clk, enable, reset, acumulado, d, q);
	input logic clk, enable, reset, d;
	output logic q;
	
	always_ff @(negedge clk, posedge reset) begin
		if(reset)
			q=1'b0;
		else
			q=d;
	end

	always_ff @(posedge clk) begin
		q=acumulado;
	end

endmodule