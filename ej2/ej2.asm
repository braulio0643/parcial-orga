extern malloc
global filtro

;########### SECCION DE DATOS
section .data
mask: DB 0x00,0x01,0xF0,0xF0,0x04,0x05 ,0xF0 ,0xF0 ,0x08 ,0x09 ,0xF0 ,0xF0 ,0x0C ,0x0D ,0xF0 ,0xF0


;########### SECCION DE TEXTO (PROGRAMA)
section .text


filtro:
  
    
;prologo
    push rbp
    mov rbp, rsp

    push r15
    push r14
    push r13
    push r12
    push rbx
    sub rsp, 8


    mov r15, rdi
    mov r14, rsi
    sub r14, 3  
    shl rsi, 2   
    sub rsi, 12
    mov rdi, rsi
    call malloc    

    mov r10, rax
    mov r13, rax


    xor r12,r12  ;r12 = i
             
 
.cycle:    
   
.pares:
    movdqu xmm2, [r15]

    movdqu xmm3, [mask]    
    pshufb xmm2, xmm3

    phaddw xmm2, xmm2
    pmovsxwd xmm2, xmm2
    phaddd xmm2, xmm2
    phaddd xmm2, xmm2               

    
    xor rbx, rbx
    xor rcx, rcx
    movd ebx, xmm2
    shr ebx, 2                            

    mov [r13], ebx
    add r13, 2
    add r15, 2

.impares:    
    movdqu xmm1, [r15]
    
    movdqu xmm3, [mask]    
    pshufb xmm1, xmm3

    phaddw xmm1, xmm1
    pmovsxwd xmm1, xmm1
    phaddd xmm1, xmm1
    phaddd xmm1, xmm1              
    
    xor rbx, rbx
    xor rcx, rcx
    movd ebx, xmm1                  
    shr ebx, 2

    mov [r13], ebx
    add r13, 2
    
    
    add r15, 2
    inc r12
    cmp r12, r14
    jne .cycle

    mov rax, r10
   

;epilogo
    add rsp, 8
    pop rbx
    pop r12
    pop r13
    pop r14
    pop r15

    pop rbp
    ret