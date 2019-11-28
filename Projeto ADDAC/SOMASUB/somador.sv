module somador(a,b,cin,cout,s);
	input logic a,b,cin;
	output logic cout, s;
	assign s = a^b^cin;
	assign cout = (b&cin) | (a&cin) | (a&b);
endmodule