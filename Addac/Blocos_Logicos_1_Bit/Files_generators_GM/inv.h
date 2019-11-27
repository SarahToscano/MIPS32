#ifndef INV_H_INCLUDED
#define INV_H_INCLUDED

#include <stdbool.h>

int inversor(int a){

  FILE *arquivo;
  int aux=!a;

  arquivo = fopen("../INV/Golden_Model/inv.tv", "a");
  //fprintf(arquivo, "//Inversor\n//Entrada_Saida\n");
  fprintf(arquivo, "%d_%d\n", a, aux);
  return aux;
  fclose(arquivo);
}
#endif // INV_H_INCLUDED

