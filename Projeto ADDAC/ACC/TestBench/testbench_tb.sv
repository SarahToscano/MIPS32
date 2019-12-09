`timescale 1ns/100ps
module acc_tb;
	int counter, errors, aux_error;
	logic clk,rst;
	logic clk2;
	logic d, acc;
	logic en;
	logic q, q_esperado;
	
	logic [4:0]vectors[6]; 
	dff_en_r DUV(clk2, en, rst2, en, acc, d, q);

initial begin
	$display("Iniciando Testbench");
	$display("| CLK_A | CLK | EN | Acc | Saida |"); 
	$display("---------------");
	$readmemb("../Simulation/ModelSim/acc.tv",vectors);
	counter=0; errors=0;
	rst = 1; #10; rst = 0;		
end
		
always
    begin
    clk=1; #10;
	clk=0; #5;
    end

always @(posedge clk)
	if(~rst)
	begin
		{clk,clk_2, en, rst, acc, d,q_esperado} = vectors[counter];	
	end

always @(negedge clk)	//Sempre (que o clock descer)
		if(~rst)
		begin
			aux_error = errors;
			assert (q === q_esperado)
		else	
		begin
			$display("%d linha , saída = %b, (%b esperado)",counter+1, q, q_esperado);
						
			errors = errors + 1; //Incrementa contador de erros a cada bit errado encontrado
			end
		if(aux_error === errors)
			$display("| %b | %b | %b | %b | %b | OK", clk,clk_2,en,rst,acc, d, q);
		else
			$display("| %b | %b | %b | %b | %b | ERRO", clk,clk_2,en,rst,acc, d, q);

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
	
endmodule