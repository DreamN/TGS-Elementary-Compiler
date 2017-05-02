	global main

	extern printf

	section .text

main:
	mov rax, 0
	mov [VAR+3*8], rax
	mov rax, 1
	sub rax, 1
	mov [VAR+673*8], rax
	s1:
	mov rbx, [VAR+673*8]
	add rbx, 1
	mov [VAR+673*8], rbx
	cmp rbx, 5
	je s0
	mov rbx, 1
	sub rbx, 1
	mov [VAR+90*8], rbx
	s3:
	mov rcx, [VAR+90*8]
	add rcx, 1
	mov [VAR+90*8], rcx
	cmp rcx, 4
	je s2
	mov rcx, [VAR+3*8]
	mov rdx, 1
	add rcx, rdx
	mov [VAR+3*8], rcx
	jmp s3
	s2:
	jmp s1
	s0:
	mov rax, [VAR+3*8]
	push rcx
	mov rdi, formatInt
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
section .data
	VAR times 1024 DQ 0
	formatInt db  "%d", 10, 0
	formatChar db  "%c", 10, 0
