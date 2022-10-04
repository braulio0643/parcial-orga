#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"

int main (void){
	/* Acá pueden realizar sus propias pruebas */
	msg_t msg1;
    msg1.text = "Hola ";
	msg1.text_len = 5;
	msg1.tag = 0;
    
    msg_t msg2;
	msg2.text = "Chau";
	msg2.text_len = 4;
	msg2.tag = 1;
    

	msg_t msg3;
	msg3.text = "Mundo";
	msg3.text_len = 5;
	msg3.tag = 0;

    printf("%d\n", sizeof(msg_t));
	msg_t arr[] = {msg1, msg2, msg3}; 
    
	char** res = agrupar(arr, 3);
    printf("%s\n", res[1]);

	
    

	return 0;    
}


