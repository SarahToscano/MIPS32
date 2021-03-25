module ula(input logic A, B, carry_in,less, add_sub, 
			input logic[2:0]op, 
			output logic Y, cout, s_addsub);
	
	logic s_B;
	logic s_and;
	logic s_or;
	logic s_xor;
	logic s_nor;
	
	assign s_B = B ^ add_sub;
	assign {cout,s_addsub} = A+s_B+carry_in;
	
	assign s_and = A&B;
	assign s_or = A|B;
	assign s_xor = A^B;
	assign s_nor = ~(A|B);
	
	always_comb begin
		case(op)
			3'b000: 	Y = s_and;
			3'b001: 	Y = s_or;
			3'b100: 	Y = s_nor;
			3'b011: 	Y = s_xor;
			3'b010: 	Y = s_addsub;
			3'b110: 	Y = s_addsub;
			3'b111: 	Y = less;
			default:	Y = 1'b0;
		endcase
	end
	
endmodule
