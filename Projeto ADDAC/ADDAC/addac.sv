module addac(a,sel_0, sel_1, clk, cout, s);

 input logic a, sel_0, sel_1, clk;
 output logic cout, s;
 
 logic mux_0_out, mux_1_out, somador_out;
 
 mux mux_0_bloco(a, inversor(a), sel_0, mux_0_out);
 somador_out somador_bloco(a, s, sel_0, cout, somador_out);
 mux mux_1_bloco(mux_0_out, somador_out, sel_1, mux_1_out);

 s = dff_en_r acc_bloco(clk, 1'b1, 1'b0, mux_1_out,s);
 
 endmodule 