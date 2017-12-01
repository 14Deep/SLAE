; Name: HelloWorld.ASM
; Author: Jake B
; Function: Print out 'Hello, World!'
; Notes: This is heavily commented to be used as a reference point and easy to use for learning purposes
; Compiling: 

global_start

section .text

_start:
  
  ; Print 'Hello, World!'
  mov eax, 0x4  ;SysCall 4 being put into eax for 'write.
  
