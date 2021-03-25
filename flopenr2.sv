module flopenr2(input logic en,
			input logic d,
			input logic clk,
			input logic reset,
			output logic q);
 
 // asynchronous reset
 always_ff @(posedge clk, posedge reset) begin
	if (reset) q <= 1'b0;
	else if (en) q = d;
 end
endmodule
