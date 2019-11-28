`timescale 1ns/100ps
module mux_tb;
	int counter, errors, aux_error;
	logic clk,rst;
	logic a , b, cin;
	logic s, s_esperado;
	logic cout, cout_esperado;
	logic [4:0]vectors[7];

	somador DUV(a, b, cin, s, cout);

	initial begin
		$display("Iniciando Testbench");
		$display("| A | B | CIN | S | COUT |"); 
		$display("---------------");
		$readmemb("../Simulation/ModelSim/somador.tv",vectors);
		counter=0; errors=0;
		rst = 1; #10; rst = 0;		
	end
		
	always begin
		 clk=1; #30;
		clk=0; #5;
	end

	always @(posedge clk) begin
		if(~rst)begin
			{a, b, cin, s_esperado, cout_esperado} = vectors[counter];	
		end
	end

	always @(negedge clk)	//Sempre (que o clock descer)
		if(~rst)
		begin
			aux_error = errors;
			assert (cout === cout_esperado)
		else	
		begin
			errors = errors + 1; //Incrementa contador de erros a cada bit errado encontrado
			end
		if(aux_error === errors)
			$display("| %b | %b | %b | %b | %b | OK", a, b, cin, s, cout);
		else
			$display("| %b | %b | %b | %b | ERROR", a, b, cin, s, cout);

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