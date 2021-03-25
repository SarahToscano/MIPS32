module ula_32(input logic [31:0] A, B,
						 input logic [2:0] ulaControl,
						 output logic [31:0] Y,
						 output logic zero,
						 output logic overflow);
		
		logic add_sub;
		logic [31:0] cout;
		logic	[30:0] zerotest;
		logic less;
		
		assign add_sub = (ulaControl == 3'b111 | ulaControl == 3'b110) ? 1'b1 : 1'b0;
		
		ula int1(A[0], B[0], add_sub, less, add_sub, ulaControl,  Y[0], cout[0]);
		or(zerotest[0], Y[0] , Y[1]);
											
		genvar i;
		
		generate 
			for(i = 1; i < 31; i = i + 1) begin : generate_1bitalu_instances
				ula int2(A[i], B[i], cout[i - 1], 1'b0, add_sub, ulaControl, Y[i], cout[i]);
				or(zerotest[i], zerotest[i-1], Y[i+1]);
			end
		endgenerate
		
		not(zero, zerotest[30]);
		
		ula intlast(A[31], B[31], cout[30], 1'b0, add_sub, ulaControl, Y[31], cout[31], less);
		xor(overflow, cout[30], cout[31]);
	
endmodule
