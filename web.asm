section .data

buffer_tmp:
        dq 0

status_code:
        dq 0

tmp_html_buff:
        dq 0

tmp_html_size:
        dq 0


section .text

extern clientfd
extern htmlcontent
extern htmlheader
extern linhavazia

extern strlen
extern allocate
extern deallocate
extern println
extern formatastring

SYSCALL_SENDTO equ 44
SYSCALL_READ   equ 0

global mandaheader
mandaheader:
	mov [status_code], rdi

	mov rdi, 1024
	call allocate
	mov [buffer_tmp], rax
	
        mov rdi, [buffer_tmp]
        mov rsi, htmlheader
        mov rdx, [status_code]
	mov eax, 0
        call formatastring

	mov rsi, [buffer_tmp]
	call strlen

	mov rdi, [buffer_tmp]
	mov rsi, rax
	call enviadado

        mov rdi, [buffer_tmp]
        mov rsi, htmlcontent
        mov rbx, 0
	mov eax, 0
        call formatastring

        mov rsi, [buffer_tmp]
        call strlen

        mov rdi, [buffer_tmp]
        mov rsi, rax
        call enviadado

        mov rdi, [buffer_tmp]
        mov rsi, linhavazia
	mov rbx, 0 
        mov eax, 0
        call formatastring

        mov rsi, [buffer_tmp]
        call strlen

        mov rdi, [buffer_tmp]
        mov rsi, rax
        call enviadado


	mov rdi, [buffer_tmp]
	call deallocate
	mov [buffer_tmp], dword 0
	ret


global enviadado
enviadado:
	mov rdx, rsi
	mov rsi, rdi
	mov rdi, [clientfd]
	mov r10, 0
	mov r8 , 0
	mov r9 , 0
	mov rax, SYSCALL_SENDTO
	syscall
	ret

global temdadonaweb
temdadonaweb:
	mov rdx, rsi
	mov rsi, rdi
	mov rdi, [clientfd]
	mov rax, SYSCALL_READ
	syscall
	ret

global passa_html
passa_html:
	mov [tmp_html_buff], rdi
	mov [tmp_html_size], rsi
	
        mov rdi, 1024
        call allocate
        mov [buffer_tmp], rax

        mov rdi, [buffer_tmp]
        mov rsi, 10240
        call temdadonaweb

	mov rsi, [buffer_tmp]
	call println
	
	mov rdi, 200
	call mandaheader

	mov rdi, [tmp_html_buff]
	mov rsi, [tmp_html_size]
	call enviadado
	
        mov rdi, [buffer_tmp]
        call deallocate
        mov [buffer_tmp], dword 0
        ret

