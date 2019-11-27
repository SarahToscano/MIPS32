module inv(a,y);
	input logic a;
	output logic y;
	
	assign y = ~a;
endmodule