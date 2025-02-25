section .data

extern socket_deu_ruim
extern socket_deu_bom
extern sockopt_deu_bom
extern sockopt_deu_ruim
extern bindar_deu_bom
extern bindar_deu_ruim
extern escutar_deu_bom
extern escutar_deu_ruim
extern conexao_deu_bom
extern conexao_deu_ruim
extern eprintf

AF_INET equ 2
SOCK_STREAM equ 1
SYSCALL_SOCKET equ 41
SYSCALL_EXIT equ 60
SOL_SOCKET equ 1
SO_REUSEADDR equ 2
SO_REUSEPORT equ 15
SYSCALL_SETSOCKOPT equ 54
INADDR_ANY equ 0
PORT equ 8081
SYSCALL_BIND equ 49
SYSCALL_LISTEN equ 50
SYSCALL_ACCEPT equ 43
SYSCALL_CLOSE equ 3

struc sockaddr_in
	sin_family resb 2
	sin_port resb 2
	s_addr resb 4
	sin_zero resb 8
endstruc

global address
address istruc sockaddr_in
	at sin_family, dw AF_INET
	at sin_port, dw 0
	at s_addr, dd 0
iend

global addrlen
addrlen:
	dd 16

global serverfd
serverfd:
	dd 0

global opt
opt:
	dd 0

global optlen
optlen:
	dd 4

global clientfd
clientfd:
	dd 0

section .text

global criarsocket
criarsocket:
	mov rdi, AF_INET
	mov rsi, SOCK_STREAM
	mov rdx, 0
	mov rax, SYSCALL_SOCKET
	syscall
	mov [serverfd], rax
	
	test rax, rax
	jz criarsocket_deuruim

	
criarsocket_deubom:
	mov rdi, socket_deu_bom
	mov rsi, [serverfd]
	call eprintf
	ret
	

criarsocket_deuruim:
        mov rdi, socket_deu_ruim 
        call eprintf
        mov rax, SYSCALL_EXIT
	mov rdi, 9999
	syscall

global sockarserver
sockarserver:
	mov rdi, [serverfd]
	mov rsi, SOL_SOCKET
	mov rdx, SO_REUSEADDR
	or rdx, SO_REUSEPORT
	mov r10, opt
	mov r8 , [optlen]
	mov rax, SYSCALL_SETSOCKOPT
	syscall	

	test rax, rax
	jnz sockarserver_deuruim

sockarserver_deubom:
	mov rdi, sockopt_deu_bom
	mov rax, 0
	call eprintf
	ret

sockarserver_deuruim:
	mov rdi, sockopt_deu_ruim
	mov rax, 0
	call eprintf
	
	mov rax, SYSCALL_EXIT
	mov rdi, 9999
	syscall

global bindar
bindar:
	mov rdi, PORT
	call htons
	mov [address + sin_port], ax
	mov [address + s_addr], dword INADDR_ANY
	mov rdi, [serverfd]
	mov rsi, address
	mov rdx, [addrlen]
	mov rax, SYSCALL_BIND
	syscall
	
	test rax, rax
	jnz bindar_deuruim

bindar_deubom:
        mov rdi, bindar_deu_bom
        mov rax, 0
        call eprintf
        ret


bindar_deuruim:
        mov rdi, bindar_deu_ruim
        mov rax, 0
        call eprintf
        
        mov rax, SYSCALL_EXIT
        mov rdi, 9999
        syscall


global htons
htons:
	mov rax, rdi
	xchg ah, al
	ret

global escutar
escutar:
	mov rdi, [serverfd]
	mov rsi, 3
	mov rax, SYSCALL_LISTEN
	syscall
        test rax, rax
        jnz escutar_deuruim

escutar_deubom:
        mov rdi, escutar_deu_bom
        mov rax, 0
        call eprintf
        ret


escutar_deuruim:
        mov rdi, escutar_deu_ruim
        mov rax, 0
        call eprintf
        
        mov rax, SYSCALL_EXIT
        mov rdi, 9999
        syscall

global conexao
conexao:
	mov rdi, [serverfd]
	mov rsi, address
	mov rdx, addrlen
	mov rax, SYSCALL_ACCEPT
	syscall
	mov [clientfd], eax

        test rax, rax
        jl conexao_deuruim

conexao_deubom:
        mov rdi, conexao_deu_bom
        mov rax, 0
        call eprintf
        ret


conexao_deuruim:
        mov rdi, conexao_deu_ruim
        mov rax, 0
        call eprintf
        
        mov rax, SYSCALL_EXIT
        mov rdi, 9999
        syscall

global fecha
fecha:
	mov rdi, [clientfd]
	mov rax, SYSCALL_CLOSE
	syscall

	mov rdi, [serverfd]
	mov rax, SYSCALL_CLOSE
	syscall
	ret
