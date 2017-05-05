global main

extern printf

extern puts

section .text

main:
	mov rax, 0
	mov byte[arraystr + rax], 'L'
	mov rax, 1
	mov byte[arraystr + rax], 'o'
	mov rax, 2
	mov byte[arraystr + rax], 'o'
	mov rax, 3
	mov byte[arraystr + rax], 'p'
	mov rax, 4
	mov byte[arraystr + rax], ' '
	mov rax, 5
	mov byte[arraystr + rax], '1'
	mov rax, 6
	mov byte[arraystr + rax], '-'
	mov rax, 7
	mov byte[arraystr + rax], '3'
	mov rax, 8
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
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
	jmp s1
	s0:
	mov rax, 0
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov byte[arraystr + rax], 'A'
	mov rax, 1
	mov byte[arraystr + rax], ' '
	mov rax, 2
	mov byte[arraystr + rax], '='
	mov rax, 3
	mov byte[arraystr + rax], ' '
	mov rax, 4
	mov byte[arraystr + rax], 'B'
	mov rax, 5
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 1
	mov rbx, 1
	cmp rax, rbx
	jne s2
		mov rax, 0
		mov byte[arraystr + rax], 'W'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 'r'
		mov rax, 3
		mov byte[arraystr + rax], 'k'
		mov rax, 4
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s2:
	mov rax, 1
	mov rbx, 0
	cmp rax, rbx
	jne s3
		mov rax, 0
		mov byte[arraystr + rax], 'N'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 't'
		mov rax, 3
		mov byte[arraystr + rax], ' '
		mov rax, 4
		mov byte[arraystr + rax], 'W'
		mov rax, 5
		mov byte[arraystr + rax], 'o'
		mov rax, 6
		mov byte[arraystr + rax], 'r'
		mov rax, 7
		mov byte[arraystr + rax], 'k'
		mov rax, 8
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s3:
	mov rax, 0
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov byte[arraystr + rax], 'A'
	mov rax, 1
	mov byte[arraystr + rax], ' '
	mov rax, 2
	mov byte[arraystr + rax], '!'
	mov rax, 3
	mov byte[arraystr + rax], '='
	mov rax, 4
	mov byte[arraystr + rax], ' '
	mov rax, 5
	mov byte[arraystr + rax], 'B'
	mov rax, 6
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 1
	mov rbx, 1
	cmp rax, rbx
	je s4
		mov rax, 0
		mov byte[arraystr + rax], 'N'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 't'
		mov rax, 3
		mov byte[arraystr + rax], ' '
		mov rax, 4
		mov byte[arraystr + rax], 'W'
		mov rax, 5
		mov byte[arraystr + rax], 'o'
		mov rax, 6
		mov byte[arraystr + rax], 'r'
		mov rax, 7
		mov byte[arraystr + rax], 'k'
		mov rax, 8
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s4:
	mov rax, 1
	mov rbx, 0
	cmp rax, rbx
	je s5
		mov rax, 0
		mov byte[arraystr + rax], 'W'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 'r'
		mov rax, 3
		mov byte[arraystr + rax], 'k'
		mov rax, 4
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s5:
	mov rax, 0
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov byte[arraystr + rax], 'A'
	mov rax, 1
	mov byte[arraystr + rax], ' '
	mov rax, 2
	mov byte[arraystr + rax], '<'
	mov rax, 3
	mov byte[arraystr + rax], ' '
	mov rax, 4
	mov byte[arraystr + rax], 'B'
	mov rax, 5
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 1
	mov rbx, 2
	cmp rax, rbx
	jge s6
		mov rax, 0
		mov byte[arraystr + rax], 'W'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 'r'
		mov rax, 3
		mov byte[arraystr + rax], 'k'
		mov rax, 4
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s6:
	mov rax, 1
	mov rbx, 1
	cmp rax, rbx
	jge s7
		mov rax, 0
		mov byte[arraystr + rax], 'N'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 't'
		mov rax, 3
		mov byte[arraystr + rax], ' '
		mov rax, 4
		mov byte[arraystr + rax], 'W'
		mov rax, 5
		mov byte[arraystr + rax], 'o'
		mov rax, 6
		mov byte[arraystr + rax], 'r'
		mov rax, 7
		mov byte[arraystr + rax], 'k'
		mov rax, 8
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s7:
	mov rax, 1
	mov rbx, 0
	cmp rax, rbx
	jge s8
		mov rax, 0
		mov byte[arraystr + rax], 'N'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 't'
		mov rax, 3
		mov byte[arraystr + rax], ' '
		mov rax, 4
		mov byte[arraystr + rax], 'W'
		mov rax, 5
		mov byte[arraystr + rax], 'o'
		mov rax, 6
		mov byte[arraystr + rax], 'r'
		mov rax, 7
		mov byte[arraystr + rax], 'k'
		mov rax, 8
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s8:
	mov rax, 0
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov byte[arraystr + rax], 'A'
	mov rax, 1
	mov byte[arraystr + rax], ' '
	mov rax, 2
	mov byte[arraystr + rax], '<'
	mov rax, 3
	mov byte[arraystr + rax], '='
	mov rax, 4
	mov byte[arraystr + rax], ' '
	mov rax, 5
	mov byte[arraystr + rax], 'B'
	mov rax, 6
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 1
	mov rbx, 2
	cmp rax, rbx
	jg s9
		mov rax, 0
		mov byte[arraystr + rax], 'W'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 'r'
		mov rax, 3
		mov byte[arraystr + rax], 'k'
		mov rax, 4
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s9:
	mov rax, 1
	mov rbx, 1
	cmp rax, rbx
	jg s10
		mov rax, 0
		mov byte[arraystr + rax], 'W'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 'r'
		mov rax, 3
		mov byte[arraystr + rax], 'k'
		mov rax, 4
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s10:
	mov rax, 1
	mov rbx, 0
	cmp rax, rbx
	jg s11
		mov rax, 0
		mov byte[arraystr + rax], 'N'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 't'
		mov rax, 3
		mov byte[arraystr + rax], ' '
		mov rax, 4
		mov byte[arraystr + rax], 'W'
		mov rax, 5
		mov byte[arraystr + rax], 'o'
		mov rax, 6
		mov byte[arraystr + rax], 'r'
		mov rax, 7
		mov byte[arraystr + rax], 'k'
		mov rax, 8
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s11:
	mov rax, 0
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov byte[arraystr + rax], 'A'
	mov rax, 1
	mov byte[arraystr + rax], ' '
	mov rax, 2
	mov byte[arraystr + rax], '>'
	mov rax, 3
	mov byte[arraystr + rax], ' '
	mov rax, 4
	mov byte[arraystr + rax], 'B'
	mov rax, 5
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 1
	mov rbx, 2
	cmp rax, rbx
	jle s12
		mov rax, 0
		mov byte[arraystr + rax], 'N'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 't'
		mov rax, 3
		mov byte[arraystr + rax], ' '
		mov rax, 4
		mov byte[arraystr + rax], 'W'
		mov rax, 5
		mov byte[arraystr + rax], 'o'
		mov rax, 6
		mov byte[arraystr + rax], 'r'
		mov rax, 7
		mov byte[arraystr + rax], 'k'
		mov rax, 8
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s12:
	mov rax, 1
	mov rbx, 1
	cmp rax, rbx
	jle s13
		mov rax, 0
		mov byte[arraystr + rax], 'N'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 't'
		mov rax, 3
		mov byte[arraystr + rax], ' '
		mov rax, 4
		mov byte[arraystr + rax], 'W'
		mov rax, 5
		mov byte[arraystr + rax], 'o'
		mov rax, 6
		mov byte[arraystr + rax], 'r'
		mov rax, 7
		mov byte[arraystr + rax], 'k'
		mov rax, 8
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s13:
	mov rax, 1
	mov rbx, 0
	cmp rax, rbx
	jle s14
		mov rax, 0
		mov byte[arraystr + rax], 'W'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 'r'
		mov rax, 3
		mov byte[arraystr + rax], 'k'
		mov rax, 4
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s14:
	mov rax, 0
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov byte[arraystr + rax], 'A'
	mov rax, 1
	mov byte[arraystr + rax], ' '
	mov rax, 2
	mov byte[arraystr + rax], '>'
	mov rax, 3
	mov byte[arraystr + rax], '='
	mov rax, 4
	mov byte[arraystr + rax], ' '
	mov rax, 5
	mov byte[arraystr + rax], 'B'
	mov rax, 6
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 1
	mov rbx, 2
	cmp rax, rbx
	jl s15
		mov rax, 0
		mov byte[arraystr + rax], 'N'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 't'
		mov rax, 3
		mov byte[arraystr + rax], ' '
		mov rax, 4
		mov byte[arraystr + rax], 'W'
		mov rax, 5
		mov byte[arraystr + rax], 'o'
		mov rax, 6
		mov byte[arraystr + rax], 'r'
		mov rax, 7
		mov byte[arraystr + rax], 'k'
		mov rax, 8
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s15:
	mov rax, 1
	mov rbx, 1
	cmp rax, rbx
	jl s16
		mov rax, 0
		mov byte[arraystr + rax], 'W'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 'r'
		mov rax, 3
		mov byte[arraystr + rax], 'k'
		mov rax, 4
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s16:
	mov rax, 1
	mov rbx, 0
	cmp rax, rbx
	jl s17
		mov rax, 0
		mov byte[arraystr + rax], 'W'
		mov rax, 1
		mov byte[arraystr + rax], 'o'
		mov rax, 2
		mov byte[arraystr + rax], 'r'
		mov rax, 3
		mov byte[arraystr + rax], 'k'
		mov rax, 4
		mov byte[arraystr + rax], 0
		mov rdi, arraystr
		call puts
	s17:
	mov rax, 0
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
	mov rax, 0
	mov byte[arraystr + rax], 'D'
	mov rax, 1
	mov byte[arraystr + rax], 'o'
	mov rax, 2
	mov byte[arraystr + rax], 'n'
	mov rax, 3
	mov byte[arraystr + rax], 'e'
	mov rax, 4
	mov byte[arraystr + rax], 0
	mov rdi, arraystr
	call puts
section .data
VAR times 1024 DQ 0
arraystr	TIMES 512 dd 0 
formatInt db  "%d", 10, 0
formatHex db  "%x", 10, 0
