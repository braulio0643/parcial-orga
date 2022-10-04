
%define OFFSET_TEXT 0
%define OFFSET_TEXT_LEN 8
%define OFFSET_TAG 16


extern malloc

global agrupar
global sumar

;########### SECCION DE DATOS
section .data
vector1: DW 0x3788, 0xDE09, 0XD985, 0XA07C
vector2: DW 0X98E0, 0X3259, 0X0768, 0X71CC
vector3: DW 0xA164, 0xDEDA, 0xF145, 0x3892
vector4: DW 0x94BA, 0XE234, 0x1768, 0x532F 


;########### SECCION DE TEXTO (PROGRAMA)
section .text


agrupar:

movq xmm0, [vector1]
movq xmm1, [vector2]
movdqu xmm3, xmm0
paddw xmm0, xmm1
;{[0] = -12184, [1] = 4194, [2] = -7955, [3] = 4680,
movdqu xmm0, xmm3
paddsw xmm0, xmm1
;{[0] = -12184, [1] = 4194, [2] = -7955, [3] = 4680
movdqu xmm0, xmm3
;{[0x0] = 0xe75a, [0x1] = 0xe274, [0x2] = 0x1768, [0x3] = 0x532f,
paddusw xmm0, xmm1


push rbp
mov rbp, rsp
push rbx
push r12
push r13
push r14
push r15
push rdi
push rsi
;nota de después de haber hecho el ejercicio: fui recorriendo el array de msg_t's como si 
;cada elemento fuera de 24 bytes, ya que cuando le pedí sizeof(msg_t) a C me tiró 24. 
;corriendo el runTester.sh me tira como 800 errores de memoria y después de hablar con
;los profes me dijeron que debería recorrerla como si cada msg_t fuera de 16 bytes. 
;pero para eso tengo que cambiar todo y no llego a hacer los otros ejercicios, así que aviso esto por acá.


;rdi es un array de msg_t. voy a tener que entrar al texto de cada uno
;rsi supongo que es el largo del array de msg_t
;el tag de cada mensaje va desde 0 hasta 3
mov r12, rsi
mov r13, rdi ;con r13 itero
mov r14, rdi ;con r14 me guardo el comienzo


;primero hago un malloc para el array de strings, que va a ser de 4 elementos
mov rdi, 32
;pido 32 bytes ya que van a ser 4 elementos de 8 bytes
mov r8, malloc
call r8
push rax
mov rbx, rax ;me queda en rbx el comienzo del array resultado
xor r15, r15 ;uso r15 para ver el tag actual
xor rdi, rdi
xor r8, r8 ; uso r8 para contar por cual elemento del array voy (cuando llegue a r12 paro)
;en 

loopMallocs:
cmp r8, r12
je finTag
;me queda en rdx el msg_t 
add r13, OFFSET_TAG
cmp [r13], r15
je loopMallocsIguales
jmp loopMallocsDistintos

loopMallocsIguales:
sub r13, 8
add rdi, [r13]
add r13, 16
inc r8
jmp loopMallocs


loopMallocsDistintos:
add r13, 8
inc r8
jmp loopMallocs

finTag:
mov r8, malloc
call r8
xor r8, r8
xor rdi, rdi ;reseteo la suma de longitudes
mov [rbx], rax ;guardo la direccion del string concatenado
add rbx, 8
mov r13, r14 ;recupero el comienzo del array de mensajes
inc r15
cmp r15, 4
jne loopMallocs


;me queda en rax la dirección del array resultado, lo copio a rbx para iterar desde ahí
;también muevo el largo del array de msg_t a rcx para el loop externo
;hago pops para recuperar los valores originales
pop rax
mov r12, r14
mov r14, rax
mov r11, [r14]

;recupero la direccion del comienzo del array resultado
pop rsi
pop rdi

mov rcx, rsi ;en rcx tnego el largo del array
xor r8, r8 ; tag actual
xor r15, r15 ; mensaje actual
;pongo r8 en 0 y lo incremento al final de cada loop (sería el tag)

;dejo en rdi el puntero a la primera estructura, en vez del puntero al comienzo del array
;luego sigo iterando el array externo con r12
loopExt:

mov r13, rdi
mov rdx, [r13 + OFFSET_TEXT]
mov rsi, [r13 + OFFSET_TEXT_LEN]
mov r9, [r13 + OFFSET_TAG]

;me queda en r8 el tag que estoy buscando, y en r9 el tag del mensaje actual

loopInt:
cmp r15, rcx
je finTag2

cmp r8, r9
je tagIgual 
jmp tagDistinto

tagDistinto:
add rdi, 24
inc r15
jmp loopExt

tagIgual:
;rdx: string a copiar. r14: posicion en el array resultado. [r14] es el puntero a string


loopTagIgual:
mov bl,  [rdx]
mov [r11], bl
inc rdx
inc r11
cmp byte [rdx], 0
jnz loopTagIgual
add rdi, 24
inc r15
jmp loopExt



finTag2:
xor r15, r15  ;reseteo el contador de mensaje actual
inc r8  ;subo el tag
mov rdi, r12 ;vuelvo rdi al comienzo del array de mensajes
add r14, 8 ;avanzo al siguiente string (correspondiente al siguiente tag)
mov r11, [r14]
cmp r8, 4 ;si el tag es 4 me las tomo
jnz loopExt

;hay que recuperar rdi y no se si rsi tambien aca


pop r15
pop r14
pop r13
pop r12
pop rbx
pop rbp
ret

