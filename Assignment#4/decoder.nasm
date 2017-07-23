global _start
section .text
_start:

jmp short code
shellcode:
xor eax,eax
xor ebx,ebx
xor ecx,ecx
pop esi
push esi
mov edi , esi
add edi , 42
;esi will point to the start of the shellcode.
;edi will point to the end of the shellcode.
;******************************decode label is for geting the orignal order of the shellcode*****************************
decode:
mov al , byte [esi]
mov bl , byte [edi]
mov byte [esi] , bl
mov byte [edi] , al
inc esi
dec edi
add ecx, 2
cmp ecx , 43
jl decode
pop edi
mov esi , edi
;***********************************************************************************************************************
check_0x90:              ;find all 0x90 in the shellcode and jump to replace label if you find one.
cmp byte [edi]  , 0x90
je replace 
inc edi
loop check_0x90
replace:        ; here change 0x90 to 0x31
mov byte [edi] , 0x31
inc edi 
cmp ecx , 0
jnz check_0x90

call esi        ; call the decode shellcode
code:
call shellcode
shell db 0x0a,0x21,0x64,0x6c,0x72,0x6f,0x57,0x20,0x6f,0x6c,0x6c,0x65,0x48,0xff,0xff,0xff,0xe4,0xe8,0x80,0xcd,0xdb,0x90,0x01,0xb0,0xc0,0x90,0x80,0xcd,0x0d,0xb2,0xd2,0x90,0x59,0x01,0xb3,0xdb,0x90,0x04,0xb0,0xc0,0x90,0x17,0xeb

