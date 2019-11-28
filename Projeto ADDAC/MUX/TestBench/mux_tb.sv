`timescale 1ns/100ps
module mux_tb;
	int counter, errors, aux_error;
	logic clk,rst;
	logic a , b, sel;
	logic s, s_esperado;
	logic [6:0]vectors[7];

	somador DUV(a, b, sel, s);

	initial begin
		$display("Iniciando Testbench");
		$display("| A | B | SEL | S |"); 
		$display("---------------");
		$readmemb("../Simulation/ModelSim/mux.tv",vectors);
		counter=0; errors=0;
		rst = 1; #10; rst = 0;		
	end
		
	always begin
		 clk=1; #30;
		clk=0; #5;
	end

	always @(posedge clk) begin
		if(~rst)begin
			{a, b, sel, s_esperado} = vectors[counter];	
		end
	end

	always @(negedge clk)	//Sempre (que o clock descer)
		if(~rst)
		begin
			aux_error = errors;
			assert (s === s_esperado)
		else	
		begin
			errors = errors + 1; //Incrementa contador de erros a cada bit errado encontrado
			end
		if(aux_error === errors)
			$display("| %b | %b | %b | %b | OK", a, b, sel, s);
		else
			$display("| %b | %b | %b | %b | ERRO", a, b, sel, s);

		counter++;	//Incrementa contador dos vertores de teste
		
		if(counter == $size(vectors)) //Quando os vetores de teste acabarem
		begin
			$display("Testes Efetuados  = %0d", counter);
			$display("Erros Encontrados = %0d", errors);
			#10
			$stop;
		end
	end
 endmodule