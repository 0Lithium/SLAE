
global _start
section .text
_start:


loop:
    inc eax
    cmp al,37
    jnz loop
    mov cl,9
    add ebx , -10
    add ebx, 9
    int 0x80
    
