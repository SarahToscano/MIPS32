#ifndef SOMADOR_COMPLETO_H_INCLUDED
#define SOMADOR_COMPLETO_H_INCLUDED
#include "carry_out_function.h"
#include <string.h>

#define BIT 2

int somador_completo(int a, int b, int carry_in){

  FILE *arquivo;
  arquivo = fopen("SOMASUB/Simulation/ModelSim/somador.tv", "a");
  //fprintf(arquivo,"//Somador\n//A_B_Cin_Cout_Soma\n");
  fprintf(arquivo, "%d_%d_%d_", a,b,carry_in);

  int soma = a+b+carry_in;
  char soma_bin[BIT];
  int carry_out = carry_out_function(soma);
  itoa(soma, soma_bin, 2);//transforma a soma p binario

  if((a==0 & b==0))
    fprintf(arquivo, "0_%d\n", carry_in);
  else if (carry_in==0 & ((a==0 &b==1)|(a==1 &b==0)))
        fprintf(arquivo, "0_1\n");
  else{
    fprintf(arquivo, "%c_%c\n", soma_bin[BIT - 2], soma_bin[BIT - 1]);
  }
  fclose(arquivo);
  soma = 0;
  return a+b+carry_in;//corrigir p main
}
#endif // SOMADOR_COMPLETO_H_INCLUDED
