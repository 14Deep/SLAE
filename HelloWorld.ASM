; Name: HelloWorld.ASM
; Author: Jake B
; Function: Print out 'Hello, World!'
; Notes: This is heavily commented to be used as a reference point and easy to use for learning purposes
; Compiling: This needs to be assembled and linked using nasm and ld:
;            - nasm -f elf32 -o HelloWorld.o HelloWorld.asm
;            - ld -o HelloWorld HelloWorld.o
; Notes: This is written for a Linux 32 bit system. 


global _start

section .text

_start:
  
  ; Print 'Hello, World!'
  mov eax, 0x4  ; SysCall 4 being put into eax for 'write'.
  mov ebx, 0x1  ; Providing a parameter of 'stdout'
  mov ecx, message  ; Providing what is to be written, in this case 'message' from .data.
  mov edx, mlen. ; Providing the message length from the .data section. 
  int 0x80 ; Invoke SysCall by providing an interupt. 
  
  ; Exit the program gracefully.
  
  mov eax, 0x1  ; Moving SysCall 1 for 'exit' to eax. 
  mov ebx, 0x1  ; Returning 1.
  int 0x80  ; Invoke SysCall by providing an interupt. 
  

section .data

  message: db "Hello, World!"
  mlen equ $-message
  
  
  
