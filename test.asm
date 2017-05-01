	global main

	extern printf

	section .text

main:
	mov rax, 1
	mov [VAR+3*8], rax
	mov rax, 1
	mov rbx, 5
	sub rax, 1
	mov [VAR+673*8], rax
	s1:
	mov rcx, [VAR+673*8]
	add rcx, 1
	mov [VAR+673*8], rcx
	cmp rcx, rbx
	je s0
	mov rdx, [VAR+3*8]
	push rcx
	mov rdi, formatInt
	mov rsi, rdx
	xor rax, rax
	call printf
	pop rcx
	mov rdx, [VAR+3*8]
	mov rsi, [VAR+673*8]
	imul rdx, rsi
	mov [VAR+3*8], rdx
	jmp s1
	s0:
	mov rbx, [VAR+3*8]
	push rcx
	mov rdi, formatInt
	mov rsi, rbx
	xor rax, rax
	call printf
	pop rcx
section .data
	VAR times 1024 DQ 0
	formatInt db  "%d", 10, 0
	formatChar db  "%c", 10, 0
