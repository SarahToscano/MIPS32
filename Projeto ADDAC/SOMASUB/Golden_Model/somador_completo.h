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
  int aux = 0, carry_out = 0;

  int soma = a+b+carry_in;
  //char soma_bin[BIT];
  //int carry_out = carry_out_function(soma);
  //itoa(soma, soma_bin, 2);//transforma a soma p binario

  if(soma==0){
    fprintf(arquivo, "0_0\n");
    aux=0;
    carry_out = 0;
  }
  else if (soma==1){
    fprintf(arquivo, "0_1\n");
    aux=1;
    carry_out = 0;
  }
  else if(soma==2){
    fprintf(arquivo, "1_0\n");
    aux=0;
    carry_out = 1;
  }
  else if (soma==3){
    fprintf(arquivo, "1_1\n");
    aux=1;
    carry_out = 1;
  }
  else{
    aux= -5;
  }

  fclose(arquivo);
  return aux;
  /*if((a==0 & b==0))
    fprintf(arquivo, "0_%d\n", carry_in);
  else if (carry_in==0 & ((a==0 &b==1)|(a==1 &b==0)))
        fprintf(arquivo, "0_1\n");
  else{
    fprintf(arquivo, "%c_%c\n", soma_bin[BIT - 2], soma_bin[BIT - 1]);
  }
  */
}
#endif // SOMADOR_COMPLETO_H_INCLUDED
