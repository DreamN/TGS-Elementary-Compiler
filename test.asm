global _start

extern printf

section .text
_start:
	mov eax, 10
	mov ebx, 2
	add eax, ebx
	mov ebx, 3
	imul eax, ebx
	mov [VAR+0*8], eax
	mov eax, 36
	mov ebx, 48
	add eax, ebx
	mov [VAR+1*8], eax
	mov eax, 36
	mov ebx, 48
	add eax, ebx
	mov ebx, eax
	push ebx

section .data
	VAR times 676 DQ 0
