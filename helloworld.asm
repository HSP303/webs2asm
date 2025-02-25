section .text
global main

extern helloworld
extern linux
extern linebreak
extern minhas_frases
extern formathell
extern indexhtml
extern lendoarquivo
extern htmlheader
extern passa_html

extern print
extern println
extern eprintf
extern allocate
extern deallocate
extern exit
extern abrirarquivo
extern lerdados
extern strlen

extern malloc
extern free
extern printf
;extern puts

extern criarsocket
extern sockarserver
extern htons
extern bindar
extern escutar
extern conexao
extern formatastring
extern fecha

PORT equ 8080

teste:
	db `Valor do tmpend é %p\n`, 0

endereco:
	db `Endereco do malloc eh %p\n`, 0

main:
        ;mov rsi, helloworld
	;call println
	;mov rsi, linux
	;call println

	mov rdi, 16
	call allocate

	mov [tmpend], rax

	mov rdi, endereco
	mov rsi, rax
	call eprintf
	
	mov rdi, teste
	mov rsi, [tmpend]
	call eprintf
	
	mov rdi, [tmpend]
	call deallocate

	mov rdi, endereco
	mov rsi, rax
	call  eprintf

	;push rbp
	;mov rbp, rsp
	;mov rdi, formathell
	;mov rsi, 100
	;mov rdx, linux
	;mov eax, 0
	;call printf
	;pop rbp

	mov rdi, linebreak
	call eprintf

	mov rdi, lendoarquivo
	mov rsi, indexhtml
	call eprintf

	mov rdi, indexhtml
	call abrirarquivo
	
	mov [arquivoaberto], rax

	mov rdi, 1024
	call allocate

	mov [tmpend], rax
	
	mov rdi, [tmpend]
	mov rsi, 1023
	mov rdx, [arquivoaberto]
	call lerdados

        mov rsi, [tmpend]
        call strlen

	mov [tmpendlen], rax	

	mov rdi, [tmpend]
	mov rsi, 0
 	mov rdx, 0
	call eprintf

	

	call criarsocket
	
	call sockarserver

	call bindar
	
	call escutar
	
	call conexao
	
	mov rdi, [tmpend]
	mov rsi, [tmpendlen]	
	call passa_html

	call fecha

	call exit

section .data

tmpend:
        dq 0

tmpendlen:
	dq 0

arquivoaberto:
	dq 0
