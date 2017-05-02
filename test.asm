	global main

	extern printf

	extern puts

	section .text

main:
	mov rax, 0
	mov byte[arraystr + rax], 'A'
	mov rax, 1
	mov byte[arraystr + rax], 's'
	mov rax, 2
	mov byte[arraystr + rax], 's'
	mov rax, 3
	mov byte[arraystr + rax], 'i'
	mov rax, 4
	mov byte[arraystr + rax], 'g'
	mov rax, 5
	mov byte[arraystr + rax], 'n'
	mov rax, 6
	mov byte[arraystr + rax], 'm'
	mov rax, 7
	mov byte[arraystr + rax], 'e'
	mov rax, 8
	mov byte[arraystr + rax], 'n'
	mov rax, 9
	mov byte[arraystr + rax], 't'
	mov rax, 10
	mov byte[arraystr + rax], ' '
	mov rax, 11
	mov byte[arraystr + rax], 'C'
	mov rax, 12
	mov byte[arraystr + rax], 'o'
	mov rax, 13
	mov byte[arraystr + rax], 'm'
	mov rax, 14
	mov byte[arraystr + rax], 'p'
	mov rax, 15
	mov byte[arraystr + rax], 'i'
	mov rax, 16
	mov byte[arraystr + rax], 'l'
	mov rax, 17
	mov byte[arraystr + rax], 'e'
	mov rax, 18
	mov byte[arraystr + rax], 'r'
	mov rax, 19
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov [VAR+3*8], rax
	mov rax, 1
	mov rbx, 3
	sub rax, 1
	mov [VAR+18*8], rax
	add rbx, 1
	mov [VAR+700*8], rbx
	s1:
	mov rcx, [VAR+18*8]
	add rcx, 1
	mov [VAR+18*8], rcx
	mov rdx, [VAR+700*8]
	cmp rcx, rdx
	je s0
	mov rax, [VAR+18*8]
	push rcx
	mov rdi, formatInt
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
	mov rax, 1
	mov rbx, 3
	sub rax, 1
	mov [VAR+221*8], rax
	add rbx, 1
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
	add rbx, 1
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
	add rbx, 1
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
	mov rax, 0
	mov byte[arraystr + rax], 'R'
	mov rax, 1
	mov byte[arraystr + rax], 'e'
	mov rax, 2
	mov byte[arraystr + rax], 's'
	mov rax, 3
	mov byte[arraystr + rax], 'u'
	mov rax, 4
	mov byte[arraystr + rax], 'l'
	mov rax, 5
	mov byte[arraystr + rax], 't'
	mov rax, 6
	mov byte[arraystr + rax], ':'
	mov rax, 7
	mov byte[arraystr + rax], ' '
	mov rax, 8
	mov byte[arraystr + rax], '$'
	mov rax, 9
	mov byte[arraystr + rax], 'A'
	mov rax, 10
	mov byte[arraystr + rax], 'D'
	mov rax, 11
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, [VAR+3*8]
	push rcx
	mov rdi, formatInt
	mov rsi, rax
	xor rax, rax
	call printf
	pop rcx
section .data
	VAR times 1024 DQ 0
	arraystr	TIMES 512 dd 0 
	formatInt db  "%d", 10, 0
	formatHex db  "%x", 10, 0
