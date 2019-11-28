`timescale 1ns/100ps
module inv_tb ();
	logic a;
	logic clk, reset;
	logic y, y_esperado;
	logic [2:0]vector[1:0];
	int count, erro, aux_erro; 
	
	inv DUV(a, y);
	
	initial begin
		$display("Iniciando Testbench");
		$display("| A | S |"); 
		$display("---------");
		$readmemb("../Simulation/ModelSim/inv.tv",vector);
		count=0; erro=0;
		reset=1'b1; #7; reset=1'b0;
	end
	
	always begin
		clk=1; #6;
		clk=0; #10;
   end
	
	always @(posedge clk) begin
		if(~reset) begin
			{a,y_esperado} = vector[count]; //atualiza os valores na borda de subida
		end
	end
	
	always@(negedge clk) begin
		if(~reset) begin
			aux_erro=erro;
			assert (y === y_esperado); //verifica se o resultado bateu com o esperado
		end else begin
			//Caso o assert dê erro... São printadas as mensagens de Erro
			$display("Linha [%d] -- Saída Esperada: %b --  Saída: %b",count+1,  y_esperado, y);
			erro = erro + 1; //Incrementa contador de erros a cada bit errado encontrado
		end
			if(aux_erro === erro)
				$display("| %b | %b | OK", a, y);
			else
				$display("| %b | %b | ERRO", a, y);		
			count = count+1;
			
			if(count == $size(vector)) begin //Finalização dos casos de testes
				$display("Testes Efetuados  = %0d", count);
				$display("Erros Encontrados = %0d", erro);
				#10
				$stop;
			end
		end
endmodule