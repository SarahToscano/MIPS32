`timescale 1ns/100ps
module addac_tb;
    
	int counter, errors, aux_error;
	logic clk,rst;
	logic clk2;
	logic [3:0] a;
	logic sel0, sel1;
	logic cout, cout_esperado;
	logic [3:0] s, s_esperado;
	logic [11:0]vectors[11];
 
	addac DUV(a, sel0, sel1, clk2, cout, s);

	initial begin
		$display("Iniciando Testbench");
		$display("| SEL0 | SEL1 | A | CLK  |  COUT | S |"); 
		$display("-------------------------");
		$readmemb("./Simulation/ModelSim/addac.tv",vectors);
		counter=0; errors=0;
		rst = 1; #33; rst = 0;		
	end
			
	always
		 begin
		 clk=1; #10;
		clk=0; #5;
		 end

	always @(posedge clk)
		if(~rst)
		begin
			{clk2,sel0,sel1,a,cout_esperado,s_esperado} = vectors[counter];	
		end

	always @(negedge clk)	//Sempre (que o clock descer)
			if(~rst)
			begin
				aux_error = errors;
					assert (s === s_esperado)
		 else	
			begin
				//Mostra mensagem de erro se a saÃ­da do DUT for diferente da saÃ­da esperada
				$display("Error S: input in position %d = %b", i, s);
				$display("linha %d Âª , saÃ­da = %b, (%b esperado)",counter+1, s, s_esperado);
							
				errors = errors + 1; //Incrementa contador de erros a cada bit errado encontrado
				end
			end
				assert(cout === cout_esperado)
			else
			begin
				//Mostra mensagem de erro se a saÃ­da do DUT for diferente da saÃ­da esperada
				$display("Error COUT:");
				$display("linha []%d] , saida = %b, (%b esperado)",counter+1, cout, cout_esperado);
							
				errors = errors + 1; //Incrementa contador de erros a cada bit errado encontrado
				end
			if(aux_error === errors)
				$display("| %b | %b | %b | %b | %b | %b | OK", sel0, sel1, a, clk2, cout, s);
			else
				$display("| %b | %b | %b | %b | %b | %b | ERROR", sel0, sel1, a, clk2, cout, s);

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