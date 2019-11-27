#include <stdio.h>
#include <stdlib.h>
//inclusao das funcoes em C
#include "INV\Golden_Model\inv.h"
#include "MUX\Golden_Model\mux.h"
#include "SOMASUB\Golden_Model\somador_completo.h"
#include "SOMASUB\Golden_Model\carry_out_function.h"
#include "ACC\Golden_Model\acc.h"
#include "ADDAC\Golden_Model\ADDAC.h"




int main(void){
    int acumulado=0, aux=0;
    int a = 0, b = 0, carry_in = 0, sel_0 = 0, sel_1=0;
    int i = 0, clk_a = 1, clk = 0;

    for (sel_0 = 0; sel_0 < 2; sel_0++){
        for (sel_1 = 0; sel_1 < 2; sel_1++){
            for (clk = 0; clk < 2; clk++){
                for (a = 0; a < 2; a++){
                    //for(acumulado=0;acumulado<2;acumulado++){
                        aux = addac(a, sel_0, sel_1, clk_a, clk);

                    //mux(a, b, Sel);
                    //for (carry_in = 0; carry_in < 2; carry_in++){
                        //somador_completo(a, b, carry_in);
                    //}
                }
                clk_a=clk;
            }
        }
    }
    //}
    //}

    //ADDAC


    return 0;
}
