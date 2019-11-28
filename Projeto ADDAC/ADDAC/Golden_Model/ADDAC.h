#ifndef ADDAC_H_INCLUDED
#define ADDAC_H_INCLUDED

#include "..\..\INV\Golden_Model\inv.h"
#include "..\..\MUX\Golden_Model\mux.h"
#include "..\..\SOMASUB\Golden_Model\somador_completo.h"
#include "..\..\SOMASUB\Golden_Model\carry_out_function.h"
#include "..\..\ACC\Golden_Model\acc.h"

int addac (int a, int sel_0, int sel_1, int clk_a, int clk){

    int mux_0, mux_1, saida_somador, out, acumulado;
    FILE *arquivo;
    arquivo = fopen("ADDAC/Simulation/ModelSim/addac.tv", "a");

    fprintf(arquivo, "%d_%d_%d_%d_", sel_0, sel_1, a,clk);


    mux_0 = mux(a, inversor(a), sel_0);
    //fprintf(arquivo, "%d_%d_%d__", mux_0,out, sel_0);//certo

    saida_somador = somador_completo(mux_0, out, sel_0);
    //fprintf(arquivo, "%d_%d_%d__", mux_0,saida_somador,sel_1);

    mux_1 = mux(mux_0, saida_somador, sel_1);
    fprintf(arquivo, "%d_", mux_1);

    out= acc(clk_a, clk, mux_1,out);

    fprintf(arquivo, "%d\n", out);
    return out;

}



#endif // ADDAC_H_INCLUDED
