#ifndef MUX_H_INCLUDED
#define MUX_H_INCLUDED

int mux(int a, int b, int Sel){

  FILE *arquivo;
  arquivo = fopen("../MUX/Golden_Model/mux.tv", "a");

  //fprintf(arquivo, "//MUX\n//Sel_Saida\n");
  fprintf(arquivo, "%d_%d_%d_", Sel,a,b);

  if(!Sel){
        fprintf(arquivo, "%d\n", a);
        return a;
  }
  else{
        fprintf(arquivo, "%d\n", b);
        return b;
  }
  fclose(arquivo);
}
#endif // MUX_H_INCLUDED
