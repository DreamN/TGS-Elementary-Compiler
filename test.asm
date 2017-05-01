section .text

global _start

extern printf

_start:
	mov eax, 1
	mov ebx, 1
	mov ecx, 2
	add ebx, ecx
	add eax, ebx
	mov ebx, 2
	mov ecx, 3
	add ebx, ecx
	add eax, ebx
	mov ebx, 4
	mov ecx, 5
	add ebx, ecx
	add eax, ebx
	mov ebx, 6
	mov ecx, 7
	idiv ebx, ecx
	mov ebx, edx
	mov ecx, 3
	add ebx, ecx
	add eax, ebx
	mov VAR[1], eax
	mov eax, 1
	mov ebx, BYTE [eax]
	push ebx
	call printf
section .data
	VAR times 676 DQ 0
