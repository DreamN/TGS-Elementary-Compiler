	global main

	extern printf

	section .text

main:
	mov rax, 8
	mov rbx, 1
	add rax, rbx
	mov rax, 8
	mov rbx, 2
	add rax, rbx
	mov rax, 1
	mov rbx, 1
	add rax, rbx
	mov rbx, 1
	add rax, rbx
	mov rbx, 1
	add rax, rbx
	mov rbx, 1
	add rax, rbx
	mov rbx, 1
	add rax, rbx
	mov rax, 1234
	push rcx
	mov rdi, formatInt
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	mov rax, 1
	mov rbx, 1
	add rax, rbx
	mov rbx, 1
	add rax, rbx
	mov rbx, 1
	add rax, rbx
	mov rbx, 1
	mov rcx, 2
	add rbx, rcx
	add rax, rbx
	push rcx
	mov rdi, formatInt
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	mov rax, 2
	mov rbx, 3
	add rax, rbx
	mov rbx, 4
	imul rax, rbx
	mov rbx, 5
	imul rax, rbx
	mov rbx, 4
	imul rax, rbx
	push rcx
	mov rdi, formatInt
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	mov rax, 1
	mov rbx, 3
	cmp rax, rbx
	jne s0
	mov rcx, 11
	push rcx
	mov rdi, formatInt
	mov rsi, rcx
	xor rax, rax
	call printf
	pop rcx
	mov rcx, 500
	push rcx
	mov rdi, formatInt
	mov rsi, rcx
	xor rax, rax
	call printf
	pop rcx
	mov rcx, 11
	push rcx
	mov rdi, formatInt
	mov rsi, rcx
	xor rax, rax
	call printf
	pop rcx
	s0:
section .data
	VAR times 676 DQ 0
	formatInt db  "%d", 10, 0
	formatChar db  "%c", 10, 0
