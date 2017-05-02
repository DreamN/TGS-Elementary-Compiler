	global main

	extern printf

	section .text

main:
	mov rax, 0
	mov [VAR+3*8], rax
	mov rax, 1
	mov rbx, 3
	sub rax, 1
	mov [VAR+18*8], rax
	mov [VAR+700*8], rbx
	s1:
	mov rcx, [VAR+18*8]
	add rcx, 1
	mov [VAR+18*8], rcx
	mov rdx, [VAR+700*8]
	cmp rcx, rdx
	je s0
	mov rax, 1
	mov rbx, 3
	sub rax, 1
	mov [VAR+221*8], rax
	mov [VAR+702*8], rbx
	s3:
	mov rcx, [VAR+221*8]
	add rcx, 1
	mov [VAR+221*8], rcx
	mov rdx, [VAR+702*8]
	cmp rcx, rdx
	je s2
	mov rax, 1
	mov rbx, 3
	sub rax, 1
	mov [VAR+483*8], rax
	mov [VAR+704*8], rbx
	s5:
	mov rcx, [VAR+483*8]
	add rcx, 1
	mov [VAR+483*8], rcx
	mov rdx, [VAR+704*8]
	cmp rcx, rdx
	je s4
	mov rax, [VAR+483*8]
	mov rbx, 2
	cmp rax, rbx
	jne s6
	mov rax, 1
	mov rbx, 3
	sub rax, 1
	mov [VAR+1*8], rax
	mov [VAR+707*8], rbx
	s8:
	mov rcx, [VAR+1*8]
	add rcx, 1
	mov [VAR+1*8], rcx
	mov rdx, [VAR+707*8]
	cmp rcx, rdx
	je s7
	mov rax, [VAR+1*8]
	mov rbx, 2
	cmp rax, rbx
	jne s9
	mov rax, [VAR+3*8]
	mov rbx, 1
	add rax, rbx
	mov [VAR+3*8], rax
	s9:
	jmp s8
	s7:
	s6:
	jmp s5
	s4:
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
