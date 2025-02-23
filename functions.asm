section .text

extern linebreak
extern modo_leitura

extern printf
extern malloc
extern free
extern fopen
extern fread

SYSCALL_WRITE equ 1
SYSCALL_EXIT equ 60
STDOUT equ 1

global exit
exit:
        mov rax, SYSCALL_EXIT
        mov rdi, 0
        syscall


global eprintf
eprintf:
	push rbp
	mov rbp, rsp
	mov rax, 0
	call printf
	pop rbp
	ret

global allocate
allocate:
	push rbp
	mov rbp, rsp
	mov rax, 0
	call malloc
	pop rbp
	ret

global deallocate
deallocate:
	push rbp
	mov rbp, rsp
	mov rax, 0
	call free
	pop rbp
	ret

global abrirarquivo
abrirarquivo:
	push rbp
	mov rbp, rsp
	mov rsi, modo_leitura
	mov rax, 0
	call fopen
	pop rbp
	ret

global lerdados
lerdados:
	push rbp
	mov rbp, rsp
	mov rcx, rdx
	mov rdx, 1
	call fread
	pop rbp
	ret

global print
print:
        push rax
        push rsi

        call strlen
        mov rdi, STDOUT
        pop rsi
        mov rdx, rax
        mov rax, SYSCALL_WRITE
        syscall 
        pop rax
        ret

global println
println:
        push rsi

        call print
        mov rsi, linebreak
        call print
        pop rsi
        ret

global strlen
strlen:
        push rbx
        mov rbx, 0

loopstart:
        mov rax, 0
        lodsb
        test ax, ax
        jz loopout

        inc rbx
        jmp loopstart
loopout:
        mov rax, rbx
        pop rbx
        ret

