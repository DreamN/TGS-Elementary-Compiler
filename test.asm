section .text

global _start

extern printf

_start:
	mov eax, 8
	mov ebx, 10
	mov ecx, 2
	add ebx, ecx
	mov ecx, 3
	imul ebx, ecx
	mov ecx, 36
	mov edx, 48
	add ecx, edx
section .data
	VAR times 676 DQ 0
