#ifndef ACC_H_INCLUDED
#define ACC_H_INCLUDED

int acc(int clk_a, int clk, int a, int acumulado){
    FILE *arquivo;
    int y =0;
    arquivo = fopen("ACC/Simulation/ModelSim/acc.tv", "a");
    fprintf(arquivo, "%d_%d_%d_%d_", clk_a, clk, a, acumulado);

  //fprintf(arquivo, "//acc\n//clk_a clk saida\n");

    if(clk_a==1 & clk==0)//borda de descida
      y=a;
    else
        y=acumulado;//valor anterior

    fprintf(arquivo, "%d\n", y);
    return y;

    fclose(arquivo);

}
#endif // ACC_H_INCLUDED

