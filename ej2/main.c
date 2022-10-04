#include <assert.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include <argp.h>

#include "utils.h"
#include "ej2.h"

int main () {
   
	/* Acá pueden realizar sus propias pruebas */
	
	/*printf("%d\n", sizeof(unsigned)); */
	/*int16_t entrada[] = {5,3,4,8,4,9,1,4,6,0,6,5,3,2,1,2,7,2,1,3,1,2};
	int16_t* salida = filtro(entrada, 11);
	int16_t salida1 = salida[0];
	int16_t salida2 = salida[1];
	int16_t salida3 = salida[2];
	int16_t* salidaCatedra = filtro_c(entrada, 11);
	int16_t salida1C = salidaCatedra[0];
	int16_t salida2C = salidaCatedra[1];
	int16_t salida3C = salidaCatedra[2];
	printf("%d\n", salida1);
	printf("%d\n", salida2);
	printf("%d\n", salida3);
	printf("%d\n", salida1C);
	printf("%d\n", salida2C);
	printf("%d\n", salida3C);*/
    
    int16_t* entrada =(int16_t*)malloc(7*4);		//28 bytes, 14 canales, 7 datos, la res debe ser de 4 datos(8 canales)
	
	for (unsigned i = 0; i < 7*2; i++){
		uint16_t a=rand();
		entrada[i]=a;
	   }

	printf("Entrada:\n");
    int16_t* salida = (int16_t*) filtro(entrada,7);
    int16_t* salidaCatedra = (int16_t*) filtro_c(entrada,7);
	int16_t entrada1 = entrada[0];
	int16_t entrada2 = entrada[1];
	int16_t entrada3 = entrada[2];

    int16_t salida1 = salida[0];
	int16_t salida2 = salida[1];
	int16_t salida3 = salida[2];
	int16_t salida8 = salida[7];

    int16_t salida1C = salidaCatedra[0];
	int16_t salida2C = salidaCatedra[1];
	int16_t salida3C = salidaCatedra[2];
	int16_t salida8C = salidaCatedra[7];

	
	//printf("%d\n", sizeof(entrada1));

	for(int i = 0; i < 7*2; i++){
		printf("%d\n",entrada[i]);
	}
	printf("\n");
	printf("Entrada 1: %d\n", entrada1);
	printf("Entrada 2: %d\n", entrada2);
	printf("Entrada 3: %d\n", entrada3);
    printf("Mi salida1: %d\n", salida1);
	printf("Mi salida2: %d\n", salida2);
	printf("Mi salida3: %d\n", salida3);
	printf("Mi salida8: %d\n", salida8);
	printf("Catedra 1: %d\n", salida1C);
	printf("Catedra 2: %d\n", salida2C);
	printf("Catedra 3: %d\n", salida3C);
	printf("Catedra 8: %d\n", salida8C);

	return 0;
}

