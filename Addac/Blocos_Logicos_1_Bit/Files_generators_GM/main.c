#include <stdio.h>
#include <stdlib.h>
//inclusao das funcoes em C
#include "inv.h"
#include "mux.h"
#include "somador_completo.h"
#include "carry_out_function.h"
#include "acc.h"

int acumulado;

int main(void){
    int a = 0, b = 0, carry_in = 0, Sel = 0;
    int i = 0, clk_a = 0, clk = 0;

    //for (Sel = 0; Sel < 2; Sel++){
    //for (clk_a = 0; clk_a < 2; clk_a++){
        //for (clk = 0; clk < 2; clk++){
            for (a = 0; a < 2; a++){
                    //for(acumulado=0;acumulado<2;acumulado++){
                //inversor(a);
                //acc(clk_a, clk, a, acumulado);
                for (b = 0; b < 2; b++){
                    //mux(a, b, Sel);
                    for (carry_in = 0; carry_in < 2; carry_in++){
                        somador_completo(a, b, carry_in);
                    //}
                //}
            }
        }
        }
    //}
    //}

    return 0;
}
